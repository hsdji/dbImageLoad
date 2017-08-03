//
//  image.m
//  db
//
//  Created by ekhome on 17/7/31.
//  Copyright © 2017年 xiaofei. All rights reserved.
//

#import "image.h"

@implementation image
- (NSString *)imageUrlPath {
    if(_imageUrlPath == nil) {
        _imageUrlPath = [[NSString alloc] init];
    }
    return _imageUrlPath;
}

- (NSString *)imageLocalPath {
    if(_imageLocalPath == nil) {
        _imageLocalPath = [[NSString alloc] init];
    }
    return _imageLocalPath;
}

- (NSData *)imageData {
    if(_imageData == nil) {
        _imageData = [[NSData alloc] init];
    }
    return _imageData;
}


- (NSString *)title {
    if(_title == nil) {
        _title = [[NSString alloc] init];
    }
    return _title;
}

- (NSString *)desc {
    if(_desc == nil) {
        _desc = [[NSString alloc] init];
    }
    return _desc;
}
@end
