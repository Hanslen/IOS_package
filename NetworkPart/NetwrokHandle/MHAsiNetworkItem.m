//
//  MHAsiNetworkItem.m
//  MHProject
//
//  Created by MengHuan on 15/4/23.
//  Copyright (c) 2015年 MengHuan. All rights reserved.
//

#import "MHAsiNetworkItem.h"
#import <AFNetworking.h>
#import <MBProgressHUD.h>
#import "MHAsiNetworkDefine.h"
#import "MHNetwrok.h"
@interface MHAsiNetworkItem ()

@end

@implementation MHAsiNetworkItem


#pragma mark - 创建一个网络请求项，开始请求网络
/**
 *  创建一个网络请求项，开始请求网络
 *
 *  @param networkType  网络请求方式
 *  @param url          网络请求URL
 *  @param params       网络请求参数
 *  @param delegate     网络请求的委托，如果没有取消网络请求的需求，可传nil
 *  @param hashValue    网络请求的委托delegate的唯一标示
 *  @param showHUD      是否显示HUD
 *  @param successBlock 请求成功后的block
 *  @param failureBlock 请求失败后的block
 *
 *  @return MHAsiNetworkItem对象
 */
- (MHAsiNetworkItem *)initWithtype:(MHAsiNetWorkType)networkType
                               url:(NSString *)url
                            params:(NSDictionary *)params
                          delegate:(id)delegate
                            target:(id)target
                            action:(SEL)action
                         hashValue:(NSUInteger)hashValue
                           showHUD:(BOOL)showHUD
                      successBlock:(MHAsiSuccessBlock)successBlock
                      failureBlock:(MHAsiFailureBlock)failureBlock
{
    if (self = [super init])
    {
        self.networkType    = networkType;
        self.url            = url;
        self.params         = params;
        self.delegate       = delegate;
        self.showHUD        = showHUD;
        self.tagrget        = target;
        self.select         = action;
        if (showHUD==YES) {
            [MBProgressHUD showHUDAddedTo:(UIView*)[[[UIApplication sharedApplication]delegate]window] animated:YES];
        }
        __weak typeof(self)weakSelf = self;
//        DTLog(@"--请求url地址--%@\n",url);
        DTLog(@"----请求参数%@\n",params);
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];

        NSString * cerPath = [[NSBundle mainBundle] pathForResource:@"www.github.com" ofType:@"cer"];
        NSData * cerData = [NSData dataWithContentsOfFile:cerPath];
        manager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
        manager.securityPolicy.allowInvalidCertificates = YES;
        [manager.securityPolicy setValidatesDomainName:NO];
        manager.securityPolicy.pinnedCertificates = [NSSet setWithObjects:cerData, nil];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/html",@"image/png",nil];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
//        AFJSONResponseSerializer *jsonSer =(AFJSONResponseSerializer*) manager.responseSerializer;
//        jsonSer.removesKeysWithNullValues = YES;
//        [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        if (networkType==MHAsiNetWorkGET)
        {
            [manager GET:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                [MBProgressHUD hideAllHUDsForView:(UIView*)[[[UIApplication sharedApplication]delegate]window] animated:YES];
                //                DTLog(@"\n\n----请求的返回结果 %@\n",responseObject);
                if (successBlock) {
                    successBlock(responseObject);
                }
                if ([weakSelf.delegate respondsToSelector:@selector(requestDidFinishLoading:)]) {
                    [weakSelf.delegate requestDidFinishLoading:responseObject];
                }
                [weakSelf performSelector:@selector(finishedRequest: didFaild:) withObject:responseObject withObject:nil];
                [weakSelf removewItem];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [MBProgressHUD hideAllHUDsForView:(UIView*)[[[UIApplication sharedApplication]delegate]window] animated:YES];
                //                DTLog(@"---error==%@\n",error.localizedDescription);
                if (failureBlock) {
                    failureBlock(error);
                }
                if ([weakSelf.delegate respondsToSelector:@selector(requestdidFailWithError:)]) {
                    [weakSelf.delegate requestdidFailWithError:error];
                }
                [weakSelf performSelector:@selector(finishedRequest: didFaild:) withObject:nil withObject:error];
                [weakSelf removewItem];
            }];
        }else{
            [manager POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                [MBProgressHUD hideHUDForView:(UIView*)[[[UIApplication sharedApplication]delegate]window] animated:YES];
                DTLog(@"\n\n----请求的返回结果 %@\n",responseObject);
//                if (successBlock) {
//                    if ([responseObject[@"status"] integerValue] == 602)
//                    {
//                        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"未登录/账号被异地登录,请重新登录" preferredStyle:UIAlertControllerStyleAlert];
//                                                [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//                        [[self currentViewController].navigationController popViewControllerAnimated:YES];
//                        loginController *login = [[loginController alloc] initWithNibName:@"loginController" bundle:nil];
//                        AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
//                        [delegate.window.rootViewController presentViewController:login animated:YES completion:nil];
//                    }]];
//                        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:nil];
//                    }else if([responseObject[@"status"] integerValue] == 603)
//                    {
//                        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"服务器故障，请稍后重试" preferredStyle: UIAlertControllerStyleAlert];
//                        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//                        }]];
//                        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:true completion:nil];
//                    }
//                    else
//                    {
                        successBlock(responseObject);
//                    }
//                }
                if ([weakSelf.delegate respondsToSelector:@selector(requestDidFinishLoading:)]) {
                    [weakSelf.delegate requestDidFinishLoading:responseObject];
                }
                [weakSelf performSelector:@selector(finishedRequest: didFaild:) withObject:responseObject withObject:nil];
                [weakSelf removewItem];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [MBProgressHUD hideAllHUDsForView:(UIView*)[[[UIApplication sharedApplication]delegate]window] animated:YES];
                //                DTLog(@"---error==%@\n",error.localizedDescription);
                if (failureBlock) {
                    failureBlock(error);
                }
                if ([weakSelf.delegate respondsToSelector:@selector(requestdidFailWithError:)]) {
                    [weakSelf.delegate requestdidFailWithError:error];
                }
                [weakSelf performSelector:@selector(finishedRequest: didFaild:) withObject:nil withObject:error];
                [weakSelf removewItem];
            }];
        }
    }
    return self;
}
/**
 *   移除网络请求项
 */
