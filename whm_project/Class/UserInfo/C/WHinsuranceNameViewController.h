//
//  WHinsuranceNameViewController.h
//  whm_project
//
//  Created by 王义国 on 16/10/21.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "JwBackBaseController.h"
typedef void(^myblock1)(NSString  *s1);


@interface WHinsuranceNameViewController : JwBackBaseController
@property(nonatomic,copy)myblock1  mblock1;

@end