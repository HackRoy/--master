//
//  WCPXQViewController.m
//  whm_project
//
//  Created by Stephy_xue on 16/12/24.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import "WCPXQViewController.h"
#import "WHget_product_detail.h"
#import "WHstatisViewController.h"
#import "WCPQTableViewCell.h"
#import "WHintroViewController.h"
#import "WHJSCollectViewController.h"
#import "WHcoverageViewController.h"
//#import "ZhiFuViewController.h"
#import "WHTitleView.h"
#import "WHcompanyDetail.h"

@interface WCPXQViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UIView * bgView;
    UITableView * myTab;
    UIWebView * webView;
    UITapGestureRecognizer *tapGesture;
    
    NSMutableArray * nextArr;
}
@property(nonatomic,assign)NSInteger  i ;
@property(nonatomic,copy) NSString *url;
@property(nonatomic,strong)NSString * companyLogo;
@property(nonatomic,strong)NSArray * myArr;
@property(nonatomic,strong)UIView * myView;
@property(nonatomic,strong)UIImageView * mainImg;
@property(nonatomic,strong)UILabel * titLaber;
@property(nonatomic,strong)UILabel * prostatusLaber;
@property(nonatomic,strong)UILabel * staLaber;
@property(nonatomic,strong)UILabel * compLaber;

@end

@implementation WCPXQViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"产品详情";
    self.items = [NSMutableArray array];
    _myArr = [NSArray array];
    [self creatLeftTtem];
    [self creatRbtn];
    [self requestData];
//    self.i = 0;
    nextArr = [NSMutableArray array];
}

-(void)creatShouShi
{
    tapGesture =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onClickUILableAction:)];
    self.compLaber.userInteractionEnabled = YES;
    //设置手势点击数,双击：默认不设置 就是1 为单击事件
    tapGesture.numberOfTouchesRequired =1;
    // titleLabel添加手势识别
    [self.compLaber addGestureRecognizer:tapGesture];
}

