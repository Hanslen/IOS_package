//
//  ViewController.m
//  AFNetworkingTutorial
//
//  Created by Hanslen Chen on 2017/6/20.
//  Copyright © 2017年 Jiahe Chen. All rights reserved.
//

#import "ViewController.h"
#import <AFNetworking.h>
#import <MJExtension.h>
#import "MHNetwrok.h"
#import "User.h"
#import "Status.h"
#import "StatusResult.h"
#import <UIImageView+WebCache.h>
@interface ViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *testImage;

@end
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    get example
//    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]init];
//    [manager GET:@"https://hanslen.github.io/data.json" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        //responseObject is already your json type
//        NSString *value = responseObject[@"username"];
//        _testLabel.text = value;
//        
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        self.testLabel.text = @"Failure";
//    }];
    
//    post example
//    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]init];
//    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
//    NSDictionary *parameters = @{@"name":@"Tom"};
//    [manager POST:@"http://duyimemo.com/test.php" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSString *value = responseObject[@"status"];
//        _testLabel.text = value;
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"%@", error);
//    }];
    
    //upload image example
//    [self uploadImage];
    
//    NetworkHandle example
//    [self netWorking];
    
    //MJEXtension example
//    [self mjExtension];
    
//    SDWebImage example
    [self sdWebImage];
}

-(void)sdWebImage{
//    [self.testImage sd_setImageWithURL:@"http://wolfprt.com/img/logo.jpg" completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
//        NSLog(@"Loading complete");
//    }];
    [self.testImage sd_setImageWithURL:@"http://wolfprt.com/img/logo.png" placeholderImage:[UIImage imageNamed:@("touxiang")] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
          NSLog(@"Loading complete");
    }];
}

-(void)mjExtension{
//    NSDictionary *dict = @{
//                           @"name" : @"Jack",
//                           @"icon" : @"lufy.png",
//                           @"age" : @20,
//                           @"height" : @"1.55",
//                           @"money" : @100.9,
//                           @"sex" : @(SexFemale) ,
//                           @"partner":@{
//                               @"name" : @"Bob",
//                               @"icon" : @"bob.png",
//                               @"age" : @21,
//                               @"height" : @"1.65",
//                               @"money" : @200.9,
//                               @"sex" : @(SexFemale)
//                           }
//                           };
//    User *user = [User objectWithKeyValues:dict];
//    NSLog(@"name=%@, icon=%@, age=%d, height=%f, money=%@, sex=%d", user.partner.name, user.icon, user.age, user.height, user.money, user.sex);
    NSDictionary *dict = @{
                           @"statuses" : @[
                                   @{
                                       @"text" : @"今天天气真不错！",
                                       @"user" : @{
                                               @"name" : @"Rose",
                                               @"icon" : @"nami.png"
                                               }
                                       },
                                   
                                   @{
                                       @"text" : @"明天去旅游了",
                                       @"user" : @{
                                               @"name" : @"Jack",
                                               @"icon" : @"lufy.png"
                                               }
                                       }
                                   
                                   ],
                           @"ads" :@[
                                   @{
                                       @"image" : @"ad01.png",
                                       @"url" : @"http://www.ad01.com"                                                          
                                       }, 
                                   
                                   @{                               
                                       @"image" : @"ad02.png",                                   
                                       @"url" : @"http://www.ad02.com"                           
                                       }                       
                                   ],                       
                           @"totalNumber" : @"2014"                    
                           };
    StatusResult *result = [StatusResult objectWithKeyValues:dict];
    NSLog(@"totalNumber=%@", result.totalNumber);
    for (Status *status in result.statuses) {
        NSLog(@"._.");
        NSString *text = status.text;
        NSString *name = status.user.name;
        NSString *icon = status.user.icon;
        NSLog(@"text=%@, name=%@, icon=%@", text, name, icon);
    }

}

