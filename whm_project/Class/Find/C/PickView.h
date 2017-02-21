//
//  PickView.h
//  whm_project
//
//  Created by apple on 17/1/17.
//  Copyright © 2017年 chenJw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PickView : UIView

@property(nonatomic,copy)NSString * idprovence;
@property(nonatomic,copy)NSString * idcity;
@property(nonatomic,copy)NSString * idarea;

@property(nonatomic,copy)NSString * sheng;
@property(nonatomic,copy)NSString * shi;
@property(nonatomic,copy)NSString * qu;


- (void)showInView:(UIView *)view;
- (void)hiddenPickerView;


@end
