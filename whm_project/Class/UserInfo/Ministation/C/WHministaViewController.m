//
//  WHministaViewController.m
//  whm_project
//
//  Created by 王义国 on 17/1/23.
//  Copyright © 2017年 chenJw. All rights reserved.
//

#import "WHministaViewController.h"
#import "MacroUtility.h"
#import "WHprevTableViewCell.h"
#import "JGProgressHelper.h"
#import "WHmicro.h"
#import "WHgetuseinfo.h"
#import <UIImageView+WebCache.h>
#import "WHagentinfo.h"
#import "WHcount.h"
#import "WHgetintroduce.h"
#import "WHmessageListTableViewCell.h"
#import "WHcounselTableViewCell.h"
#import "WHnews.h"
#import "YCXMenu.h"
#import "WHwantMessageViewController.h"
//
#import "WHmin.h"
#import "WHgentinfo.h"
#import "UMSocial.h"
#define BASE_REST_URL @"https://www.kuaibao365.com/index/agent"
#import "WHnewsdetailViewController.h"
#import "JwUserCenter.h"


@interface WHministaViewController ()<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate,UMSocialUIDelegate>
{
    UIButton *  xiaBut ;
    BOOL floag;
    BOOL flg;
}
@property(nonatomic,strong)UITableView * tableV;
@property(nonatomic,strong)UIView * headView;
@property(nonatomic,strong)UIImageView * headImage;
@property(nonatomic,strong)UILabel * nameLaber;
@property(nonatomic,strong)UIImageView * sexImage;
@property(nonatomic,strong)UILabel * yearLaber;
@property(nonatomic,strong)UILabel * companyLaber;
@property(nonatomic,strong)UIButton * messBut;
@property(nonatomic,strong)UIButton * telBut;
@property(nonatomic,strong)UIView * line1;
@property(nonatomic,strong)UIView * line2;
@property(nonatomic,strong)UILabel * chanPinNum;
@property(nonatomic,strong)UILabel * chanPinLaber;
@property(nonatomic,strong)UIView * line3;
//
@property(nonatomic,strong)UIView * line4;
@property(nonatomic,strong)UILabel * ziXunNum;
@property(nonatomic,strong)UILabel * ziXunLaber;
@property(nonatomic,strong)UIView * line5;
@property(nonatomic,strong)UILabel * myZiXunNum;
@property(nonatomic,strong)UILabel * myZiXunLaber;
@property(nonatomic,strong)UIView * line6;
//
@property(nonatomic,strong)UILabel * mySaveNum;
@property(nonatomic,strong)UILabel * mySaveLaber;
@property(nonatomic,strong)UIView * line7;

//第一行
@property(nonatomic,strong)UILabel *  areaLaber;
@property(nonatomic,strong)UILabel * area;
@property(nonatomic,strong)UILabel * company;
@property(nonatomic,strong)UILabel * exhibition_no;
@property(nonatomic,strong)UILabel * certificate_no;
@property(nonatomic,strong)UILabel * oname;
@property(nonatomic,strong)UILabel * address;
//

@property(nonatomic,strong)NSString * selAgentID;

//
@property(nonatomic,strong)NSMutableArray * messArry;
@property(nonatomic,strong)NSMutableArray * daraArry;
@property(nonatomic,strong)NSMutableArray * newsArry;

@property(nonatomic,strong)NSString * agentID;
@property(nonatomic,strong)NSString * tel ;
@property(nonatomic,strong)NSString * isfollow;
@property(nonatomic,strong)NSString * sexUrl;
@property(nonatomic,strong)NSString * imgUrl;
@property(nonatomic,strong)NSString * strService;
@property(nonatomic,strong)NSString * strArea;
@property(nonatomic,strong)NSString * strJob;
@property(nonatomic,strong)NSString * strExh;
@property(nonatomic,strong)NSString * strOname;
@property(nonatomic,strong)NSString * strCname;
@property(nonatomic,strong)NSString * strCert;

//
@property(nonatomic,strong)UITextView * Mytextview;
@property(nonatomic,strong)NSString * strIntru;
//
@property (nonatomic , strong) NSMutableArray *items;
@property(nonatomic,assign)NSInteger  i ;

@property (nonatomic, copy) NSString *url;

@property(nonatomic,assign) BOOL follow;
@end

@implementation WHministaViewController
@synthesize items = _items;


