//
//  LYTestThreeViewController.m
//  MYPage
//
//  Created by 赵良育 on 2016/11/10.
//  Copyright © 2016年 赵良育. All rights reserved.
//

#import "LYTestThreeViewController.h"
#import "CustomProgress.h"
#import "MacroUtility.h"
#import "UIColor+Hex.h"
#import "WHgetreport.h"
#import "WHcov.h"

@interface LYTestThreeViewController ()<UIWebViewDelegate>
{
    NSTimer * timer;
    int present;

    NSTimer * timer1;
    int present1;
    
    NSTimer * timer2;
    int present2;

    NSTimer * timer3;
    int present3;

    NSTimer * timer4;
    int present4;

//    NSTimer * timer5;
//    int present5;
}

@property(nonatomic,strong)CustomProgress * custompro;
@property(nonatomic,strong)CustomProgress * custompro1;
@property(nonatomic,strong)CustomProgress * custompro2;
@property(nonatomic,strong)CustomProgress * custompro3;
@property(nonatomic,strong)CustomProgress * custompro4;
@property(nonatomic,strong)CustomProgress * custompro5;




@property(nonatomic,strong)UIWebView * scw;
@property(nonatomic,strong)UILabel * titLaber;
@property(nonatomic,strong)NSString * s1 ;
@property(nonatomic,strong)NSString * hasnt;
@property(nonatomic,strong)NSString * accident;
@property(nonatomic,strong)NSString * disease;
@property(nonatomic,strong)NSString * strleast;
@property(nonatomic,strong)NSString * cov;


@end

