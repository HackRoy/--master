//
//  WHshenheViewController.m
//  whm_project
//
//  Created by 王义国 on 17/2/12.
//  Copyright © 2017年 chenJw. All rights reserved.
//

#import "WHshenheViewController.h"
#import "MacroUtility.h"
#import "UIColor+Hex.h"
@interface WHshenheViewController ()<UITextFieldDelegate>
{
    UILabel * shenLaber;
    UILabel * moneyLaber;
    UILabel * moneyText;
    UILabel * bankLaber;
    UILabel * bankNum;
    UILabel * nameLaber;
    UILabel * nameText;
    UILabel * timeLaber;
    UILabel  * timeTijiao;
    UILabel * zhuyiLaber;
    UILabel * fenLaber;
    UIImageView * fuhaoImg;
    UIView  * lineView;
    UIView  * lineView1;
    UIView  * lineView2;
    UIView  * lineView3;

    NSMutableArray * dataArry;
    
}

@end

@implementation WHshenheViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    dataArry = [NSMutableArray array];
//    [self creatRequart];
    
    [self creatLeftTtem];
    [self ceratSetUI];
    
}

-(void)ceratSetUI
{
 
    
    self.navigationItem.title = @"提现";
    shenLaber = [[UILabel alloc]init];
    shenLaber.frame = CGRectMake(kScreenWitdh * 0.4, 20, kScreenWitdh * 0.2, kScreenWitdh * 0.2);
    shenLaber.text = @"审核中";
    shenLaber.textColor = [UIColor colorWithHex:0x28D68E];
    shenLaber.textAlignment = NSTextAlignmentCenter;
    shenLaber.font = [UIFont systemFontOfSize:15.0];
    shenLaber.layer.masksToBounds = YES;
    shenLaber.layer.cornerRadius = kScreenWitdh * 0.1;
    shenLaber.layer.borderColor = [UIColor lightGrayColor].CGColor;
    shenLaber.layer.borderWidth = 1;
    
    [self.view addSubview:shenLaber];
    //
    moneyLaber = [[UILabel alloc]init];
    moneyLaber.frame = CGRectMake(10, CGRectGetMaxY(shenLaber.frame)+ 20, kScreenWitdh * 0.7, 10);
    moneyLaber.textColor = [UIColor colorWithHex:0xD9D9D9];
    moneyLaber.text = @"提现金额(最低600元)";
    moneyLaber.font = [UIFont systemFontOfSize:12.0];
    [self.view addSubview:moneyLaber];
    
    moneyText = [[UILabel alloc]init];
    moneyText.frame = CGRectMake(30, CGRectGetMaxY(moneyLaber.frame)+5, kScreenWitdh*0.7 , 40);
  
    fuhaoImg = [[UIImageView alloc]init];
    fuhaoImg.frame = CGRectMake(10, CGRectGetMaxY(moneyLaber.frame)+20, 10, 10);
    fuhaoImg.image = [UIImage imageNamed:@"fuhao"];
    
    
    lineView = [[UIView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(moneyText.frame), kScreenWitdh - 20, 1)];
    lineView.backgroundColor = [UIColor colorWithHex:0xD9D9D9];
    moneyText.font = [UIFont systemFontOfSize:17.0];
    [self.view addSubview:lineView];
    [self.view addSubview:fuhaoImg];
    
    [self.view addSubview:moneyText];
    
    
    bankLaber = [[UILabel alloc]init];
    bankLaber.frame = CGRectMake(10, CGRectGetMaxY(lineView.frame)+10, kScreenWitdh * 0.2, 10);
    bankLaber.font = [UIFont systemFontOfSize:12.0];
    bankLaber.text = @"银行账号";
    bankLaber.textColor = [UIColor colorWithHex:0xD9D9D9];
    [self.view addSubview:bankLaber];
    
    bankNum = [[UILabel alloc]init];
    bankNum.frame = CGRectMake(10, CGRectGetMaxY(bankLaber.frame)+2, kScreenWitdh - 20 , 30);
   
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
    
    nameText = [[UILabel alloc]init];
    nameText.frame = CGRectMake(10, CGRectGetMaxY(nameLaber.frame)+2, CGRectGetWidth(bankNum.frame), CGRectGetHeight(bankNum.frame));
    nameText.font = [UIFont systemFontOfSize:15.0];
    nameText.textColor = [UIColor colorWithHex:0x666666];
    
    lineView2 = [[UIView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(nameText.frame), CGRectGetWidth(lineView1.frame), 1)];
    lineView2.backgroundColor = [UIColor colorWithHex:0xD9D9D9];
    [self.view addSubview:lineView2];
    [self.view addSubview:nameText];
    
    //
  
    timeLaber = [[UILabel alloc]init];
    timeLaber.frame = CGRectMake(10, CGRectGetMaxY(lineView2.frame)+ 10, kScreenWitdh * 0.5, 10);
    timeLaber.textColor = [UIColor colorWithHex:0xD9D9D9];
    timeLaber.text = @"提交时间";
    timeLaber.font = [UIFont systemFontOfSize:12.0];
    [self.view addSubview:timeLaber];
    
    timeTijiao = [[UILabel alloc]init];
    timeTijiao.frame = CGRectMake(10, CGRectGetMaxY(timeLaber.frame)+2, CGRectGetWidth(nameText.frame), CGRectGetHeight(nameText.frame));
    timeTijiao.font = [UIFont systemFontOfSize:15.0];
    timeTijiao.textColor = [UIColor colorWithHex:0x666666];
    [self.view addSubview:timeTijiao];
    
    lineView3 = [[UIView alloc]init];
    lineView3.frame = CGRectMake(10, CGRectGetMaxY(timeTijiao.frame), CGRectGetWidth(lineView.frame), 1);
    lineView3.backgroundColor = [UIColor colorWithHex:0xD9D9D9];
    [self.view addSubview:lineView3];
    
    //
    zhuyiLaber = [[UILabel alloc]init];
    zhuyiLaber.frame = CGRectMake(50, CGRectGetMaxY(lineView3.frame)+20, kScreenWitdh-100 , 10);
    zhuyiLaber.textColor = [UIColor colorWithHex:0xD9D9D9];
    zhuyiLaber.font = [UIFont systemFontOfSize:10.0];
    zhuyiLaber.text = @"注:提现需要提供全额发票";
    zhuyiLaber.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:zhuyiLaber];
    
    fenLaber = [[UILabel alloc]init];
    fenLaber.frame = CGRectMake(70, CGRectGetMaxY(zhuyiLaber.frame)+3, kScreenWitdh - 140  , 10);
    fenLaber.textColor = [UIColor colorWithHex:0xD9D9D9];
    fenLaber.text = @"提现额度会暂扣20%";
    fenLaber.textAlignment = NSTextAlignmentCenter;
    fenLaber.font = [UIFont systemFontOfSize:10.0];
    [self.view addSubview:fenLaber];
    
                 moneyText .text = _model.money;
                 nameText.text = _model.name;
                 bankNum.text = _model.card_num;
    
                 timeTijiao.text = [WBYRequest timeStr:_model.create_time];


    
}

//-(void)creatRequart
//{
//    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
//    [dic setObject:[WBYRequest jiami:@"kbj/get_cash"] forKey:@"kb"];
//    [dic setObject:[JwUserCenter sharedCenter].uid forKey:@"uid"];
//    [dic setObject:self.financeID forKey:@"finance_id"];
//    [dic setObject:[JwUserCenter sharedCenter].key forKey:@"token"];
//    
//    [WBYRequest wbyPostRequestDataUrl:@"kbj/get_cash" addParameters:dic success:^(WBYReqModel *model)
//     {
//         if ([model.err isEqualToString:SAME])
//         {
//             TONGZHI
//         }
//         
//         if ([model.err isEqualToString:TURE])
//         {
//             [dataArry addObjectsFromArray:model.data];
//             DataModel * model = dataArry[0];
//             moneyText .text = model.money;
//             nameText.text = model.name;
//             bankNum.text = model.card_num;
//             
//             timeTijiao.text = [WBYRequest timeStr:model.create_time];
//             
//             
//         }
//         else
//         {
//          [WBYRequest showMessage:@"没有数据"];
//         }
//     }
//    failure:^(NSError *error){
//        
//    } isRefresh:NO];
//    
//}
//
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}


@end
