//
//  SelectViewController.m
//  EnglishTeachingAPP
//
//  Created by will on 2017/10/12.
//  Copyright © 2017年 will. All rights reserved.
//

#import "SelectViewController.h"
#import "LoginViewController.h"
#import "RegistrationViewController.h"

@interface SelectViewController ()

@end

@implementation SelectViewController
- (IBAction)clicked:(UIButton *)sender {
    LoginViewController *lvc = [[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];
    RegistrationViewController *rvc = [RegistrationViewController new];
    switch (sender.tag) {
        case 0:
            [self.navigationController pushViewController:lvc animated:YES];
            break;
        case 1:
            [self.navigationController pushViewController:rvc animated:YES];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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
