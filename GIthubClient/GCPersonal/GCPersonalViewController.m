//
//  GCPersonalViewController.m
//  GithubClient
//
//  Created by ByteDance on 2022/3/22.
//  Copyright © 2022 iosByYH. All rights reserved.
//

#import "GCPersonalViewController.h"
#import <Masonry/Masonry.h>
#import "GCPersonalTableViewCell.h"
#import "GCGithubApi.h"
#import <SDWebImage/SDWebImage.h>
#import "UILabel+Font.h"
#import "GCLoginViewController.h"
#import "configure.h"
#import <YYModel/YYModel.h>
#import "GCUserListViewController.h"

@interface GCPersonalViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *contentView;
@property (strong, nonatomic) NSMutableArray<NSString*> *titles;
@property (strong, nonatomic) NSMutableArray<NSString*> *texts;
@property (strong, nonatomic) NSMutableArray<block> *actions;

@property (strong, nonatomic) UIView *informationView;
@property (strong, nonatomic) UIImageView *avatar;
@property (strong, nonatomic) UIImageView *editView;
@property (strong, nonatomic) UILabel *name;
@property (strong, nonatomic) UILabel *createdTime;
@property (strong, nonatomic) UIButton *repositoryBtn;
@property (strong, nonatomic) UIButton *followBtn;
@property (strong, nonatomic) UIButton *fansBtn;
@property (strong, nonatomic) UIButton *codeBtn;

@property (strong, nonatomic) UIButton *supBtn;
@property (strong, nonatomic) UILabel *optionView;
@end

@implementation GCPersonalViewController
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
        
        _editView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"edit.png"]];
        [_informationView addSubview:_editView];
        [_editView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.informationView.mas_right).offset(-20);
            make.top.mas_equalTo(self.informationView.mas_top).offset(10);
            make.height.width.mas_equalTo(self.informationView.mas_height).multipliedBy(0.2);
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
        
        _createdTime = [[UILabel alloc] init];
        _createdTime.textColor = [UIColor whiteColor];
        [_informationView addSubview:_createdTime];
        [_createdTime mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_name.mas_left);
            make.top.mas_equalTo(_name.mas_bottom).offset(10);
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
        
        _supBtn = [[UIButton alloc] initWithFrame:CGRectMake(350, 650, 60, 60)];
        [_supBtn setImage:[UIImage imageNamed:@"fox.jpeg"] forState:UIControlStateNormal];
        _supBtn.backgroundColor = [UIColor clearColor];
        _supBtn.layer.cornerRadius = _supBtn.frame.size.width / 2;
        [_supBtn.layer setMasksToBounds:YES];
        [self.view addSubview:_supBtn];
        
        //创建移动手势事件
        UIPanGestureRecognizer *panRcognize=[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
        [panRcognize setMinimumNumberOfTouches:1];
        [panRcognize setEnabled:YES];
        [panRcognize delaysTouchesEnded];
        [panRcognize cancelsTouchesInView];
        [self.supBtn addGestureRecognizer:panRcognize];
        [_supBtn addTarget:self action:@selector(showOptionView) forControlEvents:UIControlEventTouchUpInside];
        
        _optionView = [[UILabel alloc] init];
        _optionView.text = @"注销";
        _optionView.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:_optionView];
        [_optionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.view.mas_centerX);
            make.centerY.mas_equalTo(self.view.mas_centerY);
            make.width.mas_equalTo(self.view.mas_width).multipliedBy(0.6);
            make.height.mas_equalTo(self.view.mas_height).multipliedBy(0.1);
        }];
        _optionView.backgroundColor = UIColorFromRGB(0xF8E6E0);
        [_optionView setFont:[UIFont fontWithName:@"Helvetica-bold" size:25]];
        [self.view bringSubviewToFront:_optionView];
        UITapGestureRecognizer *touchRecongnizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(logout)];
        [_optionView setUserInteractionEnabled:YES];
        [_optionView addGestureRecognizer:touchRecongnizer];
        _optionView.hidden = YES;
        [self.view bringSubviewToFront:_supBtn];

        UITapGestureRecognizer *recongnizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTouchEvent)];
        [self.view addGestureRecognizer:recongnizer];
        self.view.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *tapEdit = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapEditView)];
        [self.editView addGestureRecognizer:tapEdit];
        self.editView.userInteractionEnabled = YES;
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
        weakSelf.model = [GCUserModel yy_modelWithJSON:response];
        [weakSelf.avatar sd_setImageWithURL:[NSURL URLWithString:response[@"avatar_url"]] placeholderImage:[UIImage imageNamed:@"icons/close.png"]];
        [weakSelf.avatar.layer setCornerRadius:CGRectGetHeight([weakSelf.avatar bounds]) / 2];
        [weakSelf.avatar.layer setMasksToBounds:YES];
        
        weakSelf.createdTime.text = [NSString stringWithFormat:@"创建于: %@", [response[@"created_at"] substringWithRange:NSMakeRange(0, 9)]];
        
        weakSelf.name.text = response[@"login"];
        
        [[GCGithubApi shareGCGithubApi] getWithUrl:_model.repos_url WithAcceptType:JSonContent WithSuccessBlock:^(id response) {
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
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return 30;
//}
/*
 *  悬浮按钮移动事件处理
 */
- (void)handlePanGesture:(UIPanGestureRecognizer *)recognizer
{
    //移动状态
    UIGestureRecognizerState recState =  recognizer.state;

    switch (recState) {
        case UIGestureRecognizerStateBegan:
            break;
        case UIGestureRecognizerStateChanged:
        {
            CGPoint translation = [recognizer translationInView:self.navigationController.view];
            recognizer.view.center = CGPointMake(recognizer.view.center.x + translation.x, recognizer.view.center.y + translation.y);
            break;
        }
        case UIGestureRecognizerStateEnded:
        {
            CGPoint stopPoint = CGPointMake(recognizer.view.center.x , recognizer.view.center.y);
            if(recognizer.view.center.x > self.view.frame.size.width - _supBtn.frame.size.width / 2) {
                stopPoint.x = self.view.frame.size.width - _supBtn.frame.size.width / 2;
            }
            else if(recognizer.view.frame.origin.x < 0) {
                stopPoint.x = _supBtn.frame.size.width / 2;
            }
            
            if(recognizer.view.center.y > self.view.frame.size.height - _supBtn.frame.size.height / 2 - 100) {
                stopPoint.y = self.view.frame.size.height - _supBtn.frame.size.height / 2 - 100;
            }
            else if(recognizer.view.frame.origin.y < 0) {
                stopPoint.y = _supBtn.frame.size.height / 2;
            }
            [UIView animateWithDuration:0.5 animations:^{
                recognizer.view.center = stopPoint;
            }];
        }
    }
    [recognizer setTranslation:CGPointMake(0, 0) inView:self.view];
}

-(void) showOptionView {
    self.optionView.hidden = !self.optionView.hidden;
}

-(void) viewTouchEvent {
    self.optionView.hidden = YES;
}

-(void) tapEditView {
    
}

-(void) logout {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:@"access_token"];
    [self.navigationController pushViewController:[[GCLoginViewController alloc] init] animated:YES];
    _optionView.hidden = YES;
}
@end
