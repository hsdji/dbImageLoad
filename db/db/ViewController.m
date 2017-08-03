//
//  ViewController.m
//  db
//
//  Created by ekhome on 16/12/19.
//  Copyright © 2016年 xiaofei. All rights reserved.
//
#import "aaViewController.h"
#import "ViewController.h"
#import "AppDelegate.h"
#import "PFDBManager.h"
#import "Mytest.h"
#import "detail.h"
#import "BaseNetManager.h"
#import "image.h"
#import <CommonCrypto/CommonDigest.h>
#import "MJExtension.h"
#import "CollectionViewController.h"
@interface ViewController ()
{
    AppDelegate * appdelegate;
    dispatch_semaphore_t seamphore;
    NSMutableArray *title;
    NSMutableArray *desc;
    NSMutableArray *imageTime;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    seamphore = dispatch_semaphore_create(0);
    appdelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    desc = [NSMutableArray new];
    title = [NSMutableArray new];
    imageTime = [NSMutableArray new];
    if ([appdelegate.db open])
    {
        [PFDBManager creatTable:@"image_table" inDataBase:appdelegate.db model:[image class]];
        [PFDBManager creatTable:@"video_table" inDataBase:appdelegate.db model:[image class]];
    //        [PFDBManager creatTable:@"table2" inDataBase:appdelegate.db model:[detail class]];
    //        for (int i = 0; i<10; i++) {
    //            NSString *name = @"";
    //            for (int i =0; i < arc4random()%3+1; i++) {
    //                NSStringEncoding gbkEncoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    //                NSInteger randomH = 0xA1+arc4random()%(0xFE - 0xA1+1);
    //                NSInteger randomL = 0xB0+arc4random()%(0xF7 - 0xB0+1);
    //                NSInteger number = (randomH<<8)+randomL;
    //                NSData *data = [NSData dataWithBytes:&number length:2];
    //                NSString *string = [[NSString alloc] initWithData:data encoding:gbkEncoding];
    //                name = [name stringByAppendingString:string];
    //            }
    //            NSString *phone = @"1";
    //            for (int i = 0; i<10; i++) {
    //                phone = [phone stringByAppendingString:[NSString stringWithFormat:@"%d",i>0?arc4random()%10:arc4random()%9+1]];
    //            }
    //            NSString *year = @"199";
    //            year = [year stringByAppendingString:[NSString stringWithFormat:@"%d 年",arc4random()%10]];
    //            [PFDBManager insertDataBase:appdelegate.db table:@"table1"  model:@[@"sex",@"name",@"year",@"month",@"M",@"day",@"houer",@"min",@"phone"] andValues:@[arc4random()%2>0?@"男":@"女",name,year,[NSString stringWithFormat:@"%u 月",arc4random()%12+1],@"com.m.xia0fei",[NSString stringWithFormat:@"%d 日",arc4random()%10],[NSString stringWithFormat:@"%d 时",arc4random()%24],@"00",phone]];
    //
    //            NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory,NSUserDomainMask, year).firstObject;
    //            [PFDBManager insertDataBase:appdelegate.db table:@"table2"  model:@[@"table_id",@"urlString",@"imagPath"] andValues:@[[NSString stringWithFormat:@"%d",i+1],@"www.baidu.com",[path stringByAppendingString:[NSString stringWithFormat:@"_%d",i]]]];
    //        }
    //
    //
    //
    //
    
     }else{
        NSLog(@"数据库打开失败");
    }
    //    block
    
    //1 __NSGlobalBlock__  全局block   存储在代码区（存储方法或者函数）
    /**
     block 本身是一个结构体  里面有 __isa 指针  __flags   __reserved __FuncPtr  __descriptor
     当block被创建以后 __isa指针指向了 __NSGlobalBlock__   一个全局的block    __FuncPtr 指向了block所在文件的某一个方法的某一行
     从打印的地址可以看出   block的地址靠前  存放在栈区
     */
    //    void(^testblock1)() = ^() {
    //        NSLog(@"我是老大");
    //    };
    //    NSLog(@"%@",testblock1);//0x10c5de2d0
    
    
    for (int i =1; i<500; i++) {
        [PFDBManager deleteDataBase:appdelegate.db table:@"image_table" id:[NSString stringWithFormat:@"%d",i]];
    }
    //第一步，创建URL
    [self downLoad];
    
    

