//
//  WHaddressDetalViewController.m
//  whm_project
//
//  Created by 王义国 on 16/10/21.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import "WHaddressDetalViewController.h"

@interface WHaddressDetalViewController ()
@property(nonatomic,strong)UILabel * myLaber;
@property(nonatomic,strong)UITextField * myText;
@end

@implementation WHaddressDetalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.myText = [[UITextField alloc]init];
    self.myText.frame = CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds)  , 50);
    //self.myText.placeholder = @"请输入详细地址";
   
    
    NSString *holderText = @"请输入详细地址";
    NSMutableAttributedString *placeholder = [[NSMutableAttributedString alloc]initWithString:holderText];
    [placeholder  addAttribute:NSForegroundColorAttributeName
                       value:[UIColor grayColor]
                       range:NSMakeRange(0, holderText.length)];
    [placeholder  addAttribute:NSFontAttributeName
                       value:[UIFont  boldSystemFontOfSize:19]
                       range:NSMakeRange(0, holderText.length)];
   self.myText.attributedPlaceholder = placeholder;
    
    
    
    
    //self.myText.font = [UIFont systemFontOfSize:<#(CGFloat)#>]
    self.navigationItem.title = @"详细地址";
    //self.myText.backgroundColor = [UIColor redColor];
    self.myText.borderStyle = UITextBorderStyleNone;
    
    self.myText.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.myText setBorderStyle:UITextBorderStyleRoundedRect];
    // self.myText.keyboardType = UIKeyboardTypeNumberPad;
    
    [self.view addSubview:_myText];
    //键盘隐藏事件
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
    tap1.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tap1];
    
    
    self.navigationItem .rightBarButtonItem =[[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(left:)];
}
-(void)left:(UIBarButtonItem *)sender
{
    if (self.myText.text != nil) {
        self.mblock1 (self.myText.text);
    }
    
    [self.navigationController popViewControllerAnimated:YES];
    
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
