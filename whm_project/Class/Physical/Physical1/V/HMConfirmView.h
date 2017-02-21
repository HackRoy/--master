//
//  HMConfirmView.h
//  selectConfirm
//
//  Created by zhaoHm on 16/8/8.
//  Copyright © 2016年 zhaoHm. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HMConfirmDelegate <NSObject>
/**
 *  confirm button
 *
 *  @param index index of itemArr
 */
-(void)confirmActionWithIndexOfArr:(NSInteger)index SelectName:(NSString *)name Key:(NSString *)key;

/**
 *  cancel button
 */
-(void)cancelActionWithNothing;

@end

@interface HMConfirmView : UIView

/**
 *  title
 */
@property (nonatomic, strong) NSString *title;
/**
 *  title color
 */
@property (nonatomic, strong) UIColor *titleColor;
/**
 *  title font
 */
@property (nonatomic, strong) UIFont *titleFont;
/**
 *  Array Of All Selection Item
 */
@property (nonatomic, strong) NSArray *itemArr;

@property (nonatomic, strong) NSString *key;

/**
 *  delegate
 */
@property (nonatomic, assign) id<HMConfirmDelegate> delegate;

/**
 *  the way of use HMConfirmView
 *  such as:
 *   init
 *    _confir = [[HMConfirmView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
 *    _confir.itemArr = itemArr;
 *    _confir.delegate = self;
 *    _confir.backgroundColor = [UIColor colorWithRed:0 / 255.0 green:0 / 255.0 blue:0 / 255.0 alpha:0.3];
 *    [self.view addSubview:_confir];
 *    [self.view bringSubviewToFront:_confir];
 *   delegate
 *    [_confir removeFromSuperview];
 */


@end
