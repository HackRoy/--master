//
//  WBYHQGSviewController.h
//  whm_project
//
//  Created by apple on 17/1/23.
//  Copyright © 2017年 chenJw. All rights reserved.
//

#import "BaseViewController.h"
typedef void(^myblock1)(NSString * s1 ,NSString * s2);

@interface WBYHQGSviewController : BaseViewController
@property(nonatomic,copy)NSString * myStr;
@property(nonatomic,copy)myblock1 mblock1;

@end