-(void)onClickUILableAction:(UITapGestureRecognizer * )tap
{
    DataModel * dataModel = _myArr[0];
    NSString * s1 = dataModel.company_logo;
    WHstatisViewController * statisVC = [[WHstatisViewController alloc]init];
    statisVC.com_id = dataModel.company.id;
    statisVC.heldArry = nextArr;
    
    WHcoverageViewController * coverVC = [[WHcoverageViewController alloc]init];
    coverVC.com_id = dataModel.company.id;
    WHintroViewController * introVC = [[WHintroViewController alloc]init];
    introVC.company_id = dataModel.company.id;
    WHJSCollectViewController * collectVC = [[WHJSCollectViewController  alloc]initWithAddVCARY:@[statisVC,coverVC,introVC] TitleS:@[@"统计",@"险种",@"简介"]];
    [self presentViewController:collectVC animated:YES completion:nil];
    
    [collectVC.titleView titllaber:self.titLaber.text ];
    [collectVC.titleView getImageImg:s1 ];
}
-(void)dealloc
{
    [self.compLaber removeGestureRecognizer:tapGesture];
    
}
-(void)creatRbtn
{
   
    UIButton * button =[UIButton buttonWithType:UIButtonTypeSystem];
    button.frame=CGRectMake(0, 0, 16, 18);
    [button setBackgroundImage:[UIImage imageNamed:@"wh_more"] forState:UIControlStateNormal];
    
    [button addTarget:self action:@selector(ringAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithCustomView:button];
    [self shoucang];
    
}
-(void)creatUI
{
    CGFloat hh = (wScreenH -49-64)/3;
    bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, wScreenW, hh)];
    bgView.backgroundColor = wBlue;
    
    [self.view addSubview:bgView];
    _myView = [[UIView alloc] initWithFrame:CGRectMake(20, 20, wScreenW - 40, hh - 20 - 50)];
    _myView.backgroundColor = [UIColor whiteColor];
    [bgView addSubview:_myView];
    
    
    DataModel * myModel =  _myArr.count >=1 ? _myArr[0]:@"";
    
    self.mainImg = [[UIImageView alloc]init];
    self.mainImg.frame = CGRectMake(wScreenW *0.1, 20, 30, 30);
    self.mainImg.layer.masksToBounds = YES;
    self.mainImg.layer.cornerRadius = 15;
    
    NSInteger stateM = [myModel.is_main integerValue];
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
    
    [self.myView addSubview:_mainImg];
    //
    self.titLaber = [[UILabel alloc]init];
    self.titLaber.frame = CGRectMake(CGRectGetMaxX(self.mainImg.frame)+10, CGRectGetMinY(self.mainImg.frame), wScreenW * 0.6, 30);
    self.titLaber.font = [UIFont systemFontOfSize:13.0];
    self.titLaber.text = myModel.name;
    [self.myView addSubview:_titLaber];
    //
    self.prostatusLaber = [[UILabel alloc]init];
    self.prostatusLaber.frame = CGRectMake(CGRectGetMinX(self.titLaber.frame)+5, CGRectGetMaxY(self.titLaber.frame), wScreenW * 0.2, 20);
    self.prostatusLaber.text = @"产品状态|";
    self.prostatusLaber.textAlignment = 2 ;
    
    self.prostatusLaber.textColor = [UIColor grayColor];
    self.prostatusLaber.font = [UIFont systemFontOfSize:12.0];
    [self.myView addSubview:_prostatusLaber];
    //
    self.staLaber = [[UILabel alloc]init];
    self.staLaber.frame = CGRectMake(CGRectGetMaxX(self.prostatusLaber.frame)+5, CGRectGetMinY(self.prostatusLaber.frame)+2, 30, 16);
    self.staLaber.layer.cornerRadius = 5;
    self.staLaber.layer.masksToBounds = YES;
    self.staLaber.text = myModel.sale_status_name;
    self.staLaber.textAlignment = NSTextAlignmentCenter;
    
    self.staLaber.backgroundColor = [UIColor colorWithHex:0x28D68E];
    self.staLaber.textColor = [UIColor whiteColor];
    self.staLaber.font = [UIFont systemFontOfSize:10.0];
    [self.myView addSubview:_staLaber];
    
    self.compLaber = [[UILabel alloc]init];
    self.compLaber.frame = CGRectMake( wScreenW - 20 - wScreenW * 0.2 - 20 ,  hh - 20 - 50 - 20, wScreenW * 0.2, 20);
    self.compLaber.font = [UIFont systemFontOfSize:10.0];
    self.compLaber.layer.masksToBounds = YES;
    //self.compLaber.layer.cornerRadius = 8;
    //self.compLaber.numberOfLines = 0;
    self.compLaber.textColor = [UIColor whiteColor];
    self.compLaber.backgroundColor =[UIColor colorWithHex:0x28D68E];
    self.compLaber.text = myModel.company_short_name;//公司险种名字
    self.compLaber.textAlignment = NSTextAlignmentCenter;
    [self.myView addSubview:_compLaber];
    
    [self creatmyView];
    [self qingqiu:myModel.company.id];
}

-(void)qingqiu:(NSString *)str
{
    id  hud = [JGProgressHelper showProgressInView:self.view];
    [self.dataService get_company_detailWithCom_id:str uid:@"" success:^(NSArray *lists) {
        [hud hide:YES];
        if (lists.count > 0 )
        {
            [nextArr addObjectsFromArray:lists];
            [self shujujiexi];
        }
       } failure:^(NSError *error) {
        
        [hud hide:YES];
        
    }];
 
}
-(void)shujujiexi
{
    WHcompanyDetail * myMod = nextArr[0];
    WHyearapp *mod = myMod.count.year_app[0];//year_app
 //   WHspcil_attriModel * mod1 = myMod.count.year_app[0];//special_attri
   // WBYspecial_attriModel * mod2 = myMod.count.year_app[0];//prod_type_code_app
}


-(void)creatmyView
{
    CGFloat hh = (wScreenH -49-64)/3;
    NSArray * arr = @[@"详情",@"责任",@"规则",@"条款",@"案例"];
    
    for (NSInteger i = 0; i < 5; i++)
    {
        UIButton * myBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        myBtn.frame = CGRectMake( wScreenW * 0.2 * i, hh - 40, wScreenW * 0.2, 40);
        [myBtn setTitleColor:wGrayColor forState:UIControlStateNormal];
        [myBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        myBtn.tag = 1221 + i;
        if (i == 0)
        {
            myBtn.selected = YES;
        }
        [myBtn addTarget:self action:@selector(onClickmyBtn:) forControlEvents:UIControlEventTouchUpInside];
        [myBtn setTitle:arr[i] forState:UIControlStateNormal];
        myBtn.titleLabel.font = [UIFont systemFontOfSize:15.f];
        [bgView addSubview:myBtn];
    }
    
    UIButton * btn = [self.view viewWithTag:1221];
    
    UIImageView * img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 20)];
    img.image = [UIImage imageNamed:@"arrowT"];
    img.tag = 5656;
    img.center = CGPointMake(btn.center.x, CGRectGetMaxY(bgView.frame));
    
    [bgView addSubview:img];
    
    [self creatMyTab];
    
    [self creatShouShi];
    
}

