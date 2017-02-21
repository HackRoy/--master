//
//  WHgetproducedetalViewController.m
//  whm_project
//
//  Created by 王义国 on 16/11/3.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import "WHgetproducedetalViewController.h"
#import "MacroUtility.h"
#import "JGProgressHelper.h"
#import "WHget_product_detail.h"
#import "UIColor+Hex.h"
#import "WHcompany.h"

#import "SGTopScrollMenu.h"

//分层界面设计
#import "WHJSCollectViewController.h"
#import "WHstatisViewController.h"
#import "WHcoverageViewController.h"
#import "WHintroViewController.h"
#import "WHTitleView.h"
#import "YCXMenu.h"
#import "UMSocial.h"
#import "WHcompanyDetail.h"

#define BASE_REST_URL @"https://www.kuaibao365.com/product/details"

@interface WHgetproducedetalViewController ()<UIScrollViewDelegate,UIWebViewDelegate,UMSocialUIDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) SGTopScrollMenu *topScrollMenu;
@property (nonatomic, strong) UIScrollView *mainScrollView;
@property (nonatomic, strong) NSArray *titles;

@property (nonatomic, strong) UITableView * myTab;




@property(nonatomic,strong)UIScrollView * scrow;
@property(nonatomic,strong)UIView * myView;
@property(nonatomic,strong)UIImageView * mainImg;
@property(nonatomic,strong)UILabel * titLaber;
@property(nonatomic,strong)UILabel * prostatusLaber;
@property(nonatomic,strong)UILabel * staLaber;
@property(nonatomic,strong)UILabel * compLaber;
// 横向的UIScrollview
@property (nonatomic, strong) UIScrollView *horScrollV;
// 纵向的UIScrollview2 --- 筛选条件
@property (nonatomic, strong) UIScrollView *conditionScrollV;
// 纵向的UIScrollview2 --- 基本信息
@property (nonatomic, strong) UIScrollView *essentialScrollV;
@property (nonatomic, strong) UIScrollView *bigScrollV;
// 纵向的UIScrollview2 --- 基本信息
@property (nonatomic, strong) UIScrollView *ruleScrollV;
// 纵向的UIScrollview2 --- 基本信息
@property (nonatomic, strong) UIScrollView *rightScrollV;
// 纵向的UIScrollview2 --- 基本信息
@property (nonatomic, strong) UIScrollView *pdfScrollV;

// index = 0
@property (nonatomic, strong) UIButton *btnConditions;
// index = 1
@property (nonatomic, strong) UIButton *btnEssentialMSG;
//index = 2
@property (nonatomic ,strong) UIButton *btnRule;

//index = 3
@property (nonatomic ,strong) UIButton *btnRight;
//index = 4
@property (nonatomic ,strong) UIButton *btnPdf;
@property(nonatomic,strong)NSString * s1 ;

@property(nonatomic,strong)NSString * s2 ;

@property(nonatomic,strong)UIWebView * scw;

@property(nonatomic, strong)NSMutableArray * dataArr1;

@property(nonatomic,strong)NSString * StrCases;

@property(nonatomic,strong)NSString * right;

@property(nonatomic,strong)NSString * rule;

@property(nonatomic,strong)NSString * pdf;

@property(nonatomic,strong)NSString * com_id;

@property(nonatomic,strong)NSString * compnyName;

@property(nonatomic,strong)NSString * companyLogo;
//
@property (nonatomic , strong) NSMutableArray *items;
@property (nonatomic, copy) NSString *url;

@property(nonatomic,assign)NSInteger  i ;

@property(nonatomic,strong)NSString * s11;
@end

@implementation WHgetproducedetalViewController
@synthesize items = _items;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self quartData];

    self.i = 1;
    // 布局
    [self setupUI];
    
     self.scw.delegate = self;
    self.scw = [[UIWebView alloc]initWithFrame:CGRectMake(0, kScreenHeight * 0.16, CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetHeight([UIScreen mainScreen].bounds)*0.8)];
    //self.scw.tintColor = [UIColor grayColor];
    
    
    [self.essentialScrollV addSubview:_scw];

}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    
}
-(void)loadWithURLString:(NSString *)urlStr
{
    NSString  * content = [self.s1 stringByReplacingOccurrencesOfString:@"+" withString:@" "];
    NSString * contentTwo = [content stringByReplacingOccurrencesOfString:@"\\\"" withString:@"\""];
    
    NSString *str1 = [NSString stringWithFormat:@"<head><style> img{max-width: %fpx;max-height:330px;\n width:expression(document.body.clientWidth>%f?\"%fpx\":\"auto\";\n height:expression(document.body.clientWidth>330?\"330px\":\"auto\");\n overflow:hidden;\n} \n</style></head>",kScreenWitdh-16,kScreenWitdh-16,kScreenWitdh-16];
    
    NSString *str2 = @"</body><html>";
    
    NSString * html = [NSString stringWithFormat:@"%@%@%@",str1,contentTwo,str2];
    
    [_scw loadHTMLString:html baseURL:nil];
}
//数据请求
-(void)quartData
{
    id hud = [JGProgressHelper showProgressInView:self.view];
    
    [self.dataService get_product_detailWithPro_id:self.pro_id uid:[JwUserCenter sharedCenter].uid success:^(WHget_product_detail *userInfo)
    {
        [hud hide:YES];
        self.s2 = userInfo.clause;
        self.StrCases = userInfo.cases;
        self.rule = userInfo.rule;
        self.right  = userInfo.rights;
        self.pdf = userInfo.pdf_path;
      
        self.com_id = userInfo.company.id;
        self.companyLogo = userInfo.company.logo;
        NSLog(@"%@",self.com_id);
        self.compnyName = userInfo.company.name;
        self.staLaber.text = userInfo.sale_status_name;
        self.titLaber.text = userInfo.name;
        self.compLaber.text = userInfo.company_short_name;//公司险种名字
        NSInteger stateM = [userInfo.is_main integerValue];
        switch (stateM)
        {
            case 1:
                self.mainImg.image =[UIImage imageNamed:@"p_zhu"];
                break;
            case 2:
                self.mainImg.image = [UIImage imageNamed:@"p_huangfu"];
                break;
            case 3:
                self.mainImg.image = [UIImage imageNamed:@"p_group"];
                break;
            default:
                break;
        }

//        [self dataHead];
     
        
    } failure:^(NSError *error) {
        [hud hide:YES];
        [JGProgressHelper showError:@""];
        
    }];
    
}


//定义响应事件

