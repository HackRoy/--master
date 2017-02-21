//
//  HmPhysicalMainPageCell.h
//  whm_project
//
//  Created by zhaoHm on 16/10/24.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WHget_user_realtion.h"

@interface HmPhysicalMainPageCell : UITableViewCell

@property (nonatomic, strong) WHget_user_realtion *model;

@property (weak, nonatomic) IBOutlet UIImageView *imgHead;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UIImageView *imgSex;
@property (weak, nonatomic) IBOutlet UILabel *lblMaritalStatus;
@property (weak, nonatomic) IBOutlet UILabel *lblDate;
@property (weak, nonatomic) IBOutlet UILabel *lblYearCost;
@property (weak, nonatomic) IBOutlet UILabel *lblPay;
@property (weak, nonatomic) IBOutlet UILabel *lblOwe;


// 参照注释
//// 头像
//// 姓名
//// 性别图片
//// 婚姻状态
//// 日期
//// 年费
//// 支出
//// 负债

@end
