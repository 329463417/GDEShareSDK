//
//  GDESSDK.h
//  GDEShareSDK
//
//  Created by 邱亚青 on 2018/9/5.
//  Copyright © 2018年 邱亚青. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GDESSDKTypeDefine.h"
#import "GDESSDKConfig.h"

@interface GDESSDK : NSObject

/** config */
@property (nonatomic, strong) GDESSDKConfig *config;

/** 分享状态的回调 */
@property (nonatomic, copy) SSDKShareStateChangedHandler stateChangedHandler;


+ (void)registerActivePlatformsonConfiguration:(GDESSDKConfigurationHandler)configurationHandler;


/**
 *  分享内容
 *
 *  @param platformType             平台类型
 *  @param parameters               分享参数
 *  @param stateChangedHandler       状态变更回调处理
 */
+ (void)share:(GDESSDKPlatformType)platformType
   parameters:(NSMutableDictionary *)parameters
onStateChanged:(SSDKShareStateChangedHandler)stateChangedHandler;

+ (void)handleOpenURL:(NSURL *)url;
@end
