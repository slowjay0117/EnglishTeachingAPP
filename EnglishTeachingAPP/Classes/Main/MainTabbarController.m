//
//  MainTabbarController.m
//  EnglishTeachingAPP
//
//  Created by will on 2017/10/12.
//  Copyright © 2017年 will. All rights reserved.
//

#import "MainTabbarController.h"
#import "MainNaviController.h"
#import "HomeTabbarViewController.h"
#import "RankingViewController.h"
#import "ShopViewController.h"
#import "MessageTableViewController.h"
#import "SettingsTableViewController.h"
#import "GroupsTableViewController.h"
#import "FriendTableViewController.h"
#import "StudentTableViewController.h"


@interface MainTabbarController ()

@end

@implementation MainTabbarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *iv = [[UIImageView alloc]initWithFrame:self.view.bounds];
    iv.image = [UIImage imageNamed:@"Bg"];
    [self.view insertSubview:iv atIndex:0];
    
    //为背景图增加一层蒙层
    UIBlurEffect* blurEffect = [UIBlurEffect effectWithStyle:(UIBlurEffectStyleLight)];
    UIVisualEffectView* visualEffect = [[UIVisualEffectView alloc]initWithEffect:blurEffect];
    [visualEffect setFrame:[UIScreen mainScreen].bounds];
    [iv addSubview:visualEffect];
    
    
    HomeTabbarViewController *htc = [HomeTabbarViewController new];
    htc.title = @"首页";
    MessageTableViewController *mvc = [MessageTableViewController new];
    mvc.title = @"消息列表";
    FriendTableViewController *fvc = [FriendTableViewController new];
    fvc.title = @"好友列表";
    SettingsTableViewController *svc = [SettingsTableViewController new];
    svc.title = @"设置";
    GroupsTableViewController *gvc = [GroupsTableViewController new];
    gvc.title = @"班级列表";
    StudentTableViewController *stuVC = [StudentTableViewController new];
    stuVC.title = @"学生列表";
    
    
    
    
    [self addChildViewController:htc];
    [self addChildViewController:[[MainNaviController alloc]initWithRootViewController:mvc]];
    [self addChildViewController:[[MainNaviController alloc]initWithRootViewController:fvc]];
    [self addChildViewController:[[MainNaviController alloc]initWithRootViewController:svc]];
    [self addChildViewController:[[MainNaviController alloc]initWithRootViewController:gvc]];
    [self addChildViewController:[[MainNaviController alloc]initWithRootViewController:stuVC]];
    
    self.tabBar.hidden = YES;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
