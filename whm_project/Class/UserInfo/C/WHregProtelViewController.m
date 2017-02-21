//
//  WHregProtelViewController.m
//  whm_project
//
//  Created by 王义国 on 16/12/5.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import "WHregProtelViewController.h"
#import "MacroUtility.h"

@interface WHregProtelViewController ()<UIWebViewDelegate>
@property(nonatomic,strong)UIWebView * scw ;
@property(nonatomic,strong)NSString * s1 ;

@end

@implementation WHregProtelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUP];
    
}
-(void)setUP
{
    
    self.title = @"注册协议";
    self.scw = [[UIWebView alloc]init];
    self.scw.frame = CGRectMake(0, 0, kScreenWitdh, kScreenHeight);
   // [self.view addSubview:_scw];
    // 应用场景:加载从服务器上下载的文件,例如pdf,或者word,图片等等文件
    NSURL * url = [[NSBundle mainBundle]URLForResource:@"register_agreement.html" withExtension:nil];
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
