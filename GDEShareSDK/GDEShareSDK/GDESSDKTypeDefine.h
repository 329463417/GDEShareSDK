//
//  GDESSDKTypeDefine.h
//  GDEShareSDK
//
//  Created by 邱亚青 on 2018/9/5.
//  Copyright © 2018年 邱亚青. All rights reserved.
//

#ifndef GDESSDKTypeDefine_h
#define GDESSDKTypeDefine_h


@class GDESSDKConfig;

static NSString *const GDESTITLEKEY = @"title";
static NSString *const GDESIMAGEKEY = @"image";
static NSString *const GDESDESCRIPTIONKEY = @"description";
static NSString *const GDESPATHKEY = @"path";
static NSString *const GDESUSERNAMEKEY = @"userName";
static NSString *const GDESURLKEY = @"url";
/**
 *  平台类型
 */
typedef NS_ENUM(NSUInteger, GDESSDKPlatformType) {
    /**
     *  未知
     */
    GDESSDKPlatformTypeUnknown    = 0,
    
    /**
     *  微信好友
     */
    GDESSDKPlatformSubTypeWechatSession    = 1,
    /**
     *  微信朋友圈
     */
    GDESSDKPlatformSubTypeWechatTimeline   = 2,
    /**
     *  微信小程序
     */
    GDESSDKPlatformSubTypeWechatMiniProgram   = 3,
    /**
     *  QQ好友
     */
    GDESSDKPlatformSubTypeQQFriend         = 4,
    
    /**
     *  QQ空间
     */
    GDESSDKPlatformSubTypeQZone            = 5,
    /**
     *  新浪微博
     */
    GDESSDKPlatformTypeSinaWeibo        = 6,
    
    /**
     *  微信平台,
     */
    GDESSDKPlatformTypeWechat              = 7,
    /**
     *  QQ平台
     */
    GDESSDKPlatformTypeQQ                  = 8,
    /**
     *  任意平台
     */
    GDESSDKPlatformTypeAny                 = 9
    
};
/**
 *  回调状态
 */
typedef NS_ENUM(NSUInteger, GDESSDKResponseState){
    
    /**
     *  开始
     */
    GDESSDKResponseStateBegin     = 0,
    
    /**
     *  成功
     */
    GDESSDKResponseStateSuccess    = 1,
    
    /**
     *  失败
     */
    GDESSDKResponseStateFail       = 2,
    
    /**
     *  取消
     */
    GDESSDKResponseStateCancel     = 3,
    
    
    //视频文件开始上传
    GDESSDKResponseStateBeginUPLoad = 4
};

/**
 *  配置分享平台回调处理器
 *
 *  @param platformType 需要初始化的分享平台类型
 *  @param config      需要初始化的分享平台应用信息
 */
typedef void(^GDESSDKConfigurationHandler) (GDESSDKPlatformType platformType, GDESSDKConfig *config);

typedef void(^SSDKShareStateChangedHandler) (GDESSDKResponseState state,   NSString *errorString);



#endif /* GDESSDKTypeDefine_h */
