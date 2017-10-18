//
//  StudentListCell.m
//  EnglishTeachingAPP
//
//  Created by will on 2017/10/17.
//  Copyright © 2017年 will. All rights reserved.
//

#import "StudentListCell.h"

@implementation StudentListCell

- (void)setStudents:(BmobUser *)students{
    _students = students;
    self.usernameTF.text = [students objectForKey:@"username"];
    self.nickTF.text = [students objectForKey:@"nick"];
    self.moneyTF.text = [NSString stringWithFormat:@"金币：%@", [students objectForKey:@"money"]];
    self.scoreTF.text = [NSString stringWithFormat:@"积分：%@", [students objectForKey:@"scoreTF"]];
    [self.headImageIV sd_setImageWithURL:[NSURL URLWithString:[students objectForKey:@"headPath"]] placeholderImage:KLoadingImage];
    
    self.headImageIV.layer.cornerRadius = self.headImageIV.size.height/2;
    self.headImageIV.layer.masksToBounds = YES;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
