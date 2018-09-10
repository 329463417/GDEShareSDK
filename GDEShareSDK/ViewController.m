//
//  ViewController.m
//  GDEShareSDK
//
//  Created by 邱亚青 on 2018/9/5.
//  Copyright © 2018年 邱亚青. All rights reserved.
//

#import "ViewController.h"
#import "GDESSDK.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [GDESSDK registerActivePlatformsonConfiguration:^(GDESSDKPlatformType platformType, GDESSDKConfig *config) {
        [config setPlaform:GDESSDKPlatformTypeWechat appId:@"wx99b23d4593d04b2a" appSecret:@"ff434ef7e06f295430d5923ad9c26677" redirectURL:nil];
        [config setPlaform:GDESSDKPlatformTypeQQ appId:@"1104570206" appSecret:nil redirectURL:nil];
        [config setPlaform:GDESSDKPlatformTypeSinaWeibo appId:@"2178095189" appSecret:@"d1476aac278184b37a666b3bb6bd7d25" redirectURL:@"http://www.gaodun.com/oauth/weibo/callback.php"];
    }];

    
}

#pragma mark - 分享到微信好友
- (IBAction)weichatFriend:(id)sender {
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[GDESTITLEKEY] = @"哈哈哈";
    parameters[GDESDESCRIPTIONKEY] = @"dfergergerger";
    parameters[GDESIMAGEKEY] = [UIImage imageNamed:@"hhhhh"];
    parameters[GDESURLKEY] = @"www.baidu.com";
    [GDESSDK share:GDESSDKPlatformSubTypeWechatSession parameters:parameters onStateChanged:^(GDESSDKResponseState state, NSString *errorString) {
        
        
    }];
    
}
- (IBAction)weichatFriendCicle:(id)sender {
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[GDESTITLEKEY] = @"哈哈哈";
    parameters[GDESDESCRIPTIONKEY] = @"dfergergerger";
    parameters[GDESIMAGEKEY] = [UIImage imageNamed:@"hhhhh"];
    parameters[GDESURLKEY] = @"www.baidu.com";
    [GDESSDK share:GDESSDKPlatformSubTypeWechatTimeline parameters:parameters onStateChanged:^(GDESSDKResponseState state, NSString *errorString) {
        
        
    }];
}

- (IBAction)weichatLittleProgram:(id)sender {
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[GDESTITLEKEY] = @"哈哈哈";
    parameters[GDESDESCRIPTIONKEY] = @"dfergergerger";
    parameters[GDESIMAGEKEY] = [UIImage imageNamed:@"hhhhh"];
    parameters[GDESURLKEY] = @"www.baidu.com";
    [GDESSDK share:GDESSDKPlatformSubTypeWechatMiniProgram parameters:parameters onStateChanged:^(GDESSDKResponseState state, NSString *errorString) {
        
        
    }];
}

- (IBAction)weiboshae:(id)sender {
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[GDESTITLEKEY] = @"哈哈哈";
    parameters[GDESDESCRIPTIONKEY] = @"dfergergerger";
    parameters[GDESIMAGEKEY] = [UIImage imageNamed:@"hhhhh"];
    parameters[GDESURLKEY] = @"www.baidu.com";
    [GDESSDK share:GDESSDKPlatformTypeSinaWeibo parameters:parameters onStateChanged:^(GDESSDKResponseState state, NSString *errorString) {
        
        
    }];
}
- (IBAction)qqzone:(id)sender {
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[GDESTITLEKEY] = @"哈哈哈";
    parameters[GDESDESCRIPTIONKEY] = @"dfergergerger";
    parameters[GDESIMAGEKEY] = [UIImage imageNamed:@"hhhhh"];
    parameters[GDESURLKEY] = @"www.baidu.com";
    [GDESSDK share:GDESSDKPlatformSubTypeQZone parameters:parameters onStateChanged:^(GDESSDKResponseState state, NSString *errorString) {
        
        
    }];
    
}

- (IBAction)qqfriend:(id)sender {
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[GDESTITLEKEY] = @"哈哈哈";
    parameters[GDESDESCRIPTIONKEY] = @"dfergergerger";
    parameters[GDESIMAGEKEY] = [UIImage imageNamed:@"hhhhh"];
    parameters[GDESURLKEY] = @"www.baidu.com";
    [GDESSDK share:GDESSDKPlatformSubTypeQQFriend parameters:parameters onStateChanged:^(GDESSDKResponseState state, NSString *errorString) {
        
        
    }];
    
}

@end