- (void)uploadImage{
    /*
     此段代码如果需要修改，可以调整的位置
     1. 把upload.php改成网站开发人员告知的地址
     2. 把file改成网站开发人员告知的字段名
     */
    
    //AFN3.0+基于封住HTPPSession的句柄
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
//    NSDictionary *dict = @{@"username":@"Saup"};
    
    //formData: 专门用于拼接需要上传的数据,在此位置生成一个要上传的数据体
    NSString * cerPath = [[NSBundle mainBundle] pathForResource:@"www.github.com" ofType:@"cer"];
    NSData * cerData = [NSData dataWithContentsOfFile:cerPath];
    manager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    manager.securityPolicy.allowInvalidCertificates = YES;
    [manager.securityPolicy setValidatesDomainName:NO];
    manager.securityPolicy.pinnedCertificates = [NSSet setWithObjects:cerData, nil];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/html",@"image/png",nil];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager POST:@"http://duyimemo.com/upload_file.php" parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        UIImage *image =[UIImage imageNamed:@"touxiang"];
        NSData *data = UIImageJPEGRepresentation(image, 0.5);
        
        
        // 在网络开发中，上传文件时，是文件不允许被覆盖，文件重名
        // 要解决此问题，
        // 可以在上传时使用当前的系统事件作为文件名
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        // 设置时间格式
        formatter.dateFormat = @"yyyyMMddHHmmss";
        NSString *str = [formatter stringFromDate:[NSDate date]];
        NSString *fileName = [NSString stringWithFormat:@"%@.jpg", str];
        
        //上传
        /*
         此方法参数
         1. 要上传的[二进制数据]
         2. 对应网站上[upload.php中]处理文件的[字段"file"]
         3. 要保存在服务器上的[文件名]
         4. 上传文件的[mimeType]
         */
        [formData appendPartWithFileData:data name:@"file" fileName:fileName mimeType:@"image/jpg"];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        //上传进度
        // @property int64_t totalUnitCount;     需要下载文件的总大小
        // @property int64_t completedUnitCount; 当前已经下载的大小
        //
        // 给Progress添加监听 KVO
//        NSLog(@"%f",1.0 * uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);
        // 回到主队列刷新UI,用户自定义的进度条
//        dispatch_async(dispatch_get_main_queue(), ^{
//            self.progressView.progress = 1.0 *
//            uploadProgress.completedUnitCount / uploadProgress.totalUnitCount;
//        });
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"上传成功 %@", responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"上传失败 %@", error);
    }];
}

#pragma mark -netWorking
-(void)netWorking
{
    //post example
//    [MHNetworkManager postReqeustWithURL:@"http://duyimemo.com/test.php" params:@{@"name":@"Tom"} successBlock:^(NSDictionary *returnData) {
//        NSLog(@"*********%@",returnData);
//    } failureBlock:^(NSError *error) {
//        NSLog(@"%@",error.localizedDescription);
//        
//    } showHUD:YES];
    
    //get example
//        [MHNetworkManager getRequstWithURL:@"https://hanslen.github.io/data.json" params:nil successBlock:^(NSDictionary *returnData) {
//            NSLog(@"%@", returnData);
//        } failureBlock:^(NSError *error) {
//            NSLog(@"%@", error);
//        } showHUD:TRUE];
    
    //upload example
    MHUploadParam *uploadImg = [[MHUploadParam alloc] init];
//    uploadImg.data = UIImagePNGRepresentation([UIImage imageNamed:@"touxiang"]);
    uploadImg.data = UIImageJPEGRepresentation([UIImage imageNamed:@"touxiang"], 0.5);
    uploadImg.fileName = @"touxiangf";
    uploadImg.name = @"file";
//    uploadImg.mimeType = @"image/jpg";
    NSLog(@"*****%@",uploadImg.data);
    [MHNetworkManager uploadFileWithURL:@"http://duyimemo.com/upload_file.php" params:nil successBlock:^(NSDictionary *returnData) {
        NSLog(@"Success upload");
    } failureBlock:^(NSError *error) {
        NSLog(@"%@", error);
    } uploadParam:uploadImg showHUD:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
