//
//  SelectViewController.m
//  EnglishTeachingAPP
//
//  Created by will on 2017/10/12.
//  Copyright © 2017年 will. All rights reserved.
//

#import "WelcomeViewController.h"
#import "LoginViewController.h"
#import "RegistrationViewController.h"

@interface WelcomeViewController ()
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UIButton *registrationBtn;

@end

@implementation WelcomeViewController
- (IBAction)loginBtn:(id)sender {
    LoginViewController *vc = [LoginViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)registrationBtn:(id)sender {
    RegistrationViewController *vc = [RegistrationViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置按钮的样式为圆角，有边框
    self.registrationBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    self.registrationBtn.layer.borderWidth = 1;
    self.registrationBtn.layer.cornerRadius = self.loginBtn.layer.cornerRadius= self.registrationBtn.bounds.size.height/2;
    self.registrationBtn.layer.masksToBounds = self.loginBtn.layer.masksToBounds = YES;
    
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