-(void)onClickUILableAction:(UITapGestureRecognizer *)sender
{
       NSLog(@"jjj");
    
    //
     WHstatisViewController * statisVC = [[WHstatisViewController alloc]init];
     WHcoverageViewController * coverVC = [[WHcoverageViewController alloc]init];
     coverVC.com_id = self.com_id;
     WHintroViewController * introVC = [[WHintroViewController alloc]init];
     introVC.company_id = self.com_id;
     WHJSCollectViewController * collectVC = [[WHJSCollectViewController  alloc]initWithAddVCARY:@[statisVC,coverVC,introVC] TitleS:@[@"统计",@"险种",@"简介"]];
    [self presentViewController:collectVC animated:YES completion:nil];
    
    [collectVC.titleView titllaber:self.compnyName];
    [collectVC.titleView getImageImg:self.companyLogo];
    
    
}
//ad默认
-(void)dataHead
{
    _horScrollV.contentOffset = CGPointMake(kScreenWitdh, 0);
    
    self.s1 = self.s2;
    [self loadWithURLString:self.s1];
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
//
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
    [self.userService collectWithUid:@"" type_id:self.pro_id type:@"product" success:^{
        [hud hide:YES];
        [JGProgressHelper showSuccess:@"收藏成功"];
        
    } failure:^(NSError *error) {
        [hud hide:YES];
        [JGProgressHelper showError:@"收藏失败"];
        
    }];
    }else
    {
        id hud = [JGProgressHelper showProgressInView:self.view];
        [self.userService collectWithUid:@"" type_id:self.pro_id type:@"product" success:^{
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
    
    self.url = [NSString stringWithFormat:@"%@/%@", BASE_REST_URL, self.pro_id];
    
    [UMSocialData defaultData].extConfig.title = @"互联网+保险智能化云服务平台";
    
    
    [UMSocialData defaultData].extConfig.qqData.url = self.url;
    [UMSocialData defaultData].extConfig.qzoneData.url = self.url;
    
    [UMSocialData defaultData].extConfig.wechatSessionData.url = self.url;
    [UMSocialData defaultData].extConfig.wechatTimelineData.url = self.url;
    
    //
    NSString *shareText = [NSString stringWithFormat:@"%@, %@", @"产品详情", self.url];
    [[UMSocialData defaultData].extConfig.sinaData setShareText:shareText];
    [[UMSocialData defaultData].extConfig.tencentData setShareText:shareText];
    
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"576bac6d67e58e0b6b000a36"
                                      shareText:[NSString stringWithFormat:@"%@", @"产品详情"]
                                     shareImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.companyLogo]]]
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

