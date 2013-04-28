//
//  StringUtils.h
//  LRDemo
//
//  Created by menxu on 13-4-19.
//  Copyright (c) 2013年 menxu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StringUtils : NSObject

+ (NSString *)intervalSinceTime:(NSDate *)theBeforeDate andTime:(NSDate *)theLaterDate;
+ (NSDateFormatter *)getDateFormatter;
+ (NSDateFormatter *)getFullDateFormatter;
+(NSString *)md5:(NSString *)str;
@end
