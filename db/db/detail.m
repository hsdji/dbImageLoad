//
//  detail.m
//  db
//
//  Created by ekhome on 17/7/21.
//  Copyright © 2017年 xiaofei. All rights reserved.
//

#import "detail.h"

@implementation detail
- (NSString *)table_id {
    if(_table_id == nil) {
        _table_id = [[NSString alloc] init];
    }
    return _table_id;
}

- (NSString *)urlString {
    if(_urlString == nil) {
        _urlString = [[NSString alloc] init];
    }
    return _urlString;
}

- (NSString *)imagPath {
    if(_imagPath == nil) {
        _imagPath = [[NSString alloc] init];
    }
    return _imagPath;
}
@end
