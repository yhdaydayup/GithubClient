//
//  GCUserListViewController.m
//  GithubClient
//
//  Created by ByteDance on 2022/4/5.
//  Copyright © 2022 iosByYH. All rights reserved.
//

#import "GCUserListViewController.h"
#import "GCUserListTableViewCell.h"
#include "GCUserModel.h"
#import <Masonry/Masonry.h>
#import "GCGithubApi.h"
#import "GCRepositoryListData.h"
#import "NSObject+GCDataModel.h"
#import "GCRepositoryViewController.h"
#import "GCUserViewController.h"

@interface GCUserListViewController () <UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) UIImageView *loadingImageView;

@property (strong, nonatomic) UIView *refreshingView;
@property (strong, nonatomic) UILabel *freshingLabel;

@property CGFloat topOffset;
@end

@implementation GCUserListViewController
-(instancetype)init {
    if(self = [super init]) {
        _data = [[NSMutableArray alloc] init];
        _tableView = [[UITableView alloc] init];
        self.tableView.backgroundColor = self.view.backgroundColor;
        _tableView.separatorColor = [UIColor clearColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[GCUserListTableViewCell class] forCellReuseIdentifier:@"GCUserListTableViewCell"];
        [self.view layoutIfNeeded];
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.mas_equalTo(self.view.mas_left).offset(5);
            make.right.mas_equalTo(self.view.mas_right).offset(-5);
            make.top.mas_equalTo(self.view.mas_top).offset(5);
            make.bottom.mas_equalTo(self.view.mas_bottom);
        }];
        _tableView.estimatedRowHeight = 40;
        _tableView.rowHeight = UITableViewAutomaticDimension;
        [_tableView setHidden:YES];
        
        //tableView自己的inset
        //    _tableView.contentInset = UIEdgeInsetsMake(5, 5, 5, 5);
        //    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        // Do any additional setup after loading the view.
        
        _loadingImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"loading.png"]];
        [self.view addSubview:_loadingImageView];
        [_loadingImageView mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.mas_equalTo(self.view.mas_top).offset(100);
            make.centerX.mas_equalTo(self.view.mas_centerX);
            make.height.and.width.mas_equalTo(self.view.mas_width).multipliedBy(0.2);
        }];
        
        _refreshingView = [[UIView alloc] init];
        [_tableView addSubview:_refreshingView];
        [_refreshingView mas_makeConstraints:^(MASConstraintMaker *make){
            make.bottom.mas_equalTo(_tableView.mas_top);
            make.height.mas_equalTo(100);
            make.width.mas_equalTo(self.view.mas_width);
            make.left.mas_equalTo(_tableView.mas_left);
        }];
        
        _freshingLabel = [[UILabel alloc] init];
        _freshingLabel.text = @"下拉刷新";
        _freshingLabel.textAlignment = NSTextAlignmentCenter;
        [_refreshingView addSubview:_freshingLabel];
        [_freshingLabel mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.mas_equalTo(_refreshingView.mas_top);
            make.height.mas_equalTo(_refreshingView.mas_height).multipliedBy(0.3);
            make.width.mas_equalTo(_refreshingView.mas_width);
            make.centerX.mas_equalTo(_refreshingView.mas_centerX);
        }];
        
        UIImageView *freshingImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"loading.png"]];
        [_refreshingView addSubview:freshingImageView];
        [freshingImageView mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.mas_equalTo(_freshingLabel.mas_bottom).offset(10);
            make.bottom.mas_equalTo(_refreshingView.mas_bottom);
            make.width.mas_equalTo(freshingImageView.mas_height);
            make.centerX.mas_equalTo(_refreshingView.mas_centerX);
        }];
        
        _tableView.separatorColor = [UIColor grayColor];
    }
    return self;
}
- (void) setData:(NSMutableArray<GCUserModel*>*) aData{
    _data = aData;
}

