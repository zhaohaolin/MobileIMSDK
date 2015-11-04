//  ----------------------------------------------------------------------
//  Copyright (C) 2015 Jack Jiang The MobileIMSDK Project.
//  All rights reserved.
//  Project URL:  https://github.com/JackJiang2011/MobileIMSDK
//
//  openmob.net PROPRIETARY/CONFIDENTIAL. Use is subject to license terms.
//
//  You can contact author with jack.jiang@openmob.net or jb2011@163.com.
//  ----------------------------------------------------------------------
//
//  AppDelegate.m
//  RainbowCore4i
//
//  Created by JackJiang on 14/10/21.
//  Copyright (c) 2014年 cngeeker.com. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "ClientCoreSDK.h"
#import "ToolKits.h"
#import "PErrorResponse.h"
#import "CharsetHelper.h"
#import "Protocal.h"
#import "ClientCoreSDK.h"
#import "ChatTransDataEventImpl.h"
#import "ChatBaseEventImpl.h"
#import "MessageQoSEventImpl.h"
#import "KeepAliveDaemon.h"
#import "AutoReLoginDaemon.h"
#import "ConfigEntity.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

@synthesize window = _window;
@synthesize viewController = _viewController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // 初始化IM核心
    [self initIMCore];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    self.viewController = [[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
    self.window.rootViewController = self.viewController;
    
    [self.window makeKeyAndVisible];

    return YES;
}

- (void) initIMCore
{
    // 设置AppKey
    [ConfigEntity registerWithAppKey:@"5418023dfd98c579b6001741"];
    
    // 设置服务器ip和服务器端口
//    [ConfigEntity setServerIp:@"rbcore.cngeeker.com"];
//    [ConfigEntity setServerPort:7901];
    
    // 使用以下代码表示不绑定固定port（由系统自动分配），否则使用默认的7801端口
//    [ConfigEntity setLocalUdpSendAndListeningPort:-1];
    
    // RainbowCore核心IM框架的敏感度模式设置
//    [ConfigEntity setSenseMode:SenseMode10S];
    
    // 开启DEBUG信息输出
    [ClientCoreSDK setENABLED_DEBUG:YES];
    
    // 设置事件回调
    [ClientCoreSDK sharedInstance].chatTransDataEvent = [[ChatTransDataEventImpl alloc] init];
    [ClientCoreSDK sharedInstance].chatBaseEvent = [[ChatBaseEventImpl alloc] init];
    [ClientCoreSDK sharedInstance].messageQoSEvent = [[MessageQoSEventImpl alloc] init];
}

- (UIView *) getMainView
{
    return self.viewController.view;
}

- (ViewController *) getMainViewController
{
    return self.viewController;
}

- (void) setMyid:(int)myid
{
    [self.viewController setMyid:myid];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    
    // 释放IM核心占用的资源
    [[ClientCoreSDK sharedInstance] releaseCore];
}

@end