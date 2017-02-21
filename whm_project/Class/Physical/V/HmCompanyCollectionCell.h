//
//  HmCompanyCollectionCell.h
//  whm_project
//
//  Created by zhaoHm on 16/10/18.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "WHhotcompany.h"

@interface HmCompanyCollectionCell : UICollectionViewCell

@property(nonatomic,strong)WHhotcompany * model;

//图片
@property (weak, nonatomic) IBOutlet UIImageView *Myheadimage;

//标题
@property (weak, nonatomic) IBOutlet UILabel *MytitLaber;
@end
