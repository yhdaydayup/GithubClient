//
//  GCWorkSpaceTableViewCellModel.h
//  GithubClient
//
//  Created by bytedance on 2022/1/12.
//  Copyright © 2022 iosByYH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GCWorkSpaceTableViewCellModel : NSObject
- (instancetype) initWithClassName:(NSString*)cellClassName WithTitle:(NSString*)title WithImagePath:(NSString*)imagePath;
@property (copy, nonatomic) NSString* cellActionClassName;
@property (copy, nonatomic) NSString* title;
@property (copy, nonatomic) NSString* imagePath;
@end

NS_ASSUME_NONNULL_END
