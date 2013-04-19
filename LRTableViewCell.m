//
//  LRTableViewCell.m
//  LRDemo
//
//  Created by menxu on 13-4-10.
//  Copyright (c) 2013年 menxu. All rights reserved.
//

#import "LRTableViewCell.h"
#import "GlobalDef.h"

@implementation LRTableViewCell

//static UIImage* defaultCoverImage;
static UIImage* defaultBackgroundImage;
//static UIImage* defaultTagBgImage;


@synthesize nameLabel = _nameLabel;
@synthesize descriptionLabel = _descriptionLabel;
@synthesize publishDateLabel = _publishDateLabel;
@synthesize typeImageView = _typeImageView;

@synthesize coverImageView = _coverImageView;
@synthesize systemTagImageView = _systemTagImageView;
@synthesize seriesTagImageView = _seriesTagImageView;
@synthesize systemTagButton = _systemTagButton;
@synthesize seriesTagButton = _seriesTagButton;

@synthesize openCountLabel = _openCountLabel;
@synthesize favoriteButton = _favoriteButton;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString*)identifier {
	if (self = [super initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:identifier]) {
	}
	
	return self;
    
}

- (void)setDataSource:(id)data{
    if (data == nil) { return;}
    Blog *blog = data;
    [self setBackgroundImage:nil];
    [self setName:blog.Title];
//    [self setDescription:article.Description];
//    [self setOpenCount:article.OpenCount];
}

- (void)setName:(NSString *)newName{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        if ([[UIDevice currentDevice] userInterfaceIdiom ] == UIUserInterfaceIdiomPhone ) {
            _nameLabel.font = English_font_title;
        } else {
            _nameLabel.font = English_font_title_iPad;
        }
        _nameLabel.textColor = ZBSTYLE_textColor;
        _nameLabel.highlightedTextColor = ZBSTYLE_highlightedTextColor;
        _nameLabel.textAlignment = UITextAlignmentLeft;
        _nameLabel.contentMode = UIViewContentModeTop;
        _nameLabel.lineBreakMode = UILineBreakModeTailTruncation;
        _nameLabel.numberOfLines = 0;
        
        [self.contentView addSubview:_nameLabel];
    }
    
    NSLog(@"setName:  nameLabel = %@",newName);
    _nameLabel.text = newName ? newName : NSLocalizedString(@"未命名", @"nil");
}

- (void)setFavorite:(BOOL)favorite tagId:(NSInteger)tagId target:(id)target action:(SEL)selector{
    
}
- (void)setArticleTags:(NSArray*)tags target:(id)target action:(SEL)selector{
    
}

+ (CGFloat)rowHeightForObject:(id)object{
    return 30.0;
}

- (void)setRead:(BOOL)read{
    
}
- (void)setBackgroundColor:(UIColor *)backgroundColor{
    [super setBackgroundColor:backgroundColor];
    
    _nameLabel.backgroundColor = [UIColor clearColor];
}

- (void)prepareForReuse {
    [super prepareForReuse];
    
    _nameLabel.text = nil;
    _nameLabel.textColor = [UIColor blackColor];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    UIFont* titleFont = nil;
//    UIFont* descriptionFont = nil;
//    descriptionFont = English_font_des;
    titleFont = English_font_title;
    
    //当前View的x坐标
    CGFloat left = kTableCellSmallMargin;
    //当前View的y坐标
    CGFloat top = kTableCellSmallMargin;
    //取得文章标题的高度
    CGSize nameLabelSize = [_nameLabel.text sizeWithFont:titleFont
                                       constrainedToSize:CGSizeMake(CELL_CONTENT_WIDTH, CGFLOAT_MAX)
                                           lineBreakMode:UILineBreakModeTailTruncation];
    _nameLabel.frame = CGRectMake(left, top, CELL_CONTENT_WIDTH - 2*kTableCellSmallMargin, nameLabelSize.height);
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

- (void)dealloc{
    [super dealloc];
    
    RELEASE_SAFELY(_nameLabel);
    RELEASE_SAFELY(_openCountLabel);
    RELEASE_SAFELY(_publishDateLabel);
    RELEASE_SAFELY(_typeImageView);
    RELEASE_SAFELY(_coverImageView);
    RELEASE_SAFELY(_favoriteButton);
    RELEASE_SAFELY(coverImageUrl);
    RELEASE_SAFELY(_systemTagImageView);
    RELEASE_SAFELY(_seriesTagImageView);
    RELEASE_SAFELY(_systemTagButton);
    RELEASE_SAFELY(_seriesTagButton);
    
   
}

@end