#pragma mark -- 布局
-(void)setupUI
{
    self.title = @"产品详情";
    self.myView = [[UIView alloc]init];
    self.myView.frame = CGRectMake(20, 35, kScreenWitdh - 40, kScreenHeight * 0.15);
    self.myView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_myView];
    self.view.backgroundColor = [UIColor blueColor];
    //
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"wh_more"] style:UIBarButtonItemStylePlain target:self action:@selector(ringAction:)];

    
   // self.myView .userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClickUILableAction:)];
    self.view.userInteractionEnabled = YES;
    //设置手势点击数,双击：默认不设置 就是1 为单击事件
    
    
    //设置手指数 单指
    
    tapGesture.numberOfTouchesRequired =1;
    
    // titleLabel添加手势识别
    
    [self.view addGestureRecognizer:tapGesture];
    
    //
    self.mainImg = [[UIImageView alloc]init];
    self.mainImg.frame = CGRectMake(kScreenWitdh *0.1, 20, 30, 30);
    self.mainImg.layer.masksToBounds = YES;
    self.mainImg.layer.cornerRadius = 15;
   // self.mainImg.image = [UIImage imageNamed:@"p_huangfu"];
    [self.myView addSubview:_mainImg];
    //
    self.titLaber = [[UILabel alloc]init];
    self.titLaber.frame = CGRectMake(CGRectGetMaxX(self.mainImg.frame)+10, CGRectGetMinY(self.mainImg.frame), kScreenWitdh * 0.6, 30);
    self.titLaber.font = [UIFont systemFontOfSize:15.0];
    //self.titLaber.text = self.nameLaber;
    [self.myView addSubview:_titLaber];
    //
    self.prostatusLaber = [[UILabel alloc]init];
    self.prostatusLaber.frame = CGRectMake(CGRectGetMinX(self.titLaber.frame)+5, CGRectGetMaxY(self.titLaber.frame), kScreenWitdh * 0.2, 20);
    self.prostatusLaber.text = @"产品状态|";
    self.prostatusLaber.textAlignment = 2 ;
    self.prostatusLaber.textColor = [UIColor grayColor];
    self.prostatusLaber.font = [UIFont systemFontOfSize:13.0];
    [self.myView addSubview:_prostatusLaber];
    //
    self.staLaber = [[UILabel alloc]init];
    self.staLaber.frame = CGRectMake(CGRectGetMaxX(self.prostatusLaber.frame)+5, CGRectGetMinY(self.prostatusLaber.frame), 40, 20);
    self.staLaber.layer.cornerRadius = 10;
    self.staLaber.layer.masksToBounds = YES;
    //self.staLaber.text = self.sale_status;
    self.staLaber.backgroundColor = [UIColor colorWithHex:0x28D68E];
    self.staLaber.textAlignment = NSTextAlignmentCenter;
    self.staLaber.textColor = [UIColor whiteColor];
    self.staLaber.font = [UIFont systemFontOfSize:13.0];
    [self.myView addSubview:_staLaber];
    
    self.compLaber = [[UILabel alloc]init];
    self.compLaber.frame = CGRectMake(wScreenW - wScreenW * 0.2 - 20 - 20,  kScreenHeight * 0.15 -30, kScreenWitdh*0.2, 30);
    //self.compLaber.text = @"泰康人寿";
    self.compLaber.textAlignment = NSTextAlignmentCenter;
    self.compLaber.font = [UIFont systemFontOfSize:15.0];
    self.compLaber.backgroundColor = [UIColor colorWithHex:0x28D68E];
    self.compLaber.textColor = [UIColor whiteColor];
    
    [self.myView addSubview:_compLaber];
    //
    // 最大的UIScrollview bigScrollV;
    self.bigScrollV = [[UIScrollView alloc] initWithFrame:CGRectMake(0,0, kScreenWitdh, kScreenHeight - 64)];
    [self.view addSubview:_bigScrollV];
    //
       // index = 1 btnEssentialMSG;
    
    NSArray * arr = @[@"详情",@"责任",@"规则",@"条款",@"案例"];
    
    for (NSInteger i = 0; i < 5; i++)
    {
        UIButton * myBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        myBtn.frame = CGRectMake( wScreenW * 0.2 * i, CGRectGetMaxY(_myView.frame), wScreenW * 0.2, 44);
        [myBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [myBtn setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
        myBtn.tag = 1221 + i;
        if (i == 0)
        {
            myBtn.selected = YES;
        }
        
        [myBtn addTarget:self action:@selector(onClickmyBtn:) forControlEvents:UIControlEventTouchUpInside];
        [myBtn setTitle:arr[i] forState:UIControlStateNormal];
        [myBtn setBackgroundColor:[UIColor blueColor]];
        myBtn.titleLabel.font = [UIFont systemFontOfSize:18.f];
        [_bigScrollV addSubview:myBtn];

    }
    
//    self.btnConditions = [UIButton buttonWithType:UIButtonTypeCustom];
//    _btnConditions.frame = CGRectMake(0, CGRectGetMaxY(_myView.frame), kScreenWitdh * 0.2, 44);
//    [_btnConditions setTitle:@"详情" forState:UIControlStateNormal];
//    [_btnConditions setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [_btnConditions setBackgroundColor:[UIColor blueColor]];
//    [_btnConditions addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
//    _btnConditions.titleLabel.font = [UIFont systemFontOfSize:15];
//    [_bigScrollV addSubview:_btnConditions];
    

//    self.btnEssentialMSG = [UIButton buttonWithType:UIButtonTypeCustom];
//    _btnEssentialMSG.frame = CGRectMake(CGRectGetMaxX(_btnConditions.frame), CGRectGetMinY(_btnConditions.frame), CGRectGetWidth(_btnConditions.frame), CGRectGetHeight(_btnConditions.frame));
//    [_btnEssentialMSG setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [_btnEssentialMSG setBackgroundColor:[UIColor blueColor]];
//    [_btnEssentialMSG addTarget:self action:@selector(btnMSGAction:) forControlEvents:UIControlEventTouchUpInside];
//    [_btnEssentialMSG setTitle:@"责任" forState:UIControlStateNormal];
//    _btnEssentialMSG.titleLabel.font = [UIFont systemFontOfSize:15];
//    [_bigScrollV addSubview:_btnEssentialMSG];
//
//    // index = 2
//    self.btnRule = [UIButton buttonWithType:UIButtonTypeCustom];
//    _btnRule.frame = CGRectMake(CGRectGetMaxX(self.btnEssentialMSG.frame), CGRectGetMinY(_btnConditions.frame), CGRectGetWidth(_btnConditions.frame), CGRectGetHeight(_btnConditions.frame));
//    [_btnRule setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [_btnRule setBackgroundColor:[UIColor blueColor]];
//    [_btnRule addTarget:self action:@selector(bntRuleAction:) forControlEvents:UIControlEventTouchUpInside];
//    [_btnRule setTitle:@"规则" forState:UIControlStateNormal];
//    _btnRule.titleLabel.font = [UIFont systemFontOfSize:15];
//    [_bigScrollV addSubview:_btnRule];
//
//    self.btnRight = [UIButton buttonWithType:UIButtonTypeCustom];
//    _btnRight.frame = CGRectMake(CGRectGetMaxX(self.btnRule.frame), CGRectGetMinY(_btnConditions.frame), CGRectGetWidth(_btnConditions.frame), CGRectGetHeight(_btnConditions.frame));
//    [_btnRight setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [_btnRight setBackgroundColor:[UIColor blueColor]];
//    [_btnRight addTarget:self action:@selector(bntRightAction:) forControlEvents:UIControlEventTouchUpInside];
//    [_btnRight setTitle:@"条款" forState:UIControlStateNormal];
//    _btnRight.titleLabel.font = [UIFont systemFontOfSize:15];
//    [_bigScrollV addSubview:_btnRight];
//    
//    //// index = 4
//    self.btnPdf = [UIButton buttonWithType:UIButtonTypeCustom];
//    _btnPdf.frame = CGRectMake(CGRectGetMaxX(self.btnRight.frame), CGRectGetMinY(_btnConditions.frame), CGRectGetWidth(_btnConditions.frame), CGRectGetHeight(_btnConditions.frame));
//    [_btnPdf setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [_btnPdf setBackgroundColor:[UIColor blueColor]];
//    [_btnPdf addTarget:self action:@selector(bntpdfAction:) forControlEvents:UIControlEventTouchUpInside];
//    [_btnPdf setTitle:@"案例" forState:UIControlStateNormal];
//    _btnPdf.titleLabel.font = [UIFont systemFontOfSize:15];
//    [_bigScrollV addSubview:_btnPdf];

    // 横向的UIScrollview horScrollV;
    
    [self creatHorScrollV];
    // 纵向的UIScrollview2 --- 筛选条件 conditionScrollV;
    self.conditionScrollV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWitdh, CGRectGetHeight(_horScrollV.frame))];
     _conditionScrollV.backgroundColor = [UIColor grayColor];
    [_horScrollV addSubview:_conditionScrollV];
    // 纵向的UIScrollview2 --- 基本信息 essentialScrollV;
    self.essentialScrollV = [[UIScrollView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_conditionScrollV.frame), CGRectGetMinY(_conditionScrollV.frame)-kScreenHeight*0.15, kScreenWitdh, CGRectGetHeight(_conditionScrollV.frame)+kScreenHeight*0.15)];
     _essentialScrollV.backgroundColor = [UIColor whiteColor];
    [_horScrollV addSubview:_essentialScrollV];

    // 纵向的UIScrollview2 --- 筛选条件 conditionScrollV;
    self.ruleScrollV = [[UIScrollView alloc] initWithFrame:CGRectMake(kScreenWitdh * 2.0, CGRectGetMinY(_conditionScrollV.frame), kScreenWitdh, CGRectGetHeight(_conditionScrollV.frame))];
    _ruleScrollV.backgroundColor = [UIColor redColor];
    [_horScrollV addSubview:_ruleScrollV];
    // 纵向的UIScrollview2 --- 基本信息 essentialScrollV;
    self.rightScrollV = [[UIScrollView alloc] initWithFrame:CGRectMake(kScreenWitdh * 3.0, CGRectGetMinY(_conditionScrollV.frame), kScreenWitdh, CGRectGetHeight(_conditionScrollV.frame))];
    _rightScrollV.backgroundColor = [UIColor yellowColor];
    [_horScrollV addSubview:_rightScrollV];
