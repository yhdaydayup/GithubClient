//
//  GCBlobViewController.h
//  GithubClient
//
//  Created by bytedance on 2022/1/27.
//  Copyright © 2022 iosByYH. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GCBlobViewController : UIViewController
- (instancetype)initWithFullName:(NSString *)fullName WithSha:(NSString *)sha;
@end

NS_ASSUME_NONNULL_END
