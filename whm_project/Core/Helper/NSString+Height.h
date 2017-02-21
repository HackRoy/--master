//
//  NSString+Height.h
//  e-bank
//
//  Created by chenJw on 16/9/7.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (Height)

- (CGFloat)heightForLabelWidth:(CGFloat)width
                      fontsize:(int)fontsize;

-(CGFloat)widthForLabelHeight:(CGFloat)height
                     fontsize:(int)fontsize;

@end
