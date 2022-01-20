//
//  AppDelegate.m
//  GIthubClient
//
//  Created by bytedance on 2022/1/11.
//

#import "AppDelegate.h"
#import "GCTabBarController.h"
#import "GCLoginViewController.h"
@interface AppDelegate ()

@end

//https://github.com/login/oauth/authorize?client_id=3ed2e4be30f051e64174&scope=repo&redirect_uri=http://localhost:5288
//personal token for test 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

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];//设置和界面大小的窗口
    self.window.backgroundColor=[UIColor whiteColor];
    
    GCTabBarController *TabBarVC = [[GCTabBarController alloc] init];
    TabBarVC.view.frame = self.window.bounds;
    
    UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:TabBarVC];
    self.window.rootViewController = nvc;
    [self.window makeKeyAndVisible];
    
    
//    GCLoginViewController *loginPageVC = [[GCLoginViewController alloc] init];
//    [nvc pushViewController:loginPageVC animated:YES];
    if([[GCGithubApi shareGCGithubApi] isLogin])
    {
    }
    else
    {
        GCLoginViewController *loginPageVC = [[GCLoginViewController alloc] init];
        [nvc pushViewController:loginPageVC animated:YES];
    }
    
    return YES;
}


#pragma mark - UISceneSession lifecycle
@end
