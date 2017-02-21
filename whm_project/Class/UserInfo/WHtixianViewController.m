//
//  WHtixianViewController.m
//  whm_project
//
//  Created by 王义国 on 17/2/10.
//  Copyright © 2017年 chenJw. All rights reserved.
//

#import "WHtixianViewController.h"
#import "MacroUtility.h"
#import "UIColor+Hex.h"
#import "JGProgressHelper.h"
#import "WBYwdzwViewController.h"

@interface WHtixianViewController ()<UITextFieldDelegate>
{
    UILabel * moneyLaber;
    UITextField * moneyText;
    UILabel * bankLaber;
    UITextField * bankNum;
    UILabel * nameLaber;
    UITextField * nameText;
    UIButton * tixianBut;
    UILabel * zhuyiLaber;
    UILabel * fenLaber;
    UIImageView * fuhaoImg;
    UIView  * lineView;
    UIView  * lineView1;
    UIView  * lineView2;
    
   
}
@property(nonatomic,strong)NSString * bankName;
@end

@implementation WHtixianViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatSetUI];
    
}
-(void)creatSetUI
{
    
    self.navigationItem.title = @"提现";
    moneyLaber = [[UILabel alloc]init];
    moneyLaber.frame = CGRectMake(10, 20, kScreenWitdh * 0.7, 10);
    moneyLaber.textColor = [UIColor colorWithHex:0xD9D9D9];
    moneyLaber.text = @"提现金额(最低600元)";
    moneyLaber.font = [UIFont systemFontOfSize:12.0];
    [self.view addSubview:moneyLaber];
    
    moneyText = [[UITextField alloc]init];
    moneyText.frame = CGRectMake(10, CGRectGetMaxY(moneyLaber.frame)+2, kScreenWitdh - 20 , 40);
    moneyText.borderStyle = UITextBorderStyleNone;
    moneyText.placeholder = @"最多6845元";
    moneyText.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    fuhaoImg = [[UIImageView alloc]init];
    fuhaoImg.frame = CGRectMake(0, 0, 10, 10);
    fuhaoImg.image = [UIImage imageNamed:@"fuhao"];
    moneyText.leftView = fuhaoImg;
    moneyText.leftViewMode = UITextFieldViewModeAlways;
    moneyText.keyboardType = UIKeyboardTypeNumberPad;
    
    lineView = [[UIView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(moneyText.frame), kScreenWitdh - 20, 1)];
    lineView.backgroundColor = [UIColor colorWithHex:0xD9D9D9];
    moneyText.font = [UIFont systemFontOfSize:17.0];
    [self.view addSubview:lineView];
    
    [self.view addSubview:moneyText];
    
    
    bankLaber = [[UILabel alloc]init];
    bankLaber.frame = CGRectMake(10, CGRectGetMaxY(lineView.frame)+10, kScreenWitdh * 0.2, 10);
    bankLaber.font = [UIFont systemFontOfSize:12.0];
    bankLaber.text = @"银行账号";
    bankLaber.textColor = [UIColor colorWithHex:0xD9D9D9];
    [self.view addSubview:bankLaber];
    
    bankNum = [[UITextField alloc]init];
    bankNum.frame = CGRectMake(10, CGRectGetMaxY(bankLaber.frame)+2, kScreenWitdh - 20 , 40);
    bankNum.borderStyle = UITextBorderStyleNone;
    bankNum.placeholder = @"请输入银行账号";
    bankNum.clearButtonMode = UITextFieldViewModeWhileEditing;
    bankNum.keyboardType = UIKeyboardTypeNumberPad;
    bankNum.font = [UIFont systemFontOfSize:15.0];
    
    lineView1 = [[UIView alloc]init];
    lineView1.frame = CGRectMake(10, CGRectGetMaxY(bankNum.frame), kScreenWitdh-20, 1);
    lineView1.backgroundColor = [UIColor colorWithHex:0xD9D9D9];
    [self.view addSubview:lineView1];
    
    [self.view addSubview:bankNum];
    
    nameLaber = [[UILabel alloc]init];
    nameLaber.frame = CGRectMake(10, CGRectGetMaxY(lineView1.frame)+ 10, kScreenWitdh * 0.7, 10);
    nameLaber.textColor = [UIColor colorWithHex:0xD9D9D9];
    nameLaber.text = @"开户行姓名(认证不可修改)";
    nameLaber.font = [UIFont systemFontOfSize:12.0];
    [self.view addSubview:nameLaber];
    
    nameText = [[UITextField alloc]init];
    nameText.frame = CGRectMake(10, CGRectGetMaxY(nameLaber.frame)+2, CGRectGetWidth(bankNum.frame), CGRectGetHeight(bankNum.frame));
    nameText.borderStyle = UITextBorderStyleNone;
    nameText.placeholder = @"请输入开户姓名";
    nameText.clearButtonMode = UITextFieldViewModeWhileEditing;
    nameText.font = [UIFont systemFontOfSize:15.0];
    nameText.textColor = [UIColor colorWithHex:0x666666];
    
    lineView2 = [[UIView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(nameText.frame), CGRectGetWidth(lineView1.frame), 1)];
    lineView2.backgroundColor = [UIColor colorWithHex:0xD9D9D9];
    [self.view addSubview:lineView2];
    [self.view addSubview:nameText];
    
    //
    tixianBut = [UIButton buttonWithType:(UIButtonTypeSystem)];
    tixianBut.frame = CGRectMake(30, CGRectGetMaxY(lineView2.frame)+20, kScreenWitdh-60, 36);
    [tixianBut setTitle:@"确定提现" forState:(UIControlStateNormal)];
    tixianBut.backgroundColor = [UIColor colorWithHex:0x4367FF ];
    
    tixianBut.layer.shadowOffset = CGSizeMake(1, 1);
    tixianBut.layer.shadowOpacity = 0.8;
    tixianBut.layer.shadowColor = [UIColor colorWithHex:0x4367FF ].CGColor;
    
    [tixianBut setTintColor:[UIColor whiteColor]];
    tixianBut.layer.cornerRadius = 18.0;
    [tixianBut addTarget:self action:@selector(tixianAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view  addSubview:tixianBut];

    zhuyiLaber = [[UILabel alloc]init];
    zhuyiLaber.frame = CGRectMake(50, CGRectGetMaxY(tixianBut.frame)+20, kScreenWitdh-100 - 30, 10);
    zhuyiLaber.textColor = [UIColor colorWithHex:0xD9D9D9];
    zhuyiLaber.font = [UIFont systemFontOfSize:10.0];
    zhuyiLaber.text = @"注:提现需要提供全额发票提现额度会暂扣";
    zhuyiLaber.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:zhuyiLaber];
    
    fenLaber = [[UILabel alloc]init];
    fenLaber.frame = CGRectMake(CGRectGetMaxX(zhuyiLaber.frame), CGRectGetMinY(zhuyiLaber.frame), 30, 10);
    fenLaber.textColor = [UIColor redColor];
    fenLaber.text = @"20%";
    fenLaber.textAlignment = NSTextAlignmentLeft;
    fenLaber.font = [UIFont systemFontOfSize:10.0];
    [self.view addSubview:fenLaber];
    
 
    bankNum.delegate = self;
    
   // bankNum.text = @"";
    
}



