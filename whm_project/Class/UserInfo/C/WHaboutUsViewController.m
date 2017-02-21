//
//  WHaboutUsViewController.m
//  whm_project
//
//  Created by 王义国 on 16/12/12.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import "WHaboutUsViewController.h"
#import "MacroUtility.h"

@interface WHaboutUsViewController ()<UIWebViewDelegate>
@property(nonatomic,strong)UIWebView * scw;
@end

@implementation WHaboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUp];
}

-(void)setUp
{
    self.title = @"关于我们";
    self.scw = [[UIWebView alloc]init];
    self.scw.frame = CGRectMake(0, 0, kScreenWitdh, kScreenHeight * 0.9);
    NSURL * url = [[NSBundle mainBundle]URLForResource:@"indexabout.html" withExtension:nil];
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    [self.scw loadRequest:request];
    [self.view addSubview:_scw];
    
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
