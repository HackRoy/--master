//
//  CALayer+HSBorderColor.m
//  HSWormHome
//
//  Created by 赵良育 on 16/9/26.
//  Copyright © 2016年 赵良育. All rights reserved.
//

#import "CALayer+HSBorderColor.h"

@implementation CALayer (HSBorderColor)

-(void)setBorderUIColor:(UIColor*)color

{

    self.borderColor = color.CGColor;

}

-(UIColor*)borderUIColor

{

    return [UIColor colorWithCGColor:self.borderColor];
    
}
@end
