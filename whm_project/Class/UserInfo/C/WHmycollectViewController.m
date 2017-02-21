//
//  WHmycollectViewController.m
//  whm_project
//
//  Created by 王义国 on 16/12/4.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import "WHmycollectViewController.h"
#import "LGcollectionCell.h"
#import "LGtitleBarView.h"
#import "WHcoverCollectTableViewController.h"
#import "WHnewsTableViewController.h"
#import "WHcompanycollectTableViewController.h"
@interface WHmycollectViewController ()<LGtitleBarViewDelegate,UIScrollViewDelegate>
@property(nonatomic,strong)NSArray * titles;
@property(nonatomic,strong)LGtitleBarView * titleBar;
@property(nonatomic,strong)WHcoverCollectTableViewController * cover;
@property(nonatomic,strong)WHcompanycollectTableViewController * company;
@property(nonatomic,strong)WHnewsTableViewController * news;


@end

@implementation WHmycollectViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setUI];
    
    
}

-(void)setUI
{
    self.navigationItem.title = @"我的收藏";
    
    self.titleBar = [[LGtitleBarView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 45)];
    
    self.titles = @[@"险种",@"公司",@"资讯"];
    self.titleBar.titles = self.titles;
    
    self.titleBar.delegate = self;
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self.view addSubview:_titleBar];
    self.myscroll = [[UIScrollView alloc]init];
    self.myscroll.frame = CGRectMake(0, 44, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame));
    [self.view addSubview:_myscroll];
    
    self.myscroll.contentSize = CGSizeMake(self.view.frame.size.width * 3, 0);
    self.myscroll.delegate = self;
    
    self.myscroll.pagingEnabled = YES;
    
    self.cover = [[WHcoverCollectTableViewController alloc]init];
    self.cover.view.frame = CGRectMake(CGRectGetWidth(self.view.frame)*0, 0, self.view.frame.size.width, self.view.frame.size.height);
   
    [self addChildViewController:_cover];
    
    [self.myscroll addSubview:self.cover.view];
    //
    self.company = [[WHcompanycollectTableViewController alloc]init];
    self.company.view.frame = CGRectMake(CGRectGetWidth(self.view.frame)*1, 0, self.view.frame.size.width, self.view.frame.size.height);
    [self addChildViewController:_company];
    [self.myscroll addSubview:self.company.view];
    //
    self.news = [[WHnewsTableViewController alloc]init];
    self.news.view.frame = CGRectMake(CGRectGetWidth(self.view.frame)*2, 0, self.view.frame.size.width, self.view.frame.size.height);
    [self addChildViewController:_news];
    [self.myscroll addSubview:self.news.view];


    
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
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
