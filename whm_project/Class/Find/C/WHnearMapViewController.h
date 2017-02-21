//
//  WHnearMapViewController.h
//  whm_project
//
//  Created by 王义国 on 16/11/30.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JwBackBaseController.h"
@interface WHnearMapViewController : JwBackBaseController

@property(nonatomic,strong)NSString * p_myImg;
@property(nonatomic,strong)NSString * p_myName;
@property(nonatomic,strong)NSString * p_mySex;
@property(nonatomic,strong)NSString * p_myAge;
@property(nonatomic,strong)NSString * p_myMobile;
@property(nonatomic,strong)NSString * p_myPro;

@property(nonatomic,strong)DataModel * myDataMod;
@property(nonatomic,copy) NSString * dailirenJin;
@end
