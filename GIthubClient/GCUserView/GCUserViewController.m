//
//  GCUserViewController.m
//  GithubClient
//
//  Created by ByteDance on 2022/4/5.
//  Copyright © 2022 iosByYH. All rights reserved.
//

#import "GCUserViewController.h"
#import <Masonry/Masonry.h>
#import "GCPersonalTableViewCell.h"
#import "GCGithubApi.h"
#import <SDWebImage/SDWebImage.h>
#import "UILabel+Font.h"
#import "GCLoginViewController.h"
#import "configure.h"
#import "GCSearchModel.h"

@interface GCUserViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *contentView;
@property (strong, nonatomic) NSMutableArray<NSString*> *titles;
@property (strong, nonatomic) NSMutableArray<NSString*> *texts;
@property (strong, nonatomic) NSMutableArray<block> *actions;

@property (strong, nonatomic) UIView *informationView;
@property (strong, nonatomic) UIImageView *avatar;
@property (strong, nonatomic) UILabel *name;
@property (strong, nonatomic) UIButton *repositoryBtn;
@property (strong, nonatomic) UIButton *followBtn;
@property (strong, nonatomic) UIButton *fansBtn;
@property (strong, nonatomic) UIButton *codeBtn;
@end

@implementation GCUserViewController
-(instancetype)init {
    if(self = [super init]) {
        self.view.backgroundColor = CommonBackGroundColor;
        self.contentView.backgroundColor = CommonBackGroundColor;
        _contentView = [[UITableView alloc] init];
        [self.view addSubview:_contentView];
        _contentView.delegate = self;
        _contentView.dataSource = self;
        [_contentView registerClass:[GCPersonalTableViewCell class] forCellReuseIdentifier:@"GCPersonalTableViewCell"];
        [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.view.mas_left);
            make.right.mas_equalTo(self.view.mas_right);
            make.top.mas_equalTo(self.view.mas_top).offset(20);
            make.bottom.mas_equalTo(self.view.mas_bottom).offset(-20);
        }];
        
        _informationView = [[UIView alloc] init];
        _informationView.backgroundColor = [UIColor blackColor];
        
        _avatar = [[UIImageView alloc] init];
        [_informationView addSubview:_avatar];
        [_avatar mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.informationView.mas_left).offset(20);
            make.top.mas_equalTo(self.informationView.mas_top).offset(10);
            make.height.width.mas_equalTo(self.informationView.mas_height).multipliedBy(0.35);
        }];

        _name = [[UILabel alloc] init];
        _name.textColor = [UIColor whiteColor];
        [_name useBoldStyle];
        [_informationView addSubview:_name];
        [_name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_avatar.mas_right).offset(20);
            make.top.mas_equalTo(_avatar.mas_top).offset(10);
            make.width.mas_equalTo(self.informationView.mas_width).multipliedBy(0.4);
            make.height.mas_equalTo(20);
        }];
        
        _repositoryBtn = [[UIButton alloc] init];
        [_repositoryBtn setTitle:@"仓库\nunknow" forState:0];
        _repositoryBtn.titleLabel.numberOfLines = 2;
        _repositoryBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        _repositoryBtn.titleLabel.textColor = [UIColor whiteColor];
        [_informationView addSubview:_repositoryBtn];
        [_repositoryBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.informationView.mas_left);
            make.width.mas_equalTo(self.informationView.mas_width).multipliedBy(0.25);
            make.top.mas_equalTo(_avatar.mas_bottom).offset(20);
            make.bottom.mas_equalTo(self.informationView.mas_bottom);
        }];
        
        _codeBtn = [[UIButton alloc] init];
        [_codeBtn setTitle:@"代码片段\nunknow" forState:0];
        _codeBtn.titleLabel.numberOfLines = 2;
        _codeBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        _codeBtn.titleLabel.textColor = [UIColor whiteColor];
        [_informationView addSubview:_codeBtn];
        [_codeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.repositoryBtn.mas_right);
            make.width.mas_equalTo(self.informationView.mas_width).multipliedBy(0.25);
            make.top.mas_equalTo(_avatar.mas_bottom).offset(20);
            make.bottom.mas_equalTo(self.informationView.mas_bottom);
        }];
        
        _fansBtn = [[UIButton alloc] init];
        [_fansBtn setTitle:@"粉丝\nunknow" forState:0];
        _fansBtn.titleLabel.numberOfLines = 2;
        _fansBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        _fansBtn.titleLabel.textColor = [UIColor whiteColor];
        [_informationView addSubview:_fansBtn];
        [_fansBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_codeBtn.mas_right);
            make.width.mas_equalTo(self.informationView.mas_width).multipliedBy(0.25);
            make.top.mas_equalTo(_avatar.mas_bottom).offset(20);
            make.bottom.mas_equalTo(self.informationView.mas_bottom);
        }];
        
        _followBtn = [[UIButton alloc] init];
        [_followBtn setTitle:@"关注\nunknow" forState:0];
        _followBtn.titleLabel.numberOfLines = 2;
        _followBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        _followBtn.titleLabel.textColor = [UIColor whiteColor];
        [_informationView addSubview:_followBtn];
        [_followBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_fansBtn.mas_right);
            make.width.mas_equalTo(self.informationView.mas_width).multipliedBy(0.25);
            make.top.mas_equalTo(_avatar.mas_bottom).offset(20);
            make.bottom.mas_equalTo(self.informationView.mas_bottom);
        }];
        
        _titles = [[NSMutableArray alloc] initWithObjects:@"公司", @"地址", @"邮箱", @"博客", nil];
        _texts = [[NSMutableArray alloc] initWithObjects:@"unknow", @"unknow", @"unknow", @"unknow", nil];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    __weak typeof(self) weakSelf = self;
    [[GCGithubApi shareGCGithubApi] getWithUrl:getAuthenticatedUserInfo() WithAcceptType:JSonContent WithSuccessBlock:^(id response) {
        [weakSelf.avatar sd_setImageWithURL:[NSURL URLWithString:response[@"avatar_url"]] placeholderImage:[UIImage imageNamed:@"icons/close.png"]];
        [weakSelf.avatar.layer setCornerRadius:CGRectGetHeight([weakSelf.avatar bounds]) / 2];
        [weakSelf.avatar.layer setMasksToBounds:YES];
        
        weakSelf.name.text = response[@"login"];
        
        [[GCGithubApi shareGCGithubApi] getWithUrl:response[@"repos_url"] WithAcceptType:JSonContent WithSuccessBlock:^(id response) {
            [weakSelf.repositoryBtn setTitle:[NSString stringWithFormat:@"仓库\n%lu", [response count]] forState:0];
        } WithFailureBlock:^() {
            
        }];
        
        [[GCGithubApi shareGCGithubApi] getWithUrl:response[@"followers_url"] WithAcceptType:JSonContent WithSuccessBlock:^(id response) {
        [weakSelf.fansBtn setTitle:[NSString stringWithFormat:@"粉丝\n%lu", [response count]] forState:0];
        } WithFailureBlock:^() {
            
        }];
        
        NSString *followUrl = response[@"following_url"];
        [[GCGithubApi shareGCGithubApi] getWithUrl:[followUrl substringWithRange:NSMakeRange(0, followUrl.length - 13)] WithAcceptType:JSonContent WithSuccessBlock:^(id response) {
            [weakSelf.followBtn setTitle:[NSString stringWithFormat:@"关注\n%lu", [response count]] forState:0];
        } WithFailureBlock:^() {
            
        }];
        
        weakSelf.texts[0] = response[@"company"];
        weakSelf.texts[1] = response[@"location"];
        weakSelf.texts[2] = response[@"email"];
        weakSelf.texts[3] = response[@"blog"];
        [weakSelf.contentView reloadData];
    } WithFailureBlock:^(){
        
    }];
}
-(void)setModel:(GCUserModel *)model {
    _model = model;
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
#pragma mark -UITableViewDataSource
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 200;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 65;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _titles.count;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return _informationView;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    GCPersonalTableViewCell *cell = [_contentView dequeueReusableCellWithIdentifier:@"GCPersonalTableViewCell"];
    [cell setCellWithTitle:_titles[indexPath.row] WithText:_texts[indexPath.row]];
    return cell;
}
@end
