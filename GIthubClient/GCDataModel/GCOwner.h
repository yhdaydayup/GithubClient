//
//  GCOwner.h
//  GithubClient
//
//  Created by bytedance on 2022/1/28.
//  Copyright © 2022 iosByYH. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GCOwner :NSObject

@property (nonatomic , copy) NSString              * login;
@property (nonatomic , assign) NSInteger              id_;
@property (nonatomic , copy) NSString              * node_id;
@property (nonatomic , copy) NSString              * avatar_url;
@property (nonatomic , copy) NSString              * gravatar_id;
@property (nonatomic , copy) NSString              * url;
@property (nonatomic , copy) NSString              * html_url;
@property (nonatomic , copy) NSString              * followers_url;
@property (nonatomic , copy) NSString              * following_url;
@property (nonatomic , copy) NSString              * gists_url;
@property (nonatomic , copy) NSString              * starred_url;
@property (nonatomic , copy) NSString              * subscriptions_url;
@property (nonatomic , copy) NSString              * organizations_url;
@property (nonatomic , copy) NSString              * repos_url;
@property (nonatomic , copy) NSString              * events_url;
@property (nonatomic , copy) NSString              * received_events_url;
@property (nonatomic , copy) NSString              * type;
@property (nonatomic , assign) BOOL              site_admin;

@end

NS_ASSUME_NONNULL_END
