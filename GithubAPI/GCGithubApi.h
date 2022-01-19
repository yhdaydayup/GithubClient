//
//  GCGithubApi.h
//  GithubClient
//
//  Created by bytedance on 2022/1/11.
//  Copyright © 2022 iosByYH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
NS_ASSUME_NONNULL_BEGIN


typedef void (^successBlock)(id);
typedef void(^failureBlock)(void);
@interface GCGithubApi : NSObject
- (BOOL) loginWithAccount:(NSString *)account WithSecret:(NSString *)secret;
- (BOOL) isLogin;
+ (instancetype) shareGCGithubApi;
- (void)getAuthenticatedUserRepositoriesWithSuccessBlock:(successBlock)successBlock WithFailureBlock:(failureBlock)failureBlock;
+(AFHTTPSessionManager *)shareHttpSessionManagerInstance;
@end

NS_ASSUME_NONNULL_END
