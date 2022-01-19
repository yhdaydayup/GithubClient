//
//  GCRepositoryListViewController.m
//  GithubClient
//
//  Created by bytedance on 2022/1/14.
//  Copyright © 2022 iosByYH. All rights reserved.
//

#import "GCRepositoryListViewController.h"
#import "GCRepositoryTableViewCell.h"
#import <Masonry/Masonry.h>
#import "GCGithubApi.h"

@interface GCRepositoryListViewController () <UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray<NSMutableDictionary*> *data;
@property (strong, nonatomic) UIImageView *loadingImageView;
@end

@implementation GCRepositoryListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _data = [[NSMutableArray<NSMutableDictionary*> alloc] init];
    _tableView = [[UITableView alloc] init];
    self.tableView.backgroundColor = self.view.backgroundColor;
    _tableView.separatorColor = [UIColor clearColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerClass:[GCRepositoryTableViewCell class] forCellReuseIdentifier:@"RepositoryTableViewCell"];
    [self.view layoutIfNeeded];
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.mas_equalTo(self.view.mas_left).offset(5);
        make.right.mas_equalTo(self.view.mas_right).offset(-5);
        make.top.mas_equalTo(self.view.mas_top).offset(5);
        make.bottom.mas_equalTo(self.view.mas_bottom);
    }];
    _tableView.estimatedRowHeight = 200;
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
    
    GCGithubApi *githubApi = [GCGithubApi shareGCGithubApi];
    __weak typeof(self) weakSelf = self;
    [githubApi getAuthenticatedUserRepositoriesWithSuccessBlock:^(id dictArray){
        weakSelf.data = dictArray;
//        [dictArray addObjectsFromArray:[dictArray copy]];
        [weakSelf.loadingImageView setHidden:YES];
        [weakSelf.tableView setHidden:NO];
        [weakSelf.tableView reloadData];
        [weakSelf.view layoutIfNeeded];
    } WithFailureBlock:^{
    }];
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
    NSLog(@"touch me!!!!");
    return;
}

//cell内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    GCRepositoryTableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"RepositoryTableViewCell"];
    [cell setData:_data[indexPath.row]];
    cell.backgroundColor = _tableView.backgroundColor;
    return cell;
}

//设置行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
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

//按section ID设置头部信息
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    NSString *sectionTitle = [self tableView:tableView titleForHeaderInSection:section];
//    if (sectionTitle == nil) {
//        return nil;
//    }
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, [self tableView:_tableView heightForHeaderInSection:0])];
//
//    UILabel *label = [[UILabel alloc] init];
//    label.backgroundColor = TabBarPage_Background_color;
//    label.textColor = TabBarPage_TextColor;
//    label.font = [UIFont boldSystemFontOfSize:20];
//    label.text = sectionTitle;
//
//    [view addSubview:label];
//    [label mas_makeConstraints:^(MASConstraintMaker* make){
//        make.top.mas_equalTo(view.mas_top);
//        make.left.mas_equalTo(view.mas_left);
//        make.right.mas_equalTo(view.mas_right);
//        make.height.mas_equalTo(view.mas_height);
//    }];
//
//    return view;
//}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
