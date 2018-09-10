//
//  GDESSDKConfig.m
//  GDEShareSDK
//
//  Created by 邱亚青 on 2018/9/7.
//  Copyright © 2018年 邱亚青. All rights reserved.
//

#import "GDESSDKConfig.h"

@implementation GDESSDKConfig

- (void)setPlaform:(GDESSDKPlatformType)plaform appId:(NSString *)appId  appSecret:(NSString *)appSecret redirectURL:(NSString *)redirectURL
{
    if (plaform == GDESSDKPlatformTypeWechat) {

        [WXApi registerApp:appId];
        
    }else if (plaform == GDESSDKPlatformTypeQQ)
    {
        TencentOAuth *tencentOAuth = [[TencentOAuth alloc] initWithAppId:appId andDelegate:self];
        
    }else if (plaform == GDESSDKPlatformTypeSinaWeibo)
    {
        [WeiboSDK enableDebugMode:YES];
        [WeiboSDK registerApp:appId];
    }
}


#pragma mark - 微信分享回调方法
- (void)onResp:(BaseResp *)resp
{
    //把返回的类型转换成与发送时相对于的返回类型,这里为SendMessageToWXResp
    SendMessageToWXResp *sendResp = (SendMessageToWXResp *)resp;
    
    if (sendResp.errCode ==0) {
        if (self.stateChangedHandler) {
            self.stateChangedHandler(GDESSDKResponseStateSuccess, nil);
        }
    }else if (sendResp.errCode ==-1)
    {
        //分享取消
        if (self.stateChangedHandler) {
            self.stateChangedHandler(GDESSDKResponseStateCancel, nil);
        }
        
    }else
    {
        //分享失败
        if (self.stateChangedHandler) {
            
            self.stateChangedHandler(GDESSDKResponseStateFail, nil);
        }
    }

}

#pragma mark - 新浪微博分享的回调
- (void)didReceiveWeiboResponse:(WBBaseResponse *)response {
    
    if ([response isKindOfClass:WBSendMessageToWeiboResponse.class])
    {
        if (response.statusCode == 0) {
            // 新浪微博分享成功
            if (self.stateChangedHandler) {
                self.stateChangedHandler(GDESSDKResponseStateSuccess, nil);
            }
            
        }
        else {
            //新浪微博分享失败
            if (self.stateChangedHandler) {
                self.stateChangedHandler(GDESSDKResponseStateFail, @"微博分享失败");
            }
        }
    }
    else if ([response isKindOfClass:WBAuthorizeResponse.class]){
        if (response.statusCode == 0) {
            // 新浪微博授权成功
            
        }
        else {
            // 新浪微博授权失败
            if (self.stateChangedHandler) {
                self.stateChangedHandler(GDESSDKResponseStateFail, @"微博授权失败");
            }
            
        }
    }
}

@end
