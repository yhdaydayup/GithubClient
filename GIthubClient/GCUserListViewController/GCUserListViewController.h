//
//  GCUserListViewController.h
//  GithubClient
//
//  Created by ByteDance on 2022/4/5.
//  Copyright © 2022 iosByYH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GCSearchModel.h"

NS_ASSUME_NONNULL_BEGIN
@class GCUserModel;
@interface GCUserListViewController : UIViewController
@property (strong, nonatomic) GCSearchModel *model;
@property (weak, nonatomic) UINavigationController *nav;
@property (strong, nonatomic) NSMutableArray<GCUserModel*> *data;
@end

NS_ASSUME_NONNULL_END
