//
//  image.h
//  db
//
//  Created by ekhome on 17/7/31.
//  Copyright © 2017年 xiaofei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface image : NSObject
@property (nonatomic,strong)NSString *imageUrlPath;
@property (nonatomic,strong)NSString *imageLocalPath;
@property (nonatomic,strong)NSData *imageData;
@property (nonatomic,strong)NSString *imageTime;
@property (nonatomic,strong)NSString *imageSize;
@property (nonatomic,strong)NSString *title;
@property (nonatomic,strong)NSString *desc;


@end
