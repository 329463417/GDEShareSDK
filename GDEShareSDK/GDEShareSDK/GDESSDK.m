//
//  GDESSDK.m
//  GDEShareSDK
//
//  Created by 邱亚青 on 2018/9/5.
//  Copyright © 2018年 邱亚青. All rights reserved.
//

#import "GDESSDK.h"
#import "WXApi.h"
#import "WeiboSDK.h"
#import <TencentOpenAPI/QQApiInterface.h>

@interface GDESSDK ()<WXApiDelegate>

/** GDESSDKPlatformType platformType */
@property (nonatomic, assign) GDESSDKPlatformType platformType;

@end
@implementation GDESSDK


+ (void)registerActivePlatformsonConfiguration:(GDESSDKConfigurationHandler)configurationHandler
{
    GDESSDK *sdk = [GDESSDK new];
    if (configurationHandler) {
        configurationHandler(sdk.platformType,sdk.config);
    }
}

+ (void)share:(GDESSDKPlatformType)platformType parameters:(NSMutableDictionary *)parameters onStateChanged:(SSDKShareStateChangedHandler)stateChangedHandler
{

    //未知平台
    NSString *title = [parameters objectForKey:GDESTITLEKEY];
    NSString *image = [parameters objectForKey:GDESIMAGEKEY];
    NSString *description = [parameters objectForKey:GDESDESCRIPTIONKEY];
    NSString *path = [parameters objectForKey:GDESPATHKEY];   //小程序专用
    NSString *userName = [parameters objectForKey:GDESUSERNAMEKEY]; //小程序专用
    NSString *url = [parameters objectForKey:GDESURLKEY];
    stateChangedHandler(GDESSDKResponseStateBegin,nil);
    if (platformType == GDESSDKPlatformTypeUnknown) {
      
        stateChangedHandler(GDESSDKResponseStateFail, @"分享平台不存在");
    }else if (platformType == GDESSDKPlatformSubTypeWechatSession)
    {
        SendMessageToWXReq *req = [[SendMessageToWXReq alloc]init];
        // 是否是文档
        req.bText =  NO;
        req.scene = WXSceneSession;
        //创建分享内容对象
        WXMediaMessage *urlMessage = [WXMediaMessage message];
        urlMessage.title = title;//分享标题
        urlMessage.description = description;//分享描述
        NSURL *imageUrl = [NSURL URLWithString:image];
        NSData *imageDate = [NSData dataWithContentsOfURL:imageUrl];
        //这步很关键，图片必须要压缩
        NSData  *data = [self compressWithMaxLength:30*1024 imageDate:imageDate];

        [urlMessage setThumbData:data];
        //创建多媒体对象
        WXWebpageObject *webObj = [WXWebpageObject object];
        webObj.webpageUrl = url;//分享链接
        //完成发送对象实例
        urlMessage.mediaObject = webObj;
        req.message = urlMessage;
        [WXApi sendReq:req];
        
   
    }else if (platformType == GDESSDKPlatformSubTypeWechatTimeline)
    {
        //分享到朋友圈
        SendMessageToWXReq *req = [[SendMessageToWXReq alloc]init];
        // 是否是文档
        req.bText =  NO;
        req.scene = WXSceneTimeline;
        //创建分享内容对象
        WXMediaMessage *urlMessage = [WXMediaMessage message];
        urlMessage.title = title;//分享标题
        urlMessage.description = description;//分享描述
        NSURL *imageUrl = [NSURL URLWithString:image];
        NSData *imageDate = [NSData dataWithContentsOfURL:imageUrl];
        //这步很关键，图片必须要压缩
        NSData  *data = [self compressWithMaxLength:30*1024 imageDate:imageDate];
        
        [urlMessage setThumbData:data];
        //创建多媒体对象
        WXWebpageObject *webObj = [WXWebpageObject object];
        webObj.webpageUrl = url;//分享链接
        //完成发送对象实例
        urlMessage.mediaObject = webObj;
        req.message = urlMessage;
        [WXApi sendReq:req];
        
    }else if (platformType == GDESSDKPlatformSubTypeWechatMiniProgram)
    {
        //分享到小程序
        //微信好友
        WXMiniProgramObject *wxobject = [WXMiniProgramObject object];
        wxobject.webpageUrl =url;
        wxobject.userName = userName;
        wxobject.path  = path;
        
        NSURL *imageUrl = [NSURL URLWithString:image];
        NSData *imageDate = [NSData dataWithContentsOfURL:imageUrl];
        //这步很关键，图片必须要压缩
        NSData  *data = [self compressWithMaxLength:30*1024 imageDate:imageDate];
        wxobject.hdImageData = data;
        WXMediaMessage *message = [WXMediaMessage message];
        message.title = title;
        message.description = description;
        message.mediaObject = wxobject;
        message.thumbData = nil;
        SendMessageToWXReq *req = [SendMessageToWXReq new];
        req.message = message;
        req.scene = WXSceneSession;
        [WXApi sendReq:req];
        
        
        
    }else if (platformType == GDESSDKPlatformSubTypeQQFriend)
    {
        //分享到qq 好友
        NSString *previewImageUrl = image;
        QQApiNewsObject *newsObj = [QQApiNewsObject
                                    objectWithURL:[NSURL URLWithString:url]
                                    title:title
                                    description:description
                                    previewImageURL:[NSURL URLWithString:previewImageUrl]];
        SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:newsObj];
        //将内容分享到qq
        QQApiSendResultCode sent = [QQApiInterface sendReq:req];
        [self handleSendResult:sent];
        
        
        
    }else if (platformType == GDESSDKPlatformSubTypeQZone)
    {
        //分享到QQ空间
  
        QQApiNewsObject *newsObj = [QQApiNewsObject
                                    objectWithURL:[NSURL URLWithString:url]
                                    title:title
                                    description:description
                                    previewImageURL:[NSURL URLWithString:image]];
        SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:newsObj];
        //将内容分享到qq
        QQApiSendResultCode sent = [QQApiInterface SendReqToQZone:req];
        [self handleSendResult:sent];
        
        
    }else if (platformType == GDESSDKPlatformTypeSinaWeibo)
    {
//        //分享到新浪微博
        WBMessageObject *message = [WBMessageObject message];

        WBWebpageObject *webpage = [WBWebpageObject object];
        webpage.objectID = @"identifier1";
        webpage.title = title;
        webpage.description = description;
        NSURL *imageUrl = [NSURL URLWithString:image];
        NSData *imageDate = [NSData dataWithContentsOfURL:imageUrl];
        //这步很关键，图片必须要压缩
        NSData  *data = [self compressWithMaxLength:30*1024 imageDate:imageDate];
      
        webpage.thumbnailData = data;
        webpage.webpageUrl = url;
        message.mediaObject = webpage;
        WBSendMessageToWeiboRequest *request = [WBSendMessageToWeiboRequest requestWithMessage:message];
        [WeiboSDK sendRequest:request];
        
        
    }
    [GDESSDK new].stateChangedHandler = stateChangedHandler ;
}

