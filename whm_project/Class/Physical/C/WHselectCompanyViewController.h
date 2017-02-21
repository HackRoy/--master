//
//  WHselectCompanyViewController.h
//  whm_project
//
//  Created by 王义国 on 16/12/13.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JwBackBaseController.h"
//typedef void(^myBlock4)(WHgetproduct * model,NSMutableArray * groupsArr,BOOL isSelectP,NSMutableDictionary * contentDic,NSMutableDictionary * fuzhiDic );


@interface WHselectCompanyViewController : JwBackBaseController
@property (nonatomic, strong) NSMutableArray *groupArr;
@property (nonatomic, assign) BOOL isSelects;

@property (nonatomic, strong) NSMutableDictionary *contentDict;
@property (nonatomic, strong) NSMutableDictionary *fuzhiDict;


//@property(nonatomic,copy)void(^myBlock4)(NSString * name2,NSMutableArray * groupsArr2,BOOL isSelectP2 );

@end
