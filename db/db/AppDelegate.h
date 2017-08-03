//
//  AppDelegate.h
//  db
//
//  Created by ekhome on 16/12/19.
//  Copyright © 2016年 xiaofei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FMDB.h>
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic,strong)FMDatabase *db;
@end

