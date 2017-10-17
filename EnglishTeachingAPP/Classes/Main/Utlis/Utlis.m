//
//  Utlis.m
//  EnglishTeachingAPP
//
//  Created by will on 2017/10/17.
//  Copyright © 2017年 will. All rights reserved.
//

#import "Utlis.h"

@implementation Utlis
+(BOOL)checkingString:(NSString *)string{
    //    tarena
    //
    //去掉文本两端空格和换行符
    NSString *newString = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    //判断长度是否大于0
    if (newString.length==0) {
        return NO;
    }
    return YES;
}
@end
