//
//  NSObject+GCDataModel.m
//  GithubClient
//
//  Created by bytedance on 2022/1/20.
//  Copyright © 2022 iosByYH. All rights reserved.
//

#import "NSObject+GCDataModel.h"
#import <YYModel/YYModel.h>
@implementation NSObject (GCDataModel)
+ (NSArray *)jsonsToModelsWithJsons:(NSArray *)jsons {
    NSMutableArray *models = [NSMutableArray array];
    for (NSDictionary *json in jsons) {
        id model = [[self class] yy_modelWithJSON:json];
        if (model) {
            [models addObject:model];
        }
    }
    return models;
}
@end
