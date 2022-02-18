//
//  GCLicense.h
//  GithubClient
//
//  Created by bytedance on 2022/1/28.
//  Copyright © 2022 iosByYH. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GCLicense :NSObject
@property (nonatomic , copy) NSString              * key;
@property (nonatomic , copy) NSString              * name;
@property (nonatomic , copy) NSString              * spdx_id;
@property (nonatomic , copy) NSString              * url;
@property (nonatomic , copy) NSString              * node_id;

@end

NS_ASSUME_NONNULL_END
