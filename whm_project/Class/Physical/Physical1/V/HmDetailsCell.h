//
//  HmDetailsCell.h
//  whm_project
//
//  Created by zhaoHm on 16/10/25.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HmMyModel.h"

@interface HmDetailsCell : UITableViewCell

@property (nonatomic, strong) HmMyModel *model;
@property (weak, nonatomic) IBOutlet UIImageView *headImg;
@property (weak, nonatomic) IBOutlet UILabel *myLaber;
@property (weak, nonatomic) IBOutlet UILabel *selectLaber;
@end
