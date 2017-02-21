//
//  WBYzfcgViewController.m
//  whm_project
//
//  Created by apple on 17/1/19.
//  Copyright © 2017年 chenJw. All rights reserved.
//

#import "WBYzfcgViewController.h"
#import "JwTabBarController.h"

#import "WBYKFPViewController.h"
@interface WBYzfcgViewController ()
@end

@implementation WBYzfcgViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"支付成功";
    [self creatBtn];
    
    [self creatUI];
}

-(void)creatUI
{
    UIImageView * img = [[UIImageView alloc] initWithFrame:CGRectMake((wScreenW - 150)/2, 40, 150, 150)];
    img.image = [UIImage imageNamed:@"chenggong"];
    [self.view addSubview:img];
    
    UILabel * midLab = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(img.frame) + 30, wScreenW, 40)];
    midLab.textColor =  wLvColour;
    midLab.textAlignment = 1;
    midLab.font = [UIFont systemFontOfSize:34.f];
    midLab.text = @"支付成功";
    [self.view addSubview:midLab];
    
    UILabel * downLab = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(midLab.frame), wScreenW, 20)];
    downLab.textColor = wGrayColor2;
    downLab.textAlignment = 1;
    downLab.font = [UIFont systemFontOfSize:10.f];
    downLab.text = @"恭喜你已成为快保家VIP代理";
    [self.view addSubview:downLab];
  
    
    UIButton * zhifu = [UIButton buttonWithType:UIButtonTypeCustom];
    [zhifu setTitle:[NSString stringWithFormat:@"立即开取发票"] forState:UIControlStateNormal];
    zhifu.frame = CGRectMake(30, CGRectGetMaxY(downLab.frame) +45, wScreenW - 60, 35);
    [zhifu setTitleColor:wWhiteColor forState:UIControlStateNormal];
    zhifu.backgroundColor = wBlue;
    zhifu.layer.masksToBounds = YES;
    zhifu.layer.cornerRadius = 17.5;
    [zhifu addTarget:self action:@selector(kaifapiao) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:zhifu];
    
}

-(void)kaifapiao
{
    
    [self.navigationController pushViewController:[WBYKFPViewController new] animated:YES];
    
}


-(void)creatBtn
{
    UIButton * button =[UIButton buttonWithType:UIButtonTypeSystem];
    button.frame=CGRectMake(0,0,20, 20);
    
    [button setBackgroundImage:[UIImage imageNamed:@"abcdef"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(left) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithCustomView:button];
    
}
-(void)left
{
    
    [[UIApplication sharedApplication].delegate window].rootViewController=[JwTabBarController new];
    
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
