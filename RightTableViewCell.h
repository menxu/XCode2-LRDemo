//
//  RightTableViewCell.h
//  LRDemo
//
//  Created by menxu on 13-4-27.
//  Copyright (c) 2013年 menxu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RightTableViewCell : UITableViewCell{
//    IBOutlet UILabel *nameLable;
//    IBOutlet UIImageView *iconView;
    IBOutlet UILabel *nameLable;
    IBOutlet UIImageView *iconView;
}

-(void)setBackgroundColor:(UIColor *)backgroundColor;
-(void)setBackgroundImage:(UIImage *)themImage;
-(void)setIcon:(UIImage *)newIcon;
-(void)setName:(NSString *)newName;
@end
