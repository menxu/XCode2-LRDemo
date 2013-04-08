//
//  LRDemoAPI.h
//  LRDemo
//
//  Created by menxu on 13-4-3.
//  Copyright (c) 2013年 menxu. All rights reserved.
//

#define MAIN_PROCOTOL       @"http://"

#define MAIN_HOST           @"192.168.1.108"
#define MAIN_PORT           @":80"

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"
#import "Blog.h"

@interface LRDemoAPI : NSObject

/********************************
 博客相关
 ********************************/
+ (NSMutableArray *)getBlogList;

@end
