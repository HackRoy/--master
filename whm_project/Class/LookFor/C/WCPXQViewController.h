//
//  WCPXQViewController.h
//  whm_project
//
//  Created by Stephy_xue on 16/12/24.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import "BaseViewController.h"

@interface WCPXQViewController : BaseViewController<UMSocialUIDelegate>
@property(nonatomic,strong)NSString * pro_id;
@property(nonatomic,strong)NSMutableArray * items;
@property(nonatomic,strong)WHgetproduct * productModel;
@property(nonatomic,strong)DataModel * dataModel;



@end
