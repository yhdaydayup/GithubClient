//
//  GCGithubApi.h
//  GithubClient
//
//  Created by bytedance on 2022/1/11.
//  Copyright © 2022 iosByYH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GCSearchModel.h"
#import <AFNetworking/AFURLRequestSerialization.h>

NS_ASSUME_NONNULL_BEGIN

NSString *getAuthenticatedUserRepositoriesUrl(void);

NSString *getRepositoryInformation(NSString *fullName);

NSString *getStaredUrl(NSString *owner, NSString *repo);

NSString *getForkUrl(NSString *owner, NSString *repo);

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

- (void) loginWithAccount:(NSString *)account WithSecret:(NSString *)secret WithSuccessBlock:(successBlock)successBlock WithFailuere:(failureBlock)failureBlock;

- (void)loginWithAccessToken:(NSString *)accessToken WithSuccessBlock:(successBlock)successBlock WithFailureBlock:(failureBlock)failureBlock;

+ (instancetype) shareGCGithubApi;

- (void)getWithUrl:(NSString*)url WithAcceptType:(contentType)type WithSuccessBlock:(successBlock)successBlock WithFailureBlock:(failureBlock)failureBlock;

- (void)getWithUrl:(NSString*)url WithAcceptType:(contentType)type WithParams:(NSMutableDictionary*)params WithSuccessBlock:(successBlock)successBlock WithFailureBlock:(failureBlock)failureBlock;

- (void)getWithSearchModel:(GCSearchModel*)model WithAcceptType:(contentType)type WithSuccessBlock:(successBlock)successBlock WithFailureBlock:(failureBlock)failureBlock;


- (void)putWithUrl:(NSString*)url WithSuccessBlock:(successBlock)successBlock WithFailureBlock:(failureBlock)failureBlock;
    
- (void)deleteWithUrl:(NSString*)url WithSuccessBlock:(successBlock)successBlock WithFailureBlock:(failureBlock)failureBlock;

- (void)postWithUrl:(NSString*)url WithAcceptType:(contentType)type WithParams:(NSMutableDictionary*)params constructingBodyWithBlock:(void(^)(id<AFMultipartFormData>))constructBlock WithSuccessBlock:(successBlock)successBlock WithFailureBlock:(failureBlock)failureBlock;

- (void)postWithUrl:(NSString*)url WithAcceptType:(contentType)type WithParams:(NSMutableDictionary*)params WithSuccessBlock:(successBlock)successBlock WithFailureBlock:(failureBlock)failureBlock;
@end

NS_ASSUME_NONNULL_END
