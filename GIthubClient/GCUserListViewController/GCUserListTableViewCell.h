//
//  GCUserListTableViewCell.h
//  GithubClient
//
//  Created by ByteDance on 2022/4/5.
//  Copyright © 2022 iosByYH. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class GCUserModel;
@interface GCUserListTableViewCell : UITableViewCell
@property (strong, nonatomic) GCUserModel *model;
@end

NS_ASSUME_NONNULL_END
