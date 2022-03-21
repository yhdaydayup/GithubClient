//
//  GCRepositoryListViewController.h
//  GithubClient
//
//  Created by bytedance on 2022/1/14.
//  Copyright © 2022 iosByYH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GCRepositoryListData.h"
#import "GCSearchModel.h"

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger,RepositoryType)
{
    Star,
    User,
};
@interface GCRepositoryListViewController : UIViewController
-(instancetype)init;
-(void)typeAct:(RepositoryType)type;
@property (strong, nonatomic) GCSearchModel *model;
- (void)setModel:(GCSearchModel *)aModel;
- (void) setData:(GCRepositoryListData*) aData;
- (void) reloadData;
@property (weak, nonatomic) UINavigationController *nav;
@end

NS_ASSUME_NONNULL_END
