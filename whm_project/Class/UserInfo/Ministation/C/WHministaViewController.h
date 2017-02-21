//
//  WHministaViewController.h
//  whm_project
//
//  Created by 王义国 on 17/1/23.
//  Copyright © 2017年 chenJw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JwBackBaseController.h"

@interface WHministaViewController :JwBackBaseController
@property(nonatomic,assign)NSInteger section;
@property(nonatomic,assign)NSInteger section2;

@property(nonatomic,strong)NSString * StrAgentId;
@property(nonatomic,strong)NSString * selectDiffent;
@end
