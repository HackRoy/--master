//
//  ForgetPwdViewController.m
//  kuaibaoAPP
//
//  Created by 王义国 on 16/10/8.
//  Copyright © 2016年 王义国. All rights reserved.
//

#import "ForgetPwdViewController.h"

#import "ForgetPwdView.h"

#import "JGProgressHelper.h"
#import "JwLoginController.h"


@interface ForgetPwdViewController ()<UITextFieldDelegate>
@property(nonatomic,strong)ForgetPwdView * fp;

@end

@implementation ForgetPwdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"忘记密码";
    
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
    tap1.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tap1];
    
    self.fp.telText.delegate  = self;
    self.fp.codeText.delegate = self;
    self.fp.passWordText.delegate = self;
    self.fp.truePassText.delegate = self;
    
    [self.fp.codeBut addTarget:self action:@selector(code:) forControlEvents:(UIControlEventTouchUpInside)];
    
    [self.fp.nextBut addTarget:self action:@selector(nextButAction:) forControlEvents:(UIControlEventTouchUpInside)];

    
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (self.fp.truePassText == textField) {
        
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
    if (self.fp.truePassText == textField) {
    
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    self.view.frame = CGRectMake(0.0f, 64+0.0f, self.view.frame.size.width, self.view.frame.size.height);
    [UIView commitAnimations];
    }
}
-(void)loadView
{
    self.fp = [[ForgetPwdView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.view =_fp;
    
    
}
//提交
-(void)nextButAction:(UIButton *)sender
{
    if (self.fp.telText.text.length >0 && self.fp.passWordText.text.length >0 && self.fp.codeText.text.length >0 && self.fp.truePassText.text.length >0) {
        
        id hud = [JGProgressHelper showProgressInView:self.view];
        
        [self.userService forgetwordWithMobile:self.fp.telText.text captcha:self.fp.codeText.text pwd:self.fp.passWordText.text success:^{
            
            [hud hide:YES];
            [JGProgressHelper showSuccess:@"修改密码成功"];
            JwLoginController * login = [[JwLoginController alloc]init];
            [self.navigationController pushViewController:login animated:YES];
            
        } failure:^(NSError *error) {
            
            [JGProgressHelper showError:@"修改失败"];
        }];
        
        
        
          }
    else
    {
       
        
        [JGProgressHelper showError:@"有未填写项,请填写"];
        
    }
    

    
    
    
}

//获取验证码
-(void)code:(UIButton * )sender
{
    
    if (self.fp.telText.text.length != 0) {
        
        if ([WBYRequest isMobileNumber:self.fp.telText.text] == YES) {
            [JGProgressHelper showSuccess:@""];
        
        
        id hud = [JGProgressHelper showProgressInView:self.view];
        [self.userService sendsmsWithMobile:self.fp.telText.text type:@"3" check_mobile:@"0" success:^{
            
            
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
                self.fp.codeBut.userInteractionEnabled = YES;
                //self.fp.timeLaber.text = @"60s";
                [self.fp.codeBut setTitle:@"60s" forState:(UIControlStateNormal)];
            });
        }else{
            int seconds = timeout % 60;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                //NSLog(@"____%@",strTime);
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationDuration:1];
                [self.fp.codeBut setTitle:[NSString stringWithFormat:@"%@秒后重新发送",strTime] forState:UIControlStateNormal];
//                self.fp.timeLaber.text = [NSString stringWithFormat:@"%@s后重发",strTime];
//                NSLog(@"%@",self.fp.timeLaber.text);
//             
//                
                [UIView commitAnimations];
                self.fp.codeBut.userInteractionEnabled = NO;
            });
            timeout--;
        }
    });
    
     dispatch_resume(_timer);
    //
        } failure:^(NSError *error) {
            
            [hud hide:YES];
            [JGProgressHelper showError:@"发送失败"];
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

//点击键盘，键盘消失

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

//隐藏键盘事件
-(void)viewTapped:(UITapGestureRecognizer*)tap1
{
    
    [self.view endEditing:YES];
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
