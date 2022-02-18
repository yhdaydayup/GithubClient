//
//  GCFolderData.h
//  GithubClient
//
//  Created by bytedance on 2022/1/26.
//  Copyright © 2022 iosByYH. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GCTreeItem :NSObject
@property (nonatomic , copy) NSString              * path;
@property (nonatomic , copy) NSString              * mode;
@property (nonatomic , copy) NSString              * type;
@property (nonatomic , assign) NSInteger              size;
@property (nonatomic , copy) NSString              * sha;
@property (nonatomic , copy) NSString              * url;

@end


@interface GCFolderData :NSObject
@property (nonatomic , copy) NSString              * sha;
@property (nonatomic , copy) NSString              * url;
@property (nonatomic , strong) NSArray <GCTreeItem*>  *tree;
@property (nonatomic , assign) BOOL              truncated;

@end

NS_ASSUME_NONNULL_END