- (void)removewItem
{
    __weak typeof(self)weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if ([weakSelf.delegate respondsToSelector:@selector(netWorkWillDealloc:)]) {
            [weakSelf.delegate netWorkWillDealloc:weakSelf];
        }
    });
}

- (void)finishedRequest:(id)data didFaild:(NSError*)error
{
    if ([self.tagrget respondsToSelector:self.select]) {
        [self.tagrget performSelector:@selector(finishedRequest:didFaild:) withObject:data withObject:error];
    }
}

-(UIViewController *)currentViewController
{
    UIViewController * currVC = nil;
    UIViewController * Rootvc = [[UIApplication sharedApplication]delegate].window.rootViewController ;
    do {
        if ([Rootvc isKindOfClass:[UINavigationController class]]) {
            UINavigationController * nav = (UINavigationController *)Rootvc;
            UIViewController * v = [nav.viewControllers lastObject];
            currVC = v;
            Rootvc = v.presentedViewController;
            continue;
        }else if([Rootvc isKindOfClass:[UITabBarController class]]){
            UITabBarController * tabVC = (UITabBarController *)Rootvc;
            currVC = tabVC;
            Rootvc = [tabVC.viewControllers objectAtIndex:tabVC.selectedIndex];
            continue;
        }
    } while (Rootvc!=nil);
    
    
    return currVC;
}

- (void)dealloc
{
    
    
}

@end
