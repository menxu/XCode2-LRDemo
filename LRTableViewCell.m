//
//  LRTableViewCell.m
//  LRDemo
//
//  Created by menxu on 13-4-10.
//  Copyright (c) 2013年 menxu. All rights reserved.
//

#import "LRTableViewCell.h"
#import "GlobalDef.h"
#import "ImageCacher.h"
//#import "UIImageView+WebCache.h"

@implementation LRTableViewCell

static UIImage* defaultUrlImage;
static UIImage* defaultBackgroundImage;
//static UIImage* defaultTagBgImage;

@synthesize creatorNameLabel    = _creatorNameLabel;
@synthesize titleLabel          = _titleLabel;
@synthesize contentLabel        = _contentLabel;
@synthesize createdTimeLabel    = _createdTimeLabel;

@synthesize creatorImageView    = _creatorImageView;
@synthesize favoriteButton      = _favoriteButton;

@synthesize systemTagImageView  = _systemTagImageView;
@synthesize seriesTagImageView  = _seriesTagImageView;
@synthesize systemTagButton     = _systemTagButton;
@synthesize seriesTagButton     = _seriesTagButton;

@synthesize openCountLabel      = _openCountLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString*)identifier {
	if (self = [super initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:identifier]) {
	}
	return self;
}

- (void)setDataSource:(id)data{
    if (data == nil) { return;}
    Blog *blog = data;
    [self setBackgroundImage:nil];
//    [self setUserName:blog.UserId];
//    [self setCategoryName:blog.CategoryId];
    [self setTitle:blog.Title];
    [self setContent:blog.Content];
    [self setSourseImage:blog.ImageUrl];
//    [self setCreatedTime:blog.CreatedTime];

//    [self setDescription:article.Description];
//    [self setOpenCount:article.OpenCount];
}

- (void)setTitle:(NSString *)title{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        if ([[UIDevice currentDevice] userInterfaceIdiom ] == UIUserInterfaceIdiomPhone ) {
            _titleLabel.font = English_font_title;
        } else {
            _titleLabel.font = English_font_title_iPad;
        }
        _titleLabel.textColor            = ZBSTYLE_textColor;
        _titleLabel.highlightedTextColor = ZBSTYLE_highlightedTextColor;
        _titleLabel.textAlignment        = UITextAlignmentLeft;
        _titleLabel.contentMode          = UIViewContentModeTop;
        _titleLabel.lineBreakMode        = UILineBreakModeTailTruncation;
        _titleLabel.numberOfLines        = 0;
        
        [self.contentView addSubview:_titleLabel];
    }
    
//    NSLog(@"setName:  nameLabel = %@",title);
    _titleLabel.text = title ? title : NSLocalizedString(@"未命名", @"nil");
}
- (void)setContent:(NSString *)content{
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] init];
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
            _contentLabel.font = English_font_des;
        }else{
            _contentLabel.font = English_font_des_iPad;
        }
        _contentLabel.textColor            = ZBSTYLE_tableSubTextColor;
        _contentLabel.highlightedTextColor = ZBSTYLE_highlightedTextColor;
        _contentLabel.textAlignment        = UITextAlignmentLeft;
        _contentLabel.contentMode          = UIViewContentModeTop;
        _contentLabel.lineBreakMode        = UILineBreakModeTailTruncation;
        _contentLabel.numberOfLines        = 0;
        
        [self.contentView addSubview:_contentLabel];
    }
    _contentLabel.text = content ? content : @"";
    
}
- (void)setSourseImage:(NSString *)image_Url{
    if ([image_Url length] == 0 ) {
        return;
    }
    _creatorImageView = [[UIImageView alloc] init];
    _creatorImageView.layer.shadowColor = [[UIColor blackColor] CGColor];
    _creatorImageView.layer.shadowOffset = CGSizeMake(0.0f, 1.0f);
    _creatorImageView.layer.shadowRadius = 1.5f;
    _creatorImageView.layer.shadowOpacity = 0.5f;
    
    [self.contentView addSubview:_creatorImageView];
    
    imageUrl = [image_Url copy];
    
    if (hasCachedImage(image_Url)) {
        [_creatorImageView setImage:[UIImage imageWithContentsOfFile:pathForURL(image_Url)]];
    }else{
        [_creatorImageView setImage:[UIImage imageNamed:@"DefaultCover.png"]];

        NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:image_Url,@"url",_creatorImageView,@"imageView",nil];
        [NSThread detachNewThreadSelector:@selector(cacheImage:) toTarget:[ImageCacher defaultCacher] withObject:dic];
    }
}

