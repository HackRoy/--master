//
//  WHorgselectTableViewController.h
//  whm_project
//
//  Created by 王义国 on 16/12/15.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JwBackBaseController.h"

typedef void(^myblock2)(NSString * s1 ,NSString * s2,NSString * s3);
@interface WHorgselectTableViewController : JwBackBaseController
@property(nonatomic,strong)NSString * com_id;

@property(nonatomic,copy)myblock2 mblock2;


@end
