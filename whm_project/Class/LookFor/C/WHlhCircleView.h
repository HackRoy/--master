//
//  WHlhCircleView.h
//  whm_project
//
//  Created by 王义国 on 16/11/17.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WHlhCircleView : UIView
@property (nonatomic,strong)UILabel * contentLabel;//内容
@property(nonatomic,strong)UILabel * titLebar;
- (instancetype)initWithFrame:(CGRect)frame;
@property(nonatomic,strong)UIImageView * MyImg;
@property(nonatomic,strong)UILabel * telLaber;
@property(nonatomic,strong)UILabel * staLaber;
-(void)getTit:(NSString * )title;
-(void)getImage:(NSString * )img;



@end
