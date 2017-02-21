//
//  WHnewsdetailViewController.m
//  whm_project
//
//  Created by 王义国 on 16/12/6.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import "WHnewsdetailViewController.h"
#import "MacroUtility.h"
#import <UIImageView+WebCache.h>
#import "UIColor+Hex.h"
#import "JGProgressHelper.h"
#import "WHgetnewsdetail.h"
#import "UMSocial.h"
#import "YCXMenu.h"
#import "WHwantMessageViewController.h"
#define BASE_REST_URL @"https://www.kuaibao365.com/news/details"


@interface WHnewsdetailViewController ()<UIWebViewDelegate,UMSocialUIDelegate>
@property(nonatomic,strong)UIView * headView ;
@property(nonatomic,strong)UIImageView * headImage;
@property(nonatomic,strong)UILabel * nameLaber;
@property(nonatomic,strong)UIImageView * sexImage;
@property(nonatomic,strong)UILabel * yearLaber;
@property(nonatomic,strong)UILabel * companyLaber;
@property(nonatomic,strong)UIButton * messBut;
@property(nonatomic,strong)UIButton * telBut;
@property(nonatomic,strong)UIView * lineView;
@property(nonatomic,strong)UILabel * titleLaber;
@property(nonatomic,strong)UILabel * timeLaber;
@property(nonatomic,strong)UILabel * numRead;
@property(nonatomic,strong)UIView * lineView2;
@property(nonatomic,strong)UIWebView * scw ;
@property(nonatomic,strong)NSString * s1 ;
@property(nonatomic,assign)NSInteger  i ;
@property (nonatomic, copy) NSString *url;
@property (nonatomic , strong) NSMutableArray *items;
@property(nonatomic,strong)NSString * imgUrl;



@end

@implementation WHnewsdetailViewController
@synthesize items = _items;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self SetupUI];
    
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self quretData];
}

