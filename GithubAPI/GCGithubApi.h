//
//  GCGithubApi.h
//  GithubClient
//
//  Created by bytedance on 2022/1/11.
//  Copyright © 2022 iosByYH. All rights reserved.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN

NSString *getAuthenticatedUserRepositoriesUrl(void);

NSString *getStaredUrl(NSString *owner, NSString *repo);

typedef void (^successBlock)(id);
typedef void(^failureBlock)(void);
@interface GCGithubApi : NSObject
- (BOOL) loginWithAccount:(NSString *)account WithSecret:(NSString *)secret;
- (BOOL) isLogin;
+ (instancetype) shareGCGithubApi;

- (void)getWithUrl:(NSString*)url WithSuccessBlock:(successBlock)successBlock WithFailureBlock:(failureBlock)failureBlock;

- (void)putWithUrl:(NSString*)url WithSuccessBlock:(successBlock)successBlock WithFailureBlock:(failureBlock)failureBlock;
    
- (void)deleteWithUrl:(NSString*)url WithSuccessBlock:(successBlock)successBlock WithFailureBlock:(failureBlock)failureBlock;
@end

NS_ASSUME_NONNULL_END
