//
//  GCFolderTableViewCell.h
//  GithubClient
//
//  Created by bytedance on 2022/1/26.
//  Copyright © 2022 iosByYH. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class  GCTreeItem;

@interface GCFolderTableViewCell : UITableViewCell
- (void)setData:(GCTreeItem*) tree;
@end

NS_ASSUME_NONNULL_END