- (void)viewDidLoad {
    [super viewDidLoad];
    self.messArry = [NSMutableArray array];
    self.daraArry = [NSMutableArray array];
    self.newsArry = [NSMutableArray array];
    
    
    [self requestData1];
    
    [self setData ];

    [self setupUI];
    self.section = 0 ;
    self.section2 = 1;
    floag = YES;
    flg = YES;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"wh_more"] style:UIBarButtonItemStylePlain target:self action:@selector(ringAction:)];
    
}
-(void)ringAction:(UIBarButtonItem *)sender
{
    if (sender == self.navigationItem.rightBarButtonItem) {
        [YCXMenu setTintColor:[UIColor colorWithHex:0x4367FF]];
        [YCXMenu setSelectedColor:[UIColor redColor]];
        if ([YCXMenu isShow])
        {
            [YCXMenu dismissMenu];
        } else {
            [YCXMenu showMenuInView:self.view fromRect:CGRectMake(self.view.frame.size.width - 50, 0, 50, 0) menuItems:self.items selected:^(NSInteger index, YCXMenuItem *item)
             {
             }];
        }
    }
    
    
}
- (NSMutableArray *)items {
    if (!_items) {
        YCXMenuItem *CollectItem = [YCXMenuItem menuItem:@"关注" image:nil target:self action:@selector(collect:)];
        CollectItem.foreColor = [UIColor whiteColor];
        CollectItem.alignment = NSTextAlignmentRight;
        CollectItem.image = [UIImage imageNamed:@"wh_attend"];
        
        YCXMenuItem *ShareItem = [YCXMenuItem menuItem:@"分享" image:nil target:self action:@selector(share:)];
        ShareItem.foreColor = [UIColor whiteColor];
        ShareItem.alignment = NSTextAlignmentRight;
        ShareItem.image = [UIImage imageNamed:@"wh_share"];
        _items = [@[CollectItem, ShareItem
                    ] mutableCopy];
        
    }
    return _items;
    
}
- (void)setItems:(NSMutableArray *)items {
    _items = items;
}
//关注
-(void)collect:(UIButton *)sender
{
//    id hud = [JGProgressHelper showProgressInView:self.view];
//    if ([self.isfollow isEqualToString:@"1"]) {
//        _follow = YES;
//    }
//    else
//    {
//        _follow = NO;
//    }
//    if (_follow == NO) {
//        [self.userService getsaveFollowWithUid:@"" agent_uid:@"" success:^{
//                            [hud hide: YES];
//                            [JGProgressHelper showSuccess:@"关注成功"];
//            _follow = YES;
//            
//            [self.tableV reloadData];
//                        } failure:^(NSError *error) {
//                            [hud hide:YES];
//                            [JGProgressHelper showError:@"关注失败"];
//                        }];
//                    }
//    if (_follow == YES) {
//        [JGProgressHelper showError:@"该代理人已经关注过"];
//        _follow = NO;
//        [self.tableV reloadData];
//    }
   

    
    self.i ++;
    if (self.i % 2 == 0) {
        
        id hud = [JGProgressHelper showProgressInView:self.view];
        if ([self.isfollow isEqualToString:@"1"]) {
            [hud hide:YES];
            
            [JGProgressHelper showError:@"该代理人已经关注过"];
            
        }
        else
        {
            [self.userService getsaveFollowWithUid:@"" agent_uid:@"" success:^{
                [hud hide: YES];
                [JGProgressHelper showSuccess:@"关注成功"];
                
            } failure:^(NSError *error) {
                [hud hide:YES];
                [JGProgressHelper showError:@"关注失败"];
            }];
        }
    }
    else
    {
        id hud = [JGProgressHelper showProgressInView:self.view];
        [self.userService followWithUid:@"" agent_uid:@"" success:^{
            [hud hide:YES];
            [JGProgressHelper showError:@"取消关注成功"];
            
        } failure:^(NSError *error) {
            [hud hide:YES];
            [JGProgressHelper showError:@"取消关注失败"];
        }];
        
    }
    
    
    
}

//分享
-(void)share:(UIButton *)sender
{
    
    self.url = [NSString stringWithFormat:@"%@/%@", BASE_REST_URL, self.agentID];
    [UMSocialData defaultData].extConfig.title = @"互联网+保险智能化云服务平台";
    [UMSocialData defaultData].extConfig.qqData.url = self.url;
    [UMSocialData defaultData].extConfig.qzoneData.url = self.url;
    
    [UMSocialData defaultData].extConfig.wechatSessionData.url = self.url;
    [UMSocialData defaultData].extConfig.wechatTimelineData.url = self.url;
    
    NSString *shareText = [NSString stringWithFormat:@"%@, %@", @"快保家", self.url];
    [[UMSocialData defaultData].extConfig.sinaData setShareText:shareText];
    [[UMSocialData defaultData].extConfig.tencentData setShareText:shareText];
    
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"576bac6d67e58e0b6b000a36"
                                      shareText:[NSString stringWithFormat:@"%@", @"快保家"]
                                     shareImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.imgUrl]]]
                                shareToSnsNames:@[UMShareToWechatSession, UMShareToWechatTimeline, UMShareToSina, UMShareToQQ, UMShareToQzone, UMShareToTencent]
                                       delegate:self];
    
    
}


