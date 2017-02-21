//
//  ZhiFuViewController.m
//  whm_project
//
//  Created by apple on 16/12/28.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import "ZhiFuViewController.h"
#import "PayTableViewCell.h"

//#import "WBYyyZHXQViewController.h"

#import "WBYzfcgViewController.h"

@interface ZhiFuViewController ()<UITableViewDelegate,UITableViewDataSource,WXApiDelegate,UIApplicationDelegate>
{
    UITableView * myTab;
    NSArray*arr1;
    NSArray*arr2;
    NSArray*arr3;
}
@end

@implementation ZhiFuViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"支付订单";
//    arr1=@[@"支付宝支付",@"微信支付"];
//    arr2=@[@"支付宝APP客户端支付",@"微信APP客户端支付"];
//    arr3=@[@"zfb",@"wx"];
    
    arr1=@[@"支付宝支付"];
    arr2=@[@"支付宝APP客户端支付"];
    arr3=@[@"zfb"];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dianji) name:@"tiaozhuan" object:nil];
    

    
    [self creatLeftTtem];
    [self creatUI];
}

-(void)creatUI
{
    UIImageView * img = [UIImageView new];
    img.frame = CGRectMake(wScreenW/2 - 30, 30, 60, 60);
    img.image = [UIImage imageNamed:@"zf"];
    [self.view addSubview:img];
    
    CGFloat jiage ;    
    if ([_myDataModel.minus floatValue] > 0)
    {
        jiage = [_myDataModel.total_fee floatValue] - [_myDataModel.minus floatValue];
    }
    else
    {
        jiage = [_myDataModel.total_fee floatValue];
    }
    
    
    UILabel * myLab = [UILabel new];
    myLab.frame = CGRectMake(wScreenW/2-70, CGRectGetMaxY(img.frame)+8,110, 50);
    myLab.tag = 1314;
    myLab.textColor = wRedColor;
    myLab.text = [NSString stringWithFormat:@"%.2f",jiage];
    myLab.textAlignment = 1;
    myLab.font  = [UIFont systemFontOfSize:28.f];
    [self.view addSubview:myLab];
    
    
    UILabel * fuhaoLab = [UILabel new];
    fuhaoLab.frame = CGRectMake(CGRectGetMinX(myLab.frame)-20,CGRectGetMaxY(myLab.frame)-20-5, 20, 20);
    fuhaoLab.textColor = wRedColor;
    fuhaoLab.textAlignment = 2;
    fuhaoLab.text = @"￥";
    fuhaoLab.font  = [UIFont systemFontOfSize:12.f];
    [self.view addSubview:fuhaoLab];
    
//    CGFloat zhekou = [_myDataModel.discount floatValue]*10;
    
        UILabel * zhekoulab = [UILabel new];
        zhekoulab.textColor = wRedColor;
        zhekoulab.frame = CGRectMake(CGRectGetMaxX(myLab.frame), CGRectGetMaxY(img.frame)+13, 60, 20);
        zhekoulab.font = [UIFont systemFontOfSize:10.f];
    
//    if ([_myDataModel.discount floatValue] == 1)
//    {
//        zhekoulab.text = [NSString stringWithFormat:@"(立减200)"];
//    }else
//    {
//        zhekoulab.text = [NSString stringWithFormat:@"(%.1f折)",zhekou];
//    }
    
    if ([_myDataModel.minus floatValue] > 0)
    {
        zhekoulab.text = [NSString stringWithFormat:@"(立减%@)",_myDataModel.minus];
    }
    
    
    
        [self.view addSubview:zhekoulab];
    
        UILabel * yuanlab = [UILabel new];
        yuanlab.frame = CGRectMake(CGRectGetMaxX(myLab.frame), CGRectGetMaxY(zhekoulab.frame), 50, 20);
        yuanlab.textColor = wRedColor;
        yuanlab.font = [UIFont systemFontOfSize:10.f];
        yuanlab.text = @"元";
        [self.view addSubview:yuanlab];
    
        UILabel * yuanjia = [UILabel new];
        yuanjia.textColor = wRedColor;
        yuanjia.frame = CGRectMake(CGRectGetMinX(myLab.frame)-10, CGRectGetMaxY(myLab.frame),62, 25);
        yuanjia.font = [UIFont systemFontOfSize:8.f];
        yuanjia.text = [NSString stringWithFormat:@"(原价￥%ld元)",[_myDataModel.total_fee integerValue]];
    
        yuanjia.textAlignment = 1;
        [self.view addSubview:yuanjia];

        UILabel * xianlab = [UILabel new];
        xianlab.frame=CGRectMake(0, 0, 62, 1);
        xianlab.backgroundColor = wRedColor;
        xianlab.center = yuanjia.center;
    
        [self.view addSubview:xianlab];

    UILabel * lab = [UILabel new];
    lab.frame=CGRectMake(CGRectGetMaxX(xianlab.frame)+3, CGRectGetMaxY(myLab.frame), 100, 25);
    lab.textColor = wGrayColor2;
    lab.font = [UIFont systemFontOfSize:9.f];
    lab.text = @"快保家代理认证费用";
    [self.view addSubview:lab];
    
        UILabel * aLab = [UILabel new];
        aLab.frame = CGRectMake(0, CGRectGetMaxY(lab.frame)+30, wScreenW, 20);
        aLab.backgroundColor = wBaseColor;
        [self.view addSubview:aLab];
    
    
    UIView * bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, wScreenW, 70)];
    UIButton * zhifu = [UIButton buttonWithType:UIButtonTypeCustom];
    [zhifu setTitle:[NSString stringWithFormat:@"确认支付￥%@元",myLab.text] forState:UIControlStateNormal];
    zhifu.frame = CGRectMake(30, 30, wScreenW - 60, 35);
    [zhifu setTitleColor:wWhiteColor forState:UIControlStateNormal];
    zhifu.backgroundColor = wBlue;
    zhifu.layer.masksToBounds = YES;
    zhifu.layer.cornerRadius = 15;
    [zhifu addTarget:self action:@selector(zhifuqian) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:zhifu];
    
        myTab = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStylePlain];
        myTab.delegate =self;
        myTab.dataSource = self;
        [myTab setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        myTab.tableFooterView = bgView;
        [myTab registerClass:[PayTableViewCell class] forCellReuseIdentifier:@"cell"];
       [self.view addSubview:myTab];
        CGFloat hh = CGRectGetMaxY(aLab.frame);
        [myTab makeConstraints:^(MASConstraintMaker *make)
    {
            make.left.right.equalTo(0);
            make.top.equalTo(aLab.bottom);
            make.height.equalTo(wScreenH  - hh);
    }];

    
//
//    UILabel * aLab = [UILabel new];
//    aLab.backgroundColor = wBaseColor;
//    [self.view addSubview:aLab];
//    
//    myTab = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStylePlain];
//    myTab.delegate =self;
//    myTab.dataSource = self;
//    
//    [myTab setSeparatorStyle:UITableViewCellSeparatorStyleNone];
//    
//    [myTab registerClass:[PayTableViewCell class] forCellReuseIdentifier:@"cell"];
//    
//    [self.view addSubview:myTab];
//    __weak typeof (self) weakSelf = self;
//    [img makeConstraints:^(MASConstraintMaker *make)
//    {
//        make.top.equalTo(30);
//        make.width.height.equalTo(60);
//        make.centerX.mas_equalTo(weakSelf.view);
//    }];
//    
//    [myLab makeConstraints:^(MASConstraintMaker *make)
//    {
//        make.top.equalTo(img.bottom).offset(8);
//        make.left.right.equalTo(0);
//        make.height.equalTo(50);
//    }];
//    
//    [lab makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(myLab.bottom);
//        make.left.right.equalTo(0);
//        make.height.equalTo(16);
//    }];
//    [aLab makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(lab.bottom).offset(40);
//        make.left.right.equalTo(0);
//        make.width.equalTo(wScreenW);
//        make.height.equalTo(20);
//        }];
//    
//    CGFloat hh = CGRectGetMaxY(aLab.frame);
//    
//    [myTab makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.equalTo(0);
//        make.top.equalTo(aLab.bottom);
//        make.height.equalTo(wScreenH  - hh);
//        
//    }];
    
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arr1.count;
    
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    PayTableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        cell.upLab.text=arr1[indexPath.row];
        cell.downLab.text=arr2[indexPath.row];
        cell.img.image=[UIImage imageNamed:arr3[indexPath.row]];
//        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    [cell.myBtn setImage:[UIImage imageNamed:@"Jw_select"] forState:UIControlStateNormal];

    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

-(void)zhifuqian
{
    [self zhifu];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  return 50;
    
}


-(void)requestData
{
    NSMutableDictionary*dic=[NSMutableDictionary dictionary];
    [dic setObject:@"LGD_20161229110439615512" forKey:@"sworkOrderCode"];
    //    NSInteger aaa=[@"1200" floatValue]*100 ;
    [dic setObject:@"1200" forKey:@"serviceFee"];
    [dic setObject:@"old" forKey:@"ordertype"];
    
    //    if (_biaoti)
    //    {
    //        [dic setObject:_biaoti forKey:@"serviceItem"];
    //    }else
    //    {
    [dic setObject:@"测试" forKey:@"serviceItem"];
    //    }
    //    if (_miaoshu)
    //    {
    //        [dic setObject:_miaoshu forKey:@"serviceClass"];
    //
    //    }else
    //    {
    [dic setObject:@"测" forKey:@"serviceClass"];
    //    }
    //    http://192.168.1.216/WeiXinApi.asmx/CreatePrePay_id
    
//#define BASEURL @"http://intradata.shanxinyanglao.com:85/"

    NSString *url =[NSString stringWithFormat:@"%@WeiXinApi.asmx/CreatePrePay_id",@"http://intradata.shanxinyanglao.com:85/"];
    //    WeiXinApi.asmx/CreatePrePay_id
    BOOL isok=[WXApi handleOpenURL:[NSURL URLWithString:url] delegate:self];
    NSLog(@"====%d",isok);
    
    NSString *urlStr=[NSURL URLWithString:url]?url:[self strUTF8Encoding:url];
    AFHTTPSessionManager*manger=[self getAFManager];
    
    [manger POST:urlStr parameters:dic success:^(NSURLSessionDataTask *task, id responseObject)
     {
         if (responseObject)
         {
             NSMutableString *stamp  = [responseObject objectForKey:@"timestamp"];
             //调起微信支付
             PayReq* req             = [[PayReq alloc] init];
             req.partnerId           = [responseObject objectForKey:@"partnerid"];
             req.prepayId            = [responseObject objectForKey:@"prepayid"];
             req.nonceStr            = [responseObject objectForKey:@"noncestr"];
             req.timeStamp           = stamp.intValue;
             req.package             = [responseObject objectForKey:@"package"];
             
             req.sign=[responseObject objectForKey:@"sign"];
             [WXApi sendReq:req];
             
             BOOL isSuccess=[WXApi isWXAppInstalled];
             if (isSuccess==NO)
             {
                [WBYRequest showMessage:@"没有安装微信客户端"];
             }
         }else
         {
            [WBYRequest showMessage:@"未获取到json对象"];
         }
     } failure:^(NSURLSessionDataTask *task, NSError *error)
     {
         NSLog(@"=====%@",error);
     }];
}

-(void)onResp:(BaseResp *)resp
{
    NSString *strTitle;
    if ([resp isKindOfClass:[SendMessageToWXResp class]])
    {
        strTitle = [NSString stringWithFormat:@"发送媒体消息结果"];
    }
    if ([resp isKindOfClass:[PayResp class]])
    {
        strTitle = [NSString stringWithFormat:@"支付结果"];
        switch (resp.errCode)
        {
            case WXSuccess:
            {
                NSLog(@"支付结果: 成功!");
            }
                break;
            case WXErrCodeCommon:
            { //签名错误、未注册APPID、项目设置APPID不正确、注册的APPID与设置的不匹配、其他异常等
                
                NSLog(@"支付结果: 失败!");
            }
                break;
            case WXErrCodeUserCancel:
            { //用户点击取消并返回
                
            }
                break;
            case WXErrCodeSentFail:
            { //发送失败
                NSLog(@"发送失败");
            }
                break;
            case WXErrCodeUnsupport:
            { //微信不支持
                NSLog(@"微信不支持");
            }
                break;
            case WXErrCodeAuthDeny:
            { //授权失败
                NSLog(@"授权失败");
            }
                break;
            default:
                break;
        }
        
    }
}

-(AFHTTPSessionManager *)getAFManager
{
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    //     manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    manager.responseSerializer = [AFJSONResponseSerializer serializer];//设置返回数据为json
    manager.requestSerializer.stringEncoding = NSUTF8StringEncoding;
    manager.requestSerializer.timeoutInterval=10;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"application/json",
                                                                              @"text/html",
                                                                              @"text/json",
                                                                              @"text/plain",
                                                                              @"text/javascript",
                                                                              @"text/xml",
                                                                              @"image/*"]];
    return manager;
    
}