    UIButton *btn = [UIButton buttonWithType:0];
    btn.frame = CGRectMake(100, 10, 1000, 300);
    [self.view addSubview:btn];
    [btn setTitle:@"XXXXXXXXXXXX" forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor redColor]];
    [btn addTarget:self action:@selector(ttt) forControlEvents:UIControlEventTouchUpInside];
    
    
    
//    UIButton *vbtn = [UIButton buttonWithType:0];
//    [vbtn setTitle:@"视频" forState:UIControlStateNormal];
//    [self.view addSubview:vbtn];
//    vbtn.frame = CGRectMake(10, 350, 100, 80);
//    [vbtn setBackgroundColor:[UIColor greenColor]];
//    [vbtn addTarget:self action:@selector(show) forControlEvents:UIControlEventTouchUpInside];
    
    
    
}

-(void)show{
    
    
    [BaseNetManager GET:@"http://ykrectab.youku.com/feed/seccate/list.json?pid=a4a4a2c40ca74aa5&guid=8b7d39ef52189794e1e0f50b4633b121&mac=cc%3A2d%3A83%3A2c%3A0e%3Ad4&imei=863048039849554&_t_=1501650409&e=md5&_s_=ae6b63d92d1676aff591255166db90f7&operator=%E4%B8%AD%E5%9B%BD%E7%A7%BB%E5%8A%A8_46002&network=WIFI&uid=&utdid=VoVRAxSmejYDAJkw8w4HQc1b&apptype=3&pg=34&module=32&appVer=6.9.0" parameters:@{} completionHandler:^(NSDictionary *responseObj, NSError *error) {
        
        NSString *totalNum = [responseObj valueForKey:@"totalNum"];
        
        NSArray *arr = [responseObj valueForKey:@"data"];
        
        NSLog(@"%@",arr);
    }];

    
}

-(void)ttt{
    NSArray *arr = [PFDBManager queryDataBase:appdelegate.db table:@"image_table" id:@"1" className:[image class]];
    CollectionViewController *v = [CollectionViewController new];
    v.allImageArr = arr;
    NSLog(@"%ld",arr.count);
    [self presentViewController:v animated:YES completion:^{
        
    }];
}

