//
//  CompleteTypeViewController.h
//  whm_project
//
//  Created by YiTu8 on 2016/10/27.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol completeTypeDelegate <NSObject>

-(void)completeName:(NSString *)cName completeId:(NSString *)cId;

@end


@interface CompleteTypeViewController : UIViewController

@property (nonatomic,weak)id<completeTypeDelegate>delegate;

@property (nonatomic,strong)NSString *completeName;
@property (nonatomic,strong)NSString *completeId;



@end
