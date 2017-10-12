//
//  AppDelegate.h
//  EnglishTeachingAPP
//
//  Created by will on 2017/10/12.
//  Copyright © 2017年 will. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainTabbarController.h"
#import "LeftSlideViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) MainTabbarController *mainTabVC;
@property (nonatomic, strong) LeftSlideViewController *leftSlideVC;


- (void)showSelectVC;
- (void)showHomeVC;
@end

