//
//  LRDemoAPI.h
//  LRDemo
//
//  Created by menxu on 13-4-3.
//  Copyright (c) 2013年 menxu. All rights reserved.
//

#define MAIN_PROCOTOL       @"http://"

#define MAIN_HOST           @"localhost"
#define MAIN_PORT           @":3000"
#define MAIN_SPACE          @"/api"
#define BLOG_LISTS          @"/blog_lists"

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"
#import "Blog.h"
#import "Parser.h"

@interface LRDemoAPI : NSObject

/********************************
 博客相关
 ********************************/
+(NSURL *)get_url:(NSString *)path;
+ (NSMutableArray *)getBlogList;
+ (NSArray *)get_by_synchronous_api_blog_lists;
+ (NSMutableArray *)get_by_json_blogLists:(NSString *)json_str;

+ (BOOL)getBlogList:(NSUInteger)maxId
             length:(NSUInteger)length
           delegate:(id<ParserDelegate>)delegate
      useCacheFirst:(BOOL)useCacheFirst;

+ (Parser *)getBlogList:(NSString *)userId
                  tagArray:(NSArray *)tagArray
             startPosition:(NSUInteger)startPosition
                    length:(NSUInteger)length
                  delegate:(id<ParserDelegate>)delegate
             useCacheFirst:(BOOL)useCacheFirst;

+ (Parser *)getBlogList:(NSString *)userId
                  tagArray:(NSArray *)tagArray
             startPosition:(NSUInteger)startPosition
                    length:(NSUInteger)length
                  delegate:(id<ParserDelegate>)delegate
             useCacheFirst:(BOOL)useCacheFirst
            connectionType:(ConnectionType)type;

@end
