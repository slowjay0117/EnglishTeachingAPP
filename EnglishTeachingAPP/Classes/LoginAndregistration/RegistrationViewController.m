//
//  RegistrationViewController.m
//  EnglishTeachingAPP
//
//  Created by will on 2017/10/12.
//  Copyright © 2017年 will. All rights reserved.
//

#import "RegistrationViewController.h"

@interface RegistrationViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;

@end

@implementation RegistrationViewController
- (IBAction)clicked:(id)sender {
    BmobUser *bUser = [[BmobUser alloc] init];
    [bUser setUsername:self.nameTF.text];
    [bUser setPassword:self.passwordTF.text];
    [bUser setObject:@"YES" forKey:@"isTeacher"];
    [bUser signUpInBackgroundWithBlock:^ (BOOL isSuccessful, NSError *error){
        if (isSuccessful){
            AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
            [app showHomeVC];
        } else {
            NSLog(@"%@",error);
        }
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"注册";
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
