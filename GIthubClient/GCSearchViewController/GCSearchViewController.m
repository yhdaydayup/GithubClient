//
//  GCSearchViewController.m
//  GithubClient
//
//  Created by bytedance on 2022/1/28.
//  Copyright © 2022 iosByYH. All rights reserved.
//

#import "GCSearchViewController.h"
#import "GCSearchRepositoryResultViewController.h"
#import <Masonry/Masonry.h>

@interface GCSearchViewController ()<UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>
@property (strong, nonatomic) UITableView *historyTableView;
@property (strong, nonatomic) UISearchBar *searchBar;
@property (strong, nonatomic) NSMutableArray *data;
@end

@implementation GCSearchViewController

- (instancetype)init{
    if(self = [super init]) {
        _historyTableView = [[UITableView alloc] init];
        _searchBar = [[UISearchBar alloc] init];
        _data = [[NSMutableArray alloc] init];
        
        [self.view addSubview:_searchBar];
        [_searchBar mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.mas_equalTo(self.view.mas_top).offset(20);
            make.left.mas_equalTo(self.view.mas_left);
            make.right.mas_equalTo(self.view.mas_right);
            make.height.mas_equalTo(100);
        }];
        _searchBar.delegate = self;
        _searchBar.showsSearchResultsButton = YES;
        
        [self.view addSubview:_historyTableView];
        _historyTableView.delegate = self;
        _historyTableView.dataSource = self;
        [_historyTableView mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.mas_equalTo(_searchBar.mas_bottom);
            make.left.mas_equalTo(self.view.mas_left);
            make.right.mas_equalTo(self.view.mas_right);
            make.bottom.mas_equalTo(self.view.mas_bottom);
        }];
        
        self.edgesForExtendedLayout = UIRectEdgeNone;
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
        //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
        tapGestureRecognizer.cancelsTouchesInView = NO;
        //将触摸事件添加到当前view
        [self.view addGestureRecognizer:tapGestureRecognizer];
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSMutableArray *historyData = [defaults objectForKey:@"search history"];
        if(historyData) {
            [_data removeAllObjects];
            [_data addObjectsFromArray:historyData];
        }
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:YES];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:_data forKey:@"search history"];
    [_historyTableView reloadData];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell *cell = [_historyTableView dequeueReusableCellWithIdentifier:@"historyTableViewCell"];
    if(!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"historyTableViewCell"];
        [cell.imageView mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.mas_equalTo(cell.mas_left).offset(5);
            make.height.and.width.mas_equalTo(cell.mas_height).multipliedBy(0.4);
            make.centerY.mas_equalTo(cell.mas_centerY);
        }];
        cell.imageView.image = [UIImage imageNamed:@"history.png"];

        [cell.textLabel mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.mas_equalTo(cell.imageView.mas_right).offset(5);
            make.right.mas_lessThanOrEqualTo(cell.mas_right).offset(-5);
            make.height.mas_equalTo(cell.mas_height);
            make.centerY.mas_equalTo(cell.mas_centerY);
        }];
    }
    cell.textLabel.text = _data[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    _searchBar.text = _data[indexPath.row];
    [self searchBarSearchButtonClicked:self.searchBar];
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _data.count;
}

- (void)encodeWithCoder:(nonnull NSCoder *)coder {
    return;
}

- (void)traitCollectionDidChange:(nullable UITraitCollection *)previousTraitCollection {
    return;
}

- (void)preferredContentSizeDidChangeForChildContentContainer:(nonnull id<UIContentContainer>)container {
    return;
}

//- (CGSize)sizeForChildContentContainer:(nonnull id<UIContentContainer>)container withParentContainerSize:(CGSize)parentSize {
//    return;
//}

- (void)systemLayoutFittingSizeDidChangeForChildContentContainer:(nonnull id<UIContentContainer>)container {
    return;
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(nonnull id<UIViewControllerTransitionCoordinator>)coordinator {
    return;;
}

- (void)willTransitionToTraitCollection:(nonnull UITraitCollection *)newCollection withTransitionCoordinator:(nonnull id<UIViewControllerTransitionCoordinator>)coordinator {
    return;
}

- (void)didUpdateFocusInContext:(nonnull UIFocusUpdateContext *)context withAnimationCoordinator:(nonnull UIFocusAnimationCoordinator *)coordinator {
    return;
}

- (void)setNeedsFocusUpdate {
    return;
}

- (BOOL)shouldUpdateFocusInContext:(nonnull UIFocusUpdateContext *)context {
    return NO;
}

- (void)updateFocusIfNeeded {
    return;
}

#pragma mark- hideKeyBoard
-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    [_searchBar resignFirstResponder];
}

#pragma mark- UISearchBarDelegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    NSString *searchText = searchBar.text;
    if([searchText isEqualToString:@""]) {
        return;
    }
    if([_data containsObject:searchText]) {
        [_data removeObject:searchText];
    }
    [_data insertObject:searchText atIndex:0];
    if(_data.count > 10) {
        [_data removeLastObject];
    }
    [_searchBar resignFirstResponder];
    GCSearchRepositoryResultViewController *resultVC = [[GCSearchRepositoryResultViewController alloc] initWithSearchText:_searchBar.text];
    [self.navigationController pushViewController:resultVC animated:YES];
}
@end

