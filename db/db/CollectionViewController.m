//
//  CollectionViewController.m
//  db
//
//  Created by ekhome on 17/8/1.
//  Copyright © 2017年 xiaofei. All rights reserved.
//

#import "CollectionViewController.h"
#import "CollectionViewCell.h"
#import "AppDelegate.h"
@interface CollectionViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UIScrollViewDelegate>
{
     NSMutableArray *imageArr;
    AppDelegate * appdelegate;
    dispatch_semaphore_t semaphore;
   
}
@property (nonatomic,strong)NSMutableArray *tasksArray;
@property (nonatomic,strong)UIScrollView  *scro;
@end

@implementation CollectionViewController

- (instancetype)init
{
    
     appdelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    // 创建一个流水布局
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    
    // 设置cell的尺寸
    layout.itemSize = CGSizeMake(100, 160);
    
    // 设置滚动的方向
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    // 行间距
    layout.minimumLineSpacing = 0;
    
    // 设置cell之间的间距
    layout.minimumInteritemSpacing = 20;
    //
    //    // 组间距
    layout.sectionInset = UIEdgeInsetsMake(20, 0, 20, 0);
    
    return [super initWithCollectionViewLayout:layout];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self observrRunLoop];
    
    semaphore = dispatch_semaphore_create(0);
    
    self.tasksArray = [NSMutableArray new];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.collectionView.bounces = NO;
    
    self.collectionView.showsHorizontalScrollIndicator = NO;
    
    self.collectionView.pagingEnabled = NO;
    
    self.collectionView.delegate = self;
    
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    [self.collectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    
    self.scro = [[UIScrollView alloc] initWithFrame:CGRectMake(0,0, self.view.frame.size.width, self.view.frame.size.height)];
    self.scro.delegate = self;
    self.scro.backgroundColor = [UIColor blackColor];
    self.scro.pagingEnabled = YES;
    self.scro.bounces = NO;
    UITapGestureRecognizer *singleTapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(singleTap:)];
    UITapGestureRecognizer *doubleTapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(doubleTap:)];
    [singleTapGestureRecognizer setNumberOfTapsRequired:1];
    [doubleTapGestureRecognizer setNumberOfTapsRequired:2];
    [self.scro addGestureRecognizer:doubleTapGestureRecognizer];
    [self.scro addGestureRecognizer:singleTapGestureRecognizer];
    [singleTapGestureRecognizer requireGestureRecognizerToFail:doubleTapGestureRecognizer];
    imageArr = [NSMutableArray new];
    
    
 __block   NSMutableArray *arr = [NSMutableArray new];
 __block   NSMutableArray *arr2 = [NSMutableArray new];
 __block   NSMutableArray *arr3 = [NSMutableArray new];
    
    self.descArr = [NSMutableArray new];
    self.timeArr = [NSMutableArray new];
    self.timeArr = [NSMutableArray new];
    dispatch_async(dispatch_queue_create("com.loadImageFromMemery", DISPATCH_QUEUE_CONCURRENT), ^{
        
        
        for (int i =0; i<self.allImageArr.count; i++) {
            [self.descArr addObject:[self.allImageArr[i] valueForKey:@"desc"]];
            [self.timeArr addObject:[self.allImageArr[i]valueForKey:@"title"]];
            [self.timeArr addObject:[self.allImageArr[i]valueForKey:@"imageTime"]];
        }
        int  count = (int)self.allImageArr.count/3;
        dispatch_async(dispatch_queue_create("com.loadImageFromMemery1", DISPATCH_QUEUE_CONCURRENT), ^{
        for (int i =0; i<count; i++) {
            NSString *styr = [self.allImageArr[i] valueForKey:@"imageLocalPath"];
            NSString *localStr = NSHomeDirectory();
            localStr = [localStr stringByAppendingPathComponent:@"Documents"];
            localStr = [localStr stringByAppendingString:@"/image"];
            localStr =[[localStr stringByAppendingString:@"/"] stringByAppendingString:styr];
            UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfFile:localStr]];
            [arr addObject:[UIImage imageWithData:UIImageJPEGRepresentation(image, 0.01)]];
            
            if (i == count-1) {
                NSLog(@"111111111111111111完成");
                [imageArr addObjectsFromArray:arr];
                dispatch_semaphore_signal(semaphore);
            }
        }
        });
        
        
        dispatch_async(dispatch_queue_create("com.loadImageFromMemery2", DISPATCH_QUEUE_CONCURRENT), ^{
            for (int i = count+1; i< 2*count+1; i++) {
                NSString *styr = [self.allImageArr[i] valueForKey:@"imageLocalPath"];
                NSString *localStr = NSHomeDirectory();
                localStr = [localStr stringByAppendingPathComponent:@"Documents"];
                localStr = [localStr stringByAppendingString:@"/image"];
                localStr =[[localStr stringByAppendingString:@"/"] stringByAppendingString:styr];
                UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfFile:localStr]];
                [arr2 addObject:[UIImage imageWithData:UIImageJPEGRepresentation(image, 0.01)]];
                if (i == 2*count-1) {
                    NSLog(@"22222222222222222完成");
                    [imageArr addObjectsFromArray:arr2];
                     dispatch_semaphore_signal(semaphore);
                }
            }
        });
       
        dispatch_async(dispatch_queue_create("com.loadImageFromMemery3", DISPATCH_QUEUE_CONCURRENT), ^{
            for (int i =count*2 +2; i< self.allImageArr.count; i++) {
                NSString *styr = [self.allImageArr[i] valueForKey:@"imageLocalPath"];
                NSString *localStr = NSHomeDirectory();
                localStr = [localStr stringByAppendingPathComponent:@"Documents"];
                localStr = [localStr stringByAppendingString:@"/image"];
                localStr =[[localStr stringByAppendingString:@"/"] stringByAppendingString:styr];
                UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfFile:localStr]];
                [arr3 addObject:[UIImage imageWithData:UIImageJPEGRepresentation(image, 0.01)]];
                if (i == 3*count-1) {
                    NSLog(@"333333333333333333333完成");
                     [imageArr addObjectsFromArray:arr3];
                    dispatch_semaphore_signal(semaphore);
                }
            }
        });

        for (int i =0; i<3; i++) {
            dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
            [self.collectionView reloadData];
        }
    });
    
   
    
    
}


