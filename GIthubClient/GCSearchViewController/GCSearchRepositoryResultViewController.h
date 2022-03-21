//
//  GCSearchRepositoryResultViewController.h
//  GithubClient
//
//  Created by bytedance on 2022/1/28.
//  Copyright © 2022 iosByYH. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, SelectStatus) {
    ShowRepository,
    ShowUser
};

@interface GCSearchRepositoryResultViewController : UIViewController
- (instancetype) initWithSearchText:(NSString *)text;
@end

NS_ASSUME_NONNULL_END
