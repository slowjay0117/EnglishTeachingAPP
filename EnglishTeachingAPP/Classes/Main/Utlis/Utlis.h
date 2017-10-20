//
//  Utlis.h
//  EnglishTeachingAPP
//
//  Created by will on 2017/10/17.
//  Copyright © 2017年 will. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import "YYTextView.h"
static AVAudioPlayer *player;
@interface Utlis : NSObject
+(BOOL)checkingString:(NSString *)string;

+ (void)loginTeacherAccount;
+ (void)faceMappingWithText:(YYTextView *)tv;
@end
