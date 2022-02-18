////
////  GCRepositoryListViewController.m
////  GithubClient
////
////  Created by bytedance on 2022/1/14.
////  Copyright © 2022 iosByYH. All rights reserved.
////
//
//#import "GCDropdownListItem.h"
//#import <Masonry/Masonry.h>
//
//
//@interface GCDropdownListItem () <UITableViewDelegate, UITableViewDataSource>
//@property (strong, nonatomic) IBOutlet UITableView *tableView;
//
//@property (strong, nonatomic) NSMutableArray *data;
//@end
//
//@implementation GCDropdownListItem
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    _data = [[NSMutableArray alloc] init];
//    _tableView = [[UITableView alloc] init];
//    self.tableView.backgroundColor = self.view.backgroundColor;
//    _tableView.separatorColor = [UIColor clearColor];
//    _tableView.delegate = self;
//    _tableView.dataSource = self;
//    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"GCDropdownListItemCell"];
//    [self.view layoutIfNeeded];
//    [self.view addSubview:_tableView];
//    [_tableView mas_makeConstraints:^(MASConstraintMaker *make){
//        make.left.mas_equalTo(self.view.mas_left).offset(5);
//        make.right.mas_equalTo(self.view.mas_right).offset(-5);
//        make.top.mas_equalTo(self.view.mas_top).offset(5);
//        make.bottom.mas_equalTo(self.view.mas_bottom);
//    }];
//    _tableView.estimatedRowHeight = 200;
//    _tableView.rowHeight = UITableViewAutomaticDimension;
//    [_tableView setHidden:YES];
//}
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    return 1;
//}
//
////设置每个section包含的行数
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    NSLog(@"!!!!!!!!!!!");
//    return _data.count;
//}
//
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    [_tableView deselectRowAtIndexPath:indexPath animated:NO];
//    GCRepositoryViewController *vc = [[GCRepositoryViewController alloc] initWithFullName:_data[indexPath.row].full_name];
//    [self.navigationController pushViewController:vc animated:YES];
//    return;
//}
//
//- ( UISwipeActionsConfiguration *)tableView:(UITableView *)tableView trailingSwipeActionsConfigurationForRowAtIndexPath:(NSIndexPath *)indexPath {
//    //删除
//    UIContextualAction *deleteRowAction = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleNormal title:@"delete" handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {
//        //假删除
//        [self.data removeObjectAtIndex:indexPath.row];
//        [self.tableView reloadData];
//    }];
//    deleteRowAction.backgroundColor = [UIColor redColor];
//
//    UISwipeActionsConfiguration *config = [UISwipeActionsConfiguration configurationWithActions:@[deleteRowAction]];
//    //是否让cell 进行全滑动时是否执行
////    config.performsFirstActionWithFullSwipe = NO;
//    return config;
//}
//
////cell内容
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
//    UITableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"GCDropdownListItemCell"];
//    cell.backgroundColor = _tableView.backgroundColor;
//    return cell;
//}
//
////设置行高
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return UITableViewAutomaticDimension;
//}
//
////设置头部标题
//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    return @"";
//}
//
////设置尾部标题
//- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
//{
//    return @"";
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
//{
//    return 0;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return 0;
//}
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    [self dealHead];
//    return;
//}
//- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
//{
//    __weak typeof(self) weakSelf = self;
//    if(_tableView.contentOffset.y < _topOffset - _refreshingView.bounds.size.height)
//    {
//        //使refresh panel保持显示
//        _freshingLabel.text = @"加载中";
//        _tableView.contentInset = UIEdgeInsetsMake(100, 0, 0, 0);
//        [_tableView setHidden:YES];
//        sleep(0.2);
//        GCGithubApi *githubApi = [GCGithubApi shareGCGithubApi];
//        void (^endBlock)(void) = ^{
//            weakSelf.tableView.contentInset = UIEdgeInsetsZero;
//            [weakSelf.tableView setHidden:NO];
//        };
//        [githubApi getWithUrl:getAuthenticatedUserRepositoriesUrl() WithAcceptType:JSonContent WithSuccessBlock:^(id responseObject){
//            weakSelf.data = [GCRepositoryListDatum jsonsToModelsWithJsons:responseObject];
//            [weakSelf.tableView reloadData];
//            endBlock();
//            
//        } WithFailureBlock:^{
//            endBlock();
//        }];
//    }
//    return;
//}
//- (void)dealHead
//{
//    if(_tableView.contentOffset.y < _topOffset - 10) {
//        _refreshingView.hidden = NO;
//        if(_tableView.contentOffset.y < _topOffset - _refreshingView.bounds.size.height)
//        {
//            //使refresh panel保持显示
//            _freshingLabel.text = @"松开刷新";
//        }
//        else {
//            _freshingLabel.text = @"下拉刷新";
//        }
//    }
//    else {
//        _refreshingView.hidden = YES;
//    }
//}
//
////按section ID设置头部信息
////- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
////    NSString *sectionTitle = [self tableView:tableView titleForHeaderInSection:section];
////    if (sectionTitle == nil) {
////        return nil;
////    }
////    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, [self tableView:_tableView heightForHeaderInSection:0])];
////
////    UILabel *label = [[UILabel alloc] init];
////    label.backgroundColor = TabBarPage_Background_color;
////    label.textColor = TabBarPage_TextColor;
////    label.font = [UIFont boldSystemFontOfSize:20];
////    label.text = sectionTitle;
////
////    [view addSubview:label];
////    [label mas_makeConstraints:^(MASConstraintMaker* make){
////        make.top.mas_equalTo(view.mas_top);
////        make.left.mas_equalTo(view.mas_left);
////        make.right.mas_equalTo(view.mas_right);
////        make.height.mas_equalTo(view.mas_height);
////    }];
////
////    return view;
////}
///*
// #pragma mark - Navigation
// 
// // In a storyboard-based application, you will often want to do a little preparation before navigation
// - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
// // Get the new view controller using [segue destinationViewController].
// // Pass the selected object to the new view controller.
// }
// */
//
//@end
