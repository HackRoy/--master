//
//  WHgetreport.h
//  whm_project
//
//  Created by 王义国 on 16/11/12.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JwModelBase.h"
#import "WHrela.h"
#import "WHpros.h"
#import "WHtotalrate.h"
#import "WHscore.h"
#import "WHcov.h"
#import "WHsecond.h"


@protocol  WHgetreport <NSObject>

@end

@interface WHgetreport : JwModelBase
@property(nonatomic,strong)NSArray <WHrela,Optional> * rela;

@property(nonatomic,strong)WHtotalrate<Optional>* total_rate;

@property(nonatomic,strong)NSArray <WHpros,Optional> * pros;

@property(nonatomic,strong)WHscore <Optional>* score;

@property(nonatomic,strong)WHcov <Optional>* cov; //保障是否全面

@property(nonatomic,strong)NSArray <WHsecond ,Optional> * second;

@property(nonatomic,strong)WHcov <Optional> * hasnt; //缺少保障项目

@property(nonatomic,strong)WHcov <Optional> * accident_insured;//意外保险保额

@property(nonatomic,strong)WHcov <Optional> * disease_insured;//重大疾病保额





@end
