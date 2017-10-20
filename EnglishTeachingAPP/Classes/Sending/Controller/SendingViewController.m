//
//  SendingViewController.m
//  EnglishTeachingAPP
//
//  Created by will on 2017/10/19.
//  Copyright © 2017年 will. All rights reserved.
//

#import "SendingViewController.h"
#import "YYTextView.h"
#import "FaceView.h"
#import "SelectPhotoView.h"

@interface SendingViewController ()<YYTextViewDelegate, FaceViewDelegate,ZLPhotoActionSheetDelegate,SelectPhotoViewDelegate>
@property (weak, nonatomic) IBOutlet YYTextView *titleTV;
@property (weak, nonatomic) IBOutlet YYTextView *detailTV;
@property (weak, nonatomic) IBOutlet UILabel *imageCountLabel;
@property (weak, nonatomic) IBOutlet UIView *toolbarView;
@property (nonatomic, strong)FaceView *faceView;
@property (nonatomic, strong)YYTextView *currentTV;

//选择图片相关
@property (nonatomic, strong) NSMutableArray<ZLSelectPhotoModel *> *lastSelectMoldels;
@property (nonatomic, strong) NSMutableArray *selectPhotos;
@property (nonatomic, strong)SelectPhotoView *selectPhotoView;

@end

@implementation SendingViewController
- (void)textViewDidBeginEditing:(YYTextView *)textView{
    self.currentTV = textView;
}

- (FaceView *)faceView{
    if (!_faceView) {
        _faceView = [[[NSBundle mainBundle]loadNibNamed:@"FaceView" owner:self options:0]firstObject];
        _faceView.delegate = self;
        
        //让界面中的两个文本输入框进行表情匹配
        [Utlis faceMappingWithText:self.titleTV];
        [Utlis faceMappingWithText:self.detailTV];
    }
    return _faceView;
}

-(SelectPhotoView *)selectPhotoView{
    if (!_selectPhotoView) {
        _selectPhotoView = [[SelectPhotoView alloc]initWithFrame:CGRectMake(0, 0, KSW, 180)];
        _selectPhotoView.delegate = self;
    }
    return _selectPhotoView;
}

- (IBAction)clicked:(UIButton *)sender {
    switch (sender.tag) {
        case 0:
        {
            //让文本框弹出的软键盘换成表情键盘
            self.currentTV.inputView = self.currentTV.inputView?nil:self.faceView;
            //刷新软键盘
            [self.currentTV reloadInputViews];
        }
            break;
            
        case 1:
        {
            //让文本框弹出的软键盘换成图片键盘
            self.currentTV.inputView = self.currentTV.inputView?nil:self.selectPhotoView;
            //刷新软键盘
            [self.currentTV reloadInputViews];
            
            //如果没有选择过图片
            if (self.selectPhotos.count==0) {
                [self showSelectSheet];
            }
            
        }
            
            break;
            
        case 3:
            self.currentTV.inputView = nil;
            [self.currentTV reloadInputViews];
            break;
            
        default:
            break;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"新建消息";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(backAction)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"发送" style:UIBarButtonItemStyleDone target:self action:@selector(sendAction)];
    
    //监听软键盘
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardChangeAction:) name:UIKeyboardWillChangeFrameNotification object:nil];
    [self.detailTV becomeFirstResponder];
}

- (void)keyboardChangeAction:(NSNotification *)noti{
    //得到软键盘的Frame
    CGRect keyboardF = [noti.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    //判断收软键盘
    if (keyboardF.origin.y == KSH) {
        //还原
        self.toolbarView.transform = CGAffineTransformIdentity;
    }else{//软键盘弹出
        self.toolbarView.transform = CGAffineTransformMakeTranslation(0, -keyboardF.size.height);
    }
    
}

- (void)backAction{
    UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定返回首页吗？" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"点错了" style:UIAlertActionStyleCancel handler:nil];
    [ac addAction:action1];
    [ac addAction:action2];
    [self presentViewController:ac animated:YES completion:nil];
}

- (void)sendAction{
    
}

- (void)showSelectSheet{
    [self.view endEditing:YES];
    ZLPhotoActionSheet *actionSheet = [[ZLPhotoActionSheet alloc]init];
    actionSheet.delegate = self;
    //设置照片最大选择数
    actionSheet.maxSelectCount = 9;
    //设置照片最大浏览数
    actionSheet.maxPreviewCount = 20;
    
    [actionSheet showWithSender:self animate:YES lastSelectPhotoModels:self.lastSelectMoldels completion:^(NSArray<UIImage *> * _Nonnull selectPhotos, NSArray<ZLSelectPhotoModel *> * _Nonnull selectPhotoModels) {
        self.selectPhotos = [selectPhotos mutableCopy];
        self.lastSelectMoldels = [selectPhotoModels mutableCopy];
        
        //把图片数据传递给自定义控件
        self.selectPhotoView.selectPhotos = self.selectPhotos;
        self.selectPhotoView.lastSelectMoldels = self.lastSelectMoldels;
        //让软键盘响应
        [self.currentTV becomeFirstResponder];
        
        //更新选择图片数量的label
        self.imageCountLabel.text = @(self.selectPhotos.count).stringValue;
        self.imageCountLabel.hidden = self.selectPhotos.count==0?YES:NO;
    }];
}

#pragma mark - SelectPhotoViewDelegate协议
- (void)didClickedAddImageBtnAction{
    //显示选择图片的框架
    [self showSelectSheet];
}

- (void)deleteAction{
    //更新界面中图片数量的label
    self.imageCountLabel.text = @(self.selectPhotos.count).stringValue;
    self.imageCountLabel.hidden = self.selectPhotos.count == 0?YES:NO;
}

#pragma mark - FaceViewDelegate协议
- (void)didClickedFace:(NSString *)text{
    [self.currentTV insertText:text];
}
- (void)didClickedDeleteAction{
    [self.currentTV deleteBackward];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 选择图片框架协议方法
-(void)selectImageCancelAction{
    [self.currentTV becomeFirstResponder];
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
