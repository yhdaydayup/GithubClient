//
//  GCGithubApi.m
//  GithubClient
//
//  Created by bytedance on 2022/1/11.
//  Copyright © 2022 iosByYH. All rights reserved.
//

#import "GCGithubApi.h"

@interface GCGithubApi ()
@property (strong, nonatomic) NSString* access_token;
@end

@implementation GCGithubApi
+(AFHTTPSessionManager *)shareHttpSessionManagerInstance
{
    static AFHTTPSessionManager * manager = nil;
    static dispatch_once_t onceToken;
    //dispatch_once 表示这个事件只执行一次，而且是线程安全的
    //这里说明初始化只做一次，返回单例
    dispatch_once(&onceToken, ^{
        manager = [AFHTTPSessionManager manager];
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        manager.requestSerializer.timeoutInterval = 30;
        manager.completionQueue=dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0);
    });
    return manager;
}

- (BOOL) isLogin
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *token = [defaults stringForKey:@"access_token"];
    NSLog(@"%@", token);
    return token != nil;
}
- (BOOL) loginWithAccount:(NSString *)account WithSecret:(NSString *)secret
{
    //_access_token 会有有效期
    static dispatch_once_t onceToken;   // typedef long dispatch_once_t;
    dispatch_once(&onceToken, ^{
        _access_token = @"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";
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSLog(@"%@", _access_token);
        [defaults setObject:_access_token forKey:@"access_token"];
        [defaults synchronize];
    });
    return _access_token != nil;
}
+ (instancetype) shareGCGithubApi
{
    static GCGithubApi* sharedInstance;
    static dispatch_once_t onceToken;   // typedef long dispatch_once_t;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (void)getAuthenticatedUserRepositoriesWithSuccessBlock:(successBlock)successBlock WithFailureBlock:(failureBlock)failureBlock
{
    AFHTTPSessionManager *manager = [[self class]  shareHttpSessionManagerInstance];
    NSMutableArray<NSMutableDictionary*> *dictArray = [[NSMutableArray<NSMutableDictionary*> alloc] init];
    NSDictionary *params = @{@"Accept" : @"application/vnd.github.v3+json"};
    NSDictionary *headers = @{@"Authorization": [[NSString alloc] initWithFormat:@"token %@", _access_token]};
    [manager GET:@"https://api.github.com/user/repos" parameters:params headers:headers progress:nil success:^(NSURLSessionDataTask* _Nonnull task, NSDictionary* _Nonnull responseObject){
        NSLog(@"%@", responseObject);
        for(NSDictionary* obj in responseObject){
            NSLog(@"%@", obj);
            NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
            // @"owner" @"name" @"starazers_count" @"forks_count" @"description" @"language"
            //owner.login owner.avatar_url
//            [dict setValue:@"owner" forKey:@"owner"];
            [dict setValue:[obj valueForKey:@"owner"] forKey:@"owner"];
            [dict setValue:[obj valueForKey:@"name"] forKey:@"name"];
            [dict setValue:[obj valueForKey:@"stargazers_count"] forKey:@"stargazers_count"];
            [dict setValue:[obj valueForKey:@"forks_count"] forKey:@"forks_count"];
            [dict setValue:[obj valueForKey:@"description"] forKey:@"description"];
            [dict setValue:[obj valueForKey:@"language"] forKey:@"language"];
            [dictArray addObject:dict];
            NSLog(@"%@", dictArray);
            NSLog(@"get data success");
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            successBlock(dictArray);
        });
    } failure:^(NSURLSessionDataTask *task, NSError *error){
        NSLog(@"get data false, %@", error);
        failureBlock();
    }];
}
@end
