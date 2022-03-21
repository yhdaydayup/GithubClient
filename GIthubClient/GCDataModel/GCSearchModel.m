//
//  GCSearchModel.m
//  GithubClient
//
//  Created by ByteDance on 2022/2/26.
//  Copyright © 2022 iosByYH. All rights reserved.
//

#import "GCSearchModel.h"

@implementation GCSearchModel
- (instancetype)initWithUrl:(NSString*)aUrl WithParams:(NSMutableDictionary*)aParams WithHeaders:(NSMutableDictionary*)aHeaders {
    if(self = [super init]) {
        _url = aUrl;
        _params = aParams;
        _headers = aHeaders;
    }
    return self;
}
@end
