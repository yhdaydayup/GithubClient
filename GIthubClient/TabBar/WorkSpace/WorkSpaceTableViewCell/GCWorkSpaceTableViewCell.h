//
//  GCWorkSpaceTableViewCell.h
//  GithubClient
//
//  Created by bytedance on 2022/1/12.
//  Copyright © 2022 iosByYH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GCWorkSpaceTableViewCellModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface GCWorkSpaceTableViewCell : UITableViewCell
@property (strong, nonatomic) UIImageView *imageArea;
- (void) setModel:(GCWorkSpaceTableViewCellModel *)model;
@end

NS_ASSUME_NONNULL_END
