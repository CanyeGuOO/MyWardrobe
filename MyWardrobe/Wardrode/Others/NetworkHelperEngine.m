//
//  ViewController.m
//  MyWardrobe
//
//  Created by develop1 on 2017/5/15.
//  Copyright © 2017年 残夜孤鸥. All rights reserved.
//

#import "NetworkHelperEngine.h"

static NetworkHelperEngine * networkHelperEngine = nil;

@implementation NetworkHelperEngine

//创建单例对象
+ (NetworkHelperEngine *)shareNetworkHelperEngine
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        networkHelperEngine = [[NetworkHelperEngine alloc] init];
    });
    return networkHelperEngine;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        //AFN请求操作管理对象
        self.manager = [AFHTTPSessionManager manager];
        [self.manager.requestSerializer setValue: [[NSUserDefaults standardUserDefaults] objectForKey:@"Set-Cookie"]forHTTPHeaderField:@"Cookie"];
//        [self.manager.requestSerializer setCachePolicy:NSURLRequestReturnCacheDataElseLoad];
        self.manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/plain", @"text/html", @"image/jpeg", @"text/javascript", nil];
        self.manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        self.manager.requestSerializer = [AFHTTPRequestSerializer serializer];
//        self.manager.securityPolicy = [AFSecurityPolicy defaultPolicy];
//        self.manager.securityPolicy.allowInvalidCertificates = YES; // 忽略证书
//        self.manager.securityPolicy.validatesDomainName = NO;  // 是否验证域名
           //超时设置
//        [self.manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
//        self.manager.requestSerializer.timeoutInterval = 6;
//        [self.manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];

        
    }
    return self;
}

//封装一个网络请求
- (void)postInforFromServerWithUrlString:(NSString *)urlString
                             dictionary:(NSMutableDictionary *)parameters
                                success:(Success)success
                                   fail:(Fail)fail
{
    [self.manager POST:urlString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        // 进度
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSData *data = [NSJSONSerialization JSONObjectWithData:responseObject options:(NSJSONReadingMutableContainers) error:nil];
        success(data);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        fail(error);
    }];
}

- (void)gettInforFromServerWithUrlString:(NSString *)urlString
                              dictionary:(NSMutableDictionary *)parameters
                                 success:(Success)success
                                    fail:(Fail)fail
{
    [self.manager GET:urlString parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        //进度
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSData *data = [NSJSONSerialization JSONObjectWithData:responseObject options:(NSJSONReadingMutableContainers) error:nil];
        success(data);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        fail(error);
    }];
}





@end
