//
//  GCWorkSpaceViewController.m
//  GithubClient
//
//  Created by bytedance on 2022/1/11.
//  Copyright © 2022 iosByYH. All rights reserved.
//

#import "GCWorkSpaceViewController.h"
#import "GCWorkSpaceTableViewCellModel.h"
#import "GCWorkSpaceTableViewCell.h"
#import "GCRepositoryListViewController.h"
#import <Masonry/Masonry.h>
#import "configure.h"

@interface GCWorkSpaceViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray<GCWorkSpaceTableViewCellModel*> *data;
@property (strong, nonatomic) UIView *topView;
@end

@implementation GCWorkSpaceViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    _data = [[NSMutableArray<GCWorkSpaceTableViewCellModel*> alloc] init];
    [_data addObject:[[GCWorkSpaceTableViewCellModel alloc] initWithClassName:@"GCRepositoryListViewController" WithTitle:@"问题" WithImagePath:@"issue.png"]];
    [_data addObject:[[GCWorkSpaceTableViewCellModel alloc] initWithClassName:@"GCRepositoryListViewController" WithTitle:@"合并请求" WithImagePath:@"request.png"]];
    [_data addObject:[[GCWorkSpaceTableViewCellModel alloc] initWithClassName:@"GCRepositoryListViewController" WithTitle:@"组织" WithImagePath:@"organization.png"]];
    [_data addObject:[[GCWorkSpaceTableViewCellModel alloc] initWithClassName:@"GCRepositoryListViewController" WithTitle:@"仓库" WithImagePath:@"repository.png"]];
    [_data addObject:[[GCWorkSpaceTableViewCellModel alloc] initWithClassName:@"GCRepositoryListViewController" WithTitle:@"标星" WithImagePath:@"star-fill.png"]];
    [_data addObject:[[GCWorkSpaceTableViewCellModel alloc] initWithClassName:@"GCRepositoryListViewController" WithTitle:@"动态" WithImagePath:@"dynamic.png"]];
    
    _topView = [[UIView alloc] init];
    _topView.backgroundColor =TabBarPage_Element_Background_Color;
    [self.view addSubview:_topView];
    [_topView mas_makeConstraints:^(MASConstraintMaker* make){
        make.left.mas_equalTo(self.view.mas_left);
        make.right.mas_equalTo(self.view.mas_right);
        make.top.mas_equalTo(self.view.mas_top);
        make.height.mas_equalTo(self.view.mas_height).multipliedBy(0.1);
    }];
    
    UILabel *topLabel = [[UILabel alloc] init];
    topLabel.text = @"工作台";
    topLabel.textColor = WorkSpace_TopTitle_TextColor;
    topLabel.font = WorkSpace_TopTitle_Font;
    topLabel.backgroundColor = TabBarPage_Element_Background_Color;
    [topLabel setTextAlignment:NSTextAlignmentCenter];
    topLabel.adjustsFontSizeToFitWidth = NO;
    [self.view addSubview:topLabel];
    [topLabel mas_makeConstraints:^(MASConstraintMaker* make){
        make.left.mas_equalTo(_topView.mas_left);
        make.right.mas_equalTo(_topView.mas_right);
        make.bottom.mas_equalTo(_topView.mas_bottom);
        make.height.mas_equalTo(_topView.mas_height).multipliedBy(0.5);
    }];
    
    _tableView = [[UITableView alloc] init];
    _tableView.backgroundColor = self.view.backgroundColor;
    _tableView.separatorColor = [UIColor clearColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.mas_equalTo(_topView.mas_bottom).offset(5);
        make.left.mas_equalTo(self.view.mas_left).offset(5);
        make.right.mas_equalTo(self.view.mas_right).offset(-5);
        make.bottom.mas_equalTo(self.view.mas_bottom);
    }];
    [_tableView registerClass:[GCWorkSpaceTableViewCell class] forCellReuseIdentifier:@"GCWorkSpaceTableViewCell"];
    
    [self.view bringSubviewToFront:_tableView];
    // Do any additional setup after loading the view.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

//设置每个section包含的行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _data.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Class vcClass = NSClassFromString(_data[indexPath.row].cellActionClassName);
    if(!vcClass) {
        return;
    }
    UIViewController *responseVC = [[vcClass alloc] init];
    responseVC.view.backgroundColor = self.view.backgroundColor;
    if(indexPath.row == 3) {
        if([responseVC isKindOfClass:[GCRepositoryListViewController class]]) {
            [(GCRepositoryListViewController*)responseVC typeAct:User];
        }
    }
    else {
        if([responseVC isKindOfClass:[GCRepositoryListViewController class]]) {
            [(GCRepositoryListViewController*)responseVC typeAct:Star];
        }
    }
    [self.navigationController pushViewController:responseVC animated:YES];
    [_tableView deselectRowAtIndexPath:indexPath animated:NO];
    return;
}

//cell内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    static int colors[] = {0x81FF8B, 0x5B84E7, 0xEE9537, 0xAA5BF0, 0x6DEEF4, 0xFC3971};
    GCWorkSpaceTableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"GCWorkSpaceTableViewCell"];
    [cell setModel:_data[indexPath.row]];
    cell.imageArea.backgroundColor = UIColorFromRGB(colors[indexPath.row]);
    return cell;
}

//设置行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  self.view.frame.size.height / 15.0;
}
 
//设置头部标题
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"我的工作";
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
    return  self.view.frame.size.height / 15.0 + 10;
}
//按section ID设置头部信息
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    NSString *sectionTitle = [self tableView:tableView titleForHeaderInSection:section];
    if (sectionTitle == nil) {
        return nil;
    }
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, [self tableView:_tableView heightForHeaderInSection:0])];
    
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = TabBarPage_Background_color;
    label.textColor = WorkSpace_Section_TextColor;
    label.font = WorkSpace_Section_Font;
    label.text = sectionTitle;
    
    [view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker* make){
        make.top.mas_equalTo(view.mas_top);
        make.left.mas_equalTo(view.mas_left);
        make.right.mas_equalTo(view.mas_right);
        make.height.mas_equalTo(view.mas_height);
    }];
    return view;
}
@end