#pragma  mark===创建tab 代理 数据源

-(void)creatMyTab
{
    CGFloat hh = (wScreenH -49-64)/3;
    
    myTab = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(bgView.frame), wScreenW, wScreenH - 64 - hh) style:UITableViewStylePlain];
    myTab.dataSource = self;
    myTab.delegate =self;
    myTab.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    [myTab registerClass:[WCPQTableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:myTab];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (section == 0)
    {
        return 3;
    }else
    {
        return 5;
    }
    
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WCPQTableViewCell * cell = [tableView  dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    [self biaochuangjian:indexPath cellll:cell];
    
    return cell;
}


-(void)biaochuangjian:(NSIndexPath *)indexPath cellll:(WCPQTableViewCell *)cell
{
    DataModel * myModel =  _myArr.count >=1 ? _myArr[0]:@"";
    
    NSArray * imgArr = @[@"aa1",@"aa2",@"aa3"];
    NSArray * imgArr1 =@[@"aa4",@"aa5",@"aa6",@"aa7",@"aa8"];
    
    NSArray * rigArr =@[myModel.limit_age_name.length >=1 ? myModel.limit_age_name:@"无",myModel.pay_period_name.length >=1 ? myModel.pay_period_name:@"无",myModel.insurance_period_name.length >=1 ? myModel.insurance_period_name:@"无"];
    
    
    NSArray * lefArr = @[@"承保年龄",@"缴费期间",@"保障时间"];
    NSArray * lefArr1 = @[@"产品类型",@"设计类型",@"特殊属性",@"承保方式",@"产品条款文字编码"];
    
    NSString * one = myModel.prod_type_code_name.length >= 1 ? myModel.prod_type_code_name:@"暂无";
    
    NSString * two = myModel.prod_desi_code_name.length >= 1 ? myModel.prod_desi_code_name:@"暂无";
    NSString * three = myModel.special_attri_name.length >= 1 ? myModel.special_attri_name:@"暂无";
    NSString * four = [myModel.ins_type isEqualToString:@"1"] ? @"个人":@"团体";
    NSString * five = myModel.ins_item_code.length >= 1 ? myModel.ins_item_code:@"暂无";
    
    NSArray * rigArr1 = @[one,two,three,four,five];
    
    if (indexPath.section == 0)
    {
        cell.myImg.image = [UIImage imageNamed:imgArr[indexPath.row]];
        cell.rigLab.text = rigArr[indexPath.row];
        cell.lefLab.text = lefArr[indexPath.row];
        
    }else if (indexPath.section == 1)
    {
        cell.myImg.image = [UIImage imageNamed:imgArr1[indexPath.row]];
        cell.rigLab.text = rigArr1[indexPath.row];
        cell.lefLab.text = lefArr1[indexPath.row];
    }
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * view =[UIView new];
    view.backgroundColor = wGrayColor;
    view.alpha = 0.6;
    view.frame = CGRectMake(0, 0, wScreenW, 10);
    
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 1)
    {
        return 10;
        
    }else
    {
        return 0;
    }
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.i = 0;

    
}

-(void)requestData
{
    NSMutableDictionary * dic =[NSMutableDictionary dictionary];
    [dic setObject:_dataModel.id forKey:@"pro_id"];
    [dic setObject:@"0" forKey:@"uid"];
    
    
    [dic setObject:[WBYRequest jiami:@"kb/get_product_detail"] forKey:@"kb"];
    __weak WCPXQViewController * mySelf = self;
    
    [WBYRequest wbyPostRequestDataUrl:@"kb/get_product_detail" addParameters:dic success:^(WBYReqModel *model)
     {
         if ([model.err isEqualToString:TURE])
         {
             _myArr = model.data;
             [mySelf creatUI];
             
         }else
         {
            [WBYRequest showMessage:model.info];
             return ;
         }
//         [WBYRequest showMessage:model.info];
         
     } failure:^(NSError *error) {
         
         [WBYRequest showMessage:@"请求失败"];
         
         
     } isRefresh:YES];
    
}

