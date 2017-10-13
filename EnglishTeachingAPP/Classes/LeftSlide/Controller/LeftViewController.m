//
//  LeftViewController.m
//  EnglishTeachingAPP
//
//  Created by will on 2017/10/12.
//  Copyright © 2017年 will. All rights reserved.
//

#import "LeftViewController.h"
#import "AppDelegate.h"
#import "HomeTableViewController.h"

@interface LeftViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIImageView *backgroundIV;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong)NSArray *titles;
@property (nonatomic, strong)NSArray *imageNames;
@end

@implementation LeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //为背景图增加一层蒙层
    UIBlurEffect* blurEffect = [UIBlurEffect effectWithStyle:(UIBlurEffectStyleLight)];
    UIVisualEffectView* visualEffect = [[UIVisualEffectView alloc]initWithEffect:blurEffect];
    [visualEffect setFrame:[UIScreen mainScreen].bounds];
    [self.backgroundIV addSubview:visualEffect];
    
    self.titles = @[@"首页",@"消息列表",@"好友列表",@"设置",@"班级列表",@"学生列表"];
    self.imageNames = @[@"home",@"message",@"friends",@"setup",@"classes",@"studens"];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.titles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    cell.textLabel.text = self.titles[indexPath.row];
    cell.imageView.image = [UIImage imageNamed:self.imageNames[indexPath.row]];
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor whiteColor];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    app.mainTabVC.selectedIndex = indexPath.row;
    
    [app.leftSlideVC closeLeftView];
    
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
