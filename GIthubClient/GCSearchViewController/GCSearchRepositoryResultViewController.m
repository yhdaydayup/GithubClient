//
//  GCSearchRepositoryResultViewController.m
//  GithubClient
//
//  Created by bytedance on 2022/1/28.
//  Copyright © 2022 iosByYH. All rights reserved.
//

#import "GCSearchRepositoryResultViewController.h"
#import "configure.h"
#import <Masonry/Masonry.h>
#import "GCFilterView.h"
#import <ReactiveObjC.h>
#import "GCGithubAPI.h"
#import "NSObject+GCDataModel.h"
#import "GCRepositoryListData.h"
#import "NSObject+GCDataModel.h"
#import "GCRepositoryListViewController.h"
#import "GCSearchModel.h"
#import <ReactiveObjc.h>



@interface GCSearchRepositoryResultViewController ()
@property (strong, nonatomic) UILabel *showRepositoryLabel;
@property (strong, nonatomic) UILabel *showUserLabel;
@property (strong, nonatomic) UIImageView *filter;
@property (strong, nonatomic) UIView *filterBar;
@property (nonatomic) SelectStatus selectStatus;
@property (strong, nonatomic) GCFilterView *filterView;
@property (strong, nonatomic) GCRepositoryListViewController *repositoriesVC;
@property (strong, nonatomic) UIView *resultView;
@property (strong, nonatomic) GCSearchModel* searchModel;
@property (copy, nonatomic) NSString *searchText;
@end

@implementation GCSearchRepositoryResultViewController
- (instancetype) initWithSearchText:(NSString *)text {
    if(self = [super init]) {
        _filterBar = [[UIView alloc] init];
        _showRepositoryLabel = [[UILabel alloc] init];
        _showUserLabel = [[UILabel alloc] init];
        _filter = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"filter.png"]];
        _filterView = [[GCFilterView alloc] init];
        _resultView = [[UIView alloc] init];
        _repositoriesVC = [[GCRepositoryListViewController alloc] init];
        
        _showRepositoryLabel.text = @"仓库";
        _showUserLabel.text = @"用户";
        _searchText = text;
        _searchModel = [[GCSearchModel alloc] initWithUrl:@"" WithParams:[NSMutableDictionary new] WithHeaders:[NSMutableDictionary new]];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = CommonBackGroundColor;
    _filterBar.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:_filterBar];
    [_filterBar mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.mas_equalTo(self.view.mas_left);
        make.right.mas_equalTo(self.view.mas_right);
        make.top.mas_equalTo(self.view.mas_top).offset(5);
        make.height.mas_equalTo(50);
    }];
    
    _showRepositoryLabel.textColor = search_result_filterLabel_textColor;
    [_filterBar addSubview:_showRepositoryLabel];
    [_showRepositoryLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.mas_equalTo(_filterBar.mas_left).offset(5);
        make.width.mas_equalTo(50);
        make.top.mas_equalTo(_filterBar.mas_top);
        make.bottom.mas_equalTo(_filterBar.mas_bottom);
    }];
    
    _showUserLabel.textColor = search_result_filterLabel_textColor;
    [_filterBar addSubview:_showUserLabel];
    [_showUserLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.mas_equalTo(_showRepositoryLabel.mas_right).offset(5);
        make.width.mas_equalTo(50);
        make.top.mas_equalTo(_filterBar.mas_top);
        make.bottom.mas_equalTo(_filterBar.mas_bottom);
    }];
    
    [_filterBar addSubview:_filter];
    [_filter mas_makeConstraints:^(MASConstraintMaker *make){
        make.right.mas_equalTo(_filterBar.mas_right).offset(-5);
        make.width.and.height.mas_equalTo(30);
        make.centerY.mas_equalTo(_filterBar.mas_centerY);
    }];
    
    [self.view addSubview:_resultView];
    [_resultView mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.mas_equalTo(self.view.mas_left).offset(5);
        make.right.mas_equalTo(_filterBar.mas_right).offset(-5);
        make.top.mas_equalTo(_filterBar.mas_bottom).offset(5);
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-5);
    }];
    
    [self.view addSubview:_filterView];
    [_filterView mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.mas_equalTo(self.view.mas_left);
        make.right.mas_equalTo(self.view.mas_right);
        make.top.mas_equalTo(self.view.mas_top);
        make.height.mas_equalTo(800);
    }];
    _filterView.hidden = YES;
    [self.view bringSubviewToFront:_filterView];
    
    [_resultView addSubview:_repositoriesVC.view];
    [_repositoriesVC.view mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.mas_equalTo(_resultView.mas_left);
        make.right.mas_equalTo(_resultView.mas_right);
        make.top.mas_equalTo(_resultView.mas_top);
        make.bottom.mas_equalTo(_resultView.mas_bottom);
    }];
    _repositoriesVC.nav = self.navigationController;
    
    [self addEvents];
    
    [self showRepositorySelected];
}
- (void) addEvents {
    UITapGestureRecognizer *tapShowRepositoryLabel = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showRepositorySelected)];
    [_showRepositoryLabel addGestureRecognizer:tapShowRepositoryLabel];
    _showRepositoryLabel.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tapShowUserLabel = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showUserSelected)];
    [_showUserLabel addGestureRecognizer:tapShowUserLabel];
    _showUserLabel.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tapFilter = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showFilterView)];
    [_filter addGestureRecognizer:tapFilter];
    _filter.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tapCompleteLabel = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showRepositorySelected)];
    [_filterView.completeLabel addGestureRecognizer:tapCompleteLabel];
    _filterView.completeLabel.userInteractionEnabled = YES;
    
    _selectStatus = ShowRepository;
}

- (void) showRepositorySelected {
    _selectStatus = ShowRepository;
    [self revertStyle];
    _showRepositoryLabel.textColor = search_result_filterLabel_selected_textColor;
    [self searchForRepository];
}

- (void) showUserSelected {
    _selectStatus = ShowUser;
    [self revertStyle];
    _showUserLabel.textColor = search_result_filterLabel_selected_textColor;
}

- (void) revertStyle{
    _showUserLabel.textColor = search_result_filterLabel_textColor;
    _showRepositoryLabel.textColor = search_result_filterLabel_textColor;
    if(_selectStatus == ShowUser) {
        _showUserLabel.textColor = search_result_filterLabel_selected_textColor;
    }
    else if(_selectStatus == ShowRepository) {
        _showRepositoryLabel.textColor = search_result_filterLabel_selected_textColor;
    }
}

- (void) showFilterView {
    _filterView.hidden = NO;
    [self.view bringSubviewToFront:_filterView];
}

- (void)searchForRepository{
//    q=tetris+language:assembly&sort=stars&order=desc
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:_searchText forKey:@"q"];
    [params setObject:@"100" forKey:@"per_page"];
    [params setObject:_filterView.orderRule ? @"desc" : @"asc" forKey:@"order"];

    NSMutableDictionary *headers = [[NSMutableDictionary alloc] init];
    [headers setObject:_filterView.language forKey:@"language"];
    [headers setObject:_filterView.sortBy forKey:@"sort"];
    _searchModel.params = params;
    _searchModel.headers = headers;
    _searchModel.url = @"https://api.github.com/search/repositories";
    [_repositoriesVC setModel:_searchModel];
    _repositoriesVC.view.hidden = NO;
    _filterView.hidden = YES;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
@end
