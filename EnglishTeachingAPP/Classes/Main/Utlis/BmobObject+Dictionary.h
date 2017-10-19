//
//  BmobObject+Dictionary.h
//  EnglishTeachingAPP
//
//  Created by will on 2017/10/19.
//  Copyright © 2017年 will. All rights reserved.
//

#import <BmobSDK/Bmob.h>

@interface BmobObject (Dictionary)
- (id)objectForKeyedSubscript:(NSString *)key;
@end
