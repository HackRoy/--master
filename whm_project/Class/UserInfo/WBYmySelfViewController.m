//
#import "WBYmySelfViewController.h"
#import "WBYyyZHXQViewController.h"
#import "WHsetupTableViewController.h"
#import "WHminiStationTableViewController.h"
#import "WHmyphysicalTableViewController.h"
#import "WHgetReportViewController.h"
#import "WHinviteViewController.h"
#import "WHputongTableViewController.h"
#import "WHcollectViewController.h"
#import "WHmyfollowListViewController.h"
#import "WHaboutUsViewController.h"
#import "WHupdatePwdViewController.h"
#import "WBYwdzwViewController.h"
#import "JwLoginController.h"
#import "UIColor+Hex.h"
@interface WBYmySelfViewController ()
{
    NSArray * userArry;
    UIImageView * bgView;
    UIView  * downView;
    NSArray * imgArr;
    NSArray * labArr;
    
}
@end

@implementation WBYmySelfViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    userArry = [NSArray array];
    self.title = @"我的";
    UIButton * button =[UIButton buttonWithType:UIButtonTypeSystem];
    button.frame=CGRectMake(0,0,20, 20);

    [button setImage:[UIImage imageNamed:@"shezhi"] forState:UIControlStateNormal];
    
    [button addTarget:self action:@selector(left) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithCustomView:button];
}

-(void)left
{
    WHsetupTableViewController * setup = [[WHsetupTableViewController alloc]init];
    [self.navigationController pushViewController:setup animated:YES];
    
}
-(void)creatUi
{
    [bgView removeFromSuperview];
    [downView removeFromSuperview];
    DataModel * myModel = userArry[0];
    CGFloat hh =(wScreenH - 49-64)/3;
    CGFloat ww = hh/2-10;
     bgView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, wScreenW,hh)];
//    bgView.backgroundColor = wBlue;
    bgView.userInteractionEnabled = YES;
    bgView.image = [UIImage imageNamed:@"mytopbg.png"];
    
    [self.view addSubview:bgView];
    
    UIButton * myBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    myBtn.frame = CGRectMake(wScreenW/2-ww/2,5, ww,ww);
    myBtn.layer.masksToBounds = YES;
    myBtn.layer.cornerRadius = ww/2;
    [myBtn sd_setImageWithURL:[NSURL URLWithString:myModel.avatar] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"Hm_head"]];
    myBtn.layer.borderColor = [[UIColor whiteColor]CGColor];
    myBtn.layer.borderWidth = 2.0;

    [myBtn addTarget:self action:@selector(changemyImg) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:myBtn];
    
    UILabel * midLab = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(myBtn.frame)+5, wScreenW, (hh/2-10)/2)];
    midLab.textAlignment = 1;
    midLab.font = [UIFont systemFontOfSize:14.0];
    midLab.textColor = wWhiteColor;
    midLab.text = [NSString stringWithFormat:@"%@(%@)",myModel.name,myModel.company?myModel.company:@"暂无公司"];
    [bgView addSubview:midLab];
    //代理人
    if ([myModel.type isEqualToString:@"1"])
    {
       //23 快保家认证  //0 未认证灰色 //1 全认证 字体金色
        UILabel * baojianLab = [[UILabel alloc] initWithFrame:CGRectMake(wScreenW/2-50, CGRectGetMaxY(midLab.frame)+5, 45, (hh/2-10)/2)];
        baojianLab.textAlignment = 1;
        baojianLab.text = @"保监认证";
        baojianLab.font = [UIFont systemFontOfSize:10];
        [bgView addSubview:baojianLab];
        
        UIImageView * myImg = [[UIImageView alloc] initWithFrame:CGRectMake(wScreenW/2-20-45-5, CGRectGetMaxY(midLab.frame)+5, 20, 20)];
        myImg.center = CGPointMake(wScreenW/2-15-45, baojianLab.center.y);
        [bgView addSubview:myImg];
        
        UIImageView * rImg = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(baojianLab.frame), CGRectGetMaxY(midLab.frame)+5, 20, 20)];
        rImg.center = CGPointMake(wScreenW/2 + 10, baojianLab.center.y);
        [bgView addSubview:rImg];
        
        UILabel * rLab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(rImg.frame)+3, CGRectGetMaxY(midLab.frame)+5, 80, (hh/2-10)/2)];
        rLab.font = [UIFont systemFontOfSize:10];
        rLab.text = @"快保家认证";
        [bgView addSubview:rLab];
        
        if ([myModel.status isEqualToString:@"0"])
        {
            baojianLab.textColor = wWhiteColor;
            rLab.textColor = wWhiteColor;
            myImg.image = [UIImage imageNamed:@"unbaojian"];
            rImg.image = [UIImage imageNamed:@"unrenzheng"];

        }else if ([myModel.status isEqualToString:@"1"])
        {
            //1 全认证 字体金色
            baojianLab.textColor = JinSe;
            rLab.textColor = JinSe;
            myImg.image = [UIImage imageNamed:@"baojian"];
            rImg.image = [UIImage imageNamed:@"renzheng"];
        }else
        {
            baojianLab.textColor = wWhiteColor;
            rLab.textColor = JinSe;
            myImg.image = [UIImage imageNamed:@"unbaojian"];
            rImg.image = [UIImage imageNamed:@"renzheng"];
        }
    }
    [self creatDownBtn:myModel];
}


