//
//  SelectPhotoView.m
//  EnglishTeachingAPP
//
//  Created by will on 2017/10/20.
//  Copyright © 2017年 will. All rights reserved.
//

#import "SelectPhotoView.h"

@implementation SelectPhotoView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UICollectionViewFlowLayout *fl = [UICollectionViewFlowLayout new];
        [fl setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        
        self.collectionView = [[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:fl];
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
        [self addSubview:self.collectionView];
        self.collectionView.alwaysBounceHorizontal = YES;
        [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
        self.collectionView.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)setSelectPhotos:(NSMutableArray *)selectPhotos{
    _selectPhotos = selectPhotos;
    //刷新collectionView
    [self.collectionView reloadData];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.selectPhotos.count+1;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    UIImageView *photoBtn = [cell viewWithTag:1];
    
    if (!photoBtn) {
        photoBtn = [[UIImageView alloc]initWithFrame:cell.bounds];
        photoBtn.tag = 1;
        [cell addSubview:photoBtn];
        
    }

    //如果点击的是图片
    if (indexPath.row<self.selectPhotos.count) {
        photoBtn.image=self.selectPhotos[indexPath.row] ;
        photoBtn.contentMode = UIViewContentModeScaleAspectFill;
        photoBtn.clipsToBounds = YES;
    }else{//添加加号按钮
        photoBtn.image=[UIImage imageNamed:@"add2"];
        photoBtn.contentMode = UIViewContentModeCenter;
    }
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    //    8  8
    //
    float w = (KSW-6*kSpacing)/4;
    return CGSizeMake(w, w*1.3);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(10, kSpacing, 0, kSpacing);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return kSpacing;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return kSpacing;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    //如果点击的是图片
    if (indexPath.row<self.selectPhotos.count) {
        [self.selectPhotos removeObjectAtIndex:indexPath.row];
        //把已选择模型数组里面的东西删掉
        [self.lastSelectMoldels removeObjectAtIndex:indexPath.row];
        //删除cell带动画 不用加reloaddata
        [self.collectionView deleteItemsAtIndexPaths:@[indexPath]];
        
        //通过delegate回调到Controller
        [self.delegate deleteAction];
    }else{//如果点击的是添加按钮
        [self.delegate didClickedAddImageBtnAction];
    }
}

@end
