//
//  WHsexViewController.m
//  whm_project
//
//  Created by 王义国 on 16/10/22.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import "WHsexViewController.h"

@interface WHsexViewController ()<UIPickerViewDataSource,UIPickerViewDelegate>
@property(nonatomic,strong)UIPickerView *pickciew ;

@property(nonatomic,strong)NSArray * sexArray;

@property(nonatomic,strong)UILabel * myLaber;
@property(nonatomic,strong)UITextField * myText;

@end

@implementation WHsexViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self SetUi];
    
    self.myText = [[UITextField alloc]init];
    self.myText.frame = CGRectMake(0 , 60, CGRectGetWidth([UIScreen mainScreen].bounds)  , 50);
    self.myText.placeholder = @"请选择性别";
    self.navigationItem.title = @"性别";
    self.myText.borderStyle = UITextBorderStyleNone;
    
    self.myText.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.myText setBorderStyle:UITextBorderStyleRoundedRect];
    // self.myText.keyboardType = UIKeyboardTypeNumberPad;
    
    [self.view addSubview:_myText];
    //键盘隐藏事件
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
    tap1.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tap1];
    
    
    self.navigationItem .leftBarButtonItem =[[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(left:)];
}

//隐藏键盘事件
-(void)viewTapped:(UITapGestureRecognizer*)tap1
{
    
    [self.view endEditing:YES];
}

//性别的选取UI
-(void)SetUi
{
    self.pickciew = [[UIPickerView alloc]initWithFrame:CGRectMake(CGRectGetWidth(self.view.frame)*0.05, CGRectGetHeight(self.view.frame)*0.45 , CGRectGetWidth(self.view.frame)*0.8, CGRectGetHeight(self.view.frame)*0.1)];
    self.pickciew.delegate = self;
    self.pickciew.dataSource = self;
    [self.view addSubview:_pickciew];
    [self.pickciew reloadAllComponents];
    self.sexArray = [NSArray arrayWithObjects:@"男",@"女", nil];
    
    
    
    
}

-(NSInteger )pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.sexArray.count;
}

-(NSInteger )numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    
    return 1;
}

-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 30;
}

-(CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    
    
    return 100;
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    
    self.myText.text = [self.sexArray objectAtIndex:row];
    
    //self.pickciew.hidden = YES;
    
}

-(UIView *) pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    if (!view) {
        view = [[UIView alloc]init];
    }
    
    
    UILabel * text = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width/2, 20)];
    text.textAlignment = NSTextAlignmentCenter;
    text.text = [self.sexArray objectAtIndex:row];
    
    [view addSubview:text];
    return view;
}

-(void)left:(UIBarButtonItem *)sender
{
    if (self.myText.text != nil) {
        self.mblock1 (self.myText.text);
    }
    
    [self.navigationController popViewControllerAnimated:YES];
    
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
