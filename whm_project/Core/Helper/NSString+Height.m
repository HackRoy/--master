//
//  NSString+Height.m
//  e-bank
//
//  Created by chenJw on 16/9/7.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import "NSString+Height.h"

@implementation NSString (Height)

- (CGFloat)heightForLabelWidth:(CGFloat)width
                      fontsize:(int)fontsize {
    
    CGSize constraint = CGSizeMake(width, CGFLOAT_MAX);
    
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:fontsize]};
    
    CGRect size = [self boundingRectWithSize:constraint
                                     options:NSStringDrawingUsesLineFragmentOrigin
                                  attributes:attributes
                                     context:nil];
    return size.size.height;
}

-(CGFloat)widthForLabelHeight:(CGFloat)height fontsize:(int)fontsize
{
    CGSize constraint = CGSizeMake(CGFLOAT_MAX, height);
    
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:fontsize]};
    
    return [self boundingRectWithSize:constraint
                              options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes
                              context:nil].size.width;
}

@end