-(void)downLoad{
    NSMutableArray *arrs = [NSMutableArray new];
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_queue_create("imageDownLoadqueue", DISPATCH_QUEUE_CONCURRENT);
    dispatch_group_async(group, queue, ^{
        
        NSString *aa = [BaseNetManager percentPathWithPath:@"http://image.baidu.com/channel/listjson?pn=0&rn=30&tag1=明星&tag2=全部&ie=utf8" params:@{}];
        [BaseNetManager GET:aa parameters:@{} completionHandler:^(NSDictionary *responseObj, NSError *error) {
            NSArray *arr = [responseObj valueForKey:@"data"];
            
            NSMutableArray *imageUrlArr = [NSMutableArray new];
            for (int i =0; i<arr.count-1; i++) {
                NSDictionary *dicm = arr[i];
                [imageUrlArr addObject:[dicm valueForKey:@"image_url"]];
                [desc addObject:[dicm valueForKey:@"desc"]];
                [title addObject:[dicm valueForKey:@"abs"]];
                [imageTime addObject:[dicm valueForKey:@"date"]];
            }
            [arrs addObjectsFromArray:imageUrlArr];
            NSLog(@"1111111111111111111111111111111111111111111111");
            dispatch_semaphore_signal(seamphore);
        }];
    });
    
    
    dispatch_group_async(group, queue, ^{
        
//        NSString *aa = [BaseNetManager percentPathWithPath:@"http://image.baidu.com/channel/listjson?pn=0&rn=30&tag1=美女&tag2=全部&ftags=长腿&ie=utf8" params:@{}];
//        [BaseNetManager GET:aa parameters:@{} completionHandler:^(NSDictionary *responseObj, NSError *error) {
//            NSArray *arr = [responseObj valueForKey:@"data"];
//            
//            NSMutableArray *imageUrlArr = [NSMutableArray new];
//            for (int i =0; i<arr.count-1; i++) {
//                NSDictionary *dicm = arr[i];
//                [imageUrlArr addObject:[dicm valueForKey:@"image_url"]];
//                [desc addObject:[dicm valueForKey:@"desc"]];
//                [title addObject:[dicm valueForKey:@"abs"]];
//                [imageTime addObject:[dicm valueForKey:@"date"]];
//            }
//            [arrs addObjectsFromArray:imageUrlArr];
//            NSLog(@"222222222222222222222222222222222222222222222222222");
//            dispatch_semaphore_signal(seamphore);
//        }];
    });
    
    
    dispatch_group_notify(group, queue, ^{
//        for (int i =0; i<2; i++) {
            dispatch_semaphore_wait(seamphore, DISPATCH_TIME_FOREVER);
//        }
        [self downLoadImage:arrs];
    });

}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
   
}



-(void)downLoadImage:(NSArray *)imageUrl{
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_queue_create("imageDownLoadqueue", NULL);
    for (int i = 0; i<imageUrl.count; i++) {
        dispatch_group_async(group, queue, ^{
            if ([appdelegate.db open])
            {
            NSString *MD5_Str = [self md5:imageUrl[i]];
             NSArray *arr  =   [PFDBManager queryDataBase:appdelegate.db table:@"image_table" model:@[@"imageLocalPath"] andValues:@[MD5_Str] className:[image class]];
                if (arr.count>1) {
                    NSLog(@"-----------------------------------");
                    for (int i =0; i<arr.count; i++) {
                        NSDictionary *dic = arr[i];
                        image *aa = [image mj_objectWithKeyValues:dic];
                        dispatch_sync(dispatch_get_main_queue(), ^{
                            NSString *localStr = NSHomeDirectory();
                            localStr = [localStr stringByAppendingPathComponent:@"Documents"];
                            localStr = [localStr stringByAppendingString:@"/image"];
                            localStr =[[localStr stringByAppendingString:@"/"] stringByAppendingString:aa.imageLocalPath];
                            UIImage *image =  [self createShareImage:@"我是缓存" image:[UIImage imageWithData:[NSData dataWithContentsOfFile:localStr]] color:[UIColor greenColor]];
                            self.view.backgroundColor= [UIColor colorWithPatternImage:image];
                        });
                    }
                }else{
                NSURL* url = [NSURL URLWithString:imageUrl[i]];
                [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:url] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                    if (connectionError) {
                        NSLog(@"%@     是坏的",url);
                    }else{
                        NSString *localStr = NSHomeDirectory();
                        localStr = [localStr stringByAppendingPathComponent:@"Documents"];
                        localStr = [localStr stringByAppendingString:@"/image"];
                        NSFileManager *fileManager = [[NSFileManager alloc] init];
                        // 判断文件夹是否存在，如果不存在，则创建
                        if (![[NSFileManager defaultManager] fileExistsAtPath:localStr]) {
                            [fileManager createDirectoryAtPath:localStr withIntermediateDirectories:YES attributes:nil error:nil];
                            [fileManager createDirectoryAtPath:localStr withIntermediateDirectories:YES attributes:nil error:nil];
                        } else {
                            NSLog(@"文件夹存在 没有新建");
                        }
                        
                        [PFDBManager insertDataBase:appdelegate.db table:@"image_table" model:@[@"imageUrlPath",@"imageLocalPath",@"imageTime",@"title",@"desc"] andValues:@[imageUrl[i],[self md5:imageUrl[i]],imageTime[i],title[i],desc[i]]];
                        
                        [UIImageJPEGRepresentation([UIImage imageWithData:data], 1) writeToFile:localStr  atomically:YES];
                        dispatch_async(dispatch_get_main_queue(), ^{
                            
                            UIImage *oldimage =  [UIImage imageWithData:data];
                            
                            NSData *data2 = UIImageJPEGRepresentation(oldimage, 0.3);
                            
                            UIImage *image = [self createShareImage:@"单小飞  之作" image:[UIImage imageWithData:data2] color:[UIColor grayColor]];
                            
                            self.view.backgroundColor= [UIColor colorWithPatternImage:image];
                            NSError *error;
                            
                            [UIImageJPEGRepresentation(image, 1.0) writeToFile:[[localStr stringByAppendingString:@"/"] stringByAppendingString:[self md5:imageUrl[i]]] options:NSDataWritingAtomic error:&error];
                            if (error) {
                            
                            }else{
                                NSArray *aa =  [PFDBManager getIDDataBase:appdelegate.db table:@"image_table" keys:@[@"imageUrlPath",@"imageLocalPath",@"imageData"] values:@[imageUrl[i],[self md5:imageUrl[i]],@""]];
                                NSLog(@"共有%ld条数据符合条件",aa.count);
                                if (aa != nil && aa.count>1) {
                                    for (int i = 0; i<aa.count-1; i++) {
                                        [PFDBManager deleteDataBase:appdelegate.db table:@"image_table" id:aa[i]];
                                    }
                                }
                            }
                        });
                    }
                    
                }];
                }
            }
        });
    }
    
}

