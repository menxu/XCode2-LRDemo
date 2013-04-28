//
//  RightTableViewCell.m
//  LRDemo
//
//  Created by menxu on 13-4-27.
//  Copyright (c) 2013年 menxu. All rights reserved.
//

#import "RightTableViewCell.h"

@implementation RightTableViewCell

-(void)setBackgroundColor:(UIColor *)backgroundColor{
    [super setBackgroundColor:backgroundColor];
    iconView.backgroundColor  = [UIColor clearColor];
    nameLable.backgroundColor = [UIColor clearColor];
    nameLable.textColor = [UIColor redColor];
}
-(void)setIcon:(UIImage *)newIcon{
//    self.contentView.backgroundColor = [UIColor redColor];
    if (newIcon == nil) {
        CGRect rc = nameLable.frame;
        rc.origin.x -= 24;
        nameLable.frame = rc;
    }
    iconView.image = newIcon;
}
-(void)setName:(NSString *)newName{
    
    nameLable.text = newName;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        nameLable.textColor = [UIColor blackColor];
    }
}
-(void)setBackgroundImage:(UIImage *)themImage{
    UIImage *backgroundImage;
    if (themImage == nil) {
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
            NSString *backgroundImagePath = [[NSBundle mainBundle] pathForResource:@"TagCellBackground" ofType:@"png"];
            backgroundImage = [[UIImage imageWithContentsOfFile:backgroundImagePath] stretchableImageWithLeftCapWidth:0.0 topCapHeight:1.0];
        }else {
            NSString *backgroundImagePath = [[NSBundle mainBundle] pathForResource:@"TagCellBackground_iPad" ofType:@"png"];
            backgroundImage = [[UIImage imageWithContentsOfFile:backgroundImagePath]
                               stretchableImageWithLeftCapWidth:0.0 topCapHeight:1.0];
        }
    }else{
        backgroundImage = themImage;
    }
    self.backgroundView = [[[UIImageView alloc] initWithImage:backgroundImage] autorelease];
    self.backgroundView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.backgroundView.frame = self.bounds;
}
- (void)dealloc {
    [nameLable release];
    nameLable = nil;
    [iconView release];
    iconView = nil;
    [nameLable release];
    [iconView release];
    [super dealloc];
}
@end