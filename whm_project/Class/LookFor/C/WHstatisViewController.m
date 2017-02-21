//
//  WHstatisViewController.m
//  whm_project
//
//  Created by 王义国 on 16/11/17.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import "WHstatisViewController.h"
#import "ZFChart.h"
#import "MacroUtility.h"
#import "WHcompanyDetail.h"
#import "JGProgressHelper.h"



@interface WHstatisViewController ()<ZFGenericChartDataSource, ZFHorizontalBarChartDelegate,ZFPieChartDataSource, ZFPieChartDelegate,UIScrollViewDelegate>
@property (nonatomic, strong) ZFHorizontalBarChart * barChart;

@property (nonatomic, assign) CGFloat height;
//
@property (nonatomic, strong) ZFHorizontalBarChart * barChart1;

@property (nonatomic, assign) CGFloat height1;
//
@property (nonatomic, strong) ZFHorizontalBarChart * barChart2;

@property (nonatomic, assign) CGFloat height2;

//圆饼
@property (nonatomic, strong) ZFPieChart * pieChart3;

@property (nonatomic, assign) CGFloat height3;
//
@property (nonatomic, strong) ZFPieChart * pieChart4;

@property (nonatomic, assign) CGFloat height4;


@property(nonatomic, strong) UIScrollView * scroll;

@property(nonatomic,strong)NSMutableArray * dataArry;

@property(nonatomic,strong)NSMutableArray *  countArry  ;

@property(nonatomic,strong)NSMutableArray * nameYearArry;
@property(nonatomic,strong)NSMutableArray * valueYearArry;

@property(nonatomic,strong)NSMutableArray * speNameArry;
@property(nonatomic,strong)NSMutableArray * speValueArry;
@property(nonatomic,strong)NSMutableArray * speCountArry;

@property(nonatomic,strong)NSMutableArray * prodNameArry;
@property(nonatomic,strong)NSMutableArray * prodValueArry;
@property(nonatomic,strong)NSMutableArray * prodCountArry;

@property(nonatomic,strong)NSMutableArray * insNameArry;
@property(nonatomic,strong)NSMutableArray * insValueArry;
@property(nonatomic,strong)NSMutableArray * insCountArry;

@property(nonatomic,strong)NSMutableArray * saleNameArry;
@property(nonatomic,strong)NSMutableArray * saleValueArry;
@property(nonatomic,strong)NSMutableArray * saleCountArry;



@end

@implementation WHstatisViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.nameYearArry = [NSMutableArray array];
    self.valueYearArry = [NSMutableArray array];
    
    self.speNameArry = [NSMutableArray array];
    self.speValueArry = [NSMutableArray array];
    
    self.prodNameArry = [NSMutableArray array];
    self.prodValueArry = [NSMutableArray array];
    
    self.saleNameArry = [NSMutableArray array];
    self.saleValueArry = [NSMutableArray array];
    
    self.insValueArry = [NSMutableArray array];
    self.insNameArry = [NSMutableArray array];
    [self setup];

   
    
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
}


