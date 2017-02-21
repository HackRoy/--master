//
//  WHgetReportViewController.m
//  whm_project
//
//  Created by 王义国 on 17/1/10.
//  Copyright © 2017年 chenJw. All rights reserved.
//

#import "WHgetReportViewController.h"
#import "LGcollectionCell.h"
#import "LGtitleBarView.h"
#import "WHreportOneTableViewController.h"
#import "WHreportTwoTableViewController.h"
#import "WHreportThreeTableViewController.h"
#import "MacroUtility.h"
#import "UIColor+Hex.h"

@interface WHgetReportViewController ()<LGtitleBarViewDelegate,UIScrollViewDelegate>

@property(nonatomic,strong)NSArray * titles;
@property(nonatomic,strong)LGtitleBarView * titleBar;
@property(nonatomic,strong)WHreportOneTableViewController * reportOne;
@property(nonatomic,strong)WHreportTwoTableViewController * reportTwo;
@property(nonatomic,strong)WHreportThreeTableViewController * reportThree;
@property(nonatomic,strong)UIView * myView;
@property(nonatomic,strong)UIImageView * headImg;

@end

@implementation WHgetReportViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
    
}

-(void)setUI
{
    self.myView = [[UIView alloc]init];
    self.myView.frame = CGRectMake(0, 0, kScreenWitdh, kScreenHeight * 0.3);
    [self.view addSubview:_myView];
    self.myView.backgroundColor = [UIColor colorWithHex:0x4367FF];
    self.headImg = [[UIImageView alloc]init];
    self.headImg.frame = CGRectMake(kScreenWitdh * 0.3, 10, kScreenWitdh * 0.4, kScreenWitdh * 0.4);
    self.headImg.image = [UIImage imageNamed:@"phydeta"];
    self.headImg.layer.masksToBounds = YES;
    self.headImg.layer.cornerRadius = kScreenWitdh * 0.2;
    [self.myView addSubview:_headImg];
    
    
    self.title = @"体检报告";
    self.titleBar = [[LGtitleBarView alloc]initWithFrame:CGRectMake(0,kScreenHeight * 0.3 , self.view.frame.size.width, 45)];
    self.titles = @[@"基本",@"保险",@"分析"];
    
    self.titleBar.titles = self.titles;
    self.titleBar.delegate = self;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self.view addSubview:_titleBar];
    self.myscroll = [[UIScrollView alloc]init];
    self.myscroll.frame = CGRectMake(0, kScreenHeight * 0.3 +44, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame));
    [self.view addSubview:_myscroll];
    
    self.myscroll.contentSize = CGSizeMake(self.view.frame.size.width * 3, 0);
    self.myscroll.delegate = self;
    
    self.myscroll.pagingEnabled = YES;
    
    self.reportOne = [[WHreportOneTableViewController alloc]init];
    self.reportOne.view.frame = CGRectMake(CGRectGetWidth(self.view.frame)*0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [self addChildViewController:_reportOne];
    
    [self.myscroll addSubview:self.reportOne.view];
    
    
    self.reportTwo = [[WHreportTwoTableViewController alloc]init];
    self.reportTwo.view.frame = CGRectMake(CGRectGetWidth(self.view.frame)*1, 0, self.view.frame.size.width, self.view.frame.size.height);
    [self addChildViewController:_reportTwo];
    [self.myscroll addSubview:self.reportTwo.view];
    //
    self.reportThree = [[WHreportThreeTableViewController alloc]init];
    self.reportThree.view.frame = CGRectMake(CGRectGetWidth(self.view.frame)*2, 0, self.view.frame.size.width, self.view.frame.size.height);
    [self addChildViewController:_reportThree];
    [self.myscroll addSubview:self.reportThree.view];


    
}
-(void)LGtitleBarView:(LGtitleBarView *)titleBarView didSelectedItem:(int)index
{
    CGFloat  x = index * self.view.frame.size.width;
    [self.myscroll setContentOffset:CGPointMake(x, 0)animated:YES];
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat index = scrollView.contentOffset.x/self.view.frame.size.width;
    
    NSIndexPath * indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    LGcollectionCell *cell = (LGcollectionCell *)[self.titleBar.collection cellForItemAtIndexPath:indexPath];
    
    [UIView animateWithDuration:0.25 animations:^{
        self.titleBar.bottomView.frame = CGRectMake(cell.frame.origin.x, cell.frame.size.height-2, cell.frame.size.width - 4, 2);
    }];
    
    [self.titleBar.collection  selectItemAtIndexPath:indexPath animated:YES scrollPosition:UICollectionViewScrollPositionCenteredVertically];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   }

@end
