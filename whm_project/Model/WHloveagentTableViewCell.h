//
//  WHloveagentTableViewCell.h
//  whm_project
//
//  Created by 王义国 on 16/11/18.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WHagent.h"

@interface WHloveagentTableViewCell : UITableViewCell
@property(nonatomic,strong)UIImageView * myImage;
@property(nonatomic,strong)UILabel * nameLaber;
@property(nonatomic,strong)UIImageView * sexImg;
@property(nonatomic,strong)UILabel * ageLaber;
@property(nonatomic,strong)UILabel * professLaber;
@property(nonatomic,strong)UIButton * telBut;
@property(nonatomic,strong)WHagent * model;


@end
