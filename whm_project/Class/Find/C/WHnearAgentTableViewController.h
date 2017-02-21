//
//  WHnearAgentTableViewController.h
//  whm_project
//
//  Created by 王义国 on 16/11/24.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JwBackBaseController.h"
typedef void(^IWAreaPickerViewConfirmBlock)(NSString *areaStr);
typedef void(^IWAreaPickerViewCancleBlock)();
@interface WHnearAgentTableViewController :JwBackBaseController
@property (nonatomic,copy) NSDictionary *areaDict;
//确认回调
@property (nonatomic,copy) IWAreaPickerViewConfirmBlock areaPickerViewConfirmBlock;
//失败回调
@property (nonatomic,copy) IWAreaPickerViewCancleBlock areaPickerViewCancleBlock;


@end