- (void)setFavorite:(BOOL)favorite tagId:(NSInteger)tagId target:(id)target action:(SEL)selector{
    
}
- (void)setArticleTags:(NSArray*)tags target:(id)target action:(SEL)selector{
    
}

+ (CGFloat)rowHeightForObject:(id)object{
    if (object == nil) {
        return 0.0;
    }
    Blog *blog = object;
    CGFloat urlImageHeight = [blog.ImageUrl length] > 0 ? COVER_BACKGROUND_HEIGHT : kTableCellSmallMargin;
    
    UIFont *titleFont   = nil;
    UIFont *contentFont = nil;
    if ([[UIDevice currentDevice] userInterfaceIdiom ] == UIUserInterfaceIdiomPhone) {
        contentFont = English_font_des;
        titleFont   = English_font_title;
    }else{
        contentFont = English_font_des_iPad;
        titleFont   = English_font_title_iPad;
    }
    //主题
    CGSize titleLabelSize = [blog.Title sizeWithFont:titleFont
                                   constrainedToSize:CGSizeMake(CELL_CONTENT_WIDTH, CGFLOAT_MAX)
                                       lineBreakMode:UILineBreakModeMiddleTruncation];
    
    //子标题
    CGSize subtitleLabelSize = [@"Hellow Blog" sizeWithFont:contentFont
                                          constrainedToSize:CGSizeMake(CELL_CONTENT_WIDTH, CGFLOAT_MAX)
                                              lineBreakMode:UILineBreakModeMiddleTruncation];
    CGSize contentLabelSize = {0};
    if ([blog.Content length] > 0) {
        contentLabelSize = [blog.Content sizeWithFont:contentFont
                                    constrainedToSize:CGSizeMake(CELL_CONTENT_WIDTH, CGFLOAT_MAX)
                                        lineBreakMode:UILineBreakModeWordWrap];
        if (contentLabelSize.height > 20*subtitleLabelSize.height) {
            contentLabelSize.height = 20*subtitleLabelSize.height;
        }
    }
    CGFloat textHeight = urlImageHeight + titleLabelSize.height + subtitleLabelSize.height + SUBTITLE_HEIGHT
    + contentLabelSize.height + (contentLabelSize.height > 0 ? kTableCellSmallMargin : 0);
    return textHeight + kTableCellSmallMargin * 3;
}

- (void)setRead:(BOOL)read{
    
}

- (void)setBackgroundColor:(UIColor *)backgroundColor{
    [super setBackgroundColor:backgroundColor];
    
    _titleLabel.backgroundColor     = [UIColor clearColor];
    _contentLabel.backgroundColor   = [UIColor clearColor];
    
}

