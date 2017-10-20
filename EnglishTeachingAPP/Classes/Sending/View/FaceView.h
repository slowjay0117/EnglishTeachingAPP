//
//  FaceView.h
//  EnglishTeachingAPP
//
//  Created by will on 2017/10/20.
//  Copyright © 2017年 will. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SendingViewController.h"

@protocol FaceViewDelegate <NSObject>

- (void)didClickedFace:(NSString *)text;
- (void)didClickedDeleteAction;

@end

@interface FaceView : UIView
@property (weak, nonatomic) IBOutlet UIScrollView *faceSV;
@property (nonatomic, strong) NSArray *faceArr;
@property (nonatomic, weak) id<FaceViewDelegate> delegate;
@end

