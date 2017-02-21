//
//  WHrestPwdViewController.m
//  whm_project
//
//  Created by 王义国 on 16/10/20.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import "WHrestPwdViewController.h"
#import "UIColor+Hex.h"
#import "JGProgressHelper.h"
#import "JwUserCenter.h"
#import "JwLoginController.h"

@interface WHrestPwdViewController ()
@property(nonatomic,strong)UIImageView * passWordImage;
@property(nonatomic,strong)UITextField * passWordText;
@property(nonatomic,strong)UIImageView * truePassImage;
@property(nonatomic,strong)UITextField * truePassText;
@property(nonatomic,strong)UIButton * myBut;

@property(nonatomic,strong)UIView * lineView;

@property(nonatomic,strong)UIView * lineView2;
@end

@implementation WHrestPwdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"重置密码";
  
    [self setUI];
}

-(void)setUI
{
    self.passWordText = [[UITextField alloc]init];
    self.passWordText.frame = CGRectMake(10, CGRectGetHeight([UIScreen mainScreen].bounds)*0.055, CGRectGetWidth([UIScreen mainScreen].bounds)-20, 36);
    self.passWordText.placeholder = @"请输入您的新密码(8-20位)";
    self.passWordText.borderStyle = UITextBorderStyleNone;
    self.passWordText.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.passWordImage= [[UIImageView alloc]init];
    self.passWordImage.frame = CGRectMake(0, 0, 30, 30);
    self.passWordImage.image = [UIImage imageNamed:@"Jw_lock"];
    self.passWordText.leftView = self.passWordImage;
    self.passWordText.leftViewMode = UITextFieldViewModeAlways;
    self.passWordText.secureTextEntry =YES;
    //
    self.lineView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.passWordText.frame)    , CGRectGetWidth([UIScreen mainScreen].bounds), 1)];
    self.lineView.backgroundColor = [UIColor colorWithRed:0.871 green:0.875 blue:0.878 alpha:1];
    
    [self.view addSubview:_lineView];
    [self.view addSubview:_passWordText];
    //
    self.truePassText = [[UITextField alloc]init];
    self.truePassText.frame = CGRectMake(10, CGRectGetMaxY(self.lineView.frame)+30, CGRectGetWidth([UIScreen mainScreen].bounds)-20, 36);
    self.truePassText.placeholder = @"再次确认您的密码(8-20位)";
    self.truePassText.borderStyle = UITextBorderStyleNone;
    self.truePassText.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.truePassImage= [[UIImageView alloc]init];
    self.truePassImage.frame = CGRectMake(0, 0, 30, 30);
    self.truePassImage.image = [UIImage imageNamed:@"Jw_passwd"];
    self.truePassText.leftView = self.truePassImage;
    self.truePassText.leftViewMode = UITextFieldViewModeAlways;
    self.truePassText.secureTextEntry = YES;
    
    //
    self.lineView2 = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.truePassText.frame)    , CGRectGetWidth([UIScreen mainScreen].bounds), 1)];
    self.lineView2.backgroundColor = [UIColor colorWithRed:0.871 green:0.875 blue:0.878 alpha:1];
    [self.view addSubview:_lineView2];
    [self.view addSubview:_truePassText];
//
    //
    self.myBut = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.myBut.frame = CGRectMake(30, CGRectGetMaxY(self.lineView2.frame)+30, CGRectGetWidth([UIScreen mainScreen].bounds)-60, CGRectGetHeight(self.truePassText.frame)*1.2);
    [self.myBut setTitle:@"提交" forState:(UIControlStateNormal)];
   // self.myBut.backgroundColor = [UIColor colorWithRed:0.234 green:0.332 blue:0.996 alpha:1];
    
    self.myBut.backgroundColor = [UIColor colorWithHex:0x4367FF ];
    self.myBut.layer.shadowOffset = CGSizeMake(1, 1);
    self.myBut.layer.shadowOpacity = 0.8;
    self.myBut.layer.shadowColor = [UIColor colorWithHex:0x4367FF ].CGColor;
    
    [self.myBut setTintColor:[UIColor whiteColor]];
    self.myBut.layer.cornerRadius = 20.0;
    [self.view addSubview:_myBut];
    [self.myBut addTarget:self action:@selector(myButAction:) forControlEvents:(UIControlEventTouchUpInside)];
    

    
}
-(void)myButAction:(UIButton *)sender
{
    if (self.passWordText.text.length != 0 && self.truePassText.text.length != 0) {
        
        if ([self.passWordText.text isEqualToString:self.truePassText.text]) {
            
            id hud = [JGProgressHelper showProgressInView:self.view];
            [self.userService updatepwdUid:@""  old_pwd:self.oldPwd pwd:self.passWordText.text success:^{
                [hud hide:YES];
                [JGProgressHelper showSuccess:@"修改密码成功"];
               // [self.navigationController popViewControllerAnimated:YES];
                JwLoginController * login = [JwLoginController new];
                [self.navigationController pushViewController:login animated:YES];
                
                } failure:^(NSError *error) {
                    [hud hide:YES];
                    [JGProgressHelper showError:@"修改密码失败"];
                
                }];
            
            
        }
        
        else
        {
            [JGProgressHelper showError:@"两次输入密码不一致,请核查"];
        }
        
    }
    else{
        [JGProgressHelper showError:@"有未填写项,请填写"];
    }
    
    
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
