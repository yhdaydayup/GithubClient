//
//  GCLoginViewController.m
//  GithubClient
//
//  Created by bytedance on 2022/1/11.
//  Copyright © 2022 iosByYH. All rights reserved.
//

#import "GCLoginViewController.h"
#import "GCGithubApi.h"
#import <Masonry/Masonry.h>
#import "configure.h"

@interface GCLoginViewController ()
@property (strong, nonatomic) UIButton *loginBT;
@property (strong, nonatomic) UIImageView *gitLogo;
@property (strong, nonatomic) UITextField *username;
@property (strong, nonatomic) UITextField *password;
@end

@implementation GCLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden = YES;
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    int width = screenRect.size.width;
    int height = screenRect.size.height;
    
    
    _gitLogo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"github.png"]];
    [self.view addSubview:_gitLogo];
    [_gitLogo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view.mas_top).offset(height * 0.3);
        make.height.mas_equalTo(0.4 * width);
        make.width.mas_equalTo(0.4 * width);
    }];

    _username = [UITextField new];
    _username.placeholder = @"input your username";
    [_username setValue:[UIColor whiteColor] forKeyPath:@"placeholderLabel.textColor"];
    _username.backgroundColor = loginPage_TextField_Background_Color;
    _username.textColor = loginPage_TextField_Font_Color;
    _password.adjustsFontSizeToFitWidth = NO;
    [_username.font fontWithSize:loginPage_TextField_Font_Size];
    [self.view addSubview:_username];
    [_username mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(_gitLogo.mas_bottom).offset(30);
        make.height.mas_equalTo(0.05 * height);
        make.width.mas_equalTo(0.9 * width);
    }];

     _password = [UITextField new];
    [_password setSecureTextEntry:YES];
    _password.placeholder = @"input your password";
    [_password setValue:[UIColor whiteColor] forKeyPath:@"placeholderLabel.textColor"];
    _password.backgroundColor = loginPage_TextField_Background_Color;
    _password.textColor = loginPage_TextField_Font_Color;
    _password.adjustsFontSizeToFitWidth = NO;
    [_password.font fontWithSize:loginPage_Login_Btn_Font_Size];
    [self.view addSubview:_password];
    [_password mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(_username.mas_bottom).offset(30);
        make.height.mas_equalTo(0.05 * height);
        make.width.mas_equalTo(0.9 * width);
    }];
    
    _loginBT = [UIButton new];
    [_loginBT setTitle:@"Login" forState:0];
    _loginBT.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:loginPage_Login_Btn_Font_Size];
    _loginBT.titleLabel.textColor = loginPage_Login_Btn_Font_Color;
    [_loginBT setBackgroundColor:loginPage_Login_Btn_Font_Background_Color];
    [self.view addSubview:_loginBT];
    [_loginBT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(_password.mas_bottom).offset(50);
        make.height.mas_equalTo(0.05 * height);
        make.width.mas_equalTo(0.9 * width);
    }];

    
    [_loginBT addTarget:self action:@selector(didLogin) forControlEvents:UIControlEventTouchUpInside];
    
}
- (void) didLogin
{
    BOOL result = [[GCGithubApi shareGCGithubApi] loginWithAccount:_username.text WithSecret:_password.text];
    if(result)
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else {
        NSLog(@"login false");
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [_password resignFirstResponder];
    [_username resignFirstResponder];
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}
- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
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
