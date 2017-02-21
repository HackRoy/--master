//
//  LYTestTwoTableViewCell.h
//  MYPage
//
//  Created by 赵良育 on 2016/11/11.
//  Copyright © 2016年 赵良育. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WHpros.h"

@interface LYTestTwoTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *policyLaber;
@property (weak, nonatomic) IBOutlet UILabel *payLaber;
@property (weak, nonatomic) IBOutlet UILabel *premLaber;
@property (weak, nonatomic) IBOutlet UILabel *coverLaber;
@property(nonatomic,strong)  WHpros * model;
@property (weak, nonatomic) IBOutlet UILabel *nameLaber;
@property (weak, nonatomic) IBOutlet UILabel *giveLaber;
@property (weak, nonatomic) IBOutlet UIImageView *headImg;

@end