@implementation LYTestThreeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self setup];
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    [self requartDate];
}
//数据请求
-(void)requartDate
{
     NSUserDefaults * ud = [NSUserDefaults standardUserDefaults];
    self.strleast = [ud valueForKey:@"three"];
    
    self.hasnt = [ud valueForKey:@"hasnt"]; //缺少保障项目
    self.accident = [ud valueForKey:@"accident"];  //意外保险保额
    self.disease = [ud valueForKey:@"disease"]; //重大疾病
    self.cov = [ud valueForKey:@"Cov"];
    
    NSLog(@"%@",self.hasnt);
     NSLog(@"%@",self.accident);
     NSLog(@"%@",self.disease);
    NSLog(@"==%@",self.s1);
    self.s1 = self.cov;
    [self loadWithURLString:self.s1];

}
-(void)setup
{
    self.view.backgroundColor = [UIColor colorWithHex: 0xF5F7F9];
    
    _custompro = [[CustomProgress alloc] initWithFrame:CGRectMake(10, 10, kScreenWitdh *0.4, 20)];
    
    //_custompro.maxValue = 20;
    //设置背景色
    _custompro.bgimg.backgroundColor =[UIColor whiteColor];
    _custompro.leftimg.backgroundColor =[UIColor colorWithRed:202/255.0 green:237/255.0 blue:234/255.0 alpha:1];
    
    _custompro.presentlab.textColor = [UIColor blackColor];
    [self.view addSubview:_custompro];

    [self timer];
    UITapGestureRecognizer *tapGestureCov = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClickUILableCov:)];
    _custompro.presentlab.userInteractionEnabled = YES;
    tapGestureCov.numberOfTapsRequired=1;
    
    //设置手指数 单指
    
    tapGestureCov.numberOfTouchesRequired=1;
    
    // titleLabel添加手势识别
    
    [_custompro1.presentlab addGestureRecognizer:tapGestureCov];
    

    
    //试图2
    _custompro1 = [[CustomProgress alloc] initWithFrame:CGRectMake(kScreenWitdh *0.5, 10, kScreenWitdh *0.4, 20)];
    
    //_custompro1.maxValue = 10;
    //设置背景色
    _custompro1.bgimg.backgroundColor =[UIColor whiteColor];
    _custompro1.leftimg.backgroundColor =[UIColor colorWithRed:202/255.0 green:237/255.0 blue:234/255.0 alpha:1];
    //[UIColor colorWithRed:249/255.0 green:242/255.0 blue:206/255.0 alpha:1];;
   _custompro1.presentlab.textColor = [UIColor blackColor];
    [self.view addSubview:_custompro1];
    [self timer1];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClickUILable:)];
    _custompro1.presentlab.userInteractionEnabled = YES;
    tapGesture.numberOfTapsRequired=1;
    
    //设置手指数 单指
    
    tapGesture.numberOfTouchesRequired=1;
    
    // titleLabel添加手势识别
    
    [_custompro1.presentlab addGestureRecognizer:tapGesture];
    


    //试图3
    _custompro2 = [[CustomProgress alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(self.custompro1.frame)+5, kScreenWitdh *0.4, 20)];
   //  _custompro2.maxValue = 40;
    //设置背景色
    _custompro2.bgimg.backgroundColor =[UIColor whiteColor];
    _custompro2.leftimg.backgroundColor = [UIColor colorWithRed:194/255.0 green:250/255.0 blue:231/255.0 alpha:1];
    _custompro2.presentlab.textColor = [UIColor blackColor];
    [self.view addSubview:_custompro2];
   [self timer2];
    UITapGestureRecognizer *tapGesture2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClickUILable2:)];
    _custompro2.presentlab.userInteractionEnabled = YES;
    tapGesture2.numberOfTapsRequired=1;
    
    //设置手指数 单指
    
    tapGesture2.numberOfTouchesRequired=1;
    
    // titleLabel添加手势识别
    
    [_custompro2.presentlab addGestureRecognizer:tapGesture2];
    
    
    //试图4
    _custompro3 = [[CustomProgress alloc] initWithFrame:CGRectMake(kScreenWitdh *0.5, CGRectGetMinY(self.custompro2.frame), kScreenWitdh *0.4, 20)];
    
   // _custompro3.maxValue = 75;
    //设置背景色
    _custompro3.bgimg.backgroundColor =[UIColor whiteColor];
    _custompro3.leftimg.backgroundColor =[UIColor colorWithRed:253/255.0 green:223/255.0 blue:212/255.0 alpha:1];;
    _custompro3.presentlab.textColor = [UIColor blackColor];
    [self.view addSubview:_custompro3];
    [self timer3];
    UITapGestureRecognizer *tapGesture3 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClickUILable2:)];
    _custompro3.presentlab.userInteractionEnabled = YES;
    tapGesture3.numberOfTapsRequired=1;
    
    //设置手指数 单指
    
    tapGesture3.numberOfTouchesRequired=1;
    
    // titleLabel添加手势识别
    
    [_custompro3.presentlab addGestureRecognizer:tapGesture3];
    

    
    //试图5
     _custompro4 = [[CustomProgress alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(self.custompro3.frame)+5, kScreenWitdh *0.4, 20)];
    //_custompro4.maxValue = 25;
    //设置背景色
    _custompro4.bgimg.backgroundColor =[UIColor whiteColor];
    _custompro4.leftimg.backgroundColor =[UIColor colorWithRed:255/255.0 green:213/255.0 blue:218/255.0 alpha:1];;
    _custompro4.presentlab.textColor = [UIColor blackColor];
    [self.view addSubview:_custompro4];
    
    UITapGestureRecognizer *tapGestureDis = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClickUILableDis:)];
    _custompro4.presentlab.userInteractionEnabled = YES;
    tapGestureDis.numberOfTapsRequired=1;
    
    //设置手指数 单指
    
    tapGestureDis.numberOfTouchesRequired=1;
    
    // titleLabel添加手势识别
    
    [_custompro4.presentlab addGestureRecognizer:tapGestureDis];
    

    
    [self timer4];
