//
//  GCTools.m
//  GithubClient
//
//  Created by bytedance on 2022/1/18.
//  Copyright © 2022 iosByYH. All rights reserved.
//

#import "GCTools.h"

void setRequiredOnVerticalAndHorizontalForUIView(UIView *widget)
{
    [widget setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [widget setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    [widget setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [widget setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
}