// 请求数据
-(void)requestData1
{
    __weak WHministaViewController * mySelf =self;
    if ([self.selectDiffent isEqualToString:@"1"] )
    {
        self.selAgentID = self.StrAgentId;
    }
    else
    {
        self.selAgentID = [JwUserCenter sharedCenter].uid;
    }
    id  hud = [JGProgressHelper showProgressInView:self.view];

    [self.dataService getMicroWithAgent_uid:self.selAgentID?self.selAgentID:@""  uid:@"" success:^(NSArray *lists)
     {
         [hud hide:YES];
         
         if (lists.count >= 1)
         {
             WHmin * model = lists[0];
             
             mySelf.chanPinNum.text = model.count.pro_count;
             mySelf.ziXunNum.text = model.count.news_count;
             mySelf.myZiXunNum.text = model.count.message_count;
             mySelf.mySaveNum.text = model.count.customer_count;
             
             [mySelf.messArry addObjectsFromArray:model.message];
             [mySelf.daraArry addObjectsFromArray:model.pro];
             [mySelf.newsArry addObjectsFromArray:model.news];
             if (model.honor.count >=1)
             {
//                 for (WHgethonor * Img in model.honor)
//                 {
//                     [mySelf.ImgArry addObject:Img.img1];
//                 }
                 
             }
             
             if (model.agent_info.count >= 1)
             {
                 
                 
                 WHagentinfo * info = model.agent_info[0];
                 mySelf.agentID = info.id;
                 mySelf.nameLaber.text = info.name;
                 mySelf.yearLaber.text = info.age;
                 //电话号码
                 mySelf.tel = info.mobile;
                 //是否已经关注
                 mySelf.isfollow = info.is_follow;
                 if (info.sex)
                 {
                     mySelf.sexUrl = info.sex;
                     
                     NSInteger  a = [info.sex integerValue];
                     if (a == 1)
                     {
                         mySelf.sexImage.image = [UIImage imageNamed:@"test_male"];
                         
                     }else
                     {
                         mySelf.sexImage.image = [UIImage imageNamed:@"test_famale"];
                     }
                     
                 }
                 
                 [mySelf.headImage sd_setImageWithURL:[NSURL URLWithString:info.avatar] placeholderImage:[UIImage imageNamed:@"Jw_user"]];
                 mySelf.imgUrl = info.avatar;//头像图标
                 mySelf.companyLaber.text = [NSString stringWithFormat:@"%@%@%@%@",info.cname,info.profession,info.work_time,info.service_area];
                 
                 self.strService = info.service_area;
                 self.strArea = info.area_info;
                 self.strJob = info.job_address;
                 self.strExh = info.exhibition_no;
                 self.strCert = info.certificate_no;
                 self.strOname = info.oname;
                 self.strCname = info.cname;
                 
             }
             
             
             
             
         }
         
         
         [mySelf.tableV reloadData];
         
     } failure:^(NSError *error) {
         [hud hide:YES];
         [JGProgressHelper  showError:@""];
         
     }];
    

    
    
}
//请求个人介绍
-(void)setData
{
    __weak WHministaViewController * mySelf = self;
    id hud = [JGProgressHelper showProgressInView:self.view];
    
    [self.dataService getintroduceWithUid:@"" success:^(NSArray *lists)
     {
         [hud hide:YES];
         
         for (WHgetintroduce * model in lists)
         {
             
             mySelf.strIntru = model.introduce;
         }
         [mySelf.tableV reloadData];
         
     } failure:^(NSError *error)
     {
         [hud hide:YES];
         [JGProgressHelper showError:@""];
         
     }];
    
    
    

    
    
}
-(void)setupUI
{
    self.title = @"微站";
    self.tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWitdh, kScreenHeight  - 64) style:(UITableViewStylePlain)];
    _tableV.delegate = self;
    _tableV.dataSource = self;
    _tableV.separatorInset = UIEdgeInsetsMake(0, 10, 0, 10);
    //
    self.headView = [[UIView alloc]init];
    self.headView.frame = CGRectMake(0, 0, kScreenWitdh , kScreenHeight * 0.22);
    //[self.view addSubview:_headView];
    //self.headView.backgroundColor = [UIColor redColor];
    self.tableV.tableHeaderView = _headView;
    [self.view addSubview:_tableV];
    
