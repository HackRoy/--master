//
//  WHpesfporViewController.m
//  whm_project
//
//  Created by 王义国 on 16/11/22.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import "WHpesfporViewController.h"
#import "WHperView.h"
#import "UIColor+Hex.h"
#import "ASBirthSelectSheet.h"
#import "JGProgressHelper.h"

@interface WHpesfporViewController ()<UITextFieldDelegate>
@property(nonatomic,strong)WHperView * per;

@end

@implementation WHpesfporViewController

-(void)loadView
{
    self.per = [[WHperView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.view = _per;
    //self.per.dateText.delegate = self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"完善保单";
    self.view.backgroundColor = [UIColor colorWithHex:0xF5F7F9];
    [self setUI];
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
//ui设计
-(void)setUI
{
    self.per.comNameText.text = self.comName;
    self.per.nameText.text = self.strName;
    self.per.comNameText.enabled = false; //禁止编辑
    self.per.nameText.enabled = false;
    [self.per.nextBut addTarget:self action:@selector(nextButAction:) forControlEvents:(UIControlEventTouchUpInside)];
   
    
    UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClickUILable:)];
    self.per.cleckImg.userInteractionEnabled = YES;
    tapGesture.numberOfTapsRequired = 1 ;
    tapGesture.numberOfTouchesRequired = 1 ;
    [self.per.cleckImg addGestureRecognizer:tapGesture];
    

    
}
//开始确认提交事件
-(void)nextButAction:(UIButton *)sender
{
    if (self.per.ProNumText.text.length != 0) {
        if (self.per.peopText.text.length != 0) {
            if (self.per.beneText.text.length != 0) {
                if (self.per.dateText.text.length != 0) {
                    
                id hud = [JGProgressHelper showProgressInView:self.view];
                  [self.userService updatePolicyWithId:self.reID uid:@"" sn_no:self.per.ProNumText.text start_date:self.per.dateText.text holder:self.per.peopText.text beneficiary:self.per.beneText.text success:^{
                      [hud hide:YES];
                      [JGProgressHelper showSuccess:@"提交成功"];
                      [self.navigationController popViewControllerAnimated:YES];
                      
                      
                  } failure:^(NSError *error) {
                      [hud hide:YES];
                      [JGProgressHelper showError:@"提交失败"];
                      
                  }];
                    
                }
                else
                {
                    [JGProgressHelper showError:@"请选择生效日期"];
                }
                
            }
            else
            {
                [JGProgressHelper showError:@"请输入受益人"];
            }
        }
        else
        {
            [JGProgressHelper showError:@"请输入投保人"];
        }
    }
    else
    {
        [JGProgressHelper showError:@"请输入保单号"];
    }
    
}

//响应点击事件
-(void)onClickUILable:(UITapGestureRecognizer *)sender
{

    ASBirthSelectSheet *datesheet = [[ASBirthSelectSheet alloc] initWithFrame:self.view.bounds];
   // datesheet.selectDate = cell.detailTextLabel.text;
    datesheet.GetSelectDate = ^(NSString *dateStr)
    {
       self.per.dateText.text = dateStr;
    };
    
    
    [self.view addSubview:datesheet];


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