-(void)shoucang
{
    YCXMenuItem *CollectItem = [YCXMenuItem menuItem:@"收藏" image:nil target:self action:@selector(collect:)];
    CollectItem.foreColor = [UIColor whiteColor];
    CollectItem.alignment = 0;
    
    CollectItem.image = [UIImage imageNamed:@"wh_collect"];
    
    
    YCXMenuItem *ShareItem = [YCXMenuItem menuItem:@"分享" image:nil target:self action:@selector(share:)];
    ShareItem.foreColor = [UIColor whiteColor];
    ShareItem.alignment = 0;
    ShareItem.image = [UIImage imageNamed:@"wh_share"];
    
    self.items = [@[CollectItem, ShareItem
                    ] mutableCopy];
}
//Nagv确认事件
-(void)ringAction:(UIButton *)sender
{
    
        [YCXMenu setTintColor:[UIColor colorWithHex:0x4367FF]];
        [YCXMenu setSelectedColor:[UIColor redColor]];
    
        if ([YCXMenu isShow]){
            [YCXMenu dismissMenu];
        } else {
            [YCXMenu showMenuInView:self.view fromRect:CGRectMake(wScreenW - 60, -10, 60, 0) menuItems:self.items selected:^(NSInteger index, YCXMenuItem *item)
            {
                
                
            }];
        }
  
    
}
//收藏
-(void)collect:(UIButton *)sender
{
    self.i ++ ;
    
    if (self.i % 2 == 1)
    {
        id hud = [JGProgressHelper showProgressInView:self.view];
        [self.userService collectWithUid:@"" type_id:_dataModel.id type:@"product" success:^{
            [hud hide:YES];
            [JGProgressHelper showSuccess:@"收藏成功"];
        } failure:^(NSError *error)
         {
             [hud hide:YES];
             [JGProgressHelper showError:@"收藏失败"];
             
         }];
    }else
    {
        id hud = [JGProgressHelper showProgressInView:self.view];
        [self.userService collectWithUid:@"" type_id:_dataModel.id type:@"product" success:^{
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
    self.url = [NSString stringWithFormat:@"%@/%@", BASE_REST_URL, _dataModel.id];
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

-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{
    //根据`responseCode`得到发送结果,如果分享成功
    if(response.responseCode == UMSResponseCodeSuccess)
    {
        //得到分享到的平台名
        NSLog(@"share to sns name is %@",[[response.data allKeys] objectAtIndex:0]);
    }
}



#pragma  mark ==== 点击事件
-(void)onClickmyBtn:(UIButton * )btn
{
    
    UIImageView * img = [self.view viewWithTag:5656];
    
    img.center = CGPointMake(btn.center.x, CGRectGetMaxY(bgView.frame));

    DataModel * mod = _myArr[0];
    btn.selected = !btn.selected;
    for (NSInteger i = 0; i < 5; i++)
    {
        UIButton * aBtn = [self.view viewWithTag:1221 + i];
        aBtn.selected = NO;
    }
    btn.selected = YES;
    [webView removeFromSuperview];
    
    if (btn.tag == 1221)
    {
        [myTab reloadData];
        
    }else if (btn.tag == 1221 + 1)
    {
        [self loadWithURLString:mod.rights];
        
    }else if (btn.tag == 1221 + 2)
    {
        [self loadWithURLString:mod.rule];
        
    }else if (btn.tag == 1221 + 3)
    {
        [self loadWithURLString:mod.clause];
        
    }else if (btn.tag == 1221 +4)
    {
        [self loadWithURLString:mod.cases];
    }
}

#pragma mark===富文本解析

-(void)loadWithURLString:(NSString *)str
{
    CGFloat hh = (wScreenH - 49 - 64)/3;
    webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(bgView.frame), wScreenW, wScreenH - 64 - hh)];
    [self.view addSubview:webView];
    
    NSString  * content = [str stringByReplacingOccurrencesOfString:@"+" withString:@" "];
    NSString * contentTwo = [content stringByReplacingOccurrencesOfString:@"\\\"" withString:@"\""];
    NSString *str1 = [NSString stringWithFormat:@"<head><style> img{max-width: %fpx;max-height:330px;\n width:expression(document.body.clientWidth>%f?\"%fpx\":\"auto\";\n height:expression(document.body.clientWidth>330?\"330px\":\"auto\");\n overflow:hidden;\n} \n</style></head>",wScreenW-16,wScreenW-16,wScreenW-16];
    
    NSString *str2 = @"</body><html>";
    
    NSString * html = [NSString stringWithFormat:@"%@%@%@",str1,contentTwo,str2];
    
    [webView loadHTMLString:html baseURL:nil];
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
