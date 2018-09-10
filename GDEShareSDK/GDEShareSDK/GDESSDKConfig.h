//
//  GDESSDKConfig.h
//  GDEShareSDK
//
//  Created by 邱亚青 on 2018/9/7.
//  Copyright © 2018年 邱亚青. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GDESSDKTypeDefine.h"
#import "WXApi.h"
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import "WeiboSDK.h"


@interface GDESSDKConfig : NSObject<TencentSessionDelegate,WXApiDelegate,WeiboSDKDelegate>

/** 分享状态的回调 */
@property (nonatomic, copy) SSDKShareStateChangedHandler stateChangedHandler;

- (void)setPlaform:(GDESSDKPlatformType)plaform appId:(NSString *)appId  appSecret:(NSString *)appSecret redirectURL:(NSString *)redirectURL;



@end