- (NSString *) md5:(NSString *) input {
    const char *cStr = [input UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, strlen(cStr), digest ); // This is the md5 call
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return  output;
}


- (NSString *)dictionaryToJson:(NSDictionary *)dic
{
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&error];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

////文字上添加水印
//-(UIImage *)addImageLogo:(UIImage *)image text:(UIImage *)logoImage
//{
//    //原始图片的宽和高，可以根据需求自己定义
//    CGFloat w = self.view.frame.size.width;
//    CGFloat h = self.view.frame.size.height;
//    //logo的宽和高，也可以根据需求自己定义
//    CGFloat logoWidth = logoImage.size.width;
//    CGFloat logoHeight = logoImage.size.height;
//    //绘制
//    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
//    CGContextRef context = CGBitmapContextCreate(NULL, w, h, 8, 444 * w, colorSpace, kCGImageAlphaPremultipliedFirst);
//    CGContextDrawImage(context, CGRectMake(0, 0, w, h), image.CGImage);
//    //绘制的logo位置,可自己调整
//    CGContextDrawImage(context, CGRectMake(w-logoWidth-10, 10, logoWidth, logoHeight), [logoImage CGImage]);
//    CGImageRef imageMasked = CGBitmapContextCreateImage(context);
//    CGContextRelease(context);
//    CGColorSpaceRelease(colorSpace);
//    return [UIImage imageWithCGImage:imageMasked];
//}

- (UIImage *)createShareImage:(NSString *)str image:(UIImage *)image color:(UIColor *)color

{
    
    
    CGSize size=CGSizeMake(image.size.width, image.size.height);//画布大小
    
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
    
    [image drawAtPoint:CGPointMake(0, 0)];
    
    //获得一个位图图形上下文
    
    CGContextRef context=UIGraphicsGetCurrentContext();
    
    CGContextDrawPath(context, kCGPathStroke);
    
    
    
    //画 打败了多少用户
    
    [str drawAtPoint:CGPointMake(30, 200) withAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"Arial-BoldMT" size:30],NSForegroundColorAttributeName:color}];
    
    //画自己想画的内容。。。。。
    
    //返回绘制的新图形
    
    UIImage *newImage=UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
    
}

@end
