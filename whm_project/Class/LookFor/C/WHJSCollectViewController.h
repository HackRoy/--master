//
//  WHJSCollectViewController.h
//  whm_project
//
//  Created by 王义国 on 16/11/17.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WHTitleView ;
@interface WHJSCollectViewController : UIViewController<UIScrollViewDelegate>
{
    NSArray * _VCAry;
    NSArray * _TitleAry;
    UIView *   _LineView;
    UIScrollView *_MeScroolView;
}
-(instancetype)initWithAddVCARY:(NSArray *)VCS TitleS:(NSArray *)TitleS;

@property(nonatomic,weak)WHTitleView * titleView;


@end
