//
//  HmPhysicalGroupView.h
//  whm_project
//
//  Created by zhaoHm on 16/11/23.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WHgetproduct.h"

@interface HmPhysicalGroupView : UIView

@property (nonatomic, strong) WHgetproduct *model;

@property (nonatomic, strong) UIImageView *imgHeader;
@property (nonatomic, strong) UILabel *lblName;
@property (nonatomic, strong) UIButton *btnDelete;
@property (nonatomic, strong) UIImageView *imgPoint;

@end