-(void)creatDownBtn:(DataModel *)mod
{
    CGFloat ww = (wScreenW)/3;
    CGFloat hh = (wScreenH - 64 - 49 - (wScreenH - 49-64)/3)/3;
    downView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(bgView.frame), wScreenW, wScreenH - 64 - 49 - (wScreenH - 49-64)/3)];
    
    [self.view addSubview:downView];
     //代理人
    if ([mod.type isEqualToString:@"1"])
    {
        labArr = @[@"我的家人",@"我的保单",@"我的收藏",@"我的关注",@"我的微站",@"我的账务",@"我的邀请",@"关于我们",@"设置"];
        imgArr = @[@"myjiaren",@"mybaodan",@"myshoucang",@"myguanzhu",@"myweizhan",@"myzhengwu",@"myyaoqing",@"mywomen",@"myshezhi"];
    }
    else
    {
        labArr = @[@"我的家人",@"我的保单",@"我的收藏",@"我的关注",@"我的账务",@"我的邀请",@"关于我们",@"修改密码",@"设置"];
        imgArr = @[@"myjiaren",@"mybaodan",@"myshoucang",@"myguanzhu",@"myzhengwu",@"myyaoqing",@"mywomen",@"mima",@"myshezhi"];
    }
    for (NSInteger i = 0; i<2; i++)
    {
        UILabel * aLab = [UILabel new];
        aLab.backgroundColor = [UIColor colorWithHex:0xF5F7F9];
        aLab.frame = CGRectMake(ww+ww*i, 0, 1, wScreenH - 64 - 49 - (wScreenH - 49-64)/3);
        [downView addSubview:aLab];
    }
    for (NSInteger i = 0; i<2; i++)
    {
        UILabel * aLab = [UILabel new];
        aLab.backgroundColor = [UIColor colorWithHex:0xF5F7F9];
        aLab.frame = CGRectMake(0,hh + hh*i,wScreenW,1);
        [downView addSubview:aLab];
    }
    for (NSInteger i=0; i<9; i++)
    {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(ww * (i%3),hh * (i/3), ww, hh);
        [btn setImage:[UIImage imageNamed:imgArr[i]] forState:UIControlStateNormal];
        btn.tag = 5858 + i;
        [btn addTarget:self action:@selector(jinru:) forControlEvents:UIControlEventTouchUpInside];
        [btn setImageEdgeInsets:UIEdgeInsetsMake(10,30, 45, 30)];
        [downView addSubview:btn];
        
        UILabel * aLab = [UILabel new];
        aLab.frame = CGRectMake(0,hh-45, ww, 40);
        aLab.font = [UIFont systemFontOfSize:12];
        aLab.textAlignment = 1;
        aLab.text = labArr[i];
        aLab.textColor = [UIColor colorWithHex:0x666666];
        [btn addSubview:aLab];
    }
}

