//
//  YinDaoViewController.m
//  zheShiGeHaoRuanJian
//
//  Created by Stephy_xue on 16/11/4.
//  Copyright © 2016年 henankuibu. All rights reserved.
//

#import "YinDaoViewController.h"
#import "YinDaoCollectionViewCell.h"
#import "JwTabBarController.h"
#import "UIColor+Hex.h"

@interface YinDaoViewController ()<UIScrollViewDelegate>
{
    NSArray*arr;
    
}
@property (nonatomic, strong) UIPageControl *pageControl;

@property (nonatomic, strong) UICollectionView * myview;

@property (nonatomic ,strong)UIButton * myBut;

@end

@implementation YinDaoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [NSArray arrayWithObjects:@"1137", @"1138", @"1139",@"1140", nil]
    arr=@[@"11",@"21", @"31",@"41"];
    
    [self creatUI];
}


-(void)creatUI
{
    
    UICollectionViewFlowLayout*layout=[UICollectionViewFlowLayout new];
    
    layout.minimumInteritemSpacing=0;
    layout.minimumLineSpacing=0;
    layout.itemSize=CGSizeMake(wScreenW, wScreenH);
    
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    _myview = [[UICollectionView alloc] initWithFrame:[UIScreen mainScreen].bounds collectionViewLayout:layout];
    _myview.bounces = NO;
    _myview.backgroundColor = [UIColor whiteColor];
    _myview.showsHorizontalScrollIndicator = NO;
    _myview.showsVerticalScrollIndicator = NO;
    _myview.pagingEnabled = YES;
    _myview.dataSource = self;
    _myview.delegate = self;
    
    [_myview registerClass:[YinDaoCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
   
    [self.view addSubview:_myview];
//    [_myview addSubview:_pageControl];
    
    self.pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(self.myview.frame)-80,
    CGRectGetWidth(self.view.frame), 10)];
    self.pageControl.numberOfPages = 4;
    self.pageControl.currentPage = 0 ;
    self.pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    self.pageControl.pageIndicatorTintColor = [UIColor grayColor];
    
    [self.view addSubview:_pageControl];
    
//    self.myBut = [UIButton buttonWithType:(UIButtonTypeSystem)];
//    self.myBut.frame = CGRectMake(CGRectGetWidth(self.view.frame)*0.4, CGRectGetHeight(self.view.frame)-120, CGRectGetWidth(self.view.frame)*0.2, 30);
//    [self.myBut setTitle:@"立即体验" forState:(UIControlStateNormal)];
//   // self.myBut.backgroundColor = [UIColor redColor];
//    [self.view addSubview:_myBut];

    
    
}

//- (UIPageControl *)pageControl {
//    if (_pageControl == nil) {
//        _pageControl = [[UIPageControl alloc] init];
//        _pageControl.frame = CGRectMake(0, 0, wScreenW, 44.0f);
//        _pageControl.center = CGPointMake(wScreenW / 2, wScreenH - 60);
//    }
//    return _pageControl;
//}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return arr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    YinDaoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    
//    UIImage *img = [UIImage imageWithContentsOfFile:path];
//    CGSize size = [self adapterSizeImageSize:img.size compareSize:kScreenBounds.size];
    
  
    cell.img.image = [UIImage imageNamed:arr[indexPath.row]];
    
//    if (indexPath.row == arr.count - 1)
//    {
//        [cell.button setHidden:NO];
//        [cell.button addTarget:self action:@selector(nextButtonHandler:) forControlEvents:UIControlEventTouchUpInside];
//    } else
//    {
//        [cell.button setHidden:YES];
//    }
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    self.pageControl.currentPage = (scrollView.contentOffset.x / wScreenW);
    if (self.pageControl.currentPage == 3) {
        self.myBut = [UIButton buttonWithType:(UIButtonTypeSystem)];
        self.myBut.frame = CGRectMake(CGRectGetWidth(self.view.frame)*0.4, CGRectGetHeight(self.view.frame)-80, CGRectGetWidth(self.view.frame)*0.2, 30);
        [self.myBut setTitle:@"立即体验" forState:(UIControlStateNormal)];
        // self.myBut.backgroundColor = [UIColor redColor];
        
        [self.myBut setTintColor:[UIColor whiteColor]];
        self.myBut.backgroundColor = [UIColor colorWithHex:0xf56e40];
        [self.view addSubview:_myBut];
        [self.myBut addTarget:self action:@selector(aa:) forControlEvents:(UIControlEventTouchUpInside)];

    }
    else
    {
        self.myBut.hidden = YES;
    }
    
}

-(void)aa:(UIButton *)sender
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:@"diyici" forKey:@"zheshidiyici"];
    [ud synchronize];
    
    
    NSString * myStr = [ud objectForKey:@"zheshidiyici"];
    
    NSLog(@"====%@",myStr);
    JwTabBarController*tabview=[JwTabBarController new];
    [[UIApplication sharedApplication].delegate window].rootViewController=tabview;

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
