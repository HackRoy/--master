//
//  JwRegistController.m
//  whm_project
//
//  Created by chenJw on 16/10/18.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import "JwRegistController.h"

#import "JGProgressHelper.h"

#import "RegisterTwoViewController.h"
#include "JwLoginController.h"
#import "WHregProtelViewController.h"

#import "UIColor+AddColor.h"
@interface JwRegistController ()<UITextFieldDelegate>


@property (weak, nonatomic) IBOutlet UITextField *nameText;
@property (weak, nonatomic) IBOutlet UITextField *telText;
@property (weak, nonatomic) IBOutlet UIButton *CodeBut;
@property (weak, nonatomic) IBOutlet UITextField *CodeText;
@property (weak, nonatomic) IBOutlet UILabel *timeLaber;
@property (weak, nonatomic) IBOutlet UITextField *pwdText;
@property (weak, nonatomic) IBOutlet UITextField *comforPwdText;
@property (weak, nonatomic) IBOutlet UIButton *protlBut;
@property (weak, nonatomic) IBOutlet UIButton *codeButtion;

@property(nonatomic,strong)NSTimer * countDownTime;
@property(nonatomic,assign)NSInteger secondsCountDowm;


@end

@implementation JwRegistController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"注册";
    
    self.nameText.delegate = self;
    self.telText.delegate = self;
    self.CodeText.delegate = self;
    self.pwdText.delegate = self;
    self.comforPwdText.delegate = self;
    
      
    if ([self.strNew isEqualToString:@"new"])
    {
        [self.protlBut setTitle:@"注册" forState:(UIControlStateNormal)];
    }else
    {
        [self.protlBut setTitle:@"下一步" forState:(UIControlStateNormal)];
        
    }
    
    
    //监听方法
    [self.nameText addTarget:self action:@selector(textFieldDidChange) forControlEvents:UIControlEventEditingChanged];
    
    [self.telText addTarget:self action:@selector(textFieldDidChange) forControlEvents:UIControlEventEditingChanged];
    [self.CodeText addTarget:self action:@selector(textFieldDidChange) forControlEvents:UIControlEventEditingChanged];
    [self.pwdText addTarget:self action:@selector(textFieldDidChange) forControlEvents:UIControlEventEditingChanged];
    [self.comforPwdText addTarget:self action:@selector(textFieldDidChange) forControlEvents:UIControlEventEditingChanged];

}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.protlBut.backgroundColor=[UIColor buttonbgcolor];
    self.protlBut.enabled = NO;
    [self.protlBut setTitleColor:[UIColor ziticolor]forState:UIControlStateNormal];
    
}
-(void)textFieldDidChange{
    
    if (self.nameText.text.length!=0&&self.telText.text.length!=0&&self.CodeText.text.length!=0&&self.pwdText.text.length!=0&&self.comforPwdText.text.length!=0) {
        self.protlBut.backgroundColor = wBlue;
        [self.protlBut setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
        self.protlBut.enabled=YES;
    }else if(self.nameText.text.length==0&&self.telText.text.length==0&&self.CodeText.text.length==0&&self.pwdText.text.length==0&&self.comforPwdText.text.length!=0){
        self.protlBut.backgroundColor=[UIColor buttonbgcolor];
        self.protlBut.enabled = NO;
        [self.protlBut setTitleColor:[UIColor ziticolor]forState:UIControlStateNormal];
        
    }
}

//注册事件
- (IBAction)nextButAction:(id)sender
{
    
//    RegisterTwoViewController * regTwo = [[RegisterTwoViewController alloc] init];
//    regTwo .name = self.nameText.text;
//    regTwo .mobile = self.telText.text;
//    regTwo .captcha = self.CodeText.text;
//    regTwo . pwd = self.pwdText.text;
//    [self.navigationController pushViewController:regTwo animated:YES];
    
     if ([self.strNew isEqualToString:@"new"])
    {
        if (self.nameText.text.length != 0 && self.telText.text.length != 0 && self.CodeText.text.length != 0 && self.pwdText.text !=0 && self.comforPwdText.text.length != 0)
        {
            
            if (self.pwdText.text.length >= 8 && self.pwdText.text.length <= 16 )
            {
            if ([self.pwdText.text isEqualToString:self.comforPwdText.text ]) {
                id hud = [JGProgressHelper showProgressInView:self.view];
                [self.userService registWithName:self.nameText.text mobile:self.telText.text captcha:self.CodeText.text pwd:self.pwdText.text type:@"0" company_id:@"" org_id:@"" exhibition_no:@"" nickname:@"" work_time:@"" id_number:@"" profession:@"" specialize_in:@"" address:@"" success:^(JwUser *user)
                {
                    
                    [hud hide:YES];
                    [JGProgressHelper showSuccess:@"普通用户注册成功"];
                    JwLoginController * login = [[JwLoginController alloc]init];
                    [self.navigationController pushViewController:login animated:YES];
                    
                } failure:^(NSError *error) {
                    
                    [JGProgressHelper showError:@"注册失败"];
                }];
            }else{
                [JGProgressHelper showError:@"两次密码不一致"];
            }
            }
            else
            {
                [JGProgressHelper showError:@"您输入的密码长度要在8到16位之间"];
            }
        }else{
            [JGProgressHelper showError:@"有未填写项,请填写"];
        }
    }else{
        
        if (self.nameText.text.length != 0 && self.telText.text.length != 0 && self.CodeText.text.length != 0 && self.pwdText.text !=0 && self.comforPwdText.text.length != 0)
        {
            if ([self.pwdText.text isEqualToString:self.comforPwdText.text])
            {
        //顾问注册进入下一步
        RegisterTwoViewController * regTwo = [[RegisterTwoViewController alloc] init];
        regTwo .name = self.nameText.text;
        regTwo .mobile = self.telText.text;
        regTwo .captcha = self.CodeText.text;
        regTwo . pwd = self.pwdText.text;
        [self.navigationController pushViewController:regTwo animated:YES];
                
            }
            else
            {
                [JGProgressHelper showError:@"两次输入密码不一致,请确认"];
            }
        }
        else
        {
            [JGProgressHelper showError:@"有未填写项,请填写"];
        }
        
    }
    
    
}
//注册协议

- (IBAction)registPro:(id)sender {
    WHregProtelViewController * regpro = [[WHregProtelViewController alloc]init];
    [self.navigationController pushViewController:regpro animated:YES];
    
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (self.comforPwdText == textField) {
    
    
    //滑动效果（动画）
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    
    //将视图的Y坐标向上移动，以使下面腾出地方用于软键盘的显示
    self.view.frame = CGRectMake(0.0f, -100.0f, self.view.frame.size.width, self.view.frame.size.height);//64-216
    
    [UIView commitAnimations];
    }
}
- (void)textFieldDidEndEditing:(UITextField *)textField;{
    if (self.comforPwdText == textField) {
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    self.view.frame = CGRectMake(0.0f, 64+0.0f, self.view.frame.size.width, self.view.frame.size.height);
    [UIView commitAnimations];
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(BOOL)trueTelenum
{
    NSString * const MOBILE = @"^1(3|4|5|7|8)\\d{9}$";
    
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    return [predicate evaluateWithObject:self];
       
}
 //验证码事件发送
- (IBAction)codeButAction:(id)sender {
    
    if (self.telText.text.length != 0) {
        
        if ([WBYRequest isMobileNumber:self.telText.text] == YES) {
            [JGProgressHelper showSuccess:@""];
            id hud = [JGProgressHelper showProgressInView:self.view];
        [self.userService sendsmsWithMobile:self.telText.text type:@"1" check_mobile:@"1" success:^{
            
            
            [hud hide:YES];
            [JGProgressHelper showSuccess:@"发送验证码成功"];
            
            
   
    
       __block int timeout=60; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout< 0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                //[self.rv.yzhBut setTitle:@"发送验证码" forState:UIControlStateNormal];
                self.codeButtion.userInteractionEnabled = YES;
                self.timeLaber.text = @"60s";
            });
        }else{
            int seconds = timeout % 60;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                //NSLog(@"____%@",strTime);
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationDuration:1];
                //[self.rg.codeBut setTitle:[NSString stringWithFormat:@"%@秒后重新发送",strTime] forState:UIControlStateNormal];
                self.timeLaber.text = [NSString stringWithFormat:@"%@s后重发",strTime];
//                NSLog(@"---%@---%d",self.timeLaber.text,seconds);
                [UIView commitAnimations];
                self.codeButtion.userInteractionEnabled = NO;
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
    
            
        } failure:^(NSError *error) {
            
            [hud hide:YES];
            [JGProgressHelper showError:@"该手机已经注册过"];
        }];
        }else
        {
            [JGProgressHelper showError:@"请核对你的手机号格式"];
        }
    }
    else
    {
        [JGProgressHelper showError:@"请输入手机号"];
    }

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
