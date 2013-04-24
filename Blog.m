//
//  Blog.m
//  LRDemo
//
//  Created by menxu on 13-4-3.
//  Copyright (c) 2013年 menxu. All rights reserved.
//

#import "Blog.h"
#import "GlobalDef.h"
#import "LRDemoAPI.h"
#import <CoreData/CoreData.h>
#import "Client.h"


@implementation Blog

@synthesize Id              = _Id;
@synthesize UserId          = _UserId;
@synthesize CategoryId      = _CategoryId;
@synthesize Title           = _Title;
@synthesize Content         = _Content;
@synthesize ImageUrl        = _ImageUrl;
@synthesize SourceImageUrl  = _SourceImageUrl;
@synthesize CreatedTime     = _CreatedTime;
@synthesize UpdatedTime     = _UpdatedTime;


- (void)updateWithJsonDictionary:(NSDictionary*)dictionary {
    [self reset];
    
    _Id             = [[dictionary objectForKey:@"id"] retain];
    _UserId         = [[dictionary objectForKey:@"user_id"] retain];
    _CategoryId     = [[dictionary objectForKey:@"category_id"] retain];
    _Title          = [[dictionary objectForKey:@"title"] retain];
    _CreatedTime    = [[dictionary objectForKey:@"created_at"] retain];
    _UpdatedTime    = [[dictionary objectForKey:@"updated_at"] retain];
    
    //过滤文章简介中的"\r"和"\n"标签
    NSString *source = [NSString stringWithFormat:@"%@...", [dictionary objectForKey:@"content"]];
    _Content = [[[source stringByReplacingOccurrencesOfString:@"\r" withString:@""]
                     stringByReplacingOccurrencesOfString:@"\n" withString:@""]
                    retain];
    
    //如果博客封面路径是相对路径改为绝对路径
    if ([_ImageUrl hasPrefix:@"../"]) {
        NSRange range = {0};
        range.location = 2;
        range.length = [_ImageUrl length] - range.location;
        
        NSString *imageFullPath = [[NSString alloc] initWithFormat:@"%@%@%@%@%@",
                                   MAIN_PROCOTOL,MAIN_HOST,MAIN_PORT,DOWNLOAD_RESOURCE_PATH,[_ImageUrl substringWithRange:range]];
        [_ImageUrl release];
        _ImageUrl = imageFullPath;
        NSString *imageFullPath2 = [[NSString alloc] initWithFormat:@"%@%@%@%@%@",
                                    MAIN_PROCOTOL,MAIN_HOST,MAIN_PORT,DOWNLOAD_RESOURCE_PATH,[[dictionary objectForKey:@"image_url"] substringWithRange:range]];
        _SourceImageUrl = imageFullPath2;
    }else{
        _SourceImageUrl = [_ImageUrl copy];
    }
}

- (id)initWithJsonDictionary:(NSDictionary*)dictionary {
    if (self = [super init]) {
        [self updateWithJsonDictionary:dictionary];
    }
    return self;
}

- (id)initWithFavorite:(NSManagedObject *)managedObject{
    if (self = [super init]) {
        self.Id             = [managedObject valueForKey:@"id"];
        self.UserId         = [managedObject valueForKey:@"user_id"];
        self.CategoryId     = [managedObject valueForKey:@"category_id"];
        self.Title          = [managedObject valueForKey:@"title"];
        self.Content        = [managedObject valueForKey:@"content"];
        self.SourceImageUrl = @"addTo";
        self.CreatedTime    = [managedObject valueForKey:@"created_at"];
        self.UpdatedTime    = [managedObject valueForKey:@"updated_at"];
    }
    return self;
}

- (void)dealloc {
    [self reset];
    [super dealloc];
}
- (void)reset {
    RELEASE_SAFELY(_Id);
    RELEASE_SAFELY(_UserId);
    RELEASE_SAFELY(_CategoryId)
    RELEASE_SAFELY(_Title);
    RELEASE_SAFELY(_ImageUrl);
    RELEASE_SAFELY(_SourceImageUrl);
    RELEASE_SAFELY(_CreatedTime);
    RELEASE_SAFELY(_UpdatedTime);
}
@end
