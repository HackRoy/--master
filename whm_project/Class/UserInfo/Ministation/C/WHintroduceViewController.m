//
//  WHintroduceViewController.m
//  whm_project
//
//  Created by 王义国 on 16/10/29.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import "WHintroduceViewController.h"
#import "JGProgressHelper.h"
#import "WHgetintroduce.h"
#import "UIColor+Hex.h"

@interface WHintroduceViewController ()<UITextViewDelegate>
@property(nonatomic,strong)UITextView * Mytextview;
@property(nonatomic,strong)NSMutableArray * dataArry;
@property(nonatomic,strong)UIButton * myBut;


@end

@implementation WHintroduceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
}
-(void)viewWillAppear:(BOOL)animated
{
    [self setData];
}

//数据请求
-(void)setData
{
    id hud = [JGProgressHelper showProgressInView:self.view];
    [self.dataService getintroduceWithUid:@"" success:^(NSArray *lists) {
        [hud hide:YES];
        self.dataArry = [NSMutableArray arrayWithArray:lists];
        for (WHgetintroduce * model in self.dataArry) {
          //  NSLog(@"====%@",model.introduce);
            self.Mytextview.text = model.introduce;
        }
        
        
    } failure:^(NSError *error) {
        [hud hide:YES];
        [JGProgressHelper showError:@""];
        
    }];
    
    
    
    
}

-(void)setUI
{
    self.Mytextview = [[UITextView alloc]init];
    self.Mytextview.frame = CGRectMake(10, 10, CGRectGetWidth([UIScreen mainScreen].bounds)-20, CGRectGetHeight([UIScreen mainScreen].bounds)*0.3);
    self.Mytextview.textColor = [UIColor grayColor];
    self.Mytextview.font = [UIFont fontWithName:@"Arial" size:16.0];//设置字体名字和字体大小
    
    self.Mytextview.delegate = self;//设置它的委托方法
    
    self.Mytextview.backgroundColor = [UIColor whiteColor];//设置它的背景颜色
    self.Mytextview.scrollEnabled = YES;//是否可以拖动
    self.Mytextview.autoresizingMask = UIViewAutoresizingFlexibleHeight;//自适应高度
    
    [self.view addSubview:_Mytextview];
    
   // self.navigationItem .rightBarButtonItem =[[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(right:)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"eduit"] style:(UIBarButtonItemStylePlain) target:self action:@selector(right:)];
    
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
    tap1.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tap1];
    
    self.navigationItem.title = @"个人介绍";
   // self.Mytextview.backgroundColor = [UIColor grayColor];
    
    self.myBut = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.myBut.frame = CGRectMake(10,CGRectGetMaxY(self.Mytextview.frame)+10, CGRectGetWidth([UIScreen mainScreen].bounds)-20, 40);
    [self.myBut setTitle:@"确认修改" forState:(UIControlStateNormal)];
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
    if (self.Mytextview.text != 0) {
        
        id hud = [JGProgressHelper showProgressInView:self.view];
        
        [self.userService save_introduceWithUid:@"" introduce:self.Mytextview.text success:^{
            [hud hide:YES];
            [JGProgressHelper showSuccess:@"修改成功"];
            [self.navigationController popViewControllerAnimated:YES];
            
         } failure:^(NSError *error) {
            
            [hud hide:YES];
            [JGProgressHelper showError:@"保存失败"];
        }];
        
        
        
    }
    else
    {
        [JGProgressHelper showError:@"请填写个人介绍内容"];
        
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


-(void)right:(UIBarButtonItem *)sender
{
    
//    if (self.Mytextview.text != 0) {
//        
//        id hud = [JGProgressHelper showProgressInView:self.view];
//        
//        [self.userService save_introduceWithUid:@"" introduce:self.Mytextview.text success:^{
//            [hud hide:YES];
//            [JGProgressHelper showSuccess:@"保存成功"];
//            
//            
//        } failure:^(NSError *error) {
//            
//            [hud hide:YES];
//            [JGProgressHelper showError:@"保存失败"];
//        }];
//        
//        
//        
//    }
//    else
//    {
//        [JGProgressHelper showError:@"请填写个人介绍内容"];
//        
//    }
//
    self.Mytextview.backgroundColor = [UIColor lightGrayColor];
    
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
