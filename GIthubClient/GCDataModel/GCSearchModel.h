//
//  GCSearchModel.h
//  GithubClient
//
//  Created by ByteDance on 2022/2/26.
//  Copyright © 2022 iosByYH. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GCSearchModel : NSObject
@property (copy, nonatomic) NSString *url;
@property (strong, nonatomic) NSMutableDictionary *params;
@property (strong, nonatomic) NSMutableDictionary *headers;
- (instancetype)initWithUrl:(NSString*)aUrl WithParams:(NSMutableDictionary*)aParams WithHeaders:(NSMutableDictionary*)aHeaders;
@end

NS_ASSUME_NONNULL_END
