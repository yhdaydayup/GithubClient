//
//  UILabel+Font.m
//  GithubClient
//
//  Created by ByteDance on 2022/3/23.
//  Copyright © 2022 iosByYH. All rights reserved.
//

#import "UILabel+Font.h"

@implementation UILabel (Font)
-(instancetype)init {
    if(self = [super init]) {
        [self useBaseStyle];
    }
    return self;
}
-(void)useBaseStyle {
    self.font = [UIFont fontWithName:@"Helvetica" size:14];
}
-(void)useBoldStyle {
    self.font = [UIFont fontWithName:@"Helvetica-bold" size:17];
}
@end
