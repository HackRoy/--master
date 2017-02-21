//
//  WHJSCollectViewController.m
//  whm_project
//
//  Created by 王义国 on 16/11/17.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import "WHJSCollectViewController.h"
#import "WHTitleView.h"

#define SCREEN_WIDTH     [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT  [UIScreen mainScreen].bounds.size.height
#define LYRGBColor(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

@interface WHJSCollectViewController ()

@end

@implementation WHJSCollectViewController

-(instancetype)initWithAddVCARY:(NSArray *)VCS TitleS:(NSArray *)TitleS
{
    
    if (self = [super init]) {
        _VCAry = VCS;
        _TitleAry = TitleS;
        self.edgesForExtendedLayout = UIRectEdgeNone;
        //先初始化界面
      WHTitleView *BJView  = [[WHTitleView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 280)];
        BJView.backgroundColor = LYRGBColor(69, 107, 246);
        self.titleView = BJView;
        [self.view addSubview:BJView];
       // [self.titleView titllaber:@"你好吗"];
        
        for (int i = 0 ; i<_VCAry.count; i++) {
            
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(i*(SCREEN_WIDTH/_VCAry.count), CGRectGetMaxY(BJView.frame)- 40 , SCREEN_WIDTH/_VCAry.count, 40);
            
            btn.titleLabel.font = [UIFont systemFontOfSize:15];
            [btn setTitle:_TitleAry[i] forState:UIControlStateNormal];
            [btn setTitleColor:LYRGBColor(182, 197, 253) forState:UIControlStateNormal];
            if (i==0) {
                btn.selected = YES;
            }
            [btn setTitleColor:LYRGBColor(255, 255, 255) forState:UIControlStateSelected];
            btn.tag = 1000+i;
            [btn addTarget:self action:@selector(SeleScrollBtn:) forControlEvents:UIControlEventTouchUpInside];
            //            UIView * view = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(btn.frame)+1, CGRectGetHeight(btn.frame)/4, 1, CGRectGetHeight(btn.frame)/2)];
            //            view.backgroundColor = LYRGBColor(238, 238, 238);
            
            [BJView addSubview:btn];
            //            [BJView addSubview:view];
        }
        
        _LineView = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/(_VCAry.count * 4), BJView.frame.size.height-1, SCREEN_WIDTH/(_VCAry.count * 2), 1)];
        _LineView.backgroundColor = LYRGBColor(61, 110, 229);
        [BJView addSubview:_LineView];
        
        
        _MeScroolView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, BJView.frame.size.height, SCREEN_WIDTH, SCREEN_HEIGHT-BJView.frame.size.height)];
        _MeScroolView.backgroundColor = LYRGBColor(232, 232, 232);
        _MeScroolView.showsHorizontalScrollIndicator = NO;
        _MeScroolView.pagingEnabled = YES;
        _MeScroolView.delegate = self;
        [self.view addSubview:_MeScroolView];
    
        for (int i2 = 0; i2 <_VCAry.count; i2 ++) {
            UIView *view = [[_VCAry objectAtIndex:i2  ] view];
            view.frame = CGRectMake(i2  *SCREEN_WIDTH, 0, SCREEN_WIDTH, _MeScroolView.frame.size.height);
            [_MeScroolView addSubview:view];
            [self addChildViewController:[_VCAry objectAtIndex:i2  ]];
        }
        
        [_MeScroolView setContentSize:CGSizeMake(SCREEN_WIDTH*_VCAry.count, _MeScroolView.frame.size.height)];
        
    }
    return self;
}
/**
 *  滚动停止调用
 *
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    int index = scrollView.contentOffset.x/scrollView.frame.size.width;
    NSLog(@"当前第几页====%d",index);
    
    /**
     *  此方法用于改变x轴
     */
    [UIView animateWithDuration:0.3 animations:^{
        CGRect f = _LineView.frame;
        f.origin.x = index*(SCREEN_WIDTH/_VCAry.count) + SCREEN_WIDTH /( _VCAry.count * 4);
        _LineView.frame = f;
    }];
    
    UIButton *btn = [self.view viewWithTag:1000+index];
    for (UIButton *b in btn.superview.subviews) {
        if ([b isKindOfClass:[UIButton class]]) {
            b.selected = (b==btn)?YES:NO;
        }
    }
    
}
//点击每个按钮然后选中对应的scroolview页面及选中按钮
-(void)SeleScrollBtn:(UIButton*)btn{
    for (UIButton *button in btn.superview.subviews)
    {
        if ([button isKindOfClass:[UIButton class]]) {
            button.selected = (button != btn) ? NO : YES;
        }
    }
    [UIView animateWithDuration:0.3 animations:^{
        CGRect f = _LineView.frame;
        f.origin.x = (btn.tag-1000)*(SCREEN_WIDTH/_VCAry.count) + SCREEN_WIDTH /( _VCAry.count * 4);
        _LineView.frame = f;
        _MeScroolView.contentOffset = CGPointMake((btn.tag-1000)*SCREEN_WIDTH, 0);
    }];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
