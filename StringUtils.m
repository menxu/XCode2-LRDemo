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


+(NSString *)md5:(NSString *)str {
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5( cStr, strlen(cStr), result );
    return [NSString stringWithFormat:
            @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}
@end
