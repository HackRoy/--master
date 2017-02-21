//
//  HmBaoeCell.h
//  whm_project
//
//  Created by zhaoHm on 16/11/30.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HmBaoeCell : UITableViewCell<UITextFieldDelegate>

// 图标
@property (nonatomic, strong) UIImageView *headImg;
// 文字
@property (nonatomic, strong) UILabel *myLaber;
// 内容
@property (nonatomic, strong) UITextField *selectLaber;

@end
