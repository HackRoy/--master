//
//  WHnewsdetailViewController.h
//  whm_project
//
//  Created by 王义国 on 16/12/6.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JwBackBaseController.h"

@interface WHnewsdetailViewController : JwBackBaseController
@property(nonatomic,strong)NSString * newsID;
@property(nonatomic,strong)NSString * tel;
@property(nonatomic,strong)NSString * newsHeadimg;
@property(nonatomic,strong)NSString * newsName;
@property(nonatomic,strong)NSString * newsSeximg;
@property(nonatomic,strong)NSString * newsYear;
@property(nonatomic,strong)NSString * newsCompany;
@property(nonatomic,strong)NSString * agentID;

@end
