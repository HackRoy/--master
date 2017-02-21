//
//  UIBarButtonItem+Extension.m
//  Jw_ebank
//
//  Created by Jw on 16/3/9.
//  Copyright © 2016年 Jw. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"
#import "UIView+Extension.h"

@implementation UIBarButtonItem (Extension)

+ (UIBarButtonItem *)itemWithTarget:(id)target Action:(SEL)action image:(NSString *)image highImage:(NSString *)highImage{
    
    UIButton *btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    
    [btn addTarget:target action:action forControlEvents:(UIControlEventTouchUpInside)];
    [btn setImage:[UIImage imageNamed:image] forState:(UIControlStateNormal)];
    [btn setImage:[UIImage imageNamed:highImage] forState:(UIControlStateHighlighted)];
    
    btn.jw_size = btn.currentImage.size;
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}

@end