-(void)jinru:(UIButton *)myBtn
{
     DataModel * myModel = userArry[0];
    
    if (myBtn.tag == 5858)
    {
        WHmyphysicalTableViewController * physic = [[WHmyphysicalTableViewController alloc] init];
        physic.strPeople = @"a";
        [self.navigationController pushViewController:physic animated:YES];
      }
    if (myBtn.tag == 5858+1)
    {
        WHmyphysicalTableViewController * physic = [[WHmyphysicalTableViewController alloc] init];
        [self.navigationController pushViewController:physic animated:YES];
    }
    if (myBtn.tag == 5858+2)
    {
        WHcollectViewController * collect = [[WHcollectViewController alloc]init];
        [self.navigationController pushViewController:collect animated:YES];
    }
    if (myBtn.tag == 5858+3)
    {
        WHmyfollowListViewController * followList = [[WHmyfollowListViewController alloc]init];
        followList.StrFod = myModel.type;
        [self.navigationController pushViewController:followList animated:YES];
    }
    if (myBtn.tag == 5858+8)
    {
        WHsetupTableViewController * setup = [[WHsetupTableViewController alloc]init];
        [self.navigationController pushViewController:setup animated:YES];
    }
    
    if ([myModel.type isEqualToString:@"1"])
    {
        if (myBtn.tag == 5858+4)
        {
            WHminiStationTableViewController * station = [[WHminiStationTableViewController alloc]init];
            [self.navigationController pushViewController:station animated:YES];
 
        }
        if (myBtn.tag == 5858+5)
        {
           //我的账务
            WBYwdzwViewController * wdzw = [WBYwdzwViewController new];
            
            [self.navigationController pushViewController:wdzw animated:YES];
        }
        if (myBtn.tag == 5858+6)
        {
            WHinviteViewController * invite = [[WHinviteViewController alloc]init];
            [self.navigationController pushViewController:invite animated:YES];        }
        if (myBtn.tag == 5858+7)
        {
            WHaboutUsViewController * aboutUs = [[WHaboutUsViewController alloc]init];
            [self.navigationController pushViewController:aboutUs animated:YES];
        }
    }
    else
    {
     //   @"我的账务",@"我的邀请",@"关于我们",@"修改密码",@"设置
        if (myBtn.tag == 5858+4)
        {
            WBYwdzwViewController * wdzw = [WBYwdzwViewController new];
            [self.navigationController pushViewController:wdzw animated:YES];
        }
        if (myBtn.tag == 5858+5)
        {
            WHinviteViewController * invite = [[WHinviteViewController alloc]init];
            [self.navigationController pushViewController:invite animated:YES];
        }
        if (myBtn.tag == 5858+6)
        {
            WHaboutUsViewController * aboutUs = [[WHaboutUsViewController alloc]init];
            [self.navigationController pushViewController:aboutUs animated:YES];
        }
        if (myBtn.tag == 5858+7)
        {
            WHupdatePwdViewController * updatePwd = [[WHupdatePwdViewController alloc]init];
            [self.navigationController pushViewController:updatePwd animated:YES];
        }
    }
 }
-(void)changemyImg
{
    DataModel * mod = userArry[0];
    WBYyyZHXQViewController * xiangqing = [WBYyyZHXQViewController new];
    xiangqing.perMod = mod;
[self.navigationController pushViewController:xiangqing animated:YES];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    if ([self.navigationController.navigationBar respondsToSelector:@selector( setBackgroundImage:forBarMetrics:)])
    {
        
        NSArray *list=self.navigationController.navigationBar.subviews;
        
        for (id obj in list)
        {
            
            if ([UIDevice currentDevice].systemVersion.floatValue >= 10.0)
            {//10.0的系统字段不一样
                UIView *view =   (UIView*)obj;
                for (id obj2 in view.subviews) {
                    
                    if ([obj2 isKindOfClass:[UIImageView class]])
                    {
                        
                        UIImageView *image =  (UIImageView*)obj2;
                        image.hidden = YES;
                    }
                }
            }
        }
    }
    self.navigationController.navigationBar.barTintColor=wBlue;
    /****************/
    NSUserDefaults * myUser = [NSUserDefaults standardUserDefaults];
    NSString * uid = [myUser objectForKey:MYUID];
    NSString * token = [myUser objectForKey:MYTOKEN];
    
    [myUser synchronize];
    if (uid.length>1 && token.length>5)
    {
        [self requestData];
  
    }else
    {
        UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:[[JwLoginController alloc] init]];
        [[UIApplication sharedApplication].delegate window].rootViewController = nav;
    }
  
}
-(void)requestData
{    
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setObject:[WBYRequest jiami:@"kbj/get_user_info"] forKey:@"kb"];
    [dic setObject:[JwUserCenter sharedCenter].uid forKey:@"uid"];
    [dic setObject:[JwUserCenter sharedCenter].key forKey:@"token"];
    
    [WBYRequest wbyPostRequestDataUrl:@"kbj/get_user_info" addParameters:dic success:^(WBYReqModel *model)
     {
           if ([model.err isEqualToString:TURE])
         {
             userArry = model.data;
             [self creatUi];
         }
           else if ([model.err isEqualToString:SAME])
         {
             TONGZHI
         }
     } failure:^(NSError *error)
     {
     } isRefresh:YES];
  
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