- (void) reloadData {
    [self.loadingImageView setHidden:NO];
    self.refreshingView.hidden = NO;
    self.tableView.hidden = YES;
    GCGithubApi *githubApi = [GCGithubApi shareGCGithubApi];
    __weak typeof(self) weakSelf = self;
    [githubApi getWithSearchModel:_model WithAcceptType:JSonContent WithSuccessBlock:^(id responseObject){
        if([NSStringFromClass([responseObject class]) isEqual:@"__NSDictionaryI"]) {
            responseObject = responseObject[@"items"];
        }
        weakSelf.data = [GCUserModel jsonsToModelsWithJsons:responseObject];
        [weakSelf.loadingImageView setHidden:YES];
        weakSelf.refreshingView.hidden = YES;
        [weakSelf.tableView setHidden:NO];
        [weakSelf.tableView reloadData];
        [weakSelf.view layoutIfNeeded];
        [weakSelf.tableView reloadData];
    } WithFailureBlock:^{
    }];
}
- (void)setModel:(GCSearchModel *)aModel {
    _model = aModel;
    [self reloadData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view layoutIfNeeded];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

//设置每个section包含的行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"!!!!!!!!!!!");
    return _data.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_tableView deselectRowAtIndexPath:indexPath animated:NO];
    GCUserViewController *vc = [[GCUserViewController alloc] init];
    [vc setModel:_data[indexPath.row]];
    if(_nav) {
        [_nav pushViewController:vc animated:YES];
    }
    else {
        [self.navigationController pushViewController:vc animated:YES];
    }
    return;
}

- ( UISwipeActionsConfiguration *)tableView:(UITableView *)tableView trailingSwipeActionsConfigurationForRowAtIndexPath:(NSIndexPath *)indexPath {
    //删除
    UIContextualAction *deleteRowAction = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleNormal title:@"delete" handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {
        //假删除
        [self.data removeObjectAtIndex:indexPath.row];
        [self.tableView reloadData];
    }];
    deleteRowAction.backgroundColor = [UIColor redColor];
    
    UISwipeActionsConfiguration *config = [UISwipeActionsConfiguration configurationWithActions:@[deleteRowAction]];
    //是否让cell 进行全滑动时是否执行
    //    config.performsFirstActionWithFullSwipe = NO;
    return config;
}

//cell内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    GCUserListTableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"GCUserListTableViewCell"];
    [cell setModel:_data[indexPath.row]];
    cell.backgroundColor = _tableView.backgroundColor;
    return cell;
}

//设置行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

//设置头部标题
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"";
}

//设置尾部标题
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    return @"";
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self dealHead];
    return;
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    __weak typeof(self) weakSelf = self;
    if(_tableView.contentOffset.y < _topOffset - _refreshingView.bounds.size.height)
    {
        //使refresh panel保持显示
        _freshingLabel.text = @"加载中";
        _tableView.contentInset = UIEdgeInsetsMake(100, 0, 0, 0);
        [_tableView setHidden:YES];
        sleep(0.2);
        GCGithubApi *githubApi = [GCGithubApi shareGCGithubApi];
        void (^endBlock)(void) = ^{
            weakSelf.tableView.contentInset = UIEdgeInsetsZero;
            [weakSelf.tableView setHidden:NO];
        };
        [githubApi getWithSearchModel:_model WithAcceptType:JSonContent WithSuccessBlock:^(id responseObject) {
            if([NSStringFromClass([responseObject class]) isEqual:@"__NSDictionaryI"]) {
                responseObject = responseObject[@"items"];
            }
            weakSelf.data = [GCUserModel jsonsToModelsWithJsons:responseObject];
            [weakSelf.tableView reloadData];
            endBlock();
        } WithFailureBlock:^{
            endBlock();
        }];
    }
    return;
}
- (void)dealHead
{
    if(_tableView.contentOffset.y < _topOffset - 10) {
        _refreshingView.hidden = NO;
        if(_tableView.contentOffset.y < _topOffset - _refreshingView.bounds.size.height)
        {
            //使refresh panel保持显示
            _freshingLabel.text = @"松开刷新";
        }
        else {
            _freshingLabel.text = @"下拉刷新";
        }
    }
    else {
        _refreshingView.hidden = YES;
    }
}
@end