-(void)loadImage{
    
}


static void callBackBlock (CFRunLoopObserverRef observer, CFRunLoopActivity activity, void *info){
    CollectionViewController *v = (__bridge CollectionViewController *)info;
    if (v.tasksArray.count)
    {
        dispatch_block_t task = v.tasksArray[0];
        task();
        [v.tasksArray removeObjectAtIndex:0];
    }
    
    
};


#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return imageArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[CollectionViewCell alloc] init];
    }
    __weak typeof(imageArr)weakimageArr =  imageArr;
    
    [self.tasksArray addObject:^{
        cell.imageView.image = weakimageArr[indexPath.row];
    }];
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>



- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
 
    self.scro.contentSize = CGSizeMake(self.view.frame.size.width*imageArr.count, self.view.frame.size.width);
    for (int i =0; i<imageArr.count-indexPath.row; i++) {
       UIImageView *imagev2 = [[UIImageView alloc]initWithFrame:CGRectMake(i*self.view.frame.size.width + 20, 200, self.view.frame.size.width-40, 300)];
        imagev2.tag = i;
        imagev2.image = imageArr[i+indexPath.row];
        [self.scro addSubview:imagev2];
        UITextView *textView = [[UITextView alloc]initWithFrame:CGRectMake(i*self.view.frame.size.width + 20, 500, self.view.frame.size.width-40, self.view.frame.size.height-580)];
        textView.text = [[[self.timeArr[i+indexPath.row] stringByAppendingString:@"/n"] stringByAppendingString:self.timeArr[i]] stringByAppendingString:self.descArr[i]];
        textView.textColor = [UIColor whiteColor];
        textView.backgroundColor = [UIColor blackColor];
        textView.font = [UIFont systemFontOfSize:14 weight:20];
        [self.scro addSubview:textView];
        
    }
    [self.view addSubview:self.scro];
    
}


-(void)singleTap:(UITapGestureRecognizer *)sender{
    [self.scro removeFromSuperview];
}


-(void)doubleTap:(UITapGestureRecognizer *)sender{
    int index = self.scro.contentOffset.x/self.view.frame.size.width;
    
    for (UIImageView *ima in self.scro.subviews) {
        if (ima.tag == index&& ima.frame.size.height == 300) {
            ima.frame = CGRectMake(index*self.view.frame.size.width + 20, 0, self.view.frame.size.width, self.view.frame.size.height);
            
        }else if(ima.tag == index&& ima.frame.size.height == self.view.frame.size.height){
            ima.frame = CGRectMake(index*self.view.frame.size.width + 20, 200, self.view.frame.size.width-40, 300);
        }
    }
    [self.view endEditing:YES];
    
}







-(void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    NSLog(@"警告");

}

-(void)pinchAction:(UIPinchGestureRecognizer *)UIPinchGestureRecognizer
{
    
  
    
}




/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/


-(void)observrRunLoop{
    CFRunLoopRef runloop = CFRunLoopGetCurrent();
    CFRunLoopObserverContext    observerContext = {
        0,
        (__bridge void *)(self),
        &CFRetain,
        &CFRelease,
        NULL
    };
    CFRunLoopObserverRef observer =  CFRunLoopObserverCreate(CFAllocatorGetDefault(), kCFRunLoopBeforeTimers, YES, 0,callBackBlock, &observerContext);
    CFRunLoopAddObserver(runloop, observer,kCFRunLoopCommonModes);
    CFRelease(observer);
}


- (UIImage *)createShareImage:(NSString *)str image:(UIImage *)image color:(UIColor *)color

{
    CGSize size=CGSizeMake(image.size.width, image.size.height);//画布大小
    
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
    
    [image drawAtPoint:CGPointMake(0, 0)];
    
    //获得一个位图图形上下文
    
    CGContextRef context=UIGraphicsGetCurrentContext();
    
    CGContextDrawPath(context, kCGPathStroke);
    
    
    
    //画 打败了多少用户
    
    [str drawAtPoint:CGPointMake(20, 550) withAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"Arial-BoldMT" size:100],NSForegroundColorAttributeName:color}];
    
    //画自己想画的内容。。。。。
    
    //返回绘制的新图形
    
    UIImage *newImage=UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
    
}



@end
