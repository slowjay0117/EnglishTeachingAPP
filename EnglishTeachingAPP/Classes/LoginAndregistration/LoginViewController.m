//
//  LoginViewController.m
//  EnglishTeachingAPP
//
//  Created by will on 2017/10/12.
//  Copyright © 2017年 will. All rights reserved.
//

#import "LoginViewController.h"
#import "AppDelegate.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;

@end

@implementation LoginViewController
- (IBAction)clicked:(id)sender {
    [BmobUser loginInbackgroundWithAccount:self.nameTF.text andPassword:self.passwordTF.text block:^(BmobUser *user, NSError *error) {
        if (user) {
            AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
            [app showHomeVC];
        }else{
            NSLog(@"登录失败：%@", error);
        }
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"登录";
    [self.navigationController setNavigationBarHidden:NO animated:YES];
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
