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

NSString *getRepositoryInformation(NSString *fullName);

NSString *getStaredUrl(NSString *owner, NSString *repo);

NSString *getReadmeUrl(NSString *fullName);

NSString *getFolderUrl(NSString *fullName, NSString *sha);

NSString *getBlogUrl(NSString *fullName, NSString *sha);

NSString *getUserStarRepositoryUrl(NSString *userName);

NSString *getAuthenticatedUserInfo(void);

typedef NS_ENUM(NSInteger, contentType) {
    JSonContent,
    RawContent,
    HtmlContent
};

typedef void (^successBlock)(id);
typedef void(^failureBlock)(void);
@interface GCGithubApi : NSObject
- (BOOL) loginWithAccount:(NSString *)account WithSecret:(NSString *)secret;
- (BOOL) isLogin;
+ (instancetype) shareGCGithubApi;



- (void)getWithUrl:(NSString*)url WithAcceptType:(contentType)type WithSuccessBlock:(successBlock)successBlock WithFailureBlock:(failureBlock)failureBlock;

- (void)getWithUrl:(NSString*)url WithAcceptType:(contentType)type WithParams:(NSMutableDictionary*)params WithSuccessBlock:(successBlock)successBlock WithFailureBlock:(failureBlock)failureBlock;


- (void)putWithUrl:(NSString*)url WithSuccessBlock:(successBlock)successBlock WithFailureBlock:(failureBlock)failureBlock;
    
- (void)deleteWithUrl:(NSString*)url WithSuccessBlock:(successBlock)successBlock WithFailureBlock:(failureBlock)failureBlock;
@end

NS_ASSUME_NONNULL_END
