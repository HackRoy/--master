//
//  InsuranceViewController.h
//  小胖的demo
//
//  Created by YiTu8 on 2016/10/19.
//  Copyright © 2016年 shuaili. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "JwBackBaseController.h"

@protocol completeDelegate <NSObject>
-(void)comNamepleteId:(NSString *)cId completeName:(NSString *)cName;

@end

@interface InsuranceViewController : JwBackBaseController

//@property(nonatomic,copy)NSString * myOrid;
@property (nonatomic,weak)id<completeDelegate>delegate;


@property (nonatomic,strong)NSString *compId;
@property (nonatomic,strong)NSString *compName;

@property (nonatomic,strong)NSString *completeId;



@end
