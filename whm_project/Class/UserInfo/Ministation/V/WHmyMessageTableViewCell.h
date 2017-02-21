//
//  WHmyMessageTableViewCell.h
//  whm_project
//
//  Created by 王义国 on 16/10/28.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WHgetmessage.h"

@interface WHmyMessageTableViewCell : UITableViewCell
@property(nonatomic,strong)UILabel * titLaber;
@property(nonatomic,strong)UILabel * nameLaber;
@property(nonatomic,strong)UILabel * addressLaber;
@property(nonatomic,strong)UILabel * statuLaber;
@property(nonatomic,strong)UILabel * timeLaber;
@property(nonatomic,strong)WHgetmessage * model;

@end
