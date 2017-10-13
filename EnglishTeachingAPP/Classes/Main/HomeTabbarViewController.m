//
//  HomeTabbarViewController.m
//  EnglishTeachingAPP
//
//  Created by will on 2017/10/13.
//  Copyright © 2017年 will. All rights reserved.
//

#import "HomeTabbarViewController.h"
#import "RankingViewController.h"
#import "ShopViewController.h"
#import "HomeworkViewController.h"
#import "HomeTableViewController.h"

@interface HomeTabbarViewController ()

@end

@implementation HomeTabbarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    HomeTableViewController *hvc = [HomeTableViewController new];
    RankingViewController *rvc = [RankingViewController new];
    HomeworkViewController *homeworkVC = [HomeworkViewController new];
    ShopViewController *svc = [ShopViewController new];
    
    hvc.title = @"首页";
    hvc.tabBarItem.image = [UIImage imageNamed:@"home"];
    rvc.title = @"排行榜";
    rvc.tabBarItem.image = [UIImage imageNamed:@"ranking"];
    homeworkVC.title = @"作业";
    homeworkVC.tabBarItem.image = [UIImage imageNamed:@"changRankMode"];
    svc.title = @"商店";
    svc.tabBarItem.image = [UIImage imageNamed:@"shopping"];
    
    self.viewControllers = @[[[UINavigationController alloc]initWithRootViewController:hvc],[[UINavigationController alloc]initWithRootViewController:homeworkVC],[[UINavigationController alloc]initWithRootViewController:rvc],[[UINavigationController alloc]initWithRootViewController:svc]];
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
