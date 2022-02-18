//
//  GCWorkSpaceTableViewCellModel.m
//  GithubClient
//
//  Created by bytedance on 2022/1/12.
//  Copyright © 2022 iosByYH. All rights reserved.
//

#import "GCWorkSpaceTableViewCellModel.h"

@interface GCWorkSpaceTableViewCellModel ()
@end

@implementation GCWorkSpaceTableViewCellModel
@synthesize cellActionClassName;
@synthesize title;
@synthesize imagePath;
- (instancetype) initWithClassName:(NSString*)cellActionClassName WithTitle:(NSString*)title WithImagePath:(NSString*)imagePath
{
    if(self = [super init])
    {
        self.cellActionClassName = cellActionClassName;
        self.title = title;
        self.imagePath = imagePath;
    }
    return self;
}
@end
