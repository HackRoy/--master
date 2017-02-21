//
//  CustomProgress.h
//  WisdomPioneer
//
//  Created by 主用户 on 16/4/11.
//  Copyright © 2016年 江萧. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomProgress : UIView
@property(nonatomic, retain)UIImageView *bgimg;
@property(nonatomic, retain)UIImageView *leftimg;
@property(nonatomic, retain)UILabel *presentlab;
@property(nonatomic)float maxValue;
@property(nonatomic,strong)UILabel * mylaber;
@property(nonatomic,strong)UIImageView * Img1;

//
@property(nonatomic, retain)UIImageView *bgimg1;
@property(nonatomic, retain)UIImageView *leftimg1;
@property(nonatomic, retain)UILabel *presentlab1;
@property(nonatomic)float maxValue1;
@property(nonatomic,strong)UILabel * mylaber1;
@property(nonatomic,strong)UIImageView * Img2;
-(void)setPresent:(int)present title:(NSString *)title labelText:(NSString *)labelText;



@end
