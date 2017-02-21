//
//  JwLoginController.m
//  whm_project
//
//  Created by chenJw on 16/10/18.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import "JwLoginController.h"
#import "UIColor+Hex.h"
#import "JwRegistController.h"
#import "JGProgressHelper.h"
#import "JwUser.h"
#import "ForgetPwdViewController.h"
#import "WHpersonCenterViewController.h"
#import "RegisterTwoViewController.h"
#import "MacroUtility.h"
#import "WHKNetWorkUtils.h"
#import "JwTabBarController.h"
#import "JwLookForController.h"
#import "UIColor+AddColor.h"

@interface JwLoginController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIView *mobV;
@property (weak, nonatomic) IBOutlet UIView *pwdV;

@property (weak, nonatomic) IBOutlet UIButton *newsB;
@property (weak, nonatomic) IBOutlet UIButton *baoB;

@property (weak, nonatomic) IBOutlet UITextField *mobTF;
@property (weak, nonatomic) IBOutlet UITextField *pwdTF;

@property (weak, nonatomic) IBOutlet UIButton *clearB;
@property (weak, nonatomic) IBOutlet UIButton *eyeB;

@property (weak, nonatomic) IBOutlet UIButton *loginBut;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@end

@implementation JwLoginController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
//    [self creatLiftItemWith:[UIImage imageNamed:@"back"] withFrame:CGRectMake(0, 0,16, 20)];

//    self.navigationItem .leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:(UIBarButtonItemStylePlain) target:self action:@selector(left)];
    
//    [self creatLiftItemWith:[UIImage imageNamed:@"back"] withFrame:CGRectMake(0, 0,16, 20)];
     [self.navigationController.navigationBar setBarTintColor:wBlue];
    UIButton * button =[UIButton buttonWithType:UIButtonTypeSystem];
    button.frame=CGRectMake(0, 0,16, 20);
    
    [button setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(left) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithCustomView:button];
    
    self.title = @"登录";
    [self setupView];
//    self.loginButton 登录按钮
   

    //监听方法
    [self.mobTF addTarget:self action:@selector(textFieldDidChange) forControlEvents:UIControlEventEditingChanged];
    
    [self.pwdTF addTarget:self action:@selector(textFieldDidChange) forControlEvents:UIControlEventEditingChanged];


    self.mobTF.delegate = self;
    self.pwdTF.delegate = self;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.loginButton.backgroundColor=[UIColor buttonbgcolor];
    self.loginButton.enabled = NO;
[self.loginButton setTitleColor:[UIColor ziticolor]forState:UIControlStateNormal];

}
-(void)textFieldDidChange{

    if (self.mobTF.text.length!=0&&self.pwdTF.text.length!=0) {
        self.loginButton.backgroundColor = wBlue;
        [self.loginButton setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
        self.loginButton.enabled=YES;
    }else if(self.mobTF.text.length==0||self.pwdTF.text.length==0){
        self.loginButton.backgroundColor=[UIColor buttonbgcolor];
        self.loginButton.enabled = NO;
        [self.loginButton setTitleColor:[UIColor ziticolor]forState:UIControlStateNormal];

     }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.mobTF resignFirstResponder];
    [self.pwdTF resignFirstResponder];
}

-(void)left
{
    [[UIApplication sharedApplication].delegate window].rootViewController=[JwTabBarController new];
}
- (void)setupView
{
    self.mobV.layer.borderColor = [UIColor colorWithHex:0xc4c4c4].CGColor;
    self.pwdV.layer.borderColor = [UIColor colorWithHex:0xc4c4c4].CGColor;
    self.newsB.layer.borderColor = [UIColor colorWithHex:0xc4c4c4].CGColor;
    self.baoB.layer.borderColor = [UIColor colorWithHex:0xc4c4c4].CGColor;
    self.clearB.hidden = NO;
    self.eyeB.hidden = NO;
    
    [self.mobTF addTarget:self action:@selector(mobTFChange:) forControlEvents:(UIControlEventEditingChanged)];
    [self.pwdTF addTarget:self action:@selector(pwdTFChange:) forControlEvents:(UIControlEventEditingChanged)];
    self.pwdTF.delegate = self;
}

- (void)mobTFChange:(UITextField *)textField{
    if (textField.text.length > 0) {
        self.clearB.hidden = NO;
    }else{
        self.clearB.hidden = YES;
    }
}

- (void)pwdTFChange:(UITextField *)textField{
    if (textField.text.length > 0) {
        self.eyeB.hidden = NO;
    }else{
        self.eyeB.hidden = YES;
    }
}

//保险顾问注册
- (IBAction)PropertBut:(id)sender
{
    JwRegistController *registVC = [[JwRegistController alloc] init];
    [self.navigationController pushViewController:registVC animated:YES];
}

//忘记密码
- (IBAction)ForgetPwdAction:(id)sender
{
    ForgetPwdViewController * forgetPwd = [[ForgetPwdViewController alloc]init];
    [self.navigationController pushViewController:forgetPwd animated:YES];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self pwdTFChange:textField];
    
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    
    //将视图的Y坐标向上移动，以使下面腾出地方用于软键盘的显示
    self.view.frame = CGRectMake(0.0f, -100.0f, self.view.frame.size.width, self.view.frame.size.height);
    
    [UIView commitAnimations];
}
- (void)textFieldDidEndEditing:(UITextField *)textField

{
    self.pwdTF.secureTextEntry = YES;
    self.eyeB.hidden = YES;
    
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    self.view.frame = CGRectMake(0.0f, 64+0.0f, self.view.frame.size.width, self.view.frame.size.height);
    [UIView commitAnimations];
}

- (IBAction)onClear:(UIButton *)sender {
    self.mobTF.text = @"";
    self.clearB.hidden = YES;
}

- (IBAction)onEye:(UIButton *)sender {
    if (self.pwdTF.secureTextEntry == YES) {
        self.pwdTF.secureTextEntry = NO;
    }else{
        self.pwdTF.secureTextEntry = YES;
    }
}
//新用户注册
- (IBAction)onNews:(UIButton *)sender
{
    JwRegistController *registVC = [[JwRegistController alloc] init];
     NSString * s1 = @"new";
    registVC.strNew = s1;
    [self.navigationController pushViewController:registVC animated:YES];
}
//登录
- (IBAction)onLogin:(UIButton *)sender
{
   
    if ([WBYRequest isMobileNumber:self.mobTF.text] ==  YES )
    {
        
        if (self.mobTF.text.length != 0 && self.pwdTF.text.length != 0) {
        id hud = [JGProgressHelper showProgressInView:self.view];
            
        [self.userService loginWithMobile:self.mobTF.text password:self.pwdTF.text success:^(JwUser *user)
            {
            [hud hide:YES];
            [[UIApplication sharedApplication].delegate window].rootViewController =[JwTabBarController new];
            } failure:^(NSError *error)
         {
            [hud hide:YES];
            [JGProgressHelper showError:@"你输入的账号或密码有误请核查"];
        }];
        
    }else{
        [JGProgressHelper showError:@"请输入账号或密码!"];
    }
    }
    else
    {
        [JGProgressHelper showError:@"你输入的手机格式不对,请核实"];
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
