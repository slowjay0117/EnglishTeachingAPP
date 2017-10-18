//
//  SettingInfoViewController.m
//  EnglishTeachingAPP
//
//  Created by will on 2017/10/13.
//  Copyright © 2017年 will. All rights reserved.
//

#import "SettingInfoViewController.h"

@interface SettingInfoViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (nonatomic, strong)UITextField *nickTF;
@property (nonatomic, strong)UIImageView *headIV;
@property (nonatomic, strong)NSData *imageData;
@property (nonatomic, strong)UITextField *pwd1;
@property (nonatomic, strong)UITextField *pwd2;
@property (nonatomic, strong)UITextField *oldPwdTF;

@end

@implementation SettingInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    switch (self.rowNumber) {
        case 0:
            [self changePassword];
            break;
        case 1:
            [self showChangeNickAndHeadIV];
            break;
    }
}

///** 修改用户密码界面 */
- (void)changePassword{
    UITextField *oldPwdTF = [[UITextField alloc]initWithFrame:CGRectMake(KSW/2-75, 150, 150, 30)];
    oldPwdTF.placeholder = @"请输入旧密码";
    oldPwdTF.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:oldPwdTF];
    self.oldPwdTF = oldPwdTF;
    
    UITextField *newPwdTF = [[UITextField alloc]initWithFrame:CGRectMake(KSW/2-75, 200, 150, 30)];
    newPwdTF.placeholder = @"请输入新密码";
    newPwdTF.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:newPwdTF];
    self.pwd1 = newPwdTF;
    
    UITextField *confirmPwdTF = [[UITextField alloc]initWithFrame:CGRectMake(KSW/2-75, 250, 150, 30)];
    confirmPwdTF.placeholder = @"请再次输入密码";
    confirmPwdTF.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:confirmPwdTF];
    self.pwd2 = confirmPwdTF;
    
    UIButton *saveBtn = [[UIButton alloc]initWithFrame:CGRectMake(KSW/2, KSH-50, KSW/2, 50)];
    [saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    [saveBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [saveBtn setBackgroundColor:[UIColor lightGrayColor]];
    [saveBtn addTarget:self action:@selector(savePwdAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:saveBtn];
    
    UIButton *cancelBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, KSH-50, KSW/2, 50)];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [cancelBtn setBackgroundColor:[UIColor lightGrayColor]];
    [cancelBtn addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cancelBtn];
}

- (void)savePwdAction{
    if (self.pwd1.text != self.pwd2.text) {
        UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"警告" message:@"您输入的密码不正确，请重新修改" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
        
        [ac addAction:action2];
        
        [self presentViewController:ac animated:YES completion:nil];
    }else{
        BmobUser *bUser = [BmobUser currentUser];
        
        [bUser updateCurrentUserPasswordWithOldPassword:self.oldPwdTF.text newPassword:self.pwd1.text block:^(BOOL isSuccessful, NSError *error) {
            if (isSuccessful) {
                //如果密码修改成功 给用户加一个修改完之后的密码字段
                [bUser setObject:self.pwd1.text forKey:@"updatePwd"];
                [bUser updateInBackground];
                UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"提示" message:@"您的密码更改成功，请重新登录" preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
                    [app showSelectVC];
                    [BmobUser logout];
                }];
                [ac addAction:action1];
                
                [self presentViewController:ac animated:YES completion:nil];
            }else{
                
            }
        }];
    }
}

/** 修改昵称和头像界面 */
- (void)showChangeNickAndHeadIV{
    UIImageView *headIV = [[UIImageView alloc]initWithFrame:CGRectMake(KSW/2-50, 150, 100, 100)];
    [self.view addSubview:headIV];
    self.headIV = headIV;
    
    UIButton *selectBtn = [[UIButton alloc]initWithFrame:CGRectMake(KSW/2-40, 270, 80, 20)];
    [selectBtn setTitle:@"选择图片" forState:UIControlStateNormal];
    [selectBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [selectBtn setBackgroundColor:[UIColor lightGrayColor]];
    [selectBtn addTarget:self action:@selector(selectAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:selectBtn];
    
    UITextField *nickTF = [[UITextField alloc]initWithFrame:CGRectMake(KSW/2-75, 310, 150, 30)];
    nickTF.borderStyle = UITextBorderStyleRoundedRect;
    nickTF.placeholder = @"请输入昵称";
    [self.view addSubview:nickTF];
    self.nickTF = nickTF;
    
    UIButton *saveBtn = [[UIButton alloc]initWithFrame:CGRectMake(KSW/2, KSH-50, KSW/2, 50)];
    [saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    [saveBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [saveBtn setBackgroundColor:[UIColor lightGrayColor]];
    [saveBtn addTarget:self action:@selector(saveAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:saveBtn];
    
    UIButton *cancelBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, KSH-50, KSW/2, 50)];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [cancelBtn setBackgroundColor:[UIColor lightGrayColor]];
    [cancelBtn addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cancelBtn];
    
    //得到当前用户
    BmobUser *bUser = [BmobUser currentUser];
    //显示之前的昵称
    self.nickTF.text = [bUser objectForKey:@"nick"];
    NSString *path = [bUser objectForKey:@"headPath"];
//    NSLog(@"%@", path);
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:path]];
    self.headIV.image = [UIImage imageWithData:data];
}

- (void)selectAction{
    UIImagePickerController *vc = [UIImagePickerController new];
    vc.delegate = self;
    
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)saveAction{
    BmobUser *bUser = [BmobUser currentUser];
    
    [bUser setObject:self.nickTF.text forKey:@"nick"];
    
    [bUser updateInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
        if (isSuccessful) {
            //判断是否有图片
            if (self.imageData) {
                BmobFile *imageFile = [[BmobFile alloc]initWithFileName:@"a.jpg" withFileData:self.imageData];
                //把文件上传到服务器 上传成功之后imageFile对象中的url属性会得到文件的网络地址
                [imageFile saveInBackground:^(BOOL isSuccessful, NSError *error) {
                    if (isSuccessful) {
                        NSLog(@"文件上传完成：%@", imageFile.url);
                        //把上传的图片地址和用户进行关联
                        [bUser setObject:imageFile.url forKey:@"headPath"];
                        
                        [bUser updateInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
                            if (isSuccessful) {
                                //如果成功返回页面
                                UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"提示" message:@"保存成功" preferredStyle:UIAlertControllerStyleAlert];
                                
                                UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                                    [self dismissViewControllerAnimated:YES completion:nil];
                                }];

                                [ac addAction:action2];
                                
                                [self presentViewController:ac animated:YES completion:nil];
                                
                            }
                        }];
                        
                    }
                }];
            }else{
                [self dismissViewControllerAnimated:YES completion:nil];
            }
        }
    }];
}

- (void)cancelAction{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    
        self.imageData = UIImageJPEGRepresentation(image, .5);
    
        self.headIV.image = image;
    
    [self dismissViewControllerAnimated:YES completion:nil];
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
