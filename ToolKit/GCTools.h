//
//  GCTools.h
//  GithubClient
//
//  Created by bytedance on 2022/1/18.
//  Copyright © 2022 iosByYH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
void setRequiredOnVerticalAndHorizontalForUIView(UIView *widget);

@protocol HitChains <NSObject>
-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event;
@end

NS_ASSUME_NONNULL_END
