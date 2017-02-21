//
//  ChooseCompleteViewController.h
//  小胖的demo
//
//  Created by YiTu8 on 16/10/18.
//  Copyright © 2016年 shuaili. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JwBackBaseController.h"

#import "WHorganization.h"

@protocol completeInsDelegate <NSObject>

-(void)institutions:(WHorganization *)instModel;

@end


@interface ChooseCompleteViewController : JwBackBaseController


@property (nonatomic,weak)id<completeInsDelegate>delegate;


@property (nonatomic ,strong)WHorganization  *insModel;
@property (nonatomic,strong)NSString *cId;



@end
