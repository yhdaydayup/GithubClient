//
//  GCFilterView.h
//  GithubClient
//
//  Created by bytedance on 2022/2/7.
//  Copyright © 2022 iosByYH. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GCFilterView : UIView
@property (strong, nonatomic) NSString *sortBy;
@property (strong, nonatomic) NSString *language;
@property (nonatomic) BOOL orderRule;
@end

NS_ASSUME_NONNULL_END
