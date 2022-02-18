//
//  GCRepositoryViewController.h
//  GithubClient
//
//  Created by bytedance on 2022/1/17.
//  Copyright © 2022 iosByYH. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class GCRepositoryData;

@interface GCRepositoryViewController : UIViewController
@property (strong, nonatomic) GCRepositoryData *data;
@property (copy, nonatomic) NSString* fullName;
- (instancetype) initWithFullName:(NSString*)fullName;
@end

NS_ASSUME_NONNULL_END