-(void)setup
{
    self.scroll = [[UIScrollView alloc]init];
    self.scroll.frame = CGRectMake(0, 0, kScreenWitdh , kScreenHeight*0.8);
    self.scroll.directionalLockEnabled = YES;
    self.scroll.showsVerticalScrollIndicator =YES; //垂直方向的滚动指示
    self.scroll.indicatorStyle = UIScrollViewIndicatorStyleWhite;//滚动指示的风格
    self.scroll.showsHorizontalScrollIndicator = NO;//水平方向的滚动指示
    self.scroll.delegate = self;
    
    self.scroll.contentSize = CGSizeMake(kScreenWitdh, kScreenHeight * 2.5);
    [self.view addSubview:_scroll];
    
    
    if ([[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationLandscapeLeft || [[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationLandscapeRight){
        //首次进入控制器为横屏时
        _height = SCREEN_HEIGHT - NAVIGATIONBAR_HEIGHT * 0.2;
        
    }else{
        //首次进入控制器为竖屏时
        _height = SCREEN_HEIGHT - NAVIGATIONBAR_HEIGHT;
    }
    self.barChart = [[ZFHorizontalBarChart alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, _height/2)];
    self.barChart.dataSource = self;
    self.barChart.delegate = self;
    self.barChart.topicLabel.text = @"历年公司险种";
    self.barChart.unit = @"个";
    self.barChart.topicLabel.textColor = ZFPurple;
    [self.scroll addSubview:self.barChart];
    [self.barChart strokePath];
    //
    if ([[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationLandscapeLeft || [[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationLandscapeRight){
        //首次进入控制器为横屏时
        _height1 = SCREEN_HEIGHT - NAVIGATIONBAR_HEIGHT * 0.2;
        
    }else{
        //首次进入控制器为竖屏时
        _height1 = SCREEN_HEIGHT - NAVIGATIONBAR_HEIGHT;
    }
    self.barChart1 = [[ZFHorizontalBarChart alloc] initWithFrame:CGRectMake(0, _height/2, SCREEN_WIDTH, _height1/2)];
    self.barChart1.dataSource = self;
    self.barChart1.delegate = self;
    self.barChart1.topicLabel.text = @"特殊属性统计";
    self.barChart1.unit = @"个";
    self.barChart1.topicLabel.textColor = ZFPurple;
    [self.scroll addSubview:self.barChart1];
    [self.barChart1 strokePath];
    //
    if ([[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationLandscapeLeft || [[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationLandscapeRight){
        //首次进入控制器为横屏时
        _height2 = SCREEN_HEIGHT - NAVIGATIONBAR_HEIGHT * 0.2;
        
    }else{
        //首次进入控制器为竖屏时
        _height2 = SCREEN_HEIGHT - NAVIGATIONBAR_HEIGHT;
    }
    self.barChart2 = [[ZFHorizontalBarChart alloc] initWithFrame:CGRectMake(0, _height, SCREEN_WIDTH, _height2/2)];
    self.barChart2.dataSource = self;
    self.barChart2.delegate = self;
    self.barChart2.topicLabel.text = @"险种类型";
    self.barChart2.unit = @"个";
    self.barChart2.topicLabel.textColor = ZFPurple;
    [self.scroll addSubview:self.barChart2];
    [self.barChart2 strokePath];
    
    
    
    [self piechart];

   
}
//圆饼状图
-(void)piechart
{
    if ([[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationLandscapeLeft || [[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationLandscapeRight){
        //首次进入控制器为横屏时
        _height3 = SCREEN_HEIGHT - NAVIGATIONBAR_HEIGHT * 0.2;
        
    }else{
        //首次进入控制器为竖屏时
        _height3 = SCREEN_HEIGHT - NAVIGATIONBAR_HEIGHT;
    }
    self.pieChart3 = [[ZFPieChart alloc] initWithFrame:CGRectMake(0, _height*1.5, SCREEN_WIDTH, _height/2)];
    self.pieChart3.dataSource = self;
    self.pieChart3.delegate = self;
    
    self.pieChart3.piePatternType = kPieChartPatternTypeForCircle;//整圆
    [self.pieChart3 strokePath];
    [self.scroll addSubview:self.pieChart3];
   //销售状态
    if ([[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationLandscapeLeft || [[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationLandscapeRight){
        //首次进入控制器为横屏时
        _height4 = SCREEN_HEIGHT - NAVIGATIONBAR_HEIGHT * 0.2;
        
    }else{
        //首次进入控制器为竖屏时
        _height4 = SCREEN_HEIGHT - NAVIGATIONBAR_HEIGHT;
    }
    self.pieChart4 = [[ZFPieChart alloc] initWithFrame:CGRectMake(0, _height*2.0, SCREEN_WIDTH, _height/2)];
    self.pieChart4.dataSource = self;
    self.pieChart4.delegate = self;
    //    self.pieChart.piePatternType = kPieChartPatternTypeForCircle;
    //    self.pieChart.percentType = kPercentTypeInteger;
    //    self.pieChart.isShadow = NO;
    //    self.pieChart.isAnimated = NO;
      self.pieChart4.piePatternType = kPieChartPatternTypeForCircle;
    [self.pieChart4 strokePath];
    [self.scroll addSubview:self.pieChart4];
}
#pragma mark - ZFPieChartDataSource

- (NSArray *)valueArrayInPieChart:(ZFPieChart *)chart{
     WHcompanyDetail * myMod = self.heldArry[0];
    if (chart == self.pieChart3) {
        _saleCountArry = [NSMutableArray arrayWithArray:myMod.count.sale_status];
        for (NSInteger i = 0; i< self.saleCountArry.count; i++) {
            WBYspecial_attriModel * sale = myMod.count.sale_status[i];
            
//            [sale.value stringByAppendingString:sale.name];
//            [self.saleValueArry addObject:[sale.value stringByAppendingString:sale.name] ];
           
           // NSString * s1 = [sale.value stringByAppendingString:@"在售"];
            [self.saleValueArry addObject:sale.value];
        }
        return self.saleValueArry;
    }
    else{
        _insCountArry = [NSMutableArray arrayWithArray:myMod.count.ins_type];
        
        for (NSInteger i = 0; i< self.insCountArry.count; i++) {
            WBYspecial_attriModel * inst = myMod.count.ins_type[i];
            [self.insValueArry addObject:inst.value];
        }
        return self.insValueArry;
    
    }
}

- (NSArray *)colorArrayInPieChart:(ZFPieChart *)chart{
    if (chart == self.pieChart3) {
          return @[ZFColor(71, 204, 255, 1), ZFColor(253, 203, 76, 1), ZFColor(214, 205, 153, 1), ZFColor(78, 250, 188, 1), ZFColor(16, 140, 39, 1), ZFColor(45, 92, 34, 1)];
    }
    return @[ZFColor(71, 204, 255, 1), ZFColor(253, 203, 76, 1), ZFColor(214, 205, 153, 1), ZFColor(78, 250, 188, 1), ZFColor(16, 140, 39, 1), ZFColor(45, 92, 34, 1)];
}

#pragma mark - ZFPieChartDelegate

- (void)pieChart:(ZFPieChart *)pieChart didSelectPathAtIndex:(NSInteger)index{
    NSLog(@"第%ld个",(long)index);
}

- (CGFloat)radiusForPieChart:(ZFPieChart *)pieChart{
    return 120.f;
}

/** 此方法只对圆环类型(kPieChartPatternTypeForCirque)有效 */
- (CGFloat)radiusAverageNumberOfSegments:(ZFPieChart *)pieChart{
    return 2.f;
}

#pragma mark - 横竖屏适配(若需要同时横屏,竖屏适配，则添加以下代码，反之不需添加)

/**
 *  PS：size为控制器self.view的size，若图表不是直接添加self.view上，则修改以下的frame值
 */
//- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id <UIViewControllerTransitionCoordinator>)coordinator{
//    
//    if ([[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationLandscapeLeft || [[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationLandscapeRight){
//        self.pieChart3.frame = CGRectMake(0, 0, size.width, size.height - NAVIGATIONBAR_HEIGHT * 0.5);
//    }else{
//        self.pieChart3.frame = CGRectMake(0, 0, size.width, size.height + NAVIGATIONBAR_HEIGHT * 0.5);
//    }
//    
//    [self.pieChart3 strokePath];
//}
//

//柱状图

#pragma mark - ZFGenericChartDataSource

- (NSArray *)valueArrayInGenericChart:(ZFGenericChart *)chart{
    
    if (chart == self.barChart) {
        
        
        WHcompanyDetail * myMod = self.heldArry[0];
        _countArry = [NSMutableArray arrayWithArray:myMod.count.year_app];
            for (NSInteger k = 0 ; k< self.countArry.count ; k++) {
             WHyearapp * mod = myMod.count.year_app[k];
             [self.valueYearArry addObject:mod.value];
            
                
        }
      
        return self.valueYearArry;
        


    }
    if (chart == self.barChart1) {
        WHcompanyDetail * myMod = self.heldArry[0];
       _speCountArry = [NSMutableArray arrayWithArray:myMod.count.special_attri];
        
    for ( NSInteger i = 0; i< self.speCountArry.count; i++) {
            WHspcil_attriModel * spec = myMod.count.special_attri[i];
            [self.speValueArry addObject:spec.value];
        
        }
        return self.speValueArry;

    }
    if (chart == self.barChart2) {
       
        WHcompanyDetail * myMod = self.heldArry[0];
        _prodCountArry = [NSMutableArray arrayWithArray:myMod.count.prod_type_code_app];
        
        for ( NSInteger i = 0; i< self.prodCountArry.count; i++) {
           WBYspecial_attriModel * prod = myMod.count.prod_type_code_app[i];
            [self.prodValueArry addObject:prod.value];
            
        }
        return self.prodValueArry;
        

        
    }

    else
    {
    return @[@"0", @"0", @"0", @"0", @"0", @"0",@"0",@"0"];
    }
    
}

- (NSArray *)nameArrayInGenericChart:(ZFGenericChart *)chart{
    
    
    
   
    if (chart == self.barChart)
    {
        
        WHcompanyDetail * myMod = self.heldArry[0];
        //WHyearapp * mod = myMod.count.year_app[0];
        _countArry = [NSMutableArray arrayWithArray:myMod.count.year_app];
        //

        for (NSInteger i = 0; i< self.countArry.count; i++)
        {
            WHyearapp * mod = myMod.count.year_app[i];
            [self.nameYearArry addObject:mod.name];
        }
        
        
        return self.nameYearArry;
        
       
   }
    if (chart == self.barChart1) {
        WHcompanyDetail * myMod = self.heldArry[0];
        _speCountArry = [NSMutableArray arrayWithArray:myMod.count.special_attri];
        
        for ( NSInteger i = 0; i< self.speCountArry.count; i++) {
            WHspcil_attriModel * spec = myMod.count.special_attri[i];
            [self.speNameArry addObject:spec.name];
            
        }
        return self.speNameArry;
        
        

    }
    if (chart == self.barChart2) {
        WHcompanyDetail * myMod = self.heldArry[0];
        _prodCountArry = [NSMutableArray arrayWithArray:myMod.count.prod_type_code_app];
        
        for ( NSInteger i = 0; i< self.prodCountArry.count; i++)
        {
            WBYspecial_attriModel * prod = myMod.count.prod_type_code_app[i];
            [self.prodNameArry addObject:prod.name?prod.name:@""];
            
        }
        return self.prodNameArry;
    }

    else
    {
    
    return @[@"0", @"0", @"0", @"0", @"0", @"0",@"0",@"0"];
    }
}

- (NSArray *)colorArrayInGenericChart:(ZFGenericChart *)chart{
    return @[ZFBlue];
}

- (CGFloat)axisLineMaxValueInGenericChart:(ZFGenericChart *)chart{
    return 200;
}
- (id)valueTextColorArrayInHorizontalBarChart:(ZFHorizontalBarChart *)barChart{
    return ZFBlue;
}
- (void)horizontalBarChart:(ZFHorizontalBarChart *)barChart didSelectBarAtGroupIndex:(NSInteger)groupIndex barIndex:(NSInteger)barIndex horizontalBar:(ZFHorizontalBar *)horizontalBar popoverLabel:(ZFPopoverLabel *)popoverLabel{
    //特殊说明，因传入数据是3个subArray(代表3个类型)，每个subArray存的是6个元素(代表每个类型存了1~6年级的数据),所以这里的groupIndex是第几个subArray(类型)
    //eg：三年级第0个元素为 groupIndex为0，barIndex为2
    NSLog(@"第%ld个颜色中的第%ld个",(long)groupIndex,(long)barIndex);
    
    //可在此处进行bar被点击后的自身部分属性设置
    //    horizontalBar.barColor = ZFYellow;
    //    horizontalBar.isAnimated = YES;
    //    horizontalBar.opacity = 0.5;
    //    [horizontalBar strokePath];
    
    //可将isShowAxisLineValue设置为NO，然后执行下句代码进行点击才显示数值
    //    popoverLabel.hidden = NO;
}

- (void)horizontalBarChart:(ZFHorizontalBarChart *)barChart didSelectPopoverLabelAtGroupIndex:(NSInteger)groupIndex labelIndex:(NSInteger)labelIndex popoverLabel:(ZFPopoverLabel *)popoverLabel{
    //理由同上
    NSLog(@"第%ld组========第%ld个",(long)groupIndex,(long)labelIndex);
    
    //可在此处进行popoverLabel被点击后的自身部分属性设置
    //    popoverLabel.textColor = ZFSkyBlue;
    //    [popoverLabel strokePath];
}

#pragma mark - 横竖屏适配(若需要同时横屏,竖屏适配，则添加以下代码，反之不需添加)

/**
 *  PS：size为控制器self.view的size，若图表不是直接添加self.view上，则修改以下的frame值
 */
- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id <UIViewControllerTransitionCoordinator>)coordinator NS_AVAILABLE_IOS(8_0){
    
    if ([[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationLandscapeLeft || [[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationLandscapeRight){
        self.barChart.frame = CGRectMake(0, 0, size.width, size.height - NAVIGATIONBAR_HEIGHT * 0.5);
    }else{
        self.barChart.frame = CGRectMake(0, 0, size.width, size.height + NAVIGATIONBAR_HEIGHT * 0.5);
    }
    
    [self.barChart strokePath];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
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