-(void)quretData
{
    if (self.newsHeadimg.length == 0) {
        self.headImage.image = [UIImage imageNamed:@"Jw_user"];
    }
    else
    {
        [self.headImage sd_setImageWithURL:[NSURL URLWithString:self.newsHeadimg]];
    }
    self.nameLaber.text = self.newsName;
    NSInteger  a = [self.newsSeximg integerValue];
    if (a == 1) {
        self.sexImage.image = [UIImage imageNamed:@"test_male"];
        
    }else
    {
        self.sexImage.image = [UIImage imageNamed:@"test_famale"];
    }
    self.yearLaber.text = self.newsYear;
    self.companyLaber.text = self.newsCompany;
    //数据请求
    id hud = [JGProgressHelper showProgressInView:self.view];
    [self.dataService getnewsdetailWithNews_id:self.newsID success:^(NSArray *lists) {
        [hud hide:YES];
        
        for (WHgetnewsdetail * model in lists ) {
            NSLog(@"%@",model.title);
            self.titleLaber.text = model.title;

            NSString * s1 = model.created_time;
            self.timeLaber.text = [s1 substringToIndex:11];
            NSString * s2 = @"阅读";
            self.numRead.text = [model.count stringByAppendingString:s2];
            self.s1 = model.content;
            [self loadWithURLString:self.s1];
            self.imgUrl = model.thumbnail;
            
        }
        
    } failure:^(NSError *error) {
        
    }];
    
    
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

-(void)SetupUI
{
    self.title = @"最新资讯";
    self.headView  = [[UIView alloc]init];
    self.headView .frame = CGRectMake(0, 0, kScreenWitdh , kScreenHeight * 0.20);
    [self.view addSubview:_headView ];
    self.headImage = [[UIImageView alloc]init];
    self.headImage.frame = CGRectMake(10, 10, kScreenWitdh * 0.15, kScreenWitdh *0.15);
    self.headImage.layer.masksToBounds = YES;
    self.headImage.layer.cornerRadius = kScreenWitdh *0.075;
    // self.headImage.image = [UIImage imageNamed:@"test_head"];
   // self.headView.backgroundColor = [UIColor redColor];
    [self.headView addSubview:_headImage];
    self.nameLaber = [[UILabel alloc]init];
    self.nameLaber.frame = CGRectMake(CGRectGetMaxX(self.headImage.frame)+5, CGRectGetMinY(self.headImage.frame), kScreenWitdh* 0.15, kScreenWitdh * 0.08);
    //self.nameLaber.text = @"周星星";
    self.nameLaber.font = [UIFont systemFontOfSize:15.0];
    [self.headView addSubview:_nameLaber];
    //
    self.sexImage = [[UIImageView alloc]init];
    self.sexImage.frame = CGRectMake(CGRectGetMaxX(self.nameLaber.frame)+3, CGRectGetMinY(self.nameLaber.frame)+3, 20, 20);
    //self.sexImage.image = [UIImage imageNamed:@"test_male"];
    [self.headView addSubview:_sexImage];
    
    //
    self.yearLaber = [[UILabel alloc]init];
    self.yearLaber.frame = CGRectMake(CGRectGetMaxX(self.sexImage.frame)+3, CGRectGetMinY(self.sexImage.frame), kScreenWitdh * 0.1, 20);
    self.yearLaber.textColor = [UIColor grayColor];
    self.yearLaber.font = [UIFont systemFontOfSize:13.0];
    // self.yearLaber.text = @"36岁";
    [self.headView addSubview:_yearLaber];
    //
    self.companyLaber = [[UILabel alloc]init];
    self.companyLaber.frame = CGRectMake(CGRectGetMinX(self.nameLaber.frame),CGRectGetMaxY(self.nameLaber.frame),  kScreenWitdh * 0.4, 20);
    // self.companyLaber.text = @"新华人寿 经理 从业5年 全国";
    self.companyLaber.font = [UIFont systemFontOfSize:11.0];
    self.companyLaber.textColor = [UIColor grayColor];
    [self.headView addSubview:_companyLaber];
    //
    self.messBut = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.messBut.frame = CGRectMake(kScreenWitdh * 0.75, CGRectGetMidY(self.nameLaber.frame), 30, 30);
    [self.messBut setBackgroundImage:[UIImage imageNamed:@"message"] forState:(UIControlStateNormal)];
    self.messBut.layer.cornerRadius = 15.0;
    [self.headView addSubview:_messBut];
    [self.messBut addTarget:self action:@selector(messageAction:) forControlEvents:(UIControlEventTouchUpInside)];
    //
    self.telBut = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.telBut.frame = CGRectMake(kScreenWitdh * 0.85, CGRectGetMidY(self.nameLaber.frame), 30, 30);
    [self.telBut setBackgroundImage:[UIImage imageNamed:@"tel"] forState:(UIControlStateNormal)];
    self.telBut.layer.cornerRadius = 15.0;
    [self.headView addSubview:_telBut];
    [self.telBut addTarget:self action:@selector(telAction:) forControlEvents:(UIControlEventTouchUpInside)];
   //
    self.lineView = [[UIView alloc]init];
    self.lineView.frame = CGRectMake(0,kScreenHeight * 0.15 - 20, kScreenWitdh , 20);
    self.lineView.backgroundColor = [UIColor colorWithHex:0xD9D9D9];
    //[self.headView addSubview:_lineView];
    //
   
    //
    self.titleLaber = [[UILabel alloc]init];
    self.titleLaber.frame = CGRectMake(10, CGRectGetMaxY(self.telBut.frame)+2, kScreenWitdh-20, 30);
    [self.headView addSubview:_titleLaber];
    //
    self.timeLaber = [[UILabel alloc]init];
    self.timeLaber.frame = CGRectMake(CGRectGetMinX(self.titleLaber.frame), CGRectGetMaxY(self.titleLaber.frame)+10, kScreenWitdh * 0.3, 20);
    self.timeLaber.font = [UIFont systemFontOfSize:13.0];
    self.timeLaber.textColor = [UIColor grayColor];
    [self.headView addSubview:_timeLaber];
    //
    self.numRead = [[UILabel alloc]init];
    self.numRead.frame = CGRectMake(CGRectGetMaxX(self.timeLaber.frame)+10, CGRectGetMinY(self.timeLaber.frame), CGRectGetWidth(self.timeLaber.frame), CGRectGetHeight(self.timeLaber.frame));
    self.numRead.textColor = [UIColor grayColor];
    self.numRead.font = [UIFont systemFontOfSize:13.0];
    [self.headView addSubview:_numRead];
    //
    self.lineView2 = [[UIView alloc]init];
    self.lineView2.frame = CGRectMake(0, kScreenHeight * 0.25-2, kScreenWitdh, 2);
    self.lineView2.backgroundColor = [UIColor colorWithHex:0xD9D9D9];
  //  [self.headView addSubview:_lineView2];
    //
    self.scw = [[UIWebView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.headView.frame)+10, CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetHeight([UIScreen mainScreen].bounds)*0.7)];
    [self.view addSubview:_scw];
    //
      self.i = 1;
      self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"wh_more"] style:UIBarButtonItemStylePlain target:self action:@selector(ringAction:)];
    

}

