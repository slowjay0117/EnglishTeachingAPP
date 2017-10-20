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

+ (void)loginTeacherAccount{
    NSString *username = [[NSUserDefaults standardUserDefaults] objectForKey:@"username"];
    NSString *pwd = [[NSUserDefaults standardUserDefaults] objectForKey:@"password"];
    
    //登录回老师账号
    [BmobUser loginInbackgroundWithAccount:username andPassword:pwd block:^(BmobUser *user, NSError *error) {
        if (user) {
            [SVProgressHUD showInfoWithStatus:@"登录回老师账号"];
        }
    }];
}

+ (void)faceMappingWithText:(YYTextView *)tv{
    //表情解析器
    YYTextSimpleEmoticonParser *parser = [YYTextSimpleEmoticonParser new];
    
    NSMutableDictionary *mapperDic = [NSMutableDictionary dictionary];
    NSString *path = [[NSBundle mainBundle]pathForResource:@"default" ofType:@"plist"];
    NSArray *faceArr = [NSArray arrayWithContentsOfFile:path];
    for (NSDictionary *faceDic in faceArr) {
        NSString *imageName = faceDic[@"png"];
        NSString *text = faceDic[@"chs"];
        
        [mapperDic setObject:[UIImage imageNamed:imageName] forKey:text];
    }
    
    parser.emoticonMapper = mapperDic;
    
    tv.textParser = parser;
}
@end
