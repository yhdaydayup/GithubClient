//
//  GCPersonalViewController.h
//  GithubClient
//
//  Created by ByteDance on 2022/3/22.
//  Copyright © 2022 iosByYH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GCUserModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^block)(void);
@interface GCPersonalViewController : UIViewController
@property (strong, nonatomic) GCUserModel *model;
@end

NS_ASSUME_NONNULL_END
