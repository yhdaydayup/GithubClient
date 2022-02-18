//
//  GCPermissions.h
//  GithubClient
//
//  Created by bytedance on 2022/1/28.
//  Copyright © 2022 iosByYH. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GCPermissions :NSObject
@property (nonatomic , assign) BOOL              admin;
@property (nonatomic , assign) BOOL              maintain;
@property (nonatomic , assign) BOOL              push;
@property (nonatomic , assign) BOOL              triage;
@property (nonatomic , assign) BOOL              pull;

@end

NS_ASSUME_NONNULL_END
