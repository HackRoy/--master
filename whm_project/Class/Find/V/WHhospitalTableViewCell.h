//
//  WHhospitalTableViewCell.h
//  whm_project
//
//  Created by 王义国 on 16/12/8.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WHhospitalTableViewCell : UITableViewCell

@property(nonatomic,strong)UILabel * titLaber;
@property(nonatomic,strong)UILabel * addressLaber;
@property(nonatomic,strong)UIImageView * mapImg;
@property(nonatomic,strong)UILabel * mapLaber;
@property(nonatomic,strong)UIImageView * telImg;
@property(nonatomic,strong)UILabel * telLaber;
@property(nonatomic,strong)UIButton * telBut;

@end
