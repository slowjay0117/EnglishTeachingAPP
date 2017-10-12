//
//  AppDelegate.m
//  EnglishTeachingAPP
//
//  Created by will on 2017/10/12.
//  Copyright © 2017年 will. All rights reserved.
//

#import "AppDelegate.h"
#import "LeftViewController.h"
#import "SelectViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [Bmob registerWithAppKey:@"c5587c76df76f4fa3c2d4a4a9c8b760d"];
    
    BmobUser *bUser = [BmobUser currentUser];
    if (bUser) {
        //进行操作
        [self showHomeVC];
    }else{
        //对象为空时，可打开用户注册界面
        [self showSelectVC];
    }
    
    return YES;
}

- (void)showSelectVC{
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [self.window makeKeyAndVisible];
    
    SelectViewController *selectVC = [SelectViewController new];
    self.window.rootViewController = [[UINavigationController alloc]initWithRootViewController:selectVC];

    
    
}

- (void)showHomeVC{
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    MainTabbarController *mainTabVC = [MainTabbarController new];
    self.mainTabVC = mainTabVC;
    LeftViewController *leftVC = [LeftViewController new];
    
    LeftSlideViewController *leftSlideVC = [[LeftSlideViewController alloc]initWithLeftView:leftVC andMainView:mainTabVC];
    self.leftSlideVC = leftSlideVC;
    
    self.window.rootViewController = leftSlideVC;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
