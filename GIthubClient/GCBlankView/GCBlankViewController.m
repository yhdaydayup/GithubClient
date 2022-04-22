//
//  GCBlankViewController.m
//  GithubClient
//
//  Created by ByteDance on 2022/4/2.
//  Copyright © 2022 iosByYH. All rights reserved.
//

#import "GCBlankViewController.h"
#import "Masonry/Masonry.h"

@interface GCBlankViewController ()

@end

@implementation GCBlankViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 2 - 50, 100, 300, 20)];
    label.numberOfLines = 0;
    label.text = @"当前功能尚未完成，敬请期待";
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor orangeColor];
    [self.view addSubview:label];
    self.view.backgroundColor = [UIColor whiteColor];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.width.mas_equalTo(self.view.mas_width).multipliedBy(0.7);
        make.height.mas_equalTo(20);
        make.top.mas_equalTo(self.view.mas_top).offset(200);
    }];
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

@end
