//
//  RegistrationStudentViewController.m
//  EnglishTeachingAPP
//
//  Created by will on 2017/10/15.
//  Copyright © 2017年 will. All rights reserved.
//

#import "RegistrationStudentViewController.h"

@interface RegistrationStudentViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate,UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIButton *headBtn;
@property (weak, nonatomic) IBOutlet UITextField *usernameTF;
@property (weak, nonatomic) IBOutlet UITextField *nickFT;
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;
@property (weak, nonatomic) IBOutlet UITextField *scoreTF;
@property (weak, nonatomic) IBOutlet UITextField *moneyTF;
@property (nonatomic, strong)UIImage *headImage;
@property (nonatomic, strong)NSMutableArray *classes;
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSMutableArray *selectedClass;

@end

@implementation RegistrationStudentViewController
- (NSMutableArray *)selectedClass{
    if (!_selectedClass) {
        _selectedClass = [NSMutableArray array];
    }
    return _selectedClass;
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, KSH, KSW, 200) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (IBAction)selectedHeader:(UIButton *)sender {
    UIImagePickerController *vc = [UIImagePickerController new];
    vc.delegate = self;
    vc.allowsEditing = YES;
    
    [self presentViewController:vc animated:YES completion:nil];
}
- (IBAction)selectedClasses:(UIButton *)sender {
    [self.view endEditing:YES];
    [UIView animateWithDuration:.25 animations:^{
        if (CGAffineTransformEqualToTransform(self.tableView.transform, CGAffineTransformIdentity)) {
            self.tableView.transform = CGAffineTransformMakeTranslation(0, -200);
        }else{
            self.tableView.transform = CGAffineTransformIdentity;
        }
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

- (void)loadClasses{
    BmobQuery *bq = [BmobQuery queryWithClassName:@"Classes"];
    [bq includeKey:@"byUser"];
    [bq findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        self.classes = [array mutableCopy];
        [self.tableView reloadData];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"save" style:UIBarButtonItemStyleDone target:self action:@selector(saveAction)];
    [self loadClasses];
    
    if (self.student) {
        self.usernameTF.text = self.student.username;
        self.passwordTF.text = self.student[@"updatePwd"]?self.student[@"updatePwd"]:@"12345678";
        self.nickFT.text = self.student[@"nick"];
        self.scoreTF.text = self.student[@"scoreTF"];
        self.moneyTF.text = self.student[@"money"];
        self.selectedClass = [self.student[@"classes"] mutableCopy];
        [self.headBtn sd_setImageWithURL:[NSURL URLWithString:self.student[@"headPath"]] forState:UIControlStateNormal placeholderImage:KLoadingImage];
    }
    
}

- (void)saveAction{
    [SVProgressHUD show];
    if (![Utlis checkingString:self.usernameTF.text]||![Utlis checkingString:self.nickFT.text]||![Utlis checkingString:self.passwordTF.text]||self.selectedClass.count == 0) {
        return;
    }
    
    if (self.student) {
        NSString *pw = self.student[@"updatePwd"]?self.student[@"updatePwd"]:@"12345678";
        [BmobUser loginWithUsernameInBackground:self.student.username password:pw block:^(BmobUser *user, NSError *error) {
            if (user) {
                [SVProgressHUD showWithStatus:@"登录当前学生成功！"];
                [self updateStudent];
            }
        }];
        
    }else{
        BmobUser *bUser = [[BmobUser alloc] init];
        //新建
        self.scoreTF.text = [self checkTextFieldWithString:self.scoreTF.text];
        self.moneyTF.text = [self checkTextFieldWithString:self.moneyTF.text];
        
        [bUser setUsername:self.usernameTF.text];
        [bUser setPassword:self.passwordTF.text];
        [bUser setObject:self.nickFT.text forKey:@"nick"];
        [bUser setObject:self.scoreTF.text forKey:@"scoreTF"];
        [bUser setObject:self.moneyTF.text forKey:@"money"];
        [bUser setObject:self.selectedClass forKey:@"classes"];
        [SVProgressHUD show];
        [bUser signUpInBackgroundWithBlock:^ (BOOL isSuccessful, NSError *error){
            [SVProgressHUD dismiss];
            if (isSuccessful){
                //保存头像
                [self saveHeadImageWithUser:bUser];
                NSLog(@"保存成功");
            } else {
                NSLog(@"%@",error);
            }
        }];
    }
 
}

- (void)updateStudent{
    BmobUser *user = self.student;
    self.scoreTF.text = [self checkTextFieldWithString:self.scoreTF.text];
    self.moneyTF.text = [self checkTextFieldWithString:self.moneyTF.text];
    
    [user setUsername:self.usernameTF.text];
    [user setPassword:self.passwordTF.text];
    [user setObject:self.nickFT.text forKey:@"nick"];
    [user setObject:self.scoreTF.text forKey:@"scoreTF"];
    [user setObject:self.moneyTF.text forKey:@"money"];
    [user setObject:self.selectedClass forKey:@"classes"];
    [SVProgressHUD show];
    [user updateInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
        [SVProgressHUD dismiss];
        if (isSuccessful) {
            [self saveHeadImageWithUser:user];
            NSLog(@"保存成功");
        }else{
            NSLog(@"保存失败");
        }
    }];
}

- (NSString *)checkTextFieldWithString:(NSString *)string{
    NSString *newString = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (newString.length == 0) {
        string = @"0";
    }
    return string;
}

- (void)saveHeadImageWithUser:(BmobUser *)user{
    if (self.headImage) {        
        NSData *data = UIImageJPEGRepresentation(self.headImage, .2);
        [SVProgressHUD showProgress:0 status:@"开始上传"];
        [BmobFile filesUploadBatchWithDataArray:@[@{@"filename":@"a.jpg",@"data":data}] progressBlock:^(int index, float progress) {
        } resultBlock:^(NSArray *array, BOOL isSuccessful, NSError *error) {
            if (isSuccessful) {
                BmobFile *bf = array[0];
                [user setObject:bf.url forKey:@"headPath"];
                [user updateInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
                    [SVProgressHUD dismiss];
                    //登录回老师账号
                    [Utlis loginTeacherAccount];
                    [self.navigationController popViewControllerAnimated:YES];
                }];
            }
        }];
    }else{//没有头像
        [Utlis loginTeacherAccount];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.classes.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    
    BmobObject *bObj = self.classes[indexPath.row];
    cell.textLabel.text = [bObj objectForKey:@"className"];
    
    if ([self.selectedClass containsObject:[bObj objectForKey:@"className"]]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }else{
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    BmobObject *obj = self.classes[indexPath.row];
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell.accessoryType != UITableViewCellAccessoryCheckmark) {
        [self.selectedClass addObject:[obj objectForKey:@"className"]];
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }else{
        [self.selectedClass removeObject:[obj objectForKey:@"className"]];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    UIImage *image = info[UIImagePickerControllerEditedImage];
    [self.headBtn setImage:image forState:UIControlStateNormal];
    self.headImage = image;
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
