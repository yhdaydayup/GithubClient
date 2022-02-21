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

NSString *getRepositoryInformation(NSString *fullName){
    return [[NSString alloc] initWithFormat:@"https://api.github.com/repos/%@", fullName];
}

NSString *getStaredUrl(NSString *owner, NSString *repo){
    return [[NSString alloc] initWithFormat:@"https://api.github.com/user/starred/%@/%@",owner,repo];
}

NSString *getReadmeUrl(NSString *fullName){
    return [[NSString alloc] initWithFormat:@"https://api.github.com/repos/%@/readme", fullName];
}

NSString *getFolderUrl(NSString *fullName, NSString *sha){
    if(sha == nil) {
        return [[NSString alloc] initWithFormat:@"https://api.github.com/repos/%@/contents", fullName];
    }
    return [[NSString alloc] initWithFormat:@"https://api.github.com/repos/%@/git/trees/%@", fullName, sha];
}


NSString *getAuthenticatedUserInfo(void) {
    return [[NSString alloc] initWithFormat:@"https://api.github.com/user"];
}


NSString *getBlogUrl(NSString *fullName, NSString *sha){
    return [[NSString alloc] initWithFormat:@"https://api.github.com/repos/%@/git/blobs/%@", fullName, sha];
}

NSString *getUserStarRepositoryUrl(NSString *userName) {
    return [[NSString alloc] initWithFormat:@"https://api.github.com/users/%@/starred", userName];
}

//q=tetris+language:assembly&sort=stars&order=desc
NSString *getRepositorySearch(void) {
    return [[NSString alloc] initWithFormat:@"https://api.github.com/search/repositories"];
//    NSString *topic = [[NSString alloc] stringWithFormat:@"topic=%@", language];
//     NSString *q = [NSString *]
}

//代理NSURLSessionDelegate，为了使用NSURL，可以拦截302重定向请求
@interface GCGithubApi () <NSURLSessionTaskDelegate>
@property (strong, nonatomic) NSString* access_token;
@property (strong, nonatomic) NSDictionary *params;
@property (strong, nonatomic) NSDictionary *rawParams;
@property (strong, nonatomic) NSDictionary *headers;
@property (strong, nonatomic) AFHTTPSessionManager *manager;
@end

@implementation GCGithubApi
- (BOOL) isLogin
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:@"access_token"];
    _access_token = [defaults stringForKey:@"access_token"];
    _headers = @{@"Authorization": [[NSString alloc] initWithFormat:@"token %@", _access_token]};
    return _access_token != nil;
}
- (BOOL) loginWithAccount:(NSString *)account WithSecret:(NSString *)secret
{
    //_access_token 会有有效期
    _access_token = @"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";
    _headers = @{@"Authorization": [[NSString alloc] initWithFormat:@"token %@", _access_token]};
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:_access_token forKey:@"access_token"];
    [defaults synchronize];
    [self login];
    
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

- (void)getWithUrl:(NSString*)url WithAcceptType:(contentType)type WithSuccessBlock:(successBlock)successBlock WithFailureBlock:(failureBlock)failureBlock{
    if(type == JSonContent) {
        _params = @{@"Accept" : @"application/vnd.github.v3+json"};
    }
    else if(type == RawContent) {
        _params = @{@"Accept" : @"application/vnd.github.VERSION.raw"};
    }
    else if(type == HtmlContent) {
        _params = @{@"Accept" : @"application/vnd.github.VERSION.html"};
    }
    [_manager GET:url parameters:_params headers:_headers progress:nil success:^(NSURLSessionDataTask* _Nonnull task, id responseObject){
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"%@", task.currentRequest);
            successBlock(responseObject);
        });
    } failure:^(NSURLSessionDataTask *task, NSError *error){
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"%@", error);
            failureBlock();
        });
    }];
}

- (void)getWithUrl:(NSString*)url WithAcceptType:(contentType)type WithParams:(NSMutableDictionary*)params WithSuccessBlock:(successBlock)successBlock WithFailureBlock:(failureBlock)failureBlock{
    if(type == JSonContent) {
        [params setObject:@"Accept" forKey:@"application/vnd.github.v3+json"];
    }
    else if(type == RawContent) {
        [params setObject:@"Accept" forKey:@"application/vnd.github.VERSION.raw"];
    }
    else if(type == HtmlContent) {
        [params setObject:@"Accept" forKey:@"application/vnd.github.VERSION.html"];
    }
    [_manager GET:url parameters:params headers:_headers progress:nil success:^(NSURLSessionDataTask* _Nonnull task, id responseObject){
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"%@", task.currentRequest);
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
    _params = @{@"Accept" : @"application/vnd.github.v3+json"};
    _manager.responseSerializer = [AFJSONResponseSerializer serializer];
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
    _params = @{@"Accept" : @"application/vnd.github.v3+json"};
    _manager.responseSerializer = [AFJSONResponseSerializer serializer];
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

#pragma mark -NSUrlForLogin
- (void) login
{
 //@"https://github.com/login/oauth/authorize?client_id=05541e634a45be28bdd369f657bc9f29da60a64a&redirect_uri=http://localhost:8080&login=2743897969@qq.com&scope=repo"
    
//    _params = @{@"Accept" : @"application/vnd.github.v3+json",
//                @"client_id" : @"3ed2e4be30f051e64174",
//                @"login" : @"2743897969@qq.com",
//                @"scope" : @"repo"
//    };
//    //@"https://github.com/login/oauth/authorize?client_id=05541e634a45be28bdd369f657bc9f29da60a64a0&login=2743897969@qq.com&scope=repo"
//    _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    [self getWithUrl:@"https://github.com/login/oauth/authorize" WithSuccessBlock:^(id responseObj){
//        NSLog(@"%@", responseObj);
//
//    } WithFailureBlock:^{}];
    
//    NSURL *baseURL = [NSURL URLWithString:@"https://github.com"];
//    AFOAuth2Manager *OAuth2Manager =
//                [[AFOAuth2Manager alloc] initWithBaseURL:baseURL
//                                                clientID:@"3ed2e4be30f051e64174"
//                                                  secret:@"727bf2227c02326c67e6ee5f4a4913f4ad8838c6"];
//
//    OAuth2Manager.requestSerializer = [AFHTTPRequestSerializer serializer];
//    OAuth2Manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    OAuth2Manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
//    [OAuth2Manager authenticateUsingOAuthWithURLString:@"/login/oauth/authorize"
//                                              username:@"2743897969@qq.com"
//                                              password:@"wyh2743897969"
//                                                 scope:@"repo"
//                                               success:^(AFOAuthCredential *credential) {
//                                                   NSLog(@"Token: %@", credential.accessToken);
//                                               }
//                                               failure:^(NSError *error) {
//                                                   NSLog(@"Error: %@", error);
//                                               }];
}
@end
