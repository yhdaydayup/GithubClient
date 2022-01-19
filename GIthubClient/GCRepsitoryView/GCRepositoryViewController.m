//
//  GCRepositoryViewController.m
//  GithubClient
//
//  Created by bytedance on 2022/1/17.
//  Copyright © 2022 iosByYH. All rights reserved.
//

#import "GCRepositoryViewController.h"
#import <Masonry.h>

@interface GCRepositoryViewController ()
@property (strong, nonatomic) UIImageView *avatarImageView;
@property (strong, nonatomic) UIButton *followBtn;
@property (strong, nonatomic) UIButton *starBtn;
@property (strong, nonatomic) UIButton *forkBtn;
@property (strong, nonatomic) UILabel *repositoryPath;
@property (strong, nonatomic) UILabel *rep_description;
@property (strong, nonatomic) UIButton *issueCount;
@property (strong, nonatomic) UIButton *starCount;
@property (strong, nonatomic) UIButton *forkCount;
@property (strong, nonatomic) UIButton *followCount;
@end

@implementation GCRepositoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.frame = [UIScreen mainScreen].bounds;
    // Do any additional setup after loading the view.
    UIView *informationView = [[UIView alloc] init];
    
    _avatarImageView = [[UIImageView alloc] init];
    _followBtn = [[UIButton alloc] init];
    _starBtn = [[UIButton alloc] init];
    _forkBtn = [[UIButton alloc] init];
    _repositoryPath = [[UILabel alloc] init];
    _rep_description = [[UILabel alloc] init];
    _issueCount = [[UIButton alloc] init];
    _starCount = [[UIButton alloc] init];
    _forkCount = [[UIButton alloc] init];
    _followBtn = [[UIButton alloc] init];
    
    [self.view addSubview:informationView];
    [informationView mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.mas_equalTo(self.view.mas_left).offset(5);
        make.top.mas_equalTo(self.view.mas_top).offset(5);
        make.right.mas_equalTo(self.view.mas_right).offset(-5);
    }];
    
    [informationView addSubview:_avatarImageView];
    [_avatarImageView mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.mas_equalTo(informationView.mas_left).offset(5);
        make.top.mas_equalTo(informationView.mas_top).offset(5);
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

@end
