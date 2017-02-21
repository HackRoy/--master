//
//  JSCollectViewController.h
//  JEUnesse
//
//  Created by 赵良育 on 2016/10/14.
//  Copyright © 2016年 赵良育. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JSCollectViewController : UIViewController<UIScrollViewDelegate>
{
    NSArray  *_VCAry;
    NSArray  *_TitleAry;
    UIView   *_LineView;
    UIScrollView *_MeScroolView;
}
- (instancetype)initWithAddVCARY:(NSArray*)VCS TitleS:(NSArray*)TitleS;

-(void)getprogressValue:(CGFloat)myValue;

@property(nonatomic,assign)CGFloat  StrMyvalue;

@end
