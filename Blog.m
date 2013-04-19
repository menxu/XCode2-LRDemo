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


@implementation Blog

@synthesize Id              = _Id;
@synthesize UserId          = _UserId;
@synthesize CategoryId      = _CategoryId;
@synthesize Title           = _Title;
@synthesize Content         = _Content;
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
    RELEASE_SAFELY(_SourceImageUrl);
    RELEASE_SAFELY(_CreatedTime);
    RELEASE_SAFELY(_UpdatedTime);
}
@end
