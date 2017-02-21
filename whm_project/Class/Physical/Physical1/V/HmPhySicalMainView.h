//
//  HmPhySicalMainView.h
//  whm_project
//
//  Created by zhaoHm on 16/11/23.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WHget_user_realtion.h"

@interface HmPhySicalMainView : UIView

@property (nonatomic, strong) WHget_user_realtion *model;

@property (nonatomic, strong) UIImageView *imgHead;

@property (nonatomic, strong) CALayer *layerLine;

@property (nonatomic, strong) UIImageView *imgName;
@property (nonatomic, strong) UILabel *lblName;

@property (nonatomic, strong) UIImageView *imgSex;

@property (nonatomic, strong) UIImageView *imgRelationship;
@property (nonatomic, strong) UILabel *lblRelationship;

@property (nonatomic, strong) UIImageView *imgDate;
@property (nonatomic, strong) UILabel *lblDate;

@property (nonatomic, strong) UIImageView *imgYearCost;
@property (nonatomic, strong) UILabel *lblYearCost;

@property (nonatomic, strong) UIImageView *imgPay;
@property (nonatomic, strong) UILabel *lblPay;

@property (nonatomic, strong) UIImageView *imgOwn;
@property (nonatomic, strong) UILabel *lblOwn;


@end
