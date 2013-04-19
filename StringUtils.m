//
//  StringUtils.m
//  LRDemo
//
//  Created by menxu on 13-4-19.
//  Copyright (c) 2013年 menxu. All rights reserved.
//

#import "StringUtils.h"

@implementation StringUtils

+ (NSString *)intervalSinceTime:(NSDate *)theBeforeDate andTime:(NSDate *)theLaterDate {
    
    if (theBeforeDate == nil || theLaterDate == nil) {
        return @"";
    }
    
    NSTimeInterval beforeDate = [theBeforeDate timeIntervalSince1970];
    
    NSTimeInterval laterDate = [theLaterDate timeIntervalSince1970];
    
    NSTimeInterval subDate = laterDate - beforeDate;
    
    NSString *res = nil;
    
    if (subDate / 3600 <= 1) {
        res = [NSString stringWithFormat:@"%f", subDate / 60];
        res = [res substringToIndex:res.length - 7];
        if (subDate < 60) {
            res = [NSString stringWithFormat:NSLocalizedString(@"刚刚", @""), res];
        }
        else{
            res = [NSString stringWithFormat:NSLocalizedString(@"%@分钟前", @""), res];
        }
    }
    else if (subDate / 3600 > 1 && subDate / 86400 <= 1) {
        res = [NSString stringWithFormat:@"%f", subDate / 3600];
        res = [res substringToIndex:res.length - 7];
        res = [NSString stringWithFormat:NSLocalizedString(@"%@小时前", @""), res];
    }
    else if (subDate / 86400 > 1 && subDate / 86400 <= 3) {
        res = [NSString stringWithFormat:@"%f", subDate / 86400];
        res = [res substringToIndex:res.length - 7];
        res = [NSString stringWithFormat:NSLocalizedString(@"%@天前", @""), res];
    }
    else {
        res = [[StringUtils getDateFormatter] stringFromDate:theBeforeDate];
    }
    
    return [res length] ? res : @" ";
}

static NSDateFormatter *s_format = nil;
+ (NSDateFormatter *)getDateFormatter
{
    if (s_format == nil) {
        s_format = [[NSDateFormatter alloc] init];
        [s_format setDateFormat:@"yyyy-MM-dd"];
    }
    
    return s_format;
}

static NSDateFormatter *s_fullFormat = nil;
+ (NSDateFormatter *)getFullDateFormatter
{
    if (s_fullFormat == nil) {
        s_fullFormat = [[NSDateFormatter alloc] init];
        [s_fullFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    }
    
    return s_fullFormat;
}

@end
