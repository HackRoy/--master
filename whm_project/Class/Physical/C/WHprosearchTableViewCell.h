//
//  WHprosearchTableViewCell.h
//  whm_project
//
//  Created by 王义国 on 16/11/9.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WHgetproduct.h"

@interface WHprosearchTableViewCell : UITableViewCell
@property(nonatomic,strong)UIImageView * myImg;
@property(nonatomic,strong)UILabel * myLaber;
@property(nonatomic,strong)UIImageView * staImg;
@property(nonatomic,strong)WHgetproduct * model;

@end 
