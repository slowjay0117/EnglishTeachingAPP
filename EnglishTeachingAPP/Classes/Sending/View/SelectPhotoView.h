//
//  SelectPhotoView.h
//  EnglishTeachingAPP
//
//  Created by will on 2017/10/20.
//  Copyright © 2017年 will. All rights reserved.
//
@protocol SelectPhotoViewDelegate <NSObject>

-(void)didClickedAddImageBtnAction;
@optional
-(void)deleteAction;
@end
#import <UIKit/UIKit.h>

@interface SelectPhotoView : UIView<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *selectPhotos;
@property (nonatomic, weak)id<SelectPhotoViewDelegate> delegate;
@property (nonatomic, strong) NSMutableArray<ZLSelectPhotoModel *> *lastSelectMoldels;
@end