//Nagv确认事件
-(void)ringAction:(UIBarButtonItem *)sender
{
    if (sender == self.navigationItem.rightBarButtonItem) {
        [YCXMenu setTintColor:[UIColor colorWithHex:0x4367FF]];
        [YCXMenu setSelectedColor:[UIColor redColor]];
        if ([YCXMenu isShow]){
            [YCXMenu dismissMenu];
        } else {
            [YCXMenu showMenuInView:self.view fromRect:CGRectMake(self.view.frame.size.width - 50, 0, 50, 0) menuItems:self.items selected:^(NSInteger index, YCXMenuItem *item) {
                //NSLog(@"%@",item);
            }];
        }
    }
    
    
}
- (NSMutableArray *)items {
    if (!_items) {
        YCXMenuItem *CollectItem = [YCXMenuItem menuItem:@"收藏" image:nil target:self action:@selector(collect:)];
        CollectItem.foreColor = [UIColor whiteColor];
        CollectItem.alignment = NSTextAlignmentRight;
        CollectItem.image = [UIImage imageNamed:@"wh_collect"];
        
        YCXMenuItem *ShareItem = [YCXMenuItem menuItem:@"分享" image:nil target:self action:@selector(share:)];
        ShareItem.foreColor = [UIColor whiteColor];
        ShareItem.alignment = NSTextAlignmentRight;
        ShareItem.image = [UIImage imageNamed:@"wh_share"];
        _items = [@[CollectItem, ShareItem
                    ] mutableCopy];
        
    }
    return _items;
    
}
//收藏
-(void)collect:(UIButton *)sender
{
    self.i ++ ;
    if (self.i % 2 == 0) {
        
        id hud = [JGProgressHelper showProgressInView:self.view];
        [self.userService collectWithUid:@"" type_id:self.newsID type:@"news" success:^{
            [hud hide:YES];
            [JGProgressHelper showSuccess:@"收藏成功"];
            
        } failure:^(NSError *error) {
            [hud hide:YES];
            [JGProgressHelper showError:@"收藏失败"];
            
        }];
    }else
    {
        id hud = [JGProgressHelper showProgressInView:self.view];
        [self.userService collectWithUid:@"" type_id:self.newsID type:@"news" success:^{
            [hud hide:YES];
            [JGProgressHelper showSuccess:@"取消收藏成功"];
            
        } failure:^(NSError *error) {
            [hud hide:YES];
            [JGProgressHelper showError:@"取消收藏失败"];
            
        }];
        
        
    }


}

//分享
-(void)share:(UIButton *)sender
{
    self.url = [NSString stringWithFormat:@"%@/%@", BASE_REST_URL, self.newsID];
    [UMSocialData defaultData].extConfig.title = @"互联网+保险智能化云服务平台";
    
    
    [UMSocialData defaultData].extConfig.qqData.url = self.url;
    [UMSocialData defaultData].extConfig.qzoneData.url = self.url;
    
    [UMSocialData defaultData].extConfig.wechatSessionData.url = self.url;
    [UMSocialData defaultData].extConfig.wechatTimelineData.url = self.url;
    
    //
    NSString *shareText = [NSString stringWithFormat:@"%@, %@", @"新闻详情", self.url];
    [[UMSocialData defaultData].extConfig.sinaData setShareText:shareText];
    [[UMSocialData defaultData].extConfig.tencentData setShareText:shareText];
    
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"576bac6d67e58e0b6b000a36"
                                      shareText:[NSString stringWithFormat:@"%@", @"新闻详情"]
                                     shareImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.imgUrl]]]
                                shareToSnsNames:@[UMShareToWechatSession, UMShareToWechatTimeline, UMShareToSina, UMShareToQQ, UMShareToQzone, UMShareToTencent]
                                       delegate:self];
   }
- (void)setItems:(NSMutableArray *)items {
    _items = items;
}
-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{
    //根据`responseCode`得到发送结果,如果分享成功
    if(response.responseCode == UMSResponseCodeSuccess)
    {
        //得到分享到的平台名
        NSLog(@"share to sns name is %@",[[response.data allKeys] objectAtIndex:0]);
    }
}

//信息事件
-(void)messageAction:(UIButton *)sender
{
    NSLog(@"mseeage");
    WHwantMessageViewController * wantMes = [[WHwantMessageViewController alloc]init];
    wantMes.res_uid = self.agentID;
    wantMes.name = self.nameLaber.text;
    //    NSString * s1 = self.areaLaber.text ;
    //wantMes.cityName = [s1 substringToIndex:2];
   // wantMes.cityName = self.areaLaber.text;
    
    [self.navigationController pushViewController:wantMes animated:YES];

}
//电话事件
-(void)telAction:(UIButton *)sender
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"你确定要拨打电话吗?" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
    //  alert.alertViewStyle = UIAlertViewStyleLoginAndPasswordInput;
    [alert show];
    
}
//根据被点击按钮的索引处理点击事件
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0 ) {
        NSMutableString * str = [[NSMutableString alloc] initWithFormat:@"tel:%@",self.tel];
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
        
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