-(NSString *)strUTF8Encoding:(NSString *)str
{
    return [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

-(void)zhifu
{
    /*
    NSString *partner = @"2088321011137575";
    NSString *seller = @"327392652@qq.com";
    NSString *privateKey = @"MIICXAIBAAKBgQDBNma3AjiUReEaeWI/64Ks1AMPJ94819P21WODXJ1sgWivJL44ajMH+ughcn+LbwucdpTH/ECgjOqQnDUk9suwcSR2Hu/JkiDh+ow6CQNPphxUN2pDiOF72ZA+cfE2xLyLUb3qvTtJsVbXnik0pLUHo1aPbgL5uvnbMVzwyccFLQIDAQABAoGAXQCMrKbbCTQhyJaJHm+EtSBQYKk2Jl9VXkkU35RjCmm4NCYhkhI8gijaN89faYSIOEY0E5dunFl4RyeJxUMug+a9UVKEu5qSON58mE4CWTEo97EEvv91w6hE+kFTxxaBU3XoPusWGUUWiK2d2Fl8wMOVrYj+mqKIPtIOCVASatkCQQD0p1rltuPOCk4CJQsOkQZSvlexx21zhySCjNyW9UTJ+em0jPXbOBN+QYFg/bPeVdR3yxVP8DVEaRLkEqLRCveTAkEAyixPwyFg/ebdlcatDNR8bCpqe3Ceo58I6juZgasyP8SclsANWOhAFyLsapgdwmtBxkv9ycWtOnlVvwqOpfqIPwJASfO0dC9+WK+guOE9oF+SC7zhgSmJGhzFmni9zRvCeVMDo8HgJy2iJs3iL9FAZ3qGSNeoT4uKbm1cenhvosSv5QJAB6D+bYWP7GTOzb0OgKJwA4DiPcA1LEVvB6+yDjOQlNltcz7SAh3ZdUYLF8afsNttQvdRH1EHRWKYurnCQj8e7wJBAJUTfAF3cCKU8PmrpGxyXuuyKnznaGBHM/GEspvUx85Ch6arASwasmdAchAnRnI1r4AOhtBate9iXZIfRz8aFcI=";*/
    
    

    NSString *partner = @"2088121127399832";
    NSString *seller = @"kuaibaojia@163.com";
  NSString*privateKey=@"MIIEvwIBADANBgkqhkiG9w0BAQEFAASCBKkwggSlAgEAAoIBAQCAWm0IlcHH2jomjYszzXAbjVR4bJZ8usztoxtLbSTCeimI/Th69FquZ7icCrlMxzT919W1RdYoFzGGnCkz5e9eqVX27326yNBmQxhGAH7JPczJQLGqhMDLHpYccGLrEk+MnTUkp6k0jqvfyP7ZJdpcEx2QHLX6WoFEH6P8dEuVjCOQ8B5mJbVds6aTqUy/0gLvJPJwxTub38PRAPl37BhW+fmzipws4C38Dk3ZsOSm02tJcjcBdcPD3rtYtHnOOiw/iVYq3mRxdUIpy/ei6ALGIN8Zl8Id47das/TKtPAj7xQYKouA3yOkBpzPzkZxS0IGrIomyZZYET5lbid2rQ5RAgMBAAECggEABEqBoKrZCqRqE0XiJH42xEUKUOhYc50PIta0H+ZrNzE8WD8W901aBsCi9FyLa1yxkdb4ZxIJodd8qWJpIjoKsaB5pkLFckwqY3DUy+pSUsoFIalPB0Ne6quAGz1KoU9AZ5QN5cbRKlemuVmP45SXY0KkV2AOWWtTLQLdyZ/dswcrPeOElqM6b/gRnKCoIS6iiWSZzY5+dthqURgDLKcMwZQfo6o53ZoeLXj1jV/RTc/rxnCp9i+hmNlu914y9gP4W9lFU7CsKmH8jidnXcT+5CPAEiOqbP1H1c6sGRq1y1iqnguYniFT2+uN6vPI/iqVypPK7MVr0Kdtc/JSEQdmkQKBgQC4oeCIi9mA9PJmXBc1/WoP3MO8YUCmf2eymrx+okLNO6gjEWtrL6LuZhljgs5yM/uxqvuW3hI0a0fU3aii6i8hhK4rZJLqUbaw/WcYIZJIgpfv4yrjVyTztu68Wc1ZZAb1+AZBIGyThSBejg/rPOIL5PC0wFZ9QsUxc5eMDDRt/QKBgQCx94BmC9wlFHPzXuo3QpvcKuaBK+AvEZ3nrHkG94Toa0De9CkPl7Svr0ub5lKnEhJPmfjbZPwQSHY0yalNsZNaNBBtJSuYnPsZKSCTp53byBNAFHSEB9w6kwC0M9GibVzYwVu2fLrFuNktBZrXw3l1FyZVoFzUXxzVhJ4rypPH5QKBgQCar2zJmblplE69uWvs3NqOXZxT6Hrcw6MifQdtZQ5omhGdB8wiai+sYjflKkNCZRD7YlAUrws7haIR0n+ltmQ0RdASJNn9nOZd1IAaNI41V8xpu75D58/arCnJ/cbQnMBENT8wMzUkRwW+knD92e1cn7uXBAmyOk2xx7FxMQyAFQKBgQCuZr2NQ1IZhFGczgb44G2c9O2u6DBp7/mub3arPSUiHvkThHI4tZJ8GG0f+jZFQ5BuMZWOawgZbOlqEbW4Taz5WMxAKYzvoebwYT1rdXddSlSTF3iXapyHSkgGUEG/yyyRvesCinj+CofJdxSnHQiJloYao2xVMmAvXicjAwKPgQKBgQCMhAGjw6IG8o1uZXy93s3KpzWz6p43rCFhWmJCZmC57d2tvUaQ2ZbQb2qYFrpaZhSBDtJqoJSNCmptYfBf7YxnO9fqvUYA15invoO+zy0i6F4D3hnYRGymEEzXT6qL1ZiVwGdXXR1FmSVP08W67T54x7K/pp4gfqQvKpCedUvatA==";    
    //partner和seller获取失败,提示
    if ([partner length] == 0 ||
        [seller length] == 0 ||
        [privateKey length] == 0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"message:@"缺少partner或者seller或者私钥。"delegate:self cancelButtonTitle:@"确定"otherButtonTitles:nil];
        [alert show];
        
        return;
    }
    
   //  CGFloat jiage = [_myDataModel.total_fee floatValue] * [_myDataModel.discount floatValue];
    
    UILabel * lab = [self.view viewWithTag:1314];
    //将商品信息赋予AlixPayOrder的成员变量
    Order *order = [[Order alloc] init];
    order.partner = partner;
    order.sellerID = seller;
    order.outTradeNO = _myDataModel.out_trade_no; //订单编号
    order.subject =_myDataModel.title;//商品标题
    order.body = _myDataModel.remark; //商品描述了；
    
    
    order.totalFee = [NSString stringWithFormat:@"%@",lab.text];// 商品价格
    
   // order.totalFee = [NSString stringWithFormat:@"0.01"];

    order.notifyURL = [NSString stringWithFormat:@"http://w.kuaibao365.com/pay/ali"]; //回调URL
    order.service = @"mobile.securitypay.pay";
    order.paymentType = @"1";
    order.inputCharset = @"utf-8";
    order.itBPay = @"30m";
    order.showURL = @"m.alipay.com";
    //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
    NSString *appScheme = @"fastprotecthome";
    //将商品信息拼接成字符串
    NSString *orderSpec = [order description];
    //NSLog(@"orderSpec = %@",orderSpec);
    
    id <DataSigner> signer = CreateRSADataSigner(privateKey);
    NSString *signedString = [signer signString:orderSpec];
    NSString *orderString = nil;
    
    
    if (signedString != nil)
    {
        orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",orderSpec, signedString, @"RSA"];
        
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic)
         {
             NSString*str=resultDic[@"resultStatus"];
             
             if ([str isEqualToString:@"4000"])
             {
                [WBYRequest showMessage:@"请安装支付宝客户端"];
             }
            }];
    }
}

-(void)dianji
{
    [self.navigationController pushViewController:[WBYzfcgViewController new] animated:YES];
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