//    [self.tableV registerClass:[WHminTableViewCell class] forCellReuseIdentifier:@"cell1"];
    [self.tableV registerClass:[WHprevTableViewCell class] forCellReuseIdentifier:@"cell1"];
    [self.tableV registerClass:[WHmessageListTableViewCell class] forCellReuseIdentifier:@"cell2"];
    [self.tableV registerClass:[WHcounselTableViewCell class] forCellReuseIdentifier:@"cell3"];
    //
    
    self.headImage = [[UIImageView alloc]init];
    self.headImage.frame = CGRectMake(20, 10, kScreenWitdh * 0.15, kScreenWitdh *0.15);
    self.headImage.layer.masksToBounds = YES;
    self.headImage.layer.cornerRadius = kScreenWitdh *0.075;
    // self.headImage.image = [UIImage imageNamed:@"test_head"];
    [self.headView addSubview:_headImage];
  
    self.nameLaber = [[UILabel alloc]init];
    self.nameLaber.frame = CGRectMake(CGRectGetMaxX(self.headImage.frame)+5, CGRectGetMinY(self.headImage.frame), kScreenWitdh* 0.15, kScreenWitdh * 0.08);
    //self.nameLaber.text = @"周星星";
    self.nameLaber.font = [UIFont systemFontOfSize:15.0];
    [self.headView addSubview:_nameLaber];
  
    self.sexImage = [[UIImageView alloc]init];
    self.sexImage.frame = CGRectMake(CGRectGetMaxX(self.nameLaber.frame)+3, CGRectGetMinY(self.nameLaber.frame)+3, 20, 20);
    //self.sexImage.image = [UIImage imageNamed:@"test_male"];
    [self.headView addSubview:_sexImage];
    
    self.yearLaber = [[UILabel alloc]init];
    self.yearLaber.frame = CGRectMake(CGRectGetMaxX(self.sexImage.frame)+3, CGRectGetMinY(self.sexImage.frame), kScreenWitdh * 0.1, 20);
    self.yearLaber.textColor = [UIColor grayColor];
    self.yearLaber.font = [UIFont systemFontOfSize:13.0];
   //  self.yearLaber.text = @"36岁";
    [self.headView addSubview:_yearLaber];
    
    self.companyLaber = [[UILabel alloc]init];
    self.companyLaber.frame = CGRectMake(CGRectGetMinX(self.nameLaber.frame),CGRectGetMaxY(self.nameLaber.frame),  kScreenWitdh * 0.4, 20);
    //self.companyLaber.text = @"新华人寿 经理 从业5年 全国";
    self.companyLaber.font = [UIFont systemFontOfSize:11.0];
    self.companyLaber.textColor = [UIColor grayColor];
    [self.headView addSubview:_companyLaber];
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
    self.line1 = [[UIView alloc]init];
    self.line1.frame = CGRectMake(20, CGRectGetMaxY(self.headImage.frame)+10, kScreenWitdh - 40, 0.5);
    self.line1.backgroundColor = [UIColor lightGrayColor];
    [self.headView addSubview:_line1];
    //
    self.line2 = [[UIView alloc]init];
    self.line2.frame = CGRectMake(20, kScreenHeight * 0.22-2, kScreenWitdh - 40, 0.5);
    self.line2.backgroundColor = [UIColor lightGrayColor];
    [self.headView addSubview:_line2];
    //
    self.line3 = [[UIView alloc]init];
    self.line3.frame = CGRectMake(20, CGRectGetMinY(self.line1.frame), 0.5, CGRectGetMinY(self.line2.frame)-CGRectGetMaxY(self.line1.frame));
    self.line3.backgroundColor = [UIColor lightGrayColor];
    [self.headView addSubview:_line3];
    
    //
    self.chanPinNum = [[UILabel alloc]init];
    self.chanPinNum.frame = CGRectMake(kScreenWitdh * 0.15, CGRectGetMaxY(self.line1.frame)+5, 30, 20);
    self.chanPinNum.textColor = [UIColor greenColor];
    self.chanPinNum.text = @"2";
    [self.headView addSubview:_chanPinNum];
    self.chanPinLaber = [[UILabel alloc]init];
    self.chanPinLaber.frame = CGRectMake(kScreenWitdh *0.12, CGRectGetMaxY(self.chanPinNum.frame), 40, 20);
    self.chanPinLaber.text = @"产品";
    self.chanPinLaber.font = [UIFont systemFontOfSize:13.0];
    [self.headView addSubview:_chanPinLaber];
    //
    self.line4 = [[UIView alloc]init];
    self.line4.frame = CGRectMake(kScreenWitdh * 0.28, CGRectGetMinY(self.line1.frame), 0.5, CGRectGetHeight(self.line3.frame));
    self.line4.backgroundColor = [UIColor lightGrayColor];
    [self.headView addSubview:_line4];
    //
    self.ziXunNum = [[UILabel alloc]init];
    self.ziXunNum.frame = CGRectMake(kScreenWitdh * 0.35, CGRectGetMinY(self.chanPinNum.frame), CGRectGetWidth(self.chanPinNum.frame)*1.2, CGRectGetHeight(self.chanPinNum.frame));
    self.ziXunNum.textColor = [UIColor blueColor];
    //self.ziXunNum.text = @"662";
    [self.headView addSubview:_ziXunNum];
    //
    self.ziXunLaber = [[UILabel alloc]init];
    self.ziXunLaber.frame = CGRectMake(kScreenWitdh * 0.36, CGRectGetMinY(self.chanPinLaber.frame), CGRectGetWidth(self.chanPinLaber.frame), CGRectGetHeight(self.chanPinLaber.frame));
    self.ziXunLaber.font = [UIFont systemFontOfSize:13.0];
    self.ziXunLaber.text = @"咨询";
    [self.headView addSubview:_ziXunLaber];
    //
    self.line5 = [[UIView alloc]init];
    self.line5.frame = CGRectMake(kScreenWitdh * 0.5, CGRectGetMinY(self.line1.frame), 0.5, CGRectGetHeight(self.line3.frame));
    self.line5.backgroundColor = [UIColor lightGrayColor];
    [self.headView addSubview:_line5];
    //
    self.myZiXunNum = [[UILabel alloc]init];
    self.myZiXunNum.frame = CGRectMake(kScreenWitdh * 0.60, CGRectGetMinY(self.ziXunNum.frame), CGRectGetWidth(self.chanPinNum.frame), CGRectGetHeight(self.chanPinNum.frame));
    self.myZiXunNum.textColor = [UIColor purpleColor];
    //self.myZiXunNum.text = @"0";
    [self.headView addSubview:_myZiXunNum];
    //
    self.myZiXunLaber = [[UILabel alloc]init];
    self.myZiXunLaber.frame = CGRectMake(kScreenWitdh * 0.53, CGRectGetMinY(self.ziXunLaber.frame), CGRectGetWidth(self.chanPinLaber.frame)*2, CGRectGetHeight(self.chanPinLaber.frame));
    self.myZiXunLaber.font = [UIFont systemFontOfSize:13.0];
    self.myZiXunLaber.text = @"我的咨询";
    [self.headView addSubview:_myZiXunLaber];
    //
    self.line6 = [[UIView alloc]init];
    self.line6.frame = CGRectMake(kScreenWitdh * 0.73, CGRectGetMinY(self.line1.frame), 0.5, CGRectGetHeight(self.line3.frame));
    self.line6.backgroundColor = [UIColor lightGrayColor];
    [self.headView addSubview:_line6];
    //
    self.mySaveNum = [[UILabel alloc]init];
    self.mySaveNum.frame = CGRectMake(kScreenWitdh * 0.83, CGRectGetMinY(self.chanPinNum.frame), CGRectGetWidth(self.myZiXunNum.frame), CGRectGetHeight(self.myZiXunNum.frame));
    self.mySaveNum.textColor = [UIColor blueColor];
   // self.mySaveNum.text = @"0";
    [self.headView addSubview:_mySaveNum];
    self.mySaveLaber = [[UILabel alloc]init];
    self.mySaveLaber.frame = CGRectMake(kScreenWitdh * 0.76, CGRectGetMinY(self.chanPinLaber.frame), CGRectGetWidth(self.myZiXunLaber.frame), CGRectGetHeight(self.myZiXunLaber.frame));
    self.mySaveLaber.font = [UIFont systemFontOfSize:13.0];
    self.mySaveLaber.text = @"服务客户";
    [self.headView addSubview:_mySaveLaber];
    //
    self.line7 = [[UIView alloc]init];
    self.line7.frame = CGRectMake(kScreenWitdh-20, CGRectGetMinY(self.line1.frame), 0.5, CGRectGetHeight(self.line3.frame));
    self.line7.backgroundColor = [UIColor lightGrayColor];
    [self.headView addSubview:_line7];
    
    
    
    
    
    
    
}

