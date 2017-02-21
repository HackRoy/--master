//
//  WHpersonCenterViewController.m
//  whm_project
//
//  Created by 王义国 on 16/10/20.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import "WHpersonCenterViewController.h"
#import "UIColor+Hex.h"
#import "WHupdatePwdViewController.h"
#import "WHaccountDetaTableViewController.h"
#import "WHsetupTableViewController.h"
#import "JGProgressHelper.h"
#import "JwUserCenter.h"
#import "JwLoginController.h"
//微站
#import "WHminiStationTableViewController.h"
#import "WHgetuseinfo.h"
//体检报告
#import "WHmyphysicalTableViewController.h"
#import "WHmyfollowListViewController.h"
#import "WHmycollectViewController.h"

#import <UIImageView+WebCache.h>
#import "WHaboutUsViewController.h"
#import "WHKNetWorkUtils.h"

#import "MacroUtility.h"

#import "WHgetuseinfo.h"
//ceshi
#import "WHgetReportViewController.h"

#import "WHinviteViewController.h"

#import "WHputongTableViewController.h"
//
#import "WHcollectViewController.h"



#define JIN [UIColor colorWithRed:255/255.f green:199/255.f blue:117/255.f alpha:1]

@interface WHpersonCenterViewController ()<UIScrollViewDelegate>
@property(nonatomic,strong)UIView * headview;

@property(nonatomic,strong)UIImageView * myImage;

@property(nonatomic,strong)UILabel * nameLaber;

@property(nonatomic,strong)UIImageView * image;

@property(nonatomic,strong)UIImageView * baojianImage;
@property(nonatomic,strong)UILabel * baojianLaber;

@property(nonatomic,strong)UIImageView * renzhengImage;
@property(nonatomic,strong)UILabel * renzhengLaber;

//button键的创建
@property(nonatomic,strong)UIScrollView * scolw;

@property(nonatomic,strong)UIButton * myBut1;
@property(nonatomic,strong)UIButton * myBut2;
@property(nonatomic,strong)UIButton * myBut3;
@property(nonatomic,strong)UIButton * myBut4;
@property(nonatomic,strong)UIButton * myBut5;
@property(nonatomic,strong)UIButton * myBut6;

@property(nonatomic,strong)UILabel * myLaber1;
@property(nonatomic,strong)UILabel * myLaber2;
@property(nonatomic,strong)UILabel * myLaber3;
@property(nonatomic,strong)UILabel * myLaber4;
@property(nonatomic,strong)UILabel * myLaber5;
@property(nonatomic,strong)UILabel * myLaber6;

@property(nonatomic,strong)UIView * myView1 ;

@property(nonatomic,strong)UIView * myView2;

//
@property(nonatomic,strong)UIButton * myBut7;
@property(nonatomic,strong)UIButton * myBut8;
@property(nonatomic,strong)UIButton * myBut9;
@property(nonatomic,strong)UIButton * myBut10;
@property(nonatomic,strong)UIButton * myBut11;
@property(nonatomic,strong)UIButton * myBut12;

@property(nonatomic,strong)UILabel * myLaber7;
@property(nonatomic,strong)UILabel * myLaber8;
@property(nonatomic,strong)UILabel * myLaber9;
@property(nonatomic,strong)UILabel * myLaber10;
@property(nonatomic,strong)UILabel * myLaber11;
@property(nonatomic,strong)UILabel * myLaber12;

@property(nonatomic,strong)UIView * myView3 ;

@property(nonatomic,strong)UIView * myView4;

@property(nonatomic,strong)UIView * myView5;
@property(nonatomic,strong)UIView * myView6;

@property(nonatomic,strong)NSMutableArray * dateArry;
//
@property(nonatomic,strong)UILabel * companyLaber;

@property(nonatomic,strong)NSMutableArray * userArry;

@property(nonatomic,strong)NSString * str ;
@end

@implementation WHpersonCenterViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    

    
    [self.dataService get_user_infoWithUid:@"" success:^(NSArray *lists)
     {
         
         self.userArry = [NSMutableArray arrayWithArray:lists];
         
         for (WHgetuseinfo * model in  self.userArry)
         {
             self.str = model.type;
             
             if ([model.type isEqualToString:@"1"])
             {
                 [self.scolw clearsContextBeforeDrawing];
                 
                 [self.scolw removeFromSuperview];
                 [self setUI];
             }else
             {
                 [self.scolw clearsContextBeforeDrawing];
                 
                 [self.scolw removeFromSuperview];
                 [self commonUI];
             }
             
            
             
             if ([model.status isEqualToString: @"1"])
             {
                 self.baojianLaber.textColor = JIN;
                 self.renzhengLaber.textColor = JIN;
                 self.baojianImage.image = [UIImage imageNamed:@"baojian"];
                 self.renzhengImage.image = [UIImage imageNamed:@"renzheng"];
                 
             }
             if ([model.status isEqualToString:@"0"])
             {
                 self.baojianLaber.textColor = [UIColor whiteColor];
                 self.renzhengLaber.textColor = [UIColor whiteColor];
                 self.baojianImage.image = [UIImage imageNamed:@"unbaojian"];
                 self.renzhengImage.image = [UIImage imageNamed:@"unrenzheng"];
                 
             }
             
             if ([model.status isEqualToString:@"2"])
             {
                 self.baojianLaber.textColor = [UIColor whiteColor];
                 self.renzhengLaber.textColor = JIN;
                 self.baojianImage.image = [UIImage imageNamed:@"unbaojian"];
                 self.renzhengImage.image = [UIImage imageNamed:@"renzheng"];
                 
             }
             if ([model.status isEqualToString:@"3"])
             {
                 self.baojianLaber.textColor = [UIColor whiteColor];
                 self.renzhengLaber.textColor = JIN;
                 self.baojianImage.image = [UIImage imageNamed:@"unbaojian"];
                 self.renzhengImage.image = [UIImage imageNamed:@"renzheng"];
                 
             }
             if (model.status.length <1) {
                 self.baojianLaber.hidden = YES;
                 self.baojianImage.hidden = YES;
                 self.renzhengImage.hidden = YES;
                 self.renzhengLaber.hidden = YES;
             }
            
             
             [self.myImage sd_setImageWithURL:[NSURL URLWithString:model.avatar] placeholderImage:[UIImage imageNamed:@"Jw_user"]];
             self.nameLaber.text = model.name;
             NSString * s1 = @"(";
             NSString * s2 = @")";
             
             if (model.company == nil)
             {
                 model.company  =  @"暂无公司";
                 NSString * s3 =[s1 stringByAppendingString:model.company];
                 self.companyLaber.text = [s3 stringByAppendingString:s2];
             }
             else
             {
                 NSString * s3 =[s1 stringByAppendingString:model.company];
                 self.companyLaber.text = [s3 stringByAppendingString:s2];
                 
             }
             
             
         }
         
         
     } failure:^(NSError *error) {
         // [hud hide:YES];
         [JGProgressHelper showError:@""];
         
     }];

          
}

