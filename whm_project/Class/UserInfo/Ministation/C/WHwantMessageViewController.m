//
//  WHwantMessageViewController.m
//  whm_project
//
//  Created by 王义国 on 16/12/7.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import "WHwantMessageViewController.h"
#import "UIColor+Hex.h"
#import "JGProgressHelper.h"

@interface WHwantMessageViewController ()<UITextViewDelegate>
@property(nonatomic,strong)UITextView * Mytextview;
@property(nonatomic,strong)UIButton * myBut;
@end

@implementation WHwantMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setUI];
    self.title = @"留言";
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    [self.Mytextview becomeFirstResponder];
}

-(void)setUI
{
    self.Mytextview = [[UITextView alloc]init];
    self.Mytextview.frame = CGRectMake(10, 10, CGRectGetWidth([UIScreen mainScreen].bounds)-20, CGRectGetHeight([UIScreen mainScreen].bounds)*0.3);
    self.Mytextview.textColor = [UIColor grayColor];
    self.Mytextview.font = [UIFont fontWithName:@"Arial" size:16.0];//设置字体名字和字体大小
    self.Mytextview.layer.masksToBounds = YES;
    self.Mytextview.layer.borderColor = wGrayColor2.CGColor;
    self.Mytextview.layer.borderWidth = 0.6;
    
    self.Mytextview.delegate = self;//设置它的委托方法
    
    self.Mytextview.backgroundColor = [UIColor whiteColor];//设置它的背景颜色
    self.Mytextview.scrollEnabled = YES;//是否可以拖动
    self.Mytextview.autoresizingMask = UIViewAutoresizingFlexibleHeight;//自适应高度
    
    [self.view addSubview:_Mytextview];

    
    self.myBut = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.myBut.frame = CGRectMake(10,CGRectGetMaxY(self.Mytextview.frame)+10, CGRectGetWidth([UIScreen mainScreen].bounds)-20, 40);
    [self.myBut setTitle:@"提交" forState:(UIControlStateNormal)];
    self.myBut.layer.shadowOffset = CGSizeMake(1, 1);
    self.myBut.layer.shadowOpacity = 0.8;
    self.myBut.layer.shadowColor = [UIColor colorWithHex:0x4367FF ].CGColor;
    self.myBut.backgroundColor = [UIColor colorWithHex:0x4367FF ];
    [self.myBut setTintColor:[UIColor whiteColor]];
    [self.myBut addTarget:self action:@selector(myButAction:) forControlEvents:(UIControlEventTouchUpInside)];
    self.myBut.layer.cornerRadius = 20.0;
    [self.view addSubview:_myBut];

}

-(void)myButAction:(UIButton *)sender
{
    id hud = [JGProgressHelper showProgressInView:self.view];
    [self.userService savemessageWithReq_uid:@""
                                     res_uid:self.res_uid
                                         uid:@""
                                     message:self.Mytextview.text
                                  message_id:@"0"
                                   city_name:self.cityName
                                    req_name:self.name
                                     success:^{
                                         [hud hide:YES];
                                         [JGProgressHelper showSuccess:@"留言成功"];
        
    } failure:^(NSError *error) {
        [hud hide:YES];
        [JGProgressHelper showError:@"留言失败"];
        
    }];
    
    
    
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
