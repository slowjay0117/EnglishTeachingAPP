//
//  MainTabbarController.m
//  EnglishTeachingAPP
//
//  Created by will on 2017/10/12.
//  Copyright © 2017年 will. All rights reserved.
//

#import "MainTabbarController.h"
#import "HomeTableViewController.h"
#import "RankViewController.h"
#import "ShopViewController.h"

@interface MainTabbarController ()

@end

@implementation MainTabbarController

- (void)viewDidLoad {
    [super viewDidLoad];
    HomeTableViewController *hvc = [HomeTableViewController new];
    RankViewController *rvc = [RankViewController new];
    ShopViewController *svc = [ShopViewController new];
    
    hvc.title = @"首页";
    rvc.title = @"排行榜";
    svc.title = @"商店";
    
    self.viewControllers = @[[[UINavigationController alloc]initWithRootViewController:hvc],[[UINavigationController alloc]initWithRootViewController:rvc],[[UINavigationController alloc]initWithRootViewController:svc]];
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
