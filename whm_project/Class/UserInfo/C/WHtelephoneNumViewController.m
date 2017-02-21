//
//  WHtelephoneNumViewController.m
//  whm_project
//
//  Created by 王义国 on 16/10/24.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import "WHtelephoneNumViewController.h"
#import "WHupdateTelView.h"
#import "JGProgressHelper.h"
@interface WHtelephoneNumViewController ()

@property(nonatomic,strong)WHupdateTelView * tel ;

@end

@implementation WHtelephoneNumViewController

-(void)loadView
{
    self.tel = [[WHupdateTelView  alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.view =_tel ;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"修改手机号";
    
    [self.tel.codeBut addTarget:self action:@selector(code:) forControlEvents:(UIControlEventTouchUpInside)];

    [self.tel.nextBut addTarget:self action:@selector(nextButAction:) forControlEvents:(UIControlEventTouchUpInside)];
    

}
//获取验证码
-(void)code:(UIButton * )sender
{
    
    if (self.tel.telText.text.length != 0) {
        
        if ([WBYRequest isMobileNumber:self.tel.telText.text] == YES) {
            [JGProgressHelper showSuccess:@""];

        
        id hud = [JGProgressHelper showProgressInView:self.view];
        [self.userService sendsmsWithMobile:self.tel.telText.text  type:@"1" check_mobile:@"1" success:^{
            
            
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
                self.tel.codeBut.userInteractionEnabled = YES;
                self.tel.timeLaber.text = @"60s";
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
                self.tel.timeLaber.text = [NSString stringWithFormat:@"%@s后重发",strTime];
                NSLog(@"%@",self.tel.timeLaber.text);
                [UIView commitAnimations];
                self.tel.codeBut.userInteractionEnabled = NO;
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);

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
//修改手机号
-(void)nextButAction:(UIButton *)sender
{
   
    if (self.tel.telText.text.length != 0 && self.tel.codeText.text .length != 0) {
        id hud = [JGProgressHelper showProgressInView:self.view];
        [self.userService update_mobileWithUid:@"" mobile:self.tel.telText.text captcha:self.tel.codeText.text success:^{
            [hud hide:YES];
            [JGProgressHelper showSuccess:@"修改手机号成功"];
            
        } failure:^(NSError *error) {
            
            [hud hide:YES];
            [JGProgressHelper showError:@"修改手机号失败"];
            
        }];
        
        
    }else
    {
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