//信息事件
-(void)messageAction:(UIButton *)sender
{
    //NSLog(@"mseeage");
    WHwantMessageViewController * wantMes = [[WHwantMessageViewController alloc]init];
    wantMes.res_uid = self.agentID;
    wantMes.name = self.nameLaber.text;
    //    NSString * s1 = self.areaLaber.text ;
    //wantMes.cityName = [s1 substringToIndex:2];
    wantMes.cityName = self.areaLaber.text;
    
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
    if (buttonIndex == 0 )
    {
        NSMutableString * str = [[NSMutableString alloc] initWithFormat:@"tel:%@",self.tel];
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
        
    }
}

-(NSInteger )numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == self.section) {
        return 7;
    }
    if (section ==  self.section2) {
       return 1;
    }
    if (section == 2) {
        return  self.daraArry.count;
    }
    if (section == 3 ) {
        return self.messArry.count;
    }
    if (section == 4) {
        return self.newsArry.count;
    }
        return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    

    static NSString * CellIdentifier = @"cell11";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellIdentifier" ];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
        if (indexPath.section == 0 && indexPath.row == 0) {
            cell.textLabel.text = @"执行区域";
            cell.textLabel.textColor = [UIColor grayColor];
            cell.detailTextLabel.textColor = [UIColor grayColor];
            cell.detailTextLabel.font = [UIFont systemFontOfSize:13.0];
            cell.textLabel.font = [UIFont systemFontOfSize:13.0];
            
            self.areaLaber = [[UILabel alloc]init];
            self.areaLaber.frame = CGRectMake(kScreenWitdh * 0.5, CGRectGetMinY(cell.textLabel.frame), kScreenWitdh * 0.4, kScreenHeight * 0.081);
            self.areaLaber.font = [UIFont systemFontOfSize:13.0];
            self.areaLaber.textColor = [UIColor grayColor];
            [cell.contentView addSubview:_areaLaber];
        
            [self.areaLaber setBackgroundColor:[UIColor clearColor]];
              self.areaLaber.text = self.strService;
            
            [self.areaLaber setTag:1];
            
            
            
        }
        if (indexPath.section == 0 && indexPath.row == 1) {
            cell.textLabel.text = @"所属区域";
            cell.textLabel.textColor = [UIColor grayColor];
            cell.detailTextLabel.textColor = [UIColor grayColor];
            cell.detailTextLabel.font = [UIFont systemFontOfSize:13.0];
            cell.textLabel.font = [UIFont systemFontOfSize:13.0];
            //cell.detailTextLabel.text = self.area;
            self.area = [[UILabel alloc]init];
            self.area.frame = CGRectMake(kScreenWitdh * 0.5, CGRectGetMidY(cell.textLabel.frame), kScreenWitdh * 0.4, kScreenHeight * 0.081);
            self.area.font = [UIFont systemFontOfSize:13.0];
            self.area.textColor = [UIColor grayColor];
            self.area.text = self.strArea;
            
            [cell.contentView addSubview:_area];
           
            
        }

        if (indexPath.section == 0 && indexPath.row == 2) {
            cell.textLabel.text = @"所属公司";
            cell.textLabel.textColor = [UIColor grayColor];
            cell.detailTextLabel.textColor = [UIColor grayColor];
            cell.detailTextLabel.font = [UIFont systemFontOfSize:13.0];
            cell.textLabel.font = [UIFont systemFontOfSize:13.0];
            //cell.detailTextLabel.text = self.company;
            self.company = [[UILabel alloc]init];
            self.company.frame = CGRectMake(kScreenWitdh * 0.5, CGRectGetMidY(cell.textLabel.frame), kScreenWitdh * 0.4, kScreenHeight * 0.081);
            self.company.font = [UIFont systemFontOfSize:13.0];
            self.company.textColor = [UIColor grayColor];
            [cell.contentView addSubview:_company];
             self.company.text = self.strCname;
        }
        if (indexPath.section == 0 && indexPath.row == 3) {
            cell.textLabel.text = @"所在机构";
            cell.textLabel.textColor = [UIColor grayColor];
            cell.detailTextLabel.textColor = [UIColor grayColor];
            cell.detailTextLabel.font = [UIFont systemFontOfSize:13.0];
            cell.textLabel.font = [UIFont systemFontOfSize:13.0];
            //cell.detailTextLabel.text = self.oname;
            self.oname = [[UILabel alloc]init];
            self.oname.frame = CGRectMake(kScreenWitdh * 0.5, CGRectGetMidY(cell.textLabel.frame), kScreenWitdh * 0.4, kScreenHeight * 0.081);
            self.oname.font = [UIFont systemFontOfSize:13.0];
            self.oname.textColor = [UIColor grayColor];
            [cell.contentView addSubview:_oname];
          self.oname.text = self.strOname;
        }
        if (indexPath.section == 0 && indexPath.row == 4) {
            cell.textLabel.text = @"机构地址";
            cell.textLabel.textColor = [UIColor grayColor];
            cell.detailTextLabel.textColor = [UIColor grayColor];
            cell.detailTextLabel.font = [UIFont systemFontOfSize:13.0];
            cell.textLabel.font = [UIFont systemFontOfSize:13.0];
            //cell.detailTextLabel.text = self.address;
            self.address = [[UILabel alloc]init];
            self.address.frame = CGRectMake(kScreenWitdh * 0.5, CGRectGetMidY(cell.textLabel.frame), kScreenWitdh * 0.4, kScreenHeight * 0.081);
            self.address.font = [UIFont systemFontOfSize:13.0];
            self.address.textColor = [UIColor grayColor];
            [cell.contentView addSubview:_address];
            self.address.text = self.strJob;
        }
        
        if (indexPath.section == 0 && indexPath.row == 5) {
            cell.textLabel.text = @"资格证书号码";
            cell.textLabel.textColor = [UIColor grayColor];
            cell.detailTextLabel.textColor = [UIColor grayColor];
            cell.detailTextLabel.font = [UIFont systemFontOfSize:13.0];
            cell.textLabel.font = [UIFont systemFontOfSize:13.0];
            //cell.detailTextLabel.text = self.certificate_no;
            self.certificate_no = [[UILabel alloc]init];
            self.certificate_no.frame = CGRectMake(kScreenWitdh * 0.5, CGRectGetMidY(cell.textLabel.frame), kScreenWitdh * 0.4, kScreenHeight * 0.081);
            self.certificate_no.font = [UIFont systemFontOfSize:13.0];
            self.certificate_no.textColor = [UIColor grayColor];
            [cell.contentView addSubview:_certificate_no];
            self.certificate_no.text = self.strCert;
            

            
        }
        if (indexPath.section == 0 && indexPath.row == 6)
        {
            cell.textLabel.text = @"执业证编号";
            cell.textLabel.textColor = [UIColor grayColor];
            cell.detailTextLabel.textColor = [UIColor grayColor];
            cell.detailTextLabel.font = [UIFont systemFontOfSize:13.0];
            cell.textLabel.font = [UIFont systemFontOfSize:13.0];
            //cell.detailTextLabel.text = self.exhibition_no;
            self.exhibition_no = [[UILabel alloc]init];
            self.exhibition_no.frame = CGRectMake(kScreenWitdh * 0.5, CGRectGetMidY(cell.textLabel.frame), kScreenWitdh * 0.4, kScreenHeight * 0.081);
            self.exhibition_no.font = [UIFont systemFontOfSize:13.0];
            self.exhibition_no.textColor = [UIColor grayColor];
            [cell.contentView addSubview:_exhibition_no];
            self.exhibition_no.text = self.strExh;
        }

        if (indexPath.section == 1) {
            //cell.textLabel .text = @"你好";
            self.Mytextview = [[UITextView alloc]init];
            self.Mytextview.frame = CGRectMake(CGRectGetMinX(cell.textLabel.frame), CGRectGetMinY(cell.textLabel.frame), CGRectGetWidth([UIScreen mainScreen].bounds), 40);
            self.Mytextview.textColor = [UIColor grayColor];
            self.Mytextview.font = [UIFont fontWithName:@"Arial" size:16.0];//设置字体名字和字体大小
            
            self.Mytextview.delegate = self;//设置它的委托方法
            
            self.Mytextview.backgroundColor = [UIColor whiteColor];//设置它的背景颜色
            self.Mytextview.scrollEnabled = YES;//是否可以拖动
            self.Mytextview.autoresizingMask = UIViewAutoresizingFlexibleHeight;//自适应高度
            self.Mytextview.text = self.strIntru;
            // NSLog(@"kkkkk%@",self.Mytextview.text);
            [cell.contentView addSubview:_Mytextview];

        }
        if (indexPath.section == 2) {
            //cell.textLabel.text = @"大家好";
            
            WHprevTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell1"forIndexPath:indexPath ];
            
            if (self.daraArry.count>=1)
            {
                WHmicpro * model = self.daraArry[indexPath.row];
                [cell.myImage sd_setImageWithURL:[NSURL URLWithString:model.logo]];
                cell.titLaber.text = model.name;
                cell.ageLaber.text = model.limit_age;
                cell.styLaber.text = model.ptype_name;
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                return cell;
                
            }

        }
        if (indexPath.section == 3) {
            //cell.textLabel.text = @"王八蛋";
            WHmessageListTableViewCell * cell2 = [tableView dequeueReusableCellWithIdentifier:@"cell2" forIndexPath:indexPath];
            WHgetmessage * mes = self.messArry[indexPath.row];
            cell2.myTit.text = mes.message;
            cell2.addressLaber.text = mes.city_name;
            //NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
            NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:mes.create_time.doubleValue];
            
            NSString * s1  = [NSString stringWithFormat:@"%@",confromTimesp];
            cell2.timeLaber.text = [s1 substringToIndex:11];
            cell2.selectionStyle = UITableViewCellSelectionStyleNone;

            return cell2;
            
        }
        if (indexPath.section == 4) {
            //cell.textLabel.text = @"大傻逼";
            WHcounselTableViewCell * cell3 = [tableView dequeueReusableCellWithIdentifier:@"cell3" forIndexPath:indexPath];
            
            if (self.newsArry.count>=1)
            {
                WHnews * news = self.newsArry[indexPath.row];
                [cell3.myImg sd_setImageWithURL:[NSURL URLWithString:news.thumbnail]];
                cell3.myTit.text = news.title;
                NSString * s2 = @"阅读";
                cell3.readNum.text = [news.count stringByAppendingString:s2];
                NSString * s4 = @"类型:";
                if (news.soucre == nil) {
                    news.soucre =@"行业新闻";
                }
                cell3.styLaber.text = [s4 stringByAppendingString:news.soucre];
                NSString * s5 = news.created_time;
                cell3.timeLaber.text = [s5 substringToIndex:11];
                cell3.selectionStyle = UITableViewCellSelectionStyleNone;
                return cell3;
            }
            

        }

    }
    
    
     return cell;
    
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView* customView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, wScreenW, 40.0)];
    if (section == 0 ) {
        UILabel * Laber1 = [[UILabel alloc]init];
        Laber1.frame = CGRectMake(10, 5, wScreenW * 0.5, 30);
        Laber1.text = @"基本信息";
        Laber1.textColor  = [UIColor blueColor];
        [customView addSubview:Laber1];
        //
         xiaBut = [UIButton buttonWithType:(UIButtonTypeSystem)];
        xiaBut.frame = CGRectMake(wScreenW * 0.85, 5, 20, 20);
        if (floag == YES) {
           
            [xiaBut setImage:[UIImage imageNamed:@"p_listUp"] forState:(UIControlStateNormal)];
            

        }else
        {
             [xiaBut setImage:[UIImage imageNamed:@"p_listDown"] forState:(UIControlStateNormal)];
        }
        
        xiaBut.tag = 100;
        [xiaBut addTarget:self action:@selector(aa:) forControlEvents:(UIControlEventTouchUpInside)];
        [customView addSubview:xiaBut];
    }
    if (section == 1) {
        UILabel * Laber1 = [[UILabel alloc]init];
        Laber1.frame = CGRectMake(10, 5, wScreenW * 0.5, 30);
        Laber1.text = @"个人介绍";
        Laber1.textColor = [UIColor blueColor];
        [customView addSubview:Laber1];
        //
        xiaBut = [UIButton buttonWithType:(UIButtonTypeSystem)];
        xiaBut.frame = CGRectMake(wScreenW * 0.85, 5, 20, 20);
        //[xiaBut setImage:[UIImage imageNamed:@"p_listDown"] forState:(UIControlStateNormal)];
        if (flg == YES) {
            
            [xiaBut setImage:[UIImage imageNamed:@"p_listUp"] forState:(UIControlStateNormal)];
            
            
        }else
        {
            [xiaBut setImage:[UIImage imageNamed:@"p_listDown"] forState:(UIControlStateNormal)];
        }

        xiaBut.tag = 101;
        [xiaBut addTarget:self action:@selector(bb:) forControlEvents:(UIControlEventTouchUpInside)];
        [customView addSubview:xiaBut];

    }
    
    if (section == 2) {
        UILabel * Laber1 = [[UILabel alloc]init];
        Laber1.frame = CGRectMake(10, 5, wScreenW * 0.5, 30);
        Laber1.text = @"推荐险种";
        Laber1.textColor = [UIColor blueColor];
        [customView addSubview:Laber1];
        //
        xiaBut = [UIButton buttonWithType:(UIButtonTypeSystem)];
        xiaBut.frame = CGRectMake(wScreenW * 0.85, 5, 20, 20);
        [xiaBut setImage:[UIImage imageNamed:@"p_arrowleft"] forState:(UIControlStateNormal)];
        
        [customView addSubview:xiaBut];

    }
    if (section == 3) {
        UILabel * Laber1 = [[UILabel alloc]init];
        Laber1.frame = CGRectMake(10, 5, wScreenW * 0.5, 30);
        Laber1.text = @"我要留言";
        Laber1.textColor = [UIColor blueColor];
        [customView addSubview:Laber1];
        //
       xiaBut = [UIButton buttonWithType:(UIButtonTypeSystem)];
        xiaBut.frame = CGRectMake(wScreenW * 0.85, 5, 20, 20);
        [xiaBut setImage:[UIImage imageNamed:@"p_arrowleft"] forState:(UIControlStateNormal)];
    
     
        [customView addSubview:xiaBut];

    }
    
    if (section == 4) {
        UILabel * Laber1 = [[UILabel alloc]init];
        Laber1.frame = CGRectMake(10, 5, wScreenW * 0.5, 30);
        Laber1.text = @"保险咨询";
        Laber1.textColor = [UIColor blueColor];
        [customView addSubview:Laber1];
        //
        xiaBut = [UIButton buttonWithType:(UIButtonTypeSystem)];
        xiaBut.frame = CGRectMake(wScreenW * 0.85, 5, 20, 20);
        [xiaBut setImage:[UIImage imageNamed:@"p_arrowleft"] forState:(UIControlStateNormal)];
        
      
        [customView addSubview:xiaBut];

    }
    return customView;
    
}

