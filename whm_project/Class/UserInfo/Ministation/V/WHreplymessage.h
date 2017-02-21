//
//  WHreplymessage.h
//  whm_project
//
//  Created by 王义国 on 16/10/29.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WHreplymessage : UIView
@property(nonatomic,strong)UILabel * mesLaber;
@property(nonatomic,strong)UILabel * titLaber;
@property(nonatomic,strong)UILabel * nameLaber;
@property(nonatomic,strong)UILabel * addressLaber;
@property(nonatomic,strong)UILabel * timeLaber;
@property(nonatomic,strong)UIView * lineView;
@property(nonatomic,strong)UILabel * replyLaber;
@property(nonatomic,strong)UILabel * repTitLaber;//内容回复
@property(nonatomic,strong)UIButton * delBut;
@property(nonatomic,strong)UILabel * contentLaber;
@property(nonatomic,strong)UITextField * myTextView;
@property(nonatomic,strong)UIButton * repBut;
@property(nonatomic,strong)UILabel * repDetText;


@end
