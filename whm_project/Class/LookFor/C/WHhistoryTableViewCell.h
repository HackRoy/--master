//
//  WHhistoryTableViewCell.h
//  whm_project
//
//  Created by 王义国 on 16/11/3.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WHgetproduct.h"

@interface WHhistoryTableViewCell : UITableViewCell
@property(nonatomic,strong)UIImageView * myImage;
@property(nonatomic,strong)UILabel * myLaber;
@property(nonatomic,strong)WHgetproduct * model;
@property(nonatomic,strong)UIImageView * mainImage;
@end
