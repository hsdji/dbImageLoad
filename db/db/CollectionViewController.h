//
//  CollectionViewController.h
//  db
//
//  Created by ekhome on 17/8/1.
//  Copyright © 2017年 xiaofei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionViewController : UICollectionViewController
@property (nonatomic,strong)NSArray *allImageArr;
@property (nonatomic,strong)NSMutableArray *timeArr;
@property (nonatomic,strong)NSMutableArray *descArr;
@property (nonatomic,strong)NSMutableArray *titleArr;
@end
