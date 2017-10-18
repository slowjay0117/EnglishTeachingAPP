//
//  StudentListCell.h
//  EnglishTeachingAPP
//
//  Created by will on 2017/10/17.
//  Copyright © 2017年 will. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StudentListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headImageIV;
@property (weak, nonatomic) IBOutlet UILabel *usernameTF;
@property (weak, nonatomic) IBOutlet UILabel *nickTF;
@property (weak, nonatomic) IBOutlet UILabel *moneyTF;
@property (weak, nonatomic) IBOutlet UILabel *scoreTF;

@end
