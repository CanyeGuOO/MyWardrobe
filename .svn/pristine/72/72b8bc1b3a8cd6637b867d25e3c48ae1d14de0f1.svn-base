//
//  ViewController.h
//  MyWardrobe
//
//  Created by develop1 on 2017/5/15.
//  Copyright © 2017年 残夜孤鸥. All rights reserved.
///

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

typedef void(^Success)(id responseObject);
typedef void(^Fail)(NSError * error);

@interface NetworkHelperEngine : NSObject

@property (nonatomic, retain) AFHTTPSessionManager * manager;

//创建单例对象
+ (NetworkHelperEngine *)shareNetworkHelperEngine;

@property (nonatomic, copy) NSString * idString;
@property (nonatomic, assign)BOOL isWifi;

//封装一个post网络请求
- (void)postInforFromServerWithUrlString:(NSString *)urlString
                             dictionary:(NSMutableDictionary *)parameters
                                success:(Success)success
                                   fail:(Fail)fail;

//封装一个get网络请求
- (void)gettInforFromServerWithUrlString:(NSString *)urlString
                              dictionary:(NSMutableDictionary *)parameters
                                 success:(Success)success
                                    fail:(Fail)fail;



@end

