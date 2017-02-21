//
//  UIBarButtonItem+Extension.h
//  Jw_ebank
//
//  Created by Jw on 16/3/9.
//  Copyright © 2016年 Jw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)

+ (UIBarButtonItem *)itemWithTarget:(id)target Action:(SEL)action image:(NSString *)image highImage:(NSString *)highImage;

@end