//    //试图6
//    _custompro5 = [[CustomProgress alloc] initWithFrame:CGRectMake(kScreenWitdh *0.5, 65, kScreenWitdh *0.4, 50)];
//    _custompro5.maxValue = 7;
//    _custompro5.bgimg.backgroundColor =[UIColor whiteColor];
//    _custompro5.leftimg.backgroundColor =[UIColor colorWithRed:255/255.0 green:231/255.0 blue:240/255.0 alpha:1];;
//    _custompro5.presentlab.textColor = [UIColor blackColor];
    //[self.view addSubview:_custompro5];
   // [self timer5];

    //界面设计
    self.titLaber = [[UILabel alloc]init];
    self.titLaber.frame = CGRectMake(10, CGRectGetMaxY(_custompro4.frame)+5, kScreenWitdh * 0.5, 30);
    self.titLaber.font = [UIFont systemFontOfSize:13.0];
    self.titLaber.textColor = [UIColor grayColor];
    [self.view addSubview:_titLaber];
    
    self.titLaber.text = @"保障是否全面";
    
     self.scw = [[UIWebView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.titLaber.frame)+5, CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetHeight([UIScreen mainScreen].bounds)*0.3)];
    [self.view  addSubview:_scw];



}
//
-(void)onClickUILable1:(UITapGestureRecognizer *)sender{
    self.titLaber.text = @"个人缺少保障";
    self.s1 = self.hasnt;
    [self loadWithURLString:self.s1];

    
}
-(void)onClickUILableCov:(UITapGestureRecognizer *)sender{
    self.titLaber.text = @"保障是否全面";
    self.s1 = self.cov;
    [self loadWithURLString:self.s1];
    
    
}

-(void)onClickUILableDis:(UITapGestureRecognizer *)sender{
    self.titLaber.text = @"重大疾病保障";
    self.s1 = self.hasnt;
    [self loadWithURLString:self.s1];
    
    
}

-(void)onClickUILable:(UITapGestureRecognizer *)sender{
    self.titLaber.text = @"保费是否合理";
    self.s1 = self.strleast;
    [self loadWithURLString:self.s1];
    
    
}
-(void)onClickUILable2:(UITapGestureRecognizer *)sender{
    self.titLaber.text = @"意外保险保额";
    self.s1 = self.accident;
    [self loadWithURLString:self.s1];
    
    
}
-(void)onClickUILable3:(UITapGestureRecognizer *)sender{
    self.titLaber.text = @"重大疾病保障";
    self.s1 = self.disease;
    [self loadWithURLString:self.s1];
    
    
}
-(void)loadWithURLString:(NSString *)urlStr
{
    NSString  * content = [self.s1 stringByReplacingOccurrencesOfString:@"+" withString:@" "];
    NSString * contentTwo = [content stringByReplacingOccurrencesOfString:@"\\\"" withString:@"\""];
    
    NSString *str1 = [NSString stringWithFormat:@"<head><style> img{max-width: %fpx;max-height:330px;\n width:expression(document.body.clientWidth>%f?\"%fpx\":\"auto\";\n height:expression(document.body.clientWidth>330?\"330px\":\"auto\");\n overflow:hidden;\n} \n</style></head>",kScreenWitdh-16,kScreenWitdh-16,kScreenWitdh-16];
    //
    
    
    NSString *str2 = @"</body><html>";
    
    NSString * html = [NSString stringWithFormat:@"%@%@%@",str1,contentTwo,str2];
    //self.scw = [[UIWebView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    NSLog(@"00%@",contentTwo);
    
    [_scw loadHTMLString:html baseURL:nil];
}


-(void)timer
{
    
    if (present<=20) {
        
      
        [_custompro setPresent:6 title:@"保障是否全面" labelText:@""];
        
    }
    
}
-(void)timer1
{
    
    if (present1<=10) {
        
       
        [_custompro1 setPresent:8 title:@"保费是否合理" labelText:@""];

    }
    
}

-(void)timer2
{
    
    if (present2<=40) {
        
        [_custompro2 setPresent:30 title:@"重大疾病保额" labelText:@""];
        
    }
    
}
-(void)timer3
{
    
    if (present3<=75) {
        
        [_custompro3 setPresent:70 title:@"意外保险保额" labelText:@""];
        
    }
    
}
-(void)timer4
{
    
    if (present4<= 25) {
        
        [_custompro4 setPresent:19 title:@"个人缺少保障" labelText:@""];
        
    }
    
}
-(void)timer5
{
    
//    if (present5<= 7) {
//        
//        [_custompro5 setPresent:3 title:@"个人缺少保障" labelText:@"3分" ];
//        
//    }
    
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
