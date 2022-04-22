//
//  GCUserModel.h
//  GithubClient
//
//  Created by ByteDance on 2022/4/5.
//  Copyright © 2022 iosByYH. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GCUserModel : NSObject
@property (nonatomic , copy) NSString              * login;
@property (nonatomic , copy) NSString              * avatar_url;
@property (nonatomic , copy) NSString              * followers_url;
@property (nonatomic , copy) NSString              * following_url;
@property (nonatomic , copy) NSString              * repos_url;
@end

NS_ASSUME_NONNULL_END
