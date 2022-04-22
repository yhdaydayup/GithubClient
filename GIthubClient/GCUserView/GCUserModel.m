//
//  GCUserModel.m
//  GithubClient
//
//  Created by ByteDance on 2022/4/5.
//  Copyright © 2022 iosByYH. All rights reserved.
//

#import "GCUserModel.h"

@implementation GCUserModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"login"  : @"login",
             @"avatar_url"  : @"avatar_url",
             @"followers_url"  : @"followers_url",
             @"following_url"  : @"following_url",
             @"repos_url"  : @"repos_url",
             };
}

@end
