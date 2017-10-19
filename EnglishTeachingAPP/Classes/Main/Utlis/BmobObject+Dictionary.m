//
//  BmobObject+Dictionary.m
//  EnglishTeachingAPP
//
//  Created by will on 2017/10/19.
//  Copyright © 2017年 will. All rights reserved.
//

#import "BmobObject+Dictionary.h"

@implementation BmobObject (Dictionary)
- (id)objectForKeyedSubscript:(NSString *)key{
    return [self objectForKey:key];
}
@end