//
    self.pdfScrollV = [[UIScrollView alloc] initWithFrame:CGRectMake(kScreenWitdh * 4.0, CGRectGetMinY(_conditionScrollV.frame), kScreenWitdh, CGRectGetHeight(_conditionScrollV.frame))];
    _pdfScrollV.backgroundColor = [UIColor whiteColor];
    [_horScrollV addSubview:_pdfScrollV];

    
}

-(void)creatHorScrollV
{
    self.horScrollV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_myView.frame) + 44, kScreenWitdh, kScreenHeight - 64 - 44)];
    _horScrollV.contentSize = CGSizeMake(kScreenWitdh * 5, CGRectGetHeight(_horScrollV.frame)*1.0);
    _horScrollV.pagingEnabled = YES;
    _horScrollV.showsVerticalScrollIndicator = NO;
    _horScrollV.showsHorizontalScrollIndicator = NO;
    _horScrollV.delegate = self;
    _horScrollV.backgroundColor = [UIColor yellowColor];
    [_bigScrollV addSubview:_horScrollV];

    
}


#pragma  mark ==== 点击事件
-(void)onClickmyBtn:(UIButton * )btn
{
    UIImageView * myImg = [self.view viewWithTag:5656];
    
    btn.selected = !btn.selected;
    for (NSInteger i = 0; i < 5; i++)
    {
        UIButton * aBtn = [self.view viewWithTag:1221 + i];
        aBtn.selected = NO;
    }
    btn.selected = YES;
    
  //  myImg.center = CGPointMake(btn.center.x, <#CGFloat y#>);
    
    
    if (btn.tag == 1221)
    {
        
        
    }else if (btn.tag == 1221 + 1)
    {
        _horScrollV.contentOffset = CGPointMake(kScreenWitdh, 0);
        self.s1 = self.s2;
        [self loadWithURLString:self.s1];
        
    }else if (btn.tag == 1221 + 2)
    {
       
        
    }else if (btn.tag == 1221 + 3)
    {
        
        
    }else if (btn.tag == 1221 +4)
    {
        
        
    }
    
    
}


