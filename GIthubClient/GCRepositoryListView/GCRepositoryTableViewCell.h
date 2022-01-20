//
//  GCRepositoryTableViewCell.h
//  GithubClient
//
//  Created by bytedance on 2022/1/13.
//  Copyright © 2022 iosByYH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GCRepositoryListData.h"
NS_ASSUME_NONNULL_BEGIN


@interface GCRepositoryTableViewCell : UITableViewCell
@property(strong, nonatomic) GCRepositoryListDatum *data;
- (void) setData:(GCRepositoryListDatum*)aData;
@end

NS_ASSUME_NONNULL_END
