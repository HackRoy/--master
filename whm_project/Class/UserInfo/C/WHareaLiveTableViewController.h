//
//  WHareaLiveTableViewController.h
//  whm_project
//
//  Created by 王义国 on 16/12/28.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JwBackBaseController.h"
typedef void(^IWAreaPickerViewConfirmBlock)(NSString *areaStr);
typedef void(^IWAreaPickerViewCancleBlock)();

typedef void(^myblockArea)(NSString * s1 ,NSString * s2);

@interface WHareaLiveTableViewController : JwBackBaseController
@property (nonatomic,copy) NSDictionary *areaDict;
//确认回调
@property (nonatomic,copy) IWAreaPickerViewConfirmBlock areaPickerViewConfirmBlock;
//失败回调
@property (nonatomic,copy) IWAreaPickerViewCancleBlock areaPickerViewCancleBlock;

@property(nonatomic,copy)myblockArea mblockArea;


@end