-(void)requestData
{
    //    1304 @"uid":[JwUserCenter sharedCenter].uid,
//    @"token":[JwUserCenter sharedCenter].key
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    
    [dic setObject:[WBYRequest jiami:@"kbj/get_user_info"] forKey:@"kb"];
    [dic setObject:[JwUserCenter sharedCenter].uid forKey:@"uid"];
    [dic setObject:[JwUserCenter sharedCenter].key forKey:@"token"];

    [WBYRequest wbyPostRequestDataUrl:@"kbj/get_user_info" addParameters:dic success:^(WBYReqModel *model)
    {
        
        [_userArry removeAllObjects];
        
        if ([model.err isEqualToString:TURE])
        {
            [_userArry addObjectsFromArray:model.data];
            
        }else if ([model.err isEqualToString:SAME])
        {
            [self presentViewController:[JwLoginController new] animated:YES completion:nil];
            NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
            [user removeObjectForKey:[JwUserCenter sharedCenter].uid];
            [user removeObjectForKey:[JwUserCenter sharedCenter].key];
            [user synchronize];
        }
        
    } failure:^(NSError *error)
    {
        
    } isRefresh:YES];
    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
//    self.userArry = [NSMutableArray array];
    self.userArry = [NSMutableArray array];
    [self dataBase];
 

}

