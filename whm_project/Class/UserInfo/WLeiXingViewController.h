//
//  WLeiXingViewController.h
//  whm_project
//typedef void(^myblock1)(NSString  *s1);


//@interface WHinsuranceNameViewController : JwBackBaseController
//@property(nonatomic,copy)myblock1  mblock1;


//  Created by apple on 17/1/5.
//  Copyright © 2017年 chenJw. All rights reserved.
//

#import "BaseViewController.h"

typedef void(^dailiBlock)(NSString  * muStr,NSString * shuStr);

@interface WLeiXingViewController : BaseViewController

@property(nonatomic,copy)dailiBlock  allBlock;

@end