- (instancetype)init
{
    if (self = [super init]) {
        _config = [[GDESSDKConfig alloc] init];
        __weak typeof(self) weakSelf = self;
        [_config setStateChangedHandler:^(GDESSDKResponseState state, NSString *errorString) {
            if (weakSelf.stateChangedHandler) {
                weakSelf.stateChangedHandler(state, errorString);
            }
        }];
    }
    return self;
}
+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static GDESSDK *sdk;
    static dispatch_once_t oneToken ;
    dispatch_once(&oneToken, ^{
        sdk = [super allocWithZone:zone];
        
    });
    return sdk;
}

+ (void)handleOpenURL:(NSURL *)url
{
    NSLog(@"%@",url.scheme);
    NSString *scheme = url.scheme;
    if ([scheme containsString:@"wechat"]) {
        [WXApi handleOpenURL:url delegate:[GDESSDK new].config];
    }else if([scheme containsString:@"wb2178095189"])
    {
        [WeiboSDK handleOpenURL:url delegate:[GDESSDK new].config];
    }else
    {
        [TencentOAuth HandleOpenURL:url];
    }
    
    
}
#pragma mark - qq分享回调用的处理
+ (void)handleSendResult:(QQApiSendResultCode)sendResult
{
    switch (sendResult)
    {
        case EQQAPISENDSUCESS:
        {
            if ([GDESSDK new].stateChangedHandler) {
                [GDESSDK new].stateChangedHandler(GDESSDKResponseStateSuccess, nil);
            }
            break;
        }
        case EQQAPIQQNOTINSTALLED:
        {
            if ([GDESSDK new].stateChangedHandler) {
                [GDESSDK new].stateChangedHandler(GDESSDKResponseStateSuccess, @"QQ未安装");
            }
            break;
        }
       
        default:
        {
            if ([GDESSDK new].stateChangedHandler) {
                [GDESSDK new].stateChangedHandler(GDESSDKResponseStateSuccess, @"分享失败");
            }
            break;
        }
    }
}

+(NSData *)compressWithMaxLength:(NSUInteger)maxLength imageDate:(NSData *)imageData{
    // Compress by quality
    CGFloat compression = 1;
    //NSLog(@"Before compressing quality, image size = %ld KB",data.length/1024);
    if (imageData.length < maxLength) return imageData;
    
    CGFloat max = 1;
    CGFloat min = 0;
    for (int i = 0; i < 6; ++i) {
        compression = (max + min) / 2;
//        imageData = UIImageJPEGRepresentation(self, compression);
        //NSLog(@"Compression = %.1f", compression);
        //NSLog(@"In compressing quality loop, image size = %ld KB", data.length / 1024);
        if (imageData.length < maxLength * 0.9) {
            min = compression;
        } else if (imageData.length > maxLength) {
            max = compression;
        } else {
            break;
        }
    }
    //NSLog(@"After compressing quality, image size = %ld KB", data.length / 1024);
    if (imageData.length < maxLength) return imageData;
    UIImage *resultImage = [UIImage imageWithData:imageData];
    // Compress by size
    NSUInteger lastDataLength = 0;
    while (imageData.length > maxLength && imageData.length != lastDataLength) {
        lastDataLength = imageData.length;
        CGFloat ratio = (CGFloat)maxLength / imageData.length;
        //NSLog(@"Ratio = %.1f", ratio);
        CGSize size = CGSizeMake((NSUInteger)(resultImage.size.width * sqrtf(ratio)),
                                 (NSUInteger)(resultImage.size.height * sqrtf(ratio))); // Use NSUInteger to prevent white blank
        UIGraphicsBeginImageContext(size);
        [resultImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
        resultImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        imageData = UIImageJPEGRepresentation(resultImage, compression);
        //NSLog(@"In compressing size loop, image size = %ld KB", data.length / 1024);
    }
    //NSLog(@"After compressing size loop, image size = %ld KB", data.length / 1024);
    return imageData;
}


@end