-(void)aa:(UIButton *)aBtn
{
    
    
    if (self.section == aBtn.tag - 100+ 10) {
        self.section = 0;
        floag = YES;
    }
    else
    {
    self.section = aBtn.tag - 100 +10;
      
        floag = NO;
    }
  
    [self.tableV reloadData];
    
}
-(void)bb:(UIButton *)aBtn
{
    
    if (self.section2 == aBtn.tag - 100 + 20) {
        self.section2 = 1;
       flg = YES;
    }
    else
    {
        self.section2 = aBtn.tag - 100 + 20 ;
        flg = NO;
    }
    
    [self.tableV reloadData];
    
}
//滑到顶部隐藏
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat sectionHeaderHeight = 44;//这里的高度是设置的sectionView的高度
    
    if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
        
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
        
    } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
        
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
        
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44;
}

-(CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        return 100;
    }
    if (indexPath.section == 2) {
        return 120;
    }
    if (indexPath.section == 3) {
        return 80;
    }
    if (indexPath.section == 4) {
        return 100;
    }
    return 45;
}

//选择
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 4)
    {
        WHnews * news = self.newsArry[indexPath.row];
        WHnewsdetailViewController * detal = [[WHnewsdetailViewController alloc]init];
        detal.newsID = news.id;
        detal.newsHeadimg = self.imgUrl;
        detal.newsName = self.nameLaber.text;
        detal.newsSeximg = self.sexUrl;
        detal.newsYear = self.yearLaber.text;
        detal.newsCompany = self.companyLaber.text;
        detal.tel = self.tel;
        detal.agentID = self.agentID;
        [self.navigationController pushViewController:detal animated:YES];
        
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
    
}


@end