- (NSString *)returnBankName:(NSString*) idCard{
    
    if(idCard==nil || idCard.length<16 || idCard.length>19){
       
        [JGProgressHelper showError: @"卡号不合法"];
        return @"";
        
    }
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"bank" ofType:@"plist"];
    NSDictionary* resultDic = [NSDictionary dictionaryWithContentsOfFile:plistPath];
    NSArray *bankBin = resultDic.allKeys;
    
    //6位Bin号
    NSString* cardbin_6 = [idCard substringWithRange:NSMakeRange(0, 6)];
    //8位Bin号
    NSString* cardbin_8 = [idCard substringWithRange:NSMakeRange(0, 8)];
    
    if ([bankBin containsObject:cardbin_6]) {
        return [resultDic objectForKey:cardbin_6];
    }else if ([bankBin containsObject:cardbin_8]){
        return [resultDic objectForKey:cardbin_8];
    }else{
        [JGProgressHelper showError: @"该文件中不存在请自行添加对应卡种"];
        return @"";
    }
    return @"";
    
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    NSString *text = [bankNum text];
    
    NSCharacterSet *characterSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789\b"];
    string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    if ([string rangeOfCharacterFromSet:[characterSet invertedSet]].location != NSNotFound) {
        return NO;
    }
    
    text = [text stringByReplacingCharactersInRange:range withString:string];
    text = [text stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    NSString *newString = @"";
    while (text.length > 0) {
        
        NSString *subString = [text substringToIndex:MIN(text.length, 4)];
        newString = [newString stringByAppendingString:subString];
        if (subString.length == 4) {
            newString = [newString stringByAppendingString:@" "];
        }
        text = [text substringFromIndex:MIN(text.length, 4)];
    }
    
    newString = [newString stringByTrimmingCharactersInSet:[characterSet invertedSet]];
    
    // 限制长度
    if (newString.length >= 24) {
        return NO;
    }
    
    [bankNum setText:newString];
    
    return NO;
}


-(void)tixianAction:(UIButton *)sender
{
    
   NSString *numStr = [bankNum.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (moneyText.text.length > 0) {
        if ([moneyText.text intValue] >= 600) {
            
        if ([self returnBankName:numStr].length>0) {
            _bankName= [self returnBankName:numStr];
            NSLog(@"==%@",_bankName);
            
            if (nameText.text.length > 0) {
                
                id hud = [JGProgressHelper showProgressInView:self.view];
                [self.userService tixianWithUid:@"" money:moneyText.text name:nameText.text card_num:bankNum.text bank:self.bankName success:^{
                    
                    [hud hide:YES];
                    
                     
                    [JGProgressHelper showSuccess:@"提现成功"];
                    WBYwdzwViewController * zhangwu = [[WBYwdzwViewController alloc]init];
                    
                    zhangwu.strJiLu = @"1";
                    [self.navigationController pushViewController:zhangwu animated:YES];

                } failure:^(NSError *error) {
                    
                    [hud hide:YES];
                    [JGProgressHelper showError:@""];
                    
                }];
                
            }
            else
            {
                [JGProgressHelper showError:@"请输入开户人姓名"];
            }
        }
        else
        {
           
        }
        }else
        {
            [JGProgressHelper showError:@"最低提现600元"];
        }
    }else
    {
        [JGProgressHelper showError:@"请输入提现金额"];
    }
    
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
