//
//  HmSelectInsuredCell.h
//  whm_project
//
//  Created by zhaoHm on 16/10/18.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WHget_user_realtion.h"

@interface HmSelectInsuredCell : UITableViewCell

@property (nonatomic, strong) WHget_user_realtion *model;

// 头像
@property (weak, nonatomic) IBOutlet UIImageView *imgHead;
// 姓名
@property (weak, nonatomic) IBOutlet UILabel *lblName;
// 性别图片
@property (weak, nonatomic) IBOutlet UIImageView *imgSex;
// 婚姻状态
@property (weak, nonatomic) IBOutlet UILabel *lblMaritalStatus;
// 日期
@property (weak, nonatomic) IBOutlet UILabel *lblDate;
// 年费
@property (weak, nonatomic) IBOutlet UILabel *lblYearCost;
// 支出
@property (weak, nonatomic) IBOutlet UILabel *lblPay;
// 负债
@property (weak, nonatomic) IBOutlet UILabel *lblOwe;


@end
