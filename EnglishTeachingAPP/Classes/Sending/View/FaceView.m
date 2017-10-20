//
//  FaceView.m
//  EnglishTeachingAPP
//
//  Created by will on 2017/10/20.
//  Copyright © 2017年 will. All rights reserved.
//

#import "FaceView.h"

@implementation FaceView
- (void)awakeFromNib{
    [super awakeFromNib];
    NSString *path = [[NSBundle mainBundle]pathForResource:@"default" ofType:@"plist"];
    NSArray *arr = [NSArray arrayWithContentsOfFile:path];
    self.faceArr = arr;
    int count = 8;
    float size = KSW/count;
    
    NSInteger page = arr.count%32==0?arr.count/32:arr.count/32+1;
    for (int j=0; j<page; j++) {
        int pageCount = (j+1)*32>arr.count?arr.count%32:32;
        
        for (int i = 0; i<pageCount; i++) {
            NSDictionary *faceDic = arr[i];
            NSString *imageName = faceDic[@"png"];
            
            UIButton *faceBtn = [[UIButton alloc]initWithFrame:CGRectMake(i%count*size+j*KSW, i/count*size, size, size)];
            [faceBtn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
            [_faceSV addSubview:faceBtn];
            [faceBtn addTarget:self action:@selector(faceAction:) forControlEvents:UIControlEventTouchUpInside];
            faceBtn.tag = i;
        }
    }
    
    _faceSV.contentSize = CGSizeMake(page*KSW, 0);
    _faceSV.pagingEnabled = YES;
}

- (void)faceAction:(UIButton *)faceBtn{
    NSDictionary *dic = self.faceArr[faceBtn.tag];
    //得到点击按钮对应的文本
    NSString *chs = dic[@"chs"];
    //把得到的文本通过delegate传递给Controller
    [self.delegate didClickedFace:chs];
}

- (IBAction)deleteAction:(id)sender {
    [self.delegate didClickedDeleteAction];
}




@end
