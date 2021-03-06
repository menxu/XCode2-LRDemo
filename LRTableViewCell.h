//
//  LRTableViewCell.h
//  LRDemo
//
//  Created by menxu on 13-4-10.
//  Copyright (c) 2013年 menxu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Blog.h"

#define TYPE_IMAGE_HEIGHT       16
#define TYPE_IMAGE_WIDTH        TYPE_IMAGE_HEIGHT

#define COVER_IMAGE_HEIGHT      168
#define COVER_IMAGE_WIDTH       308

#define COVER_BACKGROUND_HEIGHT 180
#define COVER_BACKGROUND_WIDTH  308

#define SUBTITLE_HEIGHT         40
#define FAVORITE_BUTTON_WIDTH   44

#define TAG_WIDTH               120
#define TAG_HEIGHT              TAG_WIDTH

#define CELL_CONTENT_WIDTH   ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone ? SCREEN_WIDTH : ARTICLE_AREA_WIDTH_IPAD)

@interface LRTableViewCell : UITableViewCell{
    UILabel *_creatorNameLabel;
    UILabel *_categoryNameLabel;
    UILabel *_titleLabel;
    UILabel *_contentLabel;
    UILabel *_createdTimeLabel;
    UILabel *_openCountLabel;
    
    UIImageView *_creatorImageView;
    NSString *imageUrl;
    
    UIButton *_favoriteButton;
    
    UIImageView* _systemTagImageView;
    UIImageView* _seriesTagImageView;
    UIButton *_systemTagButton; //主标签，即系统标签
    UIButton *_seriesTagButton; //系列标签
    
    BOOL _bRead;
}
@property (nonatomic, readonly) UILabel *creatorNameLabel;
@property (nonatomic, readonly) UILabel *categoryNameLabel;
@property (nonatomic, readonly) UILabel *titleLabel;
@property (nonatomic, readonly) UILabel *contentLabel;
@property (nonatomic, readonly) UILabel *createdTimeLabel;
@property (nonatomic, readonly) UILabel *openCountLabel;

@property (nonatomic, readonly) UIImageView *creatorImageView;

@property (nonatomic, readonly) UIButton *favoriteButton;

@property (nonatomic, readonly) UIImageView *seriesTagImageView;
@property (nonatomic, readonly) UIImageView *systemTagImageView;
@property (nonatomic, readonly) UIButton *systemTagButton;
@property (nonatomic, readonly) UIButton *seriesTagButton;

- (void)setDataSource:(id)data;
- (void)setFavorite:(BOOL)favorite tagId:(NSInteger)tagId target:(id)target action:(SEL)selector;
- (void)setArticleTags:(NSArray*)tags target:(id)target action:(SEL)selector;

- (void)setRead:(BOOL)read;

+ (CGFloat)rowHeightForObject:(id)object;
+ (UIImage*)getDefaultUrlImage;
@end
