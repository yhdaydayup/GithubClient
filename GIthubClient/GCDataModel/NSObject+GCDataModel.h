//
//  NSObject+GCDataModel.h
//  GithubClient
//
//  Created by bytedance on 2022/1/20.
//  Copyright © 2022 iosByYH. All rights reserved.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN

@interface NSObject (GCDataModel)
+ (NSMutableArray *)jsonsToModelsWithJsons:(NSArray *)jsons;
@end

NS_ASSUME_NONNULL_END