//责任事件
-(void)btnMSGAction:(UIButton *)sender
{
  
    _horScrollV.contentOffset = CGPointMake(kScreenWitdh, 0);
    
    self.s1 = self.StrCases;
    [self loadWithURLString:self.s1];

}

//详情
-(void)btnAction:(UIButton *)sender
{
    
    _horScrollV.contentOffset = CGPointMake(kScreenWitdh, 0);

    self.s1 = self.s2;
    [self loadWithURLString:self.s1];

}

//规则
-(void)bntRuleAction:(UIButton *)sender
{
    
   
    _horScrollV.contentOffset = CGPointMake(kScreenWitdh , 0);
    
    self.s1 = self.rule;
    [self loadWithURLString:self.s1];

    
}

//条款
-(void)bntRightAction:(UIButton *)sender
{
    _horScrollV.contentOffset = CGPointMake(kScreenWitdh , 0);
    self.s1 = self.right;
    [self loadWithURLString:self.s1];
}
//案例
-(void)bntpdfAction:(UIButton *)sender
{
    _horScrollV.contentOffset = CGPointMake(kScreenWitdh, 0);
    self.s1 = self.pdf;
    [self loadWithURLString:self.s1];
}
#pragma  mark ====创建tabview
-(void)creatMytab
{
    
    
    
}

- (void)didReceiveMemoryWarning
{
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
