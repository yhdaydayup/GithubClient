//
//  GCRepositoryListViewController.h
//  GithubClient
//
//  Created by bytedance on 2022/1/14.
//  Copyright © 2022 iosByYH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GCRepositoryListData.h"

NS_ASSUME_NONNULL_BEGIN

@interface GCRepositoryListViewController : UIViewController
- (void) setData:(GCRepositoryListData*) aData;
- (void) reloadData;
@end

NS_ASSUME_NONNULL_END
