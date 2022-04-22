//
//  GCTabBarController.m
//  GithubClient
//
//  Created by bytedance on 2022/1/11.
//  Copyright © 2022 iosByYH. All rights reserved.
//

#import "GCTabBarController.h"
#import "GCWorkSpaceViewController.h"
#import "configure.h"
#import <Masonry.h>
#import "GCSearchViewController.h"
#import "GCPersonalViewController.h"

#define WorkImagePath  @"work.png"
#define WorkFillingImagePath @"work-filling.png"
#define NotificationImagePath @"notification.png"
#define NotificationFillingImagePath @"notification-filling.png"
#define SearchImagePath @"task.png"
#define SearchFillingImagePath @"task-filling.png"
#define HomeImagePath @"home.png"
#define HomeFillingImagePath @"home-filling.png"

@interface GCTabBarController ()
@property (copy, nonatomic) NSMutableArray<UIViewController*> *controllerArray;
@end

@implementation GCTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _controllerArray = [[NSMutableArray<UIViewController*> alloc] init];
    [_controllerArray addObject:[self addTabBarViewController:[GCWorkSpaceViewController class] WithTitle:@"工作台" WithImagePath:WorkImagePath WithSelectedImagePath:WorkFillingImagePath]];
    [_controllerArray addObject:[self addTabBarViewController:[GCSearchViewController class] WithTitle:@"搜索" WithImagePath:@"search.png" WithSelectedImagePath:@"search-fill.png"]];
    [_controllerArray addObject:[self addTabBarViewController:[GCPersonalViewController class] WithTitle:@"我" WithImagePath:@"task.png" WithSelectedImagePath:@"task-fill.png"]];
    self.viewControllers = _controllerArray;
}
- (UIViewController*) addTabBarViewController:(Class)className WithTitle:(NSString*)title WithImagePath:(NSString*)imagePath WithSelectedImagePath:(NSString*)selectedImagePath
{
    UIViewController *vc = [[className alloc] init];
    vc.view.frame = self.view.bounds;
    vc.navigationItem.title = title;
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:imagePath];
    vc.tabBarItem.selectedImage = [UIImage imageNamed:selectedImagePath];
    vc.view.backgroundColor = TabBarPage_Background_color;
    return vc;
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
