//
//  CollectionViewCell.m
//  db
//
//  Created by ekhome on 17/8/1.
//  Copyright © 2017年 xiaofei. All rights reserved.
//

#import "CollectionViewCell.h"

@implementation CollectionViewCell
-(UIImageView *)imageView
{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 150, 180)];
        [self addSubview:_imageView];
    }
    return _imageView;
}
@end
