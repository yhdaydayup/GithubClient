//
//  GCFolderData.m
//  GithubClient
//
//  Created by bytedance on 2022/1/26.
//  Copyright © 2022 iosByYH. All rights reserved.
//

#import "GCFolderData.h"

@implementation GCTreeItem
@end


@implementation GCFolderData
// 返回容器类中的所需要存放的数据类型 (以 Class 或 Class Name 的形式)。
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"tree" : [GCTreeItem class]};
}
@end