- (void)prepareForReuse {
    [super prepareForReuse];
    
    _titleLabel.text = nil;
    _titleLabel.textColor = [UIColor blackColor];
    _contentLabel.text = nil;
//    [_creatorImageView cancelCurrentImageLoad];
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    UIFont* titleFont = nil;
    UIFont* contentFont = nil;
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        contentFont = English_font_des;
        titleFont       = English_font_title;
    }else{
        contentFont = English_font_title_iPad;
        titleFont       = English_font_title_iPad;
    }
    
    CGSize subtitleLableSize = [@"2013-4-24" sizeWithFont:contentFont
                                             constrainedToSize:CGSizeMake(CELL_CONTENT_WIDTH, CGFLOAT_MAX)
                                             lineBreakMode:UILineBreakModeTailTruncation];
    //当前View的x坐标
    CGFloat left = kTableCellSmallMargin;
    //当前View的y坐标
    CGFloat top = kTableCellSmallMargin;
    //取得文章标题的高度
    CGSize nameLabelSize = [_titleLabel.text sizeWithFont:titleFont
                                             constrainedToSize:CGSizeMake(CELL_CONTENT_WIDTH, CGFLOAT_MAX)
                                             lineBreakMode:UILineBreakModeTailTruncation];
    _titleLabel.frame = CGRectMake(left, top, CELL_CONTENT_WIDTH - 2*kTableCellSmallMargin, nameLabelSize.height);
    
    //_creatorImageView 在 _titleLabel 之下
    top  = (_titleLabel.frame.origin.y + _titleLabel.frame.size.height);
    left = (CELL_CONTENT_WIDTH - COVER_BACKGROUND_WIDTH) / 2;
    if ([imageUrl length] > 0) {
        _creatorImageView.contentMode = UIViewContentModeScaleAspectFit;
        _creatorImageView.frame       = CGRectMake(kTableCellSmallMargin,
                                                   top + (COVER_BACKGROUND_HEIGHT - COVER_IMAGE_HEIGHT)/2,
                                                   COVER_IMAGE_WIDTH,
                                                   COVER_IMAGE_HEIGHT);
        top += COVER_BACKGROUND_HEIGHT;
    }else{
        _creatorImageView.frame = CGRectZero;
        top += kTableCellSmallMargin;
    }
    //取得_contentLabel的宽高
    CGSize contentLableSize = [_contentLabel.text sizeWithFont:contentFont
                                                  constrainedToSize:CGSizeMake(CELL_CONTENT_WIDTH, CGFLOAT_MAX)
                                                  lineBreakMode:UILineBreakModeWordWrap];
    //设置_contentLabel的坐标
    _contentLabel.frame = CGRectMake(kTableCellSmallMargin, top, CELL_CONTENT_WIDTH - 2*kTableCellSmallMargin, contentLableSize.height);
    
    if (contentLableSize.height > 0) {
        top += contentLableSize.height + kTableCellSmallMargin;
    }
//    NSLog(@"%d  %d  %d",left,top,subtitleLableSize.height);
}

//theImage为nil时使用默认的CellBackground.png作为表格Cell背景
-(void)setBackgroundImage:(UIImage *)theImage{
    UIImage *backgroundImage;
    if (theImage == nil) {
        backgroundImage = [LRTableViewCell getDefaultBackgroundImage];
    }else{
        backgroundImage = theImage;
    }
    
    if (self.backgroundView) {
        self.backgroundView = [[[UIImageView alloc] initWithImage:backgroundImage] autorelease];
        self.backgroundView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        self.backgroundView.frame = self.bounds;
    }
}
+ (UIImage*)getDefaultBackgroundImage {
    
    if (defaultBackgroundImage == nil) {
        NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"CellBackground" ofType:@"png"];
        defaultBackgroundImage = [[UIImage imageWithContentsOfFile:imagePath]
                                  stretchableImageWithLeftCapWidth:0.0 topCapHeight:1.0];
        [defaultBackgroundImage retain];
    }
    
    return defaultBackgroundImage;
}
+ (UIImage*)getDefaultUrlImage {
    
    if (defaultUrlImage == nil) {
        defaultUrlImage = [[UIImage imageNamed:@"DefaultCover.png"] retain];
    }
    
    return defaultUrlImage;
}


- (void)dealloc{
    [super dealloc];
    
    RELEASE_SAFELY(_creatorNameLabel);
    RELEASE_SAFELY(_categoryNameLabel);
    RELEASE_SAFELY(_titleLabel);
    RELEASE_SAFELY(_contentLabel);
    RELEASE_SAFELY(_createdTimeLabel);
    RELEASE_SAFELY(_openCountLabel);
    
    RELEASE_SAFELY(_creatorImageView);
    RELEASE_SAFELY(_favoriteButton);
    
    RELEASE_SAFELY(_systemTagImageView);
    RELEASE_SAFELY(_seriesTagImageView);
    RELEASE_SAFELY(_systemTagButton);
    RELEASE_SAFELY(_seriesTagButton);
}
@end
