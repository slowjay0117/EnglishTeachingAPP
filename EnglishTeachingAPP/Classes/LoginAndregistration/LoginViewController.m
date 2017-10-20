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
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@end

@implementation LoginViewController
- (IBAction)clicked:(id)sender {
    [BmobUser loginInbackgroundWithAccount:self.nameTF.text andPassword:self.passwordTF.text block:^(BmobUser *user, NSError *error) {
        if (user) {
            //保存登录的账号和密码
            NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
            [ud setObject:self.nameTF.text forKey:@"username"];
            [ud setObject:self.passwordTF.text forKey:@"password"];
            
            [ud synchronize];
            
            AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
            [app showHomeVC];
        }else{
            UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"警告" message:@"您输入的用户名或密码错误请重新输入" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
            [ac addAction:action2];
            
            [self presentViewController:ac animated:YES completion:nil];
        }
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"登录";
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    //监听软键盘
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardChangeAction:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (void)keyboardChangeAction:(NSNotification *)noti{
    //得到软键盘的Frame
    CGRect keyboardF = [noti.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    //判断收软键盘
    if (keyboardF.origin.y == KSH) {
        //还原
        self.loginBtn.transform = CGAffineTransformIdentity;
    }else{//软键盘弹出
        self.loginBtn.transform = CGAffineTransformMakeTranslation(0, -keyboardF.size.height);
    }
    
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
