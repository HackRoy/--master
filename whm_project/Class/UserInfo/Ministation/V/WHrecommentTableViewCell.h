//
//  WHrecommentTableViewCell.h
//  whm_project
//
//  Created by 王义国 on 16/10/30.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WHgetrec.h"

@interface WHrecommentTableViewCell : UITableViewCell
@property(nonatomic,strong)UIImageView * myImage;
@property(nonatomic,strong)UILabel * titLaber;
@property(nonatomic,strong)UILabel * yearLaber;
@property(nonatomic,strong)UILabel * statuLaber;
@property(nonatomic,strong)UILabel * timeLaber;
@property(nonatomic,strong)UIImageView * mainImage;
@property(nonatomic,strong)UILabel * ageLaber;

@property(nonatomic,strong)WHgetrec * model;


@end
