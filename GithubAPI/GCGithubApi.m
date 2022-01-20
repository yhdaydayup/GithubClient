//
//  GCGithubApi.m
//  GithubClient
//
//  Created by bytedance on 2022/1/11.
//  Copyright © 2022 iosByYH. All rights reserved.
//

#import "GCGithubApi.h"
#import <AFNetworking/AFNetworking.h>
#import <YYModel/YYModel.h>
#import "GCRepositoryListData.h"
#import "NSObject+GCDataModel.h"

NSString *getAuthenticatedUserRepositoriesUrl(void){
    return @"https://api.github.com/user/repos";
}

NSString *getStaredUrl(NSString *owner, NSString *repo){
    return [[NSString alloc] initWithFormat:@"https://api.github.com/user/starred/%@/%@",owner,repo];
}


@interface GCGithubApi ()
@property (strong, nonatomic) NSString* access_token;
@property (strong, nonatomic) NSDictionary *params;
@property (strong, nonatomic) NSDictionary *headers;
@property (strong, nonatomic) AFHTTPSessionManager *manager;
@end

@implementation GCGithubApi
- (BOOL) isLogin
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    _access_token = [defaults stringForKey:@"access_token"];
    _headers = @{@"Authorization": [[NSString alloc] initWithFormat:@"token %@", _access_token]};
    NSLog(@"%@", _access_token);
    return _access_token != nil;
}
- (BOOL) loginWithAccount:(NSString *)account WithSecret:(NSString *)secret
{
    //_access_token 会有有效期
    _access_token = @"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";
    _headers = @{@"Authorization": [[NSString alloc] initWithFormat:@"token %@", _access_token]};
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSLog(@"%@", _access_token);
    [defaults setObject:_access_token forKey:@"access_token"];
    [defaults synchronize];
    return _access_token != nil;
}
- (instancetype) init{
    if(self = [super init]){
        _params = @{@"Accept" : @"application/vnd.github.v3+json"};
        //headers的获取时间还需要调整
        _manager = [AFHTTPSessionManager manager];
        _manager.requestSerializer = [AFJSONRequestSerializer serializer];
        _manager.responseSerializer = [AFJSONResponseSerializer serializer];
        _manager.requestSerializer.timeoutInterval = 30;
        _manager.completionQueue=dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0);
    }
    return self;
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

// status 204 not content 说明stared ， 404 not found 说明没有star

- (void)getWithUrl:(NSString*)url WithSuccessBlock:(successBlock)successBlock WithFailureBlock:(failureBlock)failureBlock{
    [_manager GET:url parameters:_params headers:_headers progress:nil success:^(NSURLSessionDataTask* _Nonnull task, id responseObject){
        dispatch_async(dispatch_get_main_queue(), ^{
            successBlock(responseObject);
        });
    } failure:^(NSURLSessionDataTask *task, NSError *error){
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"%@", error);
            failureBlock();
        });
    }];
}

- (void)putWithUrl:(NSString*)url WithSuccessBlock:(successBlock)successBlock WithFailureBlock:(failureBlock)failureBlock{
    [_manager PUT:url parameters:_params headers:_headers success:^(NSURLSessionDataTask* _Nonnull task, id responseObject){
            NSLog(@"%@", responseObject);
            dispatch_async(dispatch_get_main_queue(), ^{
                successBlock(responseObject);
            });
        } failure:^(NSURLSessionDataTask *task, NSError *error){
            NSLog(@"%@", error);
            dispatch_async(dispatch_get_main_queue(), ^{
                failureBlock();
            });
        }
    ];
}
- (void)deleteWithUrl:(NSString*)url WithSuccessBlock:(successBlock)successBlock WithFailureBlock:(failureBlock)failureBlock{
    [_manager DELETE:url parameters:_params headers:_headers success:^(NSURLSessionDataTask* _Nonnull task, id responseObject){
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"%@", responseObject);
            successBlock(responseObject);
        });
    } failure:^(NSURLSessionDataTask *task, NSError *error){
        NSLog(@"%@", error);
        dispatch_async(dispatch_get_main_queue(), ^{
            failureBlock();
        });
    }];
}
@end