-(void)commonUI
{
    
    self.scolw.delegate = self;
    self.scolw = [[UIScrollView alloc]init];
    self.scolw.frame = CGRectMake(0, -3, CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetHeight([UIScreen mainScreen].bounds ));
    self.scolw.contentSize = CGSizeMake(CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetHeight([UIScreen mainScreen].bounds));
    [self.view addSubview:_scolw];
    
    self.image= [[UIImageView alloc]init];
    self.image.frame = CGRectMake(0,-3 , CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetHeight([UIScreen mainScreen].bounds)*0.25);
    self.image.image = [UIImage imageNamed:@"Hm_black.png"];
    [self.scolw addSubview:_image];
    
    // [self.view addSubview:_headview];
    
    self.myImage = [[UIImageView alloc]init];
    self.myImage.frame = CGRectMake(CGRectGetWidth([UIScreen mainScreen].bounds)*0.42, 10, CGRectGetWidth([UIScreen mainScreen].bounds)*0.14, CGRectGetWidth([UIScreen mainScreen].bounds)*0.14);
    //self.myImage.image = [UIImage imageNamed:@"Hm_head.png"];
    // [self.myImage sd_setImageWithURL:[NSURL URLWithString:self.headimage]];
    self.myImage.layer.masksToBounds = YES;
    self.myImage.layer.cornerRadius = CGRectGetWidth([UIScreen mainScreen].bounds)*0.14/2;
    
    [self.scolw addSubview:_myImage];
    //图片点击事件触发账户详情
    self.myImage.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *singleTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClickImage)];
    [self.myImage addGestureRecognizer:singleTap];
    
    //
    
    self.nameLaber = [[UILabel alloc]init];
    
    self.nameLaber.frame = CGRectMake(CGRectGetWidth([UIScreen mainScreen].bounds)*0.42, CGRectGetMaxY(self.myImage.frame)+15, CGRectGetWidth([UIScreen mainScreen].bounds)*0.17, 20);
    // self.nameLaber.text = @"孙一心( 康泰人寿 ) >";
    self.nameLaber.textColor = [UIColor whiteColor];
    self.nameLaber.font = [UIFont systemFontOfSize:16.0];
    [self.scolw addSubview:_nameLaber];
    //
    self.companyLaber = [[UILabel alloc]init];
    self.companyLaber.frame = CGRectMake(CGRectGetMaxX(self.nameLaber.frame), CGRectGetMinY(self.nameLaber.frame), CGRectGetWidth([UIScreen mainScreen].bounds)*0.30, 20);
    self.companyLaber.textColor = [UIColor whiteColor];
    self.companyLaber.font =[UIFont systemFontOfSize:16.0];
   // [self.scolw addSubview:_companyLaber];
    
    //
    self.baojianImage = [[UIImageView alloc]init];
    self.baojianImage.frame = CGRectMake(CGRectGetMinX(self.nameLaber.frame), CGRectGetMaxY(self.nameLaber.frame)+5, 20, 20);
   // self.baojianImage.image = [UIImage imageNamed:@"baojian.png"];
    [self.scolw addSubview:_baojianImage];
    //
    self.baojianLaber = [[UILabel alloc]init];
    self.baojianLaber.frame = CGRectMake(CGRectGetMaxX(self.baojianImage.frame)+2, CGRectGetMinY(self.baojianImage.frame), CGRectGetWidth(self.baojianImage.frame)*2.5, CGRectGetHeight(self.baojianImage.frame));
    self.baojianLaber.text = @"保监认证";
   // self.baojianLaber.textColor = [UIColor whiteColor];
    self.baojianLaber.font = [UIFont systemFontOfSize:11.0];
    [self.scolw addSubview:_baojianLaber];
    
    //
    self.renzhengImage = [[UIImageView alloc]init];
    self.renzhengImage.frame = CGRectMake(CGRectGetMaxX(self.baojianLaber.frame), CGRectGetMinY(self.baojianLaber.frame), CGRectGetWidth(self.baojianImage.frame), CGRectGetHeight(self.baojianImage.frame));
    //self.renzhengImage.image = [UIImage imageNamed:@"renzheng.png"];
    [self.scolw addSubview:_renzhengImage];
    //
    self.renzhengLaber = [[UILabel alloc]init];
    self.renzhengLaber.frame = CGRectMake(CGRectGetMaxX(self.renzhengImage.frame)+2, CGRectGetMinY(self.renzhengImage.frame), CGRectGetWidth(self.baojianLaber.frame)*1.2, CGRectGetHeight(self.baojianLaber.frame));
    //self.renzhengLaber.textColor = [UIColor whiteColor];
    self.renzhengLaber.text = @"快保家认证";
    self.renzhengLaber.font = [UIFont systemFontOfSize:11.0];
    [self.scolw addSubview:_renzhengLaber];
    
    
    
    self.myBut1 = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.myBut1.frame = CGRectMake(20, kScreenHeight * 0.25, CGRectGetWidth([UIScreen mainScreen].bounds)*0.15, CGRectGetWidth([UIScreen mainScreen].bounds)*0.15);
    
    [self.myBut1 setBackgroundImage:[UIImage imageNamed:@"myhome.png"] forState:(UIControlStateNormal)];
    [self.scolw addSubview:_myBut1];
    
    //
    self.myLaber1 = [[UILabel alloc]init];
    self.myLaber1.frame = CGRectMake(CGRectGetMinX(self.myBut1.frame), CGRectGetMaxY(self.myBut1.frame)+10, CGRectGetWidth(self.myBut1.frame)*1.5, 20);
    self.myLaber1.text = @"我的家人";
    self.myLaber1.font = [UIFont systemFontOfSize:13.0];
    self.myLaber1.textColor = [UIColor colorWithHex:0x666666];
    [self.scolw addSubview:_myLaber1];
    
    
    self.myBut2 = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.myBut2.frame = CGRectMake(CGRectGetWidth([UIScreen mainScreen].bounds)*0.4, CGRectGetMinY(self.myBut1.frame), CGRectGetWidth(self.myBut1.frame), CGRectGetHeight(self.myBut1.frame));
    [self.myBut2 setBackgroundImage:[UIImage imageNamed:@"baodan.png"] forState:(UIControlStateNormal)];
    [self.scolw addSubview:_myBut2];
    //
    self.myLaber2 = [[UILabel alloc]init];
    self.myLaber2.frame = CGRectMake(CGRectGetMinX(self.myBut2.frame), CGRectGetMinY(self.myLaber1.frame), CGRectGetWidth(self.myLaber1.frame)*1.2, CGRectGetHeight(self.myLaber1.frame));
    self.myLaber2.text = @"我的保单";
    self.myLaber2.textColor = [UIColor colorWithHex:0x666666];
    self.myLaber2.font = [UIFont systemFontOfSize:13.0];
    [self.scolw addSubview:_myLaber2];
    
    self.myBut3 = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.myBut3.frame = CGRectMake(CGRectGetWidth([UIScreen mainScreen].bounds)*0.75, CGRectGetMinY(self.myBut1.frame), CGRectGetWidth(self.myBut1.frame), CGRectGetHeight(self.myBut1.frame));
    [self.myBut3 setBackgroundImage:[UIImage imageNamed:@"shoucang.png"] forState:(UIControlStateNormal)];
    [self.scolw addSubview:_myBut3];

    self.myLaber3 = [[UILabel alloc] init];
    self.myLaber3.frame = CGRectMake(CGRectGetMinX(self.myBut3.frame), CGRectGetMinY(self.myLaber2.frame), CGRectGetWidth(self.myLaber2.frame), CGRectGetHeight(self.myLaber2.frame));
    self.myLaber3.text = @"我的收藏";
    self.myLaber3.font = [UIFont systemFontOfSize:13.0];
    self.myLaber3.textColor = [UIColor colorWithHex:0x666666];
    [self.scolw addSubview:_myLaber3];
   
    
    self.myView1 = [[UIView alloc]init];
    self.myView1.frame = CGRectMake(0, CGRectGetMaxY(self.myLaber1.frame)+10, CGRectGetWidth([UIScreen mainScreen].bounds), 1);
    self.myView1.backgroundColor = [UIColor colorWithRed:0.871 green:0.875 blue:0.878 alpha:1];
    [self.scolw addSubview:_myView1];
    
    self.myView2 = [[UIView alloc]init];
    self.myView2.frame = CGRectMake(0, CGRectGetMaxY(self.myLaber4.frame)+10, CGRectGetWidth(self.myView1.frame), 1);
    self.myView2.backgroundColor = [UIColor colorWithRed:0.871 green:0.875 blue:0.878 alpha:1];
    //
    self.myBut7 = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.myBut7.frame = CGRectMake(CGRectGetMinX(self.myBut1.frame), kScreenHeight * 0.45, CGRectGetWidth(self.myBut1.frame), CGRectGetHeight(self.myBut1.frame));
    [self.myBut7 setBackgroundImage:[UIImage imageNamed:@"guanzhu.png"] forState:(UIControlStateNormal)];
    [self.scolw addSubview:_myBut7];
    //
    self.myLaber7 = [[UILabel alloc]init];
    self.myLaber7.frame = CGRectMake(CGRectGetMinX(self.myLaber1.frame), CGRectGetMaxY(self.myBut7.frame)+10, CGRectGetWidth(self.myLaber1.frame), CGRectGetHeight(self.myLaber1.frame));
    self.myLaber7.text = @"我的关注";
    self.myLaber7.font = [UIFont systemFontOfSize:13.0];
    self.myLaber7.textColor = [UIColor colorWithHex:0x666666];
    [self.scolw addSubview:_myLaber7];
    
    self.myBut8 = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.myBut8.frame = CGRectMake(CGRectGetMinX(self.myBut2.frame), CGRectGetMinY(self.myBut7.frame), CGRectGetWidth(self.myBut7.frame), CGRectGetHeight(self.myBut7.frame));
    
    [self.myBut8 setBackgroundImage:[UIImage imageNamed:@"we.png"] forState:(UIControlStateNormal)];
    [self.scolw addSubview:_myBut8];
    //
    self.myLaber8 = [[UILabel alloc]init];
    self.myLaber8.frame = CGRectMake(CGRectGetMinX(self.myLaber2.frame), CGRectGetMinY(self.myLaber7.frame), CGRectGetWidth(self.myLaber2.frame), CGRectGetHeight(self.myLaber2.frame));
    self.myLaber8.text = @"关于我们";
    self.myLaber8.textColor = [UIColor colorWithHex:0x666666];
    self.myLaber8.font = [UIFont systemFontOfSize:13.0];
    [self.scolw addSubview:_myLaber8];
    
    self.myBut9 = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.myBut9.frame = CGRectMake(CGRectGetMinX(self.myBut3.frame), CGRectGetMinY(self.myBut8.frame), CGRectGetWidth(self.myBut8.frame), CGRectGetHeight(self.myBut8.frame));
    [self.myBut9 setBackgroundImage:([UIImage imageNamed:@"mima.png"]) forState:(UIControlStateNormal)];
    [self.scolw addSubview:_myBut9];
    
    //
    self.myLaber9 = [[UILabel alloc]init];
    self.myLaber9.frame = CGRectMake(CGRectGetMinX(self.myLaber3.frame), CGRectGetMinY(self.myLaber8.frame), CGRectGetWidth(self.myLaber8.frame), CGRectGetHeight(self.myLaber8.frame));
    self.myLaber9.text = @"修改密码";
    self.myLaber9.font = [UIFont systemFontOfSize:13.0];
   [self.scolw addSubview:_myLaber9];
    self.myLaber9.textColor = [UIColor colorWithHex:0x666666];
    
    self.myView3 = [[UIView alloc]init];
    self.myView3.frame = CGRectMake(0, CGRectGetMaxY(self.myLaber7.frame)+20, CGRectGetWidth(self.myView2.frame), 1);
    self.myView3.backgroundColor = [UIColor colorWithRed:0.871 green:0.875 blue:0.878 alpha:1];
    [self.scolw addSubview:_myView3];
    //
    
    self.myBut10 = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.myBut10.frame = CGRectMake(CGRectGetMinX(self.myBut7.frame), kScreenHeight * 0.65, CGRectGetWidth(self.myBut7.frame), CGRectGetHeight(self.myBut7.frame));
    [self.myBut10 setBackgroundImage:[UIImage imageNamed:@"shezhi.png"] forState:(UIControlStateNormal)];
    [self.scolw addSubview:_myBut10];
    //
    self.myLaber10 = [[UILabel alloc]init];
    self.myLaber10.frame = CGRectMake(CGRectGetMinX(self.myLaber7.frame)+8, CGRectGetMaxY(self.myBut10.frame)+10, CGRectGetWidth(self.myLaber7.frame), CGRectGetHeight(self.myLaber7.frame));
    self.myLaber10.text = @"设置";
    self.myLaber10.textColor = [UIColor colorWithHex:0x666666];
    self.myLaber10.font = [UIFont systemFontOfSize:13.0];
    [self.scolw addSubview:_myLaber10];
    
    //
    self.myView5 = [[UIView alloc]init];
    self.myView5.frame = CGRectMake(CGRectGetWidth([UIScreen mainScreen].bounds)*0.3, CGRectGetMaxY(self.image.frame),1, CGRectGetHeight([UIScreen mainScreen].bounds)*0.8);
    
    self.myView5.backgroundColor = [UIColor colorWithRed:0.871 green:0.875 blue:0.878 alpha:1];
    [self.scolw addSubview:_myView5];
    
    //
    self.myView6 = [[UIView alloc]init];
    self.myView6.frame = CGRectMake(CGRectGetWidth([UIScreen mainScreen].bounds)*0.65, CGRectGetMinY(self.myView5.frame),1, CGRectGetHeight([UIScreen mainScreen].bounds)*0.8);
    self.myView6.backgroundColor = [UIColor colorWithRed:0.871 green:0.875 blue:0.878 alpha:1];
    [self.scolw addSubview:_myView6];
    
    [self.myBut9 addTarget:self action:@selector(updatePwd:) forControlEvents:(UIControlEventTouchUpInside)];
    //
    [self.myBut10 addTarget:self action:@selector(whsetAction:) forControlEvents:(UIControlEventTouchUpInside)];
    //微站
    //[self.myBut9 addTarget:self action:@selector(miniStation:) forControlEvents:(UIControlEventTouchUpInside)];
    //体检报告
   // [self.myBut2 addTarget:self action:@selector(physicalAction:) forControlEvents:(UIControlEventTouchUpInside)];
    //我的家人
    [self.myBut1 addTarget:self action:@selector(physicalAction1:) forControlEvents:(UIControlEventTouchUpInside)];
    //我的保单
    [self.myBut2 addTarget:self action:@selector(physicalAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.myBut7 addTarget:self action:@selector(myfollowAction:) forControlEvents:(UIControlEventTouchUpInside)];
    //我的收藏
    [self.myBut3 addTarget:self action:@selector(mycollectAction:) forControlEvents:(UIControlEventTouchUpInside)];
    //关于我们
    [self.myBut8 addTarget:self action:@selector(aboutUsAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
}

-(void)setUI
{
    self.scolw.delegate = self;
    self.scolw = [[UIScrollView alloc]init];
    self.scolw.frame = CGRectMake(0, -3, CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetHeight([UIScreen mainScreen].bounds ));
    self.scolw.contentSize = CGSizeMake(CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetHeight([UIScreen mainScreen].bounds));
    [self.view addSubview:_scolw];
    
    self.image= [[UIImageView alloc]init];
    self.image.frame = CGRectMake(0,-3 , CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetHeight([UIScreen mainScreen].bounds)*0.25);
    self.image.image = [UIImage imageNamed:@"Hm_black.png"];
    [self.scolw addSubview:_image];
    
    // [self.view addSubview:_headview];
    
    self.myImage = [[UIImageView alloc]init];
    self.myImage.frame = CGRectMake(CGRectGetWidth([UIScreen mainScreen].bounds)*0.42, 10, CGRectGetWidth([UIScreen mainScreen].bounds)*0.18, CGRectGetWidth([UIScreen mainScreen].bounds)*0.18);
     //self.myImage.image = [UIImage imageNamed:@"Hm_head.png"];
   // [self.myImage sd_setImageWithURL:[NSURL URLWithString:self.headimage]];
    self.myImage.layer.masksToBounds = YES;
    self.myImage.layer.cornerRadius = CGRectGetWidth([UIScreen mainScreen].bounds)*0.18/2;
    
    [self.scolw addSubview:_myImage];
    //图片点击事件触发账户详情
    self.myImage.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *singleTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClickImage)];
    [self.myImage addGestureRecognizer:singleTap];
    
    self.nameLaber = [[UILabel alloc] init];
    self.nameLaber.frame = CGRectMake(0, CGRectGetMaxY(self.myImage.frame)+10, CGRectGetWidth([UIScreen mainScreen].bounds)*0.42, 20);
   // self.nameLaber.text = @"孙一心( 康泰人寿 ) >";
    self.nameLaber.textColor = [UIColor whiteColor];
    self.nameLaber.font = [UIFont systemFontOfSize:16.0];
    self.nameLaber.textAlignment = NSTextAlignmentRight;
    [self.scolw addSubview:_nameLaber];
    //
    self.companyLaber = [[UILabel alloc]init];
    self.companyLaber.frame = CGRectMake(CGRectGetMaxX(self.nameLaber.frame), CGRectGetMinY(self.nameLaber.frame), CGRectGetWidth([UIScreen mainScreen].bounds)*0.50, 20);
    self.companyLaber.textColor = [UIColor whiteColor];
    self.companyLaber.font =[UIFont systemFontOfSize:16.0];
    self.companyLaber.textAlignment = NSTextAlignmentLeft;
    [self.scolw addSubview:_companyLaber];
    
    //
    self.baojianImage = [[UIImageView alloc]init];
    self.baojianImage.frame = CGRectMake(kScreenWitdh* 0.25, CGRectGetMaxY(self.nameLaber.frame)+5, 20, 20);
    self.baojianImage.image = [UIImage imageNamed:@"baojian.png"];

    [self.scolw addSubview:_baojianImage];
    //
    self.baojianLaber = [[UILabel alloc]init];
    self.baojianLaber.frame = CGRectMake(CGRectGetMaxX(self.baojianImage.frame)+2, CGRectGetMinY(self.baojianImage.frame), CGRectGetWidth(self.baojianImage.frame)*2.5, CGRectGetHeight(self.baojianImage.frame));
    self.baojianLaber.text = @"保监认证";
    self.baojianLaber.textColor = [UIColor whiteColor];
    self.baojianLaber.font = [UIFont systemFontOfSize:11.0];
    [self.scolw addSubview:_baojianLaber];
    
    //
    self.renzhengImage = [[UIImageView alloc]init];
    self.renzhengImage.frame = CGRectMake(CGRectGetMaxX(self.baojianLaber.frame), CGRectGetMinY(self.baojianLaber.frame), CGRectGetWidth(self.baojianImage.frame), CGRectGetHeight(self.baojianImage.frame));
    self.renzhengImage.image = [UIImage imageNamed:@"renzheng.png"];
    [self.scolw addSubview:_renzhengImage];
    //
    self.renzhengLaber = [[UILabel alloc]init];
    self.renzhengLaber.frame = CGRectMake(CGRectGetMaxX(self.renzhengImage.frame)+2, CGRectGetMinY(self.renzhengImage.frame), CGRectGetWidth(self.baojianLaber.frame)*1.2, CGRectGetHeight(self.baojianLaber.frame));
    self.renzhengLaber.textColor = [UIColor whiteColor];
    self.renzhengLaber.text = @"快保家认证";
    self.renzhengLaber.font = [UIFont systemFontOfSize:11.0];
    [self.scolw addSubview:_renzhengLaber];
    

    
    self.myBut1 = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.myBut1.frame = CGRectMake(20, kScreenHeight * 0.25, CGRectGetWidth([UIScreen mainScreen].bounds)*0.15, CGRectGetWidth([UIScreen mainScreen].bounds)*0.15);
    
    [self.myBut1 setBackgroundImage:[UIImage imageNamed:@"myhome.png"] forState:(UIControlStateNormal)];
    [self.scolw addSubview:_myBut1];
    
    //
    self.myLaber1 = [[UILabel alloc]init];
    self.myLaber1.frame = CGRectMake(CGRectGetMinX(self.myBut1.frame), CGRectGetMaxY(self.myBut1.frame)+10, CGRectGetWidth(self.myBut1.frame)*1.5, 20);
    self.myLaber1.text = @"我的家人";
    self.myLaber1.textColor = [UIColor colorWithHex:0x666666];
    self.myLaber1.font = [UIFont systemFontOfSize:13.0];
    [self.scolw addSubview:_myLaber1];
    
    
    //
    self.myBut2 = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.myBut2.frame = CGRectMake(CGRectGetWidth([UIScreen mainScreen].bounds)*0.4, CGRectGetMinY(self.myBut1.frame), CGRectGetWidth(self.myBut1.frame), CGRectGetHeight(self.myBut1.frame));
    [self.myBut2 setBackgroundImage:[UIImage imageNamed:@"baodan.png"] forState:(UIControlStateNormal)];
    [self.scolw addSubview:_myBut2];
    //
    self.myLaber2 = [[UILabel alloc]init];
    self.myLaber2.frame = CGRectMake(CGRectGetMinX(self.myBut2.frame), CGRectGetMinY(self.myLaber1.frame), CGRectGetWidth(self.myLaber1.frame)*1.2, CGRectGetHeight(self.myLaber1.frame));
    self.myLaber2.text = @"我的保单";
    self.myLaber2.textColor = [UIColor colorWithHex:0x666666];
    self.myLaber2.font = [UIFont systemFontOfSize:13.0];
    [self.scolw addSubview:_myLaber2];
    
    
    //
    self.myBut3 = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.myBut3.frame = CGRectMake(CGRectGetWidth([UIScreen mainScreen].bounds)*0.75, CGRectGetMinY(self.myBut1.frame), CGRectGetWidth(self.myBut1.frame), CGRectGetHeight(self.myBut1.frame));
    [self.myBut3 setBackgroundImage:[UIImage imageNamed:@"shoucang.png"] forState:(UIControlStateNormal)];
    [self.scolw addSubview:_myBut3];
    //
    self.myLaber3 = [[UILabel alloc]init];
    self.myLaber3.frame = CGRectMake(CGRectGetMinX(self.myBut3.frame), CGRectGetMinY(self.myLaber2.frame), CGRectGetWidth(self.myLaber2.frame), CGRectGetHeight(self.myLaber2.frame));
    self.myLaber3.text = @"我的收藏";
    self.myLaber3.textColor = [UIColor colorWithHex:0x666666];
    self.myLaber3.font = [UIFont systemFontOfSize:13.0];
    [self.scolw addSubview:_myLaber3];
    //
    self.myView1 = [[UIView alloc]init];
    self.myView1.frame = CGRectMake(0, CGRectGetMaxY(self.myLaber1.frame)+10, CGRectGetWidth([UIScreen mainScreen].bounds), 1);
    self.myView1.backgroundColor = [UIColor colorWithRed:0.871 green:0.875 blue:0.878 alpha:1];
    [self.scolw addSubview:_myView1];
    
    
    
    
    //
    
    self.myBut4 = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.myBut4.frame = CGRectMake(CGRectGetMinX(self.myBut1.frame), CGRectGetMaxY(self.myView1.frame)+20, CGRectGetWidth(self.myBut1.frame), CGRectGetHeight(self.myBut1.frame));
    [self.myBut4 setBackgroundImage:[UIImage imageNamed:@"kehu.png"] forState:(UIControlStateNormal)];
   // [self.scolw addSubview:_myBut4];
    //
    self.myLaber4 = [[UILabel alloc]init];
    self.myLaber4.frame = CGRectMake(CGRectGetMinX(self.myLaber1.frame), CGRectGetMaxY(self.myBut4.frame)+20, CGRectGetWidth(self.myLaber1.frame), CGRectGetHeight(self.myLaber1.frame));
    self.myLaber4.text = @"我的客户";
    self.myLaber4.textColor = [UIColor colorWithHex:0x666666];
    
    self.myLaber4.font = [UIFont systemFontOfSize:13.0];
   // [self.scolw addSubview:_myLaber4];
    
    //
    self.myBut5 = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.myBut5.frame = CGRectMake(CGRectGetMinX(self.myBut2.frame), CGRectGetMinY(self.myBut4.frame), CGRectGetWidth(self.myBut4.frame), CGRectGetHeight(self.myBut4.frame));
    [self.myBut5 setBackgroundImage:[UIImage imageNamed:@"jihuashu.png"] forState:(UIControlStateNormal)];
    
   // [self.scolw addSubview:_myBut5];
    
    //
    self.myLaber5 = [[UILabel alloc]init];
    self.myLaber5.frame = CGRectMake(CGRectGetMinX(self.myLaber2.frame)+3, CGRectGetMinY(self.myLaber4.frame), CGRectGetWidth(self.myLaber2.frame), CGRectGetHeight(self.myLaber2.frame));
    self.myLaber5.text = @"保险计划书";
    self.myLaber5.font = [UIFont systemFontOfSize:13.0];
   // [self.scolw addSubview:_myLaber5];
    
    //
    self.myBut6 = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.myBut6.frame = CGRectMake(CGRectGetMinX(self.myBut3.frame), CGRectGetMinY(self.myBut4.frame), CGRectGetWidth(self.myBut4.frame), CGRectGetHeight(self.myBut4.frame));
    [self.myBut6 setBackgroundImage:[UIImage imageNamed:@"biaoshu.png"] forState:(UIControlStateNormal)];
   // [self.scolw addSubview:_myBut6];
    //
    self.myLaber6 = [[UILabel alloc]init];
    self.myLaber6.frame = CGRectMake(CGRectGetMinX(self.myLaber3.frame), CGRectGetMinY(self.myLaber5.frame), CGRectGetWidth(self.myLaber3.frame), CGRectGetHeight(self.myLaber3.frame));
    self.myLaber6.text = @"我的标书";
    self.myLaber6.textColor = [UIColor colorWithHex:0x666666];
    self.myLaber6.font = [UIFont systemFontOfSize:13.0];
   // [self.scolw addSubview:_myLaber6];
    
    //
    self.myView2 = [[UIView alloc]init];
    self.myView2.frame = CGRectMake(0, CGRectGetMaxY(self.myLaber4.frame)+10, CGRectGetWidth(self.myView1.frame), 1);
    self.myView2.backgroundColor = [UIColor colorWithRed:0.871 green:0.875 blue:0.878 alpha:1];
    //[self.scolw addSubview:_myView2];
    
    //
    self.myBut7 = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.myBut7.frame = CGRectMake(CGRectGetMinX(self.myBut1.frame), kScreenHeight * 0.45, CGRectGetWidth(self.myBut1.frame), CGRectGetHeight(self.myBut1.frame));
    [self.myBut7 setBackgroundImage:[UIImage imageNamed:@"guanzhu.png"] forState:(UIControlStateNormal)];
    [self.scolw addSubview:_myBut7];
    //
    
    self.myLaber7 = [[UILabel alloc]init];
    self.myLaber7.frame = CGRectMake(CGRectGetMinX(self.myLaber1.frame), CGRectGetMaxY(self.myBut7.frame)+10, CGRectGetWidth(self.myLaber1.frame), CGRectGetHeight(self.myLaber4.frame));
    self.myLaber7.text = @"我的关注";
    self.myLaber7.textColor = [UIColor colorWithHex:0x666666];
    self.myLaber7.font = [UIFont systemFontOfSize:13.0];
    [self.scolw addSubview:_myLaber7];
    
    //
    
    self.myBut8 = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.myBut8.frame = CGRectMake(CGRectGetMinX(self.myBut2.frame), CGRectGetMinY(self.myBut7.frame), CGRectGetWidth(self.myBut7.frame), CGRectGetHeight(self.myBut7.frame));
    
    [self.myBut8 setBackgroundImage:[UIImage imageNamed:@"weizhan.png"] forState:(UIControlStateNormal)];
    [self.scolw addSubview:_myBut8];
    //
    self.myLaber8 = [[UILabel alloc]init];
    self.myLaber8.frame = CGRectMake(CGRectGetMinX(self.myLaber2.frame), CGRectGetMinY(self.myLaber7.frame), CGRectGetWidth(self.myLaber2.frame), CGRectGetHeight(self.myLaber2.frame));
    self.myLaber8.text = @"我的微站";
    self.myLaber8.textColor = [UIColor colorWithHex:0x666666];
    self.myLaber8.font = [UIFont systemFontOfSize:13.0];
    [self.scolw addSubview:_myLaber8];
    
    //
    self.myBut9 = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.myBut9.frame = CGRectMake(CGRectGetMinX(self.myBut6.frame), CGRectGetMinY(self.myBut8.frame), CGRectGetWidth(self.myBut8.frame), CGRectGetHeight(self.myBut8.frame));
    [self.myBut9 setBackgroundImage:([UIImage imageNamed:@"yaoqing.png"]) forState:(UIControlStateNormal)];
    [self.scolw addSubview:_myBut9];
    
    //
    self.myLaber9 = [[UILabel alloc]init];
    self.myLaber9.frame = CGRectMake(CGRectGetMinX(self.myLaber6.frame), CGRectGetMinY(self.myLaber8.frame), CGRectGetWidth(self.myLaber8.frame), CGRectGetHeight(self.myLaber8.frame));
    self.myLaber9.text = @"我的邀请";
    self.myLaber9.textColor = [UIColor colorWithHex:0x666666];
    self.myLaber9.font = [UIFont systemFontOfSize:13.0];
    [self.scolw addSubview:_myLaber9];
    
    //
    self.myView3 = [[UIView alloc]init];
    self.myView3.frame = CGRectMake(0, CGRectGetMaxY(self.myLaber7.frame)+20, CGRectGetWidth(self.myView2.frame), 1);
    self.myView3.backgroundColor = [UIColor colorWithRed:0.871 green:0.875 blue:0.878 alpha:1];
    [self.scolw addSubview:_myView3];
    //
    
    self.myBut10 = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.myBut10.frame = CGRectMake(CGRectGetMinX(self.myBut7.frame), kScreenHeight * 0.65, CGRectGetWidth(self.myBut7.frame), CGRectGetHeight(self.myBut7.frame));
    [self.myBut10 setBackgroundImage:[UIImage imageNamed:@"we.png"] forState:(UIControlStateNormal)];
    [self.scolw addSubview:_myBut10];
    //
    self.myLaber10 = [[UILabel alloc]init];
    self.myLaber10.frame = CGRectMake(CGRectGetMinX(self.myLaber7.frame), CGRectGetMaxY(self.myBut10.frame)+10, CGRectGetWidth(self.myLaber7.frame), CGRectGetHeight(self.myLaber7.frame));
    self.myLaber10.text = @"关于我们";
    self.myLaber10.textColor = [UIColor colorWithHex:0x666666];
    self.myLaber10.font = [UIFont systemFontOfSize:13.0];
    [self.scolw addSubview:_myLaber10];
    
    //
    self.myBut11 = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.myBut11.frame = CGRectMake(CGRectGetMinX(self.myBut8.frame), CGRectGetMinY(self.myBut10.frame), CGRectGetWidth(self.myBut10.frame), CGRectGetHeight(self.myBut10.frame));
    [self.myBut11 setBackgroundImage:[UIImage imageNamed:@"mima.png"] forState:(UIControlStateNormal)];
    [self.scolw addSubview:_myBut11];
    
    //
    self.myLaber11 = [[UILabel alloc]init];
    self.myLaber11.frame = CGRectMake(CGRectGetMinX(self.myLaber8.frame), CGRectGetMinY(self.myLaber10.frame), CGRectGetWidth(self.myLaber8.frame), CGRectGetHeight(self.myLaber8.frame));
    self.myLaber11.text = @"修改密码";
    self.myLaber11.textColor = [UIColor colorWithHex:0x666666];
    
    self.myLaber11.font = [UIFont systemFontOfSize:13.0];
    [self.scolw addSubview:_myLaber11];
    
    //
    self.myBut12 = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.myBut12.frame = CGRectMake(CGRectGetMinX(self.myBut9.frame), CGRectGetMinY(self.myBut11.frame), CGRectGetWidth(self.myBut11.frame), CGRectGetHeight(self.myBut11.frame));
    [self.myBut12 setBackgroundImage:[UIImage imageNamed:@"shezhi"] forState:(UIControlStateNormal)];
    [self.scolw addSubview:_myBut12];
    
    self.myLaber12 = [[UILabel alloc]init];
    self.myLaber12.frame = CGRectMake(CGRectGetMinX(self.myLaber9.frame)+8, CGRectGetMinY(self.myLaber11.frame), CGRectGetWidth(self.myLaber11.frame), CGRectGetHeight(self.myLaber11.frame));
    self.myLaber12.text = @"设置";
    self.myLaber12.textColor = [UIColor colorWithHex:0x666666];
    self.myLaber12.font = [UIFont systemFontOfSize:13.0];
    [self.scolw addSubview:_myLaber12];
    
    //
    self.myView5 = [[UIView alloc]init];
    self.myView5.frame = CGRectMake(CGRectGetWidth([UIScreen mainScreen].bounds)*0.3, CGRectGetMaxY(self.image.frame),1, CGRectGetHeight([UIScreen mainScreen].bounds)*0.8);
    
    self.myView5.backgroundColor = [UIColor colorWithRed:0.871 green:0.875 blue:0.878 alpha:1];
    [self.scolw addSubview:_myView5];
    
    //
    self.myView6 = [[UIView alloc]init];
    self.myView6.frame = CGRectMake(CGRectGetWidth([UIScreen mainScreen].bounds)*0.65, CGRectGetMinY(self.myView5.frame),1, CGRectGetHeight([UIScreen mainScreen].bounds)*0.8);
    self.myView6.backgroundColor = [UIColor colorWithRed:0.871 green:0.875 blue:0.878 alpha:1];
    [self.scolw addSubview:_myView6];
    
    //修改密码
    
    [self.myBut11 addTarget:self action:@selector(updatePwd:) forControlEvents:(UIControlEventTouchUpInside)];
    //设置
    [self.myBut12 addTarget:self action:@selector(whsetAction:) forControlEvents:(UIControlEventTouchUpInside)];
    //微站
    [self.myBut8 addTarget:self action:@selector(miniStation:) forControlEvents:(UIControlEventTouchUpInside)];
    //体检报告
    //[self.myBut2 addTarget:self action:@selector(physicalAction:) forControlEvents:(UIControlEventTouchUpInside)];
    //我的家人
    [self.myBut1 addTarget:self action:@selector(physicalAction1:) forControlEvents:(UIControlEventTouchUpInside)];
    //我的保单
    [self.myBut2 addTarget:self action:@selector(physicalAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.myBut7 addTarget:self action:@selector(myfollowAction:) forControlEvents:(UIControlEventTouchUpInside)];
    //我的收藏
    [self.myBut3 addTarget:self action:@selector(mycollectAction:) forControlEvents:(UIControlEventTouchUpInside)];
    //关于我们
    [self.myBut10 addTarget:self action:@selector(aboutUsAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    //我的邀请
    [self.myBut9 addTarget:self action:@selector(yaoqingAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
}

//数据处理获取用户信息
-(void)dataBase
{
    id hud = [JGProgressHelper showProgressInView:self.view];
    
    if ([JwUserCenter sharedCenter].key == nil)
    {
        [hud hide:YES];
        [JGProgressHelper showError:@"请先登录"];
        
        
        
        UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:[JwLoginController new]];
        
        [[UIApplication sharedApplication].delegate window].rootViewController=nav;
    }
    else
    {
        [hud hide:YES];
        
       
    }
         
}

//我的邀请点击事件
-(void)yaoqingAction:(UIButton *)sender
{
    WHinviteViewController * invite = [[WHinviteViewController alloc]init];
    [self.navigationController pushViewController:invite animated:YES];
}

//关于我们事件
-(void)aboutUsAction:(UIButton *)sender
{
    WHaboutUsViewController * aboutUs = [[WHaboutUsViewController alloc]init];
    [self.navigationController pushViewController:aboutUs animated:YES];
}

//我的关注列表
-(void)myfollowAction:(UIButton *)sender
{
    WHmyfollowListViewController * followList = [[WHmyfollowListViewController alloc]init];
    [self.navigationController pushViewController:followList animated:YES];
    
}
//微站事件
-(void)miniStation:(UIButton *)sender
{
    WHminiStationTableViewController * station = [[WHminiStationTableViewController alloc]init];
    [self.navigationController pushViewController:station animated:YES];
}
//体检事件
-(void)physicalAction:(UIButton *)sender
{
   //WHgetReportViewController * physic = [[WHgetReportViewController alloc]init];
    WHmyphysicalTableViewController * physic = [[WHmyphysicalTableViewController alloc] init];
    [self.navigationController pushViewController:physic animated:YES];
}
-(void)physicalAction1:(UIButton *)sender
{
    WHmyphysicalTableViewController * physic = [[WHmyphysicalTableViewController alloc] init];
    physic.strPeople = @"a";
    
    [self.navigationController pushViewController:physic animated:YES];
}

//设置事件
-(void)whsetAction:(UIButton *)sender
{
    WHsetupTableViewController * setup = [[WHsetupTableViewController alloc]init];
    [self.navigationController pushViewController:setup animated:YES];
}

//修改密码事件
-(void)updatePwd:(UIButton *)sender
{
    WHupdatePwdViewController * updatePwd = [[WHupdatePwdViewController alloc]init];
    [self.navigationController pushViewController:updatePwd animated:YES];
}
//账户详情点击事件
-(void)onClickImage
{
   
    if ([self.str isEqualToString:@"0"]) {
        WHputongTableViewController * putong = [[WHputongTableViewController alloc]init];
        [self.navigationController pushViewController:putong animated:YES];
    }
    else
    {
    WHaccountDetaTableViewController * account = [[WHaccountDetaTableViewController alloc]init];
    [self.navigationController pushViewController:account animated:YES];
    }
    
}

//我的收藏事件
-(void)mycollectAction:(UIButton *)sender
{
    //WHmycollectViewController * mycollect = [[WHmycollectViewController alloc]init];
    //[self.navigationController pushViewController:mycollect animated:YES];
    
    WHcollectViewController * collect = [[WHcollectViewController alloc]init];
    [self.navigationController pushViewController:collect animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

    

@end
