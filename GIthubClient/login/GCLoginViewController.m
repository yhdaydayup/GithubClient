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
@property (strong, nonatomic) UITextField *accessToken;
@property (strong, nonatomic) UIButton *switchBtn;
@property (strong, nonatomic) UILabel *failLabel;
@end

@implementation GCLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self tryLoginWithCache];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden = YES;
    
    _gitLogo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"github.png"]];
    [self.view addSubview:_gitLogo];
    [_gitLogo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view.mas_centerY).offset(-50);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.height.width.mas_equalTo(self.view.mas_width).multipliedBy(0.4);
    }];
    
    _switchBtn = [[UIButton alloc] init];
    [_switchBtn setTitle:@"access token login" forState:0];
    _switchBtn.backgroundColor = loginPage_Login_Btn_Font_Background_Color;
    _switchBtn.titleLabel.textColor = [UIColor whiteColor];
    _switchBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    _switchBtn.layer.cornerRadius = 5;
    [self.view addSubview:_switchBtn];
    [_switchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.view.mas_right).offset(-10);
        make.top.equalTo(self.view.mas_top).offset(100);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(150);
    }];

    _username = [UITextField new];
    _username.autocapitalizationType = UITextAutocapitalizationTypeNone;//设置首字母小写
    _username.placeholder = @"input your username";
    [_username setValue:[UIColor whiteColor] forKeyPath:@"placeholderLabel.textColor"];
    _username.backgroundColor = loginPage_TextField_Background_Color;
    _username.textColor = loginPage_TextField_Font_Color;
    _username.adjustsFontSizeToFitWidth = NO;
    [_username.font fontWithSize:loginPage_TextField_Font_Size];
    [self.view addSubview:_username];
    [_username mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(_gitLogo.mas_bottom).offset(30);
        make.height.mas_equalTo(self.view.mas_height).multipliedBy(0.05);
        make.width.mas_equalTo(self.view.mas_width).multipliedBy(0.9);
    }];

     _password = [UITextField new];
    _password.autocapitalizationType = UITextAutocapitalizationTypeNone;//设置首字母小写
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
        make.height.mas_equalTo(self.view.mas_height).multipliedBy(0.05);
        make.width.mas_equalTo(self.view.mas_width).multipliedBy(0.9);
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
        make.height.mas_equalTo(self.view.mas_height).multipliedBy(0.05);
        make.width.mas_equalTo(self.view.mas_width).multipliedBy(0.9);
    }];

    _accessToken = [UITextField new];
    _accessToken.placeholder = @"input accessToken";
    [_accessToken setValue:[UIColor whiteColor] forKeyPath:@"placeholderLabel.textColor"];
    _accessToken.backgroundColor = loginPage_TextField_Background_Color;
    _accessToken.textColor = loginPage_TextField_Font_Color;
    [_accessToken.font fontWithSize:loginPage_TextField_Font_Size];
    [self.view addSubview:_accessToken];
    [_accessToken mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(_gitLogo.mas_bottom).offset(30);
        make.height.mas_equalTo(self.view.mas_height).multipliedBy(0.05);
        make.width.mas_equalTo(self.view.mas_width).multipliedBy(0.9);
    }];
    _accessToken.hidden = YES;

    [_loginBT addTarget:self action:@selector(didLogin) forControlEvents:UIControlEventTouchUpInside];
    [_switchBtn addTarget:self action:@selector(didSwitch) forControlEvents:UIControlEventTouchUpInside];
}

-(void)tryLoginWithCache {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *accessToken = [defaults stringForKey:@"access_token"];
    __weak typeof(self) weakSelf = self;
    [[GCGithubApi shareGCGithubApi] loginWithAccessToken:accessToken WithSuccessBlock:^(id response) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.navigationController popViewControllerAnimated:YES];
        });
    } WithFailureBlock:^() {
    }
    ];
}

- (void)didLogin
{
    __weak typeof(self) weakSelf = self;
    if(![_switchBtn.titleLabel.text isEqualToString:@"access token login"]) {
        NSString *accessToken = _accessToken.text;
        [[GCGithubApi shareGCGithubApi] loginWithAccessToken:accessToken WithSuccessBlock:^(id response) {
                    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                    [defaults setObject:accessToken forKey:@"access_token"];
                    [defaults synchronize];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [weakSelf.navigationController popViewControllerAnimated:YES];
                    });
                } WithFailureBlock:^() {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        weakSelf.accessToken.hidden = false;
                        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"login failed" message:@"login failure" preferredStyle:UIAlertControllerStyleAlert];
                        [weakSelf presentViewController:alert animated:YES completion:nil];
                        [weakSelf performSelector:@selector(dismissAlert:) withObject:alert afterDelay:2.0];
                    });
                }
        ];
    }
    else {
        if([_username.text isEqualToString:@"yhdaydayup"] && [_password.text isEqualToString:@"abc123456"]) {
            NSString *accessToken = @"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";
            [[GCGithubApi shareGCGithubApi] loginWithAccessToken:accessToken WithSuccessBlock:^(id response) {
                    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                    [defaults setObject:accessToken forKey:@"access_token"];
                    [defaults synchronize];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [weakSelf.navigationController popViewControllerAnimated:YES];
                    });
                } WithFailureBlock:^() {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"login failed" message:@"login failure" preferredStyle:UIAlertControllerStyleAlert];
                        [weakSelf presentViewController:alert animated:YES completion:nil];
                        [weakSelf performSelector:@selector(dismissAlert:) withObject:alert afterDelay:2.0];
                    });
                }
        ];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"login failed" message:@"login failure" preferredStyle:UIAlertControllerStyleAlert];
            [weakSelf presentViewController:alert animated:YES completion:nil];
            [weakSelf performSelector:@selector(dismissAlert:) withObject:alert afterDelay:2.0];
        });
    }
}

- (void)dismissAlert:(UIAlertController*)alert {
    [alert dismissViewControllerAnimated:YES completion:nil];
}

- (void)didSwitch
{
    if([_switchBtn.titleLabel.text isEqualToString:@"access token login"]) {
        [_switchBtn setTitle:@"username login" forState:0];
        _username.hidden = true;
        _password.hidden = true;
        _accessToken.hidden = false;
    }
    else {
        [_switchBtn setTitle:@"access token login" forState:0];
        _username.hidden = false;
        _password.hidden = false;
        _accessToken.hidden = true;
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [_password resignFirstResponder];
    [_username resignFirstResponder];
    [_accessToken resignFirstResponder];
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
