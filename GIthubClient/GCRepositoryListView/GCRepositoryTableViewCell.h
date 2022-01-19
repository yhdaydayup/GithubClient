//
//  GCRepositoryTableViewCell.h
//  GithubClient
//
//  Created by bytedance on 2022/1/13.
//  Copyright © 2022 iosByYH. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GCRepositoryTableViewCell : UITableViewCell
@property(strong, nonatomic) NSMutableDictionary *data;
- (void) setData:(NSMutableDictionary*)aData;
@end

NS_ASSUME_NONNULL_END
