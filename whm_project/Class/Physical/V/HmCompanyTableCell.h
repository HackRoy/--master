//
//  HmCompanyTableCell.h
//  whm_project
//
//  Created by zhaoHm on 16/10/18.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JwCompanys.h"

@interface HmCompanyTableCell : UITableViewCell

@property(nonatomic,strong) JwCompanys * model;

//标题
@property (weak, nonatomic) IBOutlet UILabel *nameLaber;

//头像
@property (weak, nonatomic) IBOutlet UIImageView *headImage;

@end
