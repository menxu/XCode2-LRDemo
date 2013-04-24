//
//  Blog.h
//  LRDemo
//
//  Created by menxu on 13-4-3.
//  Copyright (c) 2013年 menxu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Blog : NSObject{ 
    NSString *_Id;
    NSString *_UserId;
    NSString *_CategoryId;
    NSString *_Title;
    NSString *_Content;
    NSString *_ImageUrl;
    NSString *_SourceImageUrl;
    NSString *_CreatedTime;
    NSString *_UpdatedTime;
}

@property (nonatomic, copy) NSString *Id;
@property (nonatomic, copy) NSString *UserId;
@property (nonatomic, copy) NSString *CategoryId;
@property (nonatomic, copy) NSString *Title;
@property (nonatomic, copy) NSString *Content;
@property (nonatomic, copy) NSString *ImageUrl;
@property (nonatomic, copy) NSString *SourceImageUrl;
@property (nonatomic, copy) NSString *CreatedTime;
@property (nonatomic, copy) NSString *UpdatedTime;

- (id)initWithJsonDictionary:(NSDictionary*)dictionary;

@end
