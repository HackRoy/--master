//
//  TiJianShouYeViewController.m
//  whm_project
//
//  Created by apple on 17/2/4.
//  Copyright © 2017年 chenJw. All rights reserved.
//

#import "TiJianShouYeViewController.h"
#import "JwLoginController.h"
#import "HmSelectInsuredController.h"
#import "xuanzebeibaorenViewController.h"
@interface TiJianShouYeViewController ()
{
    UIView * firstView;
    UIView * topView;
}
@end

@implementation TiJianShouYeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self creatHeadView];
    [self creatUpView];
    
}

//-(void)request
//{
//    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
//    
//    [dic setObject:[JwUserCenter sharedCenter].uid forKey:@"uid"];
//    [dic setObject:@"486" forKey:@"pid"];
//    [dic setObject:@"1" forKey:@"gender"];
////    [dic setObject:@"" forKey:@"age"];
//    [dic setObject:@"1" forKey:@"change_one"];
//    [dic setObject:[JwUserCenter sharedCenter].key forKey:@"token"];
//    [dic setObject:[WBYRequest jiami:@"kbj/get_mongo_rate"] forKey:@"kb"];
//    
//    [WBYRequest wbyPostRequestDataUrl:@"kbj/get_mongo_rate" addParameters:dic success:^(WBYReqModel *model)
//    {
//        
//    } failure:^(NSError *error) {
//        
//    } isRefresh:YES];
//    
//
//    
//}


-(void)creatUpView
{
     firstView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, wScreenW, wScreenH-64)];
     firstView.backgroundColor = [UIColor colorWithRed:243/255.f green:248/255.f blue:249/255.f alpha:1];
    [self.view addSubview:firstView];
    
    UIButton * upBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    upBtn.frame = CGRectMake(0, 0, wScreenW,55);
    [upBtn setImage:[UIImage imageNamed:@"zhesgisha"] forState:UIControlStateNormal];
    
    [firstView addSubview:upBtn];
    
    UILabel * dibuLab = [[UILabel alloc] init];
    dibuLab.frame = CGRectMake(wScreenW*0.35,CGRectGetMaxY(upBtn.frame)+60, wScreenW*0.3, 30);
    dibuLab.backgroundColor = [UIColor colorWithRed:63/255.f green:64/255.f blue:65/255.f alpha:1];
    dibuLab.textColor = [UIColor whiteColor];
    dibuLab.text = @"第一步";
    dibuLab.textAlignment = NSTextAlignmentCenter;
    dibuLab.font = [UIFont fontWithName:@"Helvetica-Bold" size:19.f];
    dibuLab.layer.masksToBounds = YES;
    dibuLab.layer.cornerRadius = 15;
    [firstView addSubview:dibuLab];

    UILabel * lineView = [[UILabel alloc] init];
    lineView.frame = CGRectMake(10, CGRectGetMaxY(dibuLab.frame)+10, wScreenW-20, 1);
    lineView.backgroundColor = [UIColor colorWithHex:0xD9D9D9];
    [firstView addSubview: lineView];
    
    UILabel * selectLaber = [[UILabel alloc] init];
    selectLaber.frame = CGRectMake(0, CGRectGetMaxY(lineView.frame)+20, wScreenW, 30);
    selectLaber.center = CGPointMake(self.view.center.x,CGRectGetMaxY(lineView.frame)+20+15);
    selectLaber.textColor = [UIColor darkGrayColor];
    selectLaber.text = @"首先,来选择被保人!";
    selectLaber.textAlignment = 1;
    selectLaber.font = [UIFont systemFontOfSize:13.0];
    [firstView addSubview:selectLaber];

    UILabel * strLaber = [[UILabel alloc]init];
    strLaber.frame = CGRectMake(0, CGRectGetMaxY(selectLaber.frame)+5, wScreenW, 30);
     strLaber.text = @"(也就是我们要体检的对象哦!)";
    strLaber.textAlignment = 1;
     strLaber.font = [UIFont systemFontOfSize:13.0];
    strLaber.textColor = [UIColor darkGrayColor];
    
    [firstView addSubview:strLaber];
 
    UIButton * selButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
    selButton.frame = CGRectMake(50, CGRectGetMaxY(strLaber.frame)+50,wScreenW-100, 36);
    [selButton setTitle:@"选择被保人" forState:(UIControlStateNormal)];
    [selButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    selButton.layer.masksToBounds = YES;
    selButton.layer.cornerRadius = 18;
    selButton.backgroundColor = [UIColor colorWithHex:0x4367FF];
    
    [selButton addTarget:self action:@selector(xuanzebeibaoren) forControlEvents:UIControlEventTouchUpInside];
    [firstView addSubview:selButton];
    
}

#pragma mark====选择被保人
-(void)xuanzebeibaoren
{
    if ([JwUserCenter sharedCenter].uid == nil)
    {
        [JGProgressHelper showError:@"请登录账号"];
        JwLoginController * loging = [[JwLoginController alloc]init];
        [self.navigationController pushViewController:loging animated:YES];
    }
    else
    {
        HmSelectInsuredController * hmselect = [HmSelectInsuredController new];
        [hmselect returnInsured:^(WHget_user_realtion * user)
        {
     
            [self fuzhiUpView:user];
 
            
            
        }];
        [self.navigationController pushViewController:hmselect animated:YES];
    }
 }

-(void)fuzhiUpView:(WHget_user_realtion *)userModel
{
    [firstView removeFromSuperview];
    
    topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, wScreenW,60)];
    [self.view addSubview:topView];
    
    UIImageView * selImg = [[UIImageView alloc] init];
    selImg.frame = CGRectMake(10, 10, 40, 40);
     selImg.layer.masksToBounds = YES;
     selImg.layer.cornerRadius = 20;
     [selImg sd_setImageWithURL:[NSURL URLWithString:userModel.avatar] placeholderImage:[UIImage imageNamed:@"Jw_user"]];
    [topView addSubview:selImg];
    
    UIImageView * myImg1 = [[UIImageView alloc] init];
     myImg1.frame = CGRectMake(CGRectGetMaxX(selImg.frame)+5, 10, 20, 20);
     myImg1.image = [UIImage imageNamed:@"test_name.png"];
    [ topView addSubview:myImg1];
 
    UILabel * nameLaber = [[UILabel alloc]init];
    nameLaber.frame = CGRectMake(CGRectGetMaxX(myImg1.frame)+3, CGRectGetMinY(myImg1.frame), wScreenW*0.15, CGRectGetHeight(myImg1.frame));
    nameLaber.textColor = [UIColor lightGrayColor];
     nameLaber.font = [UIFont systemFontOfSize:10.0];
    nameLaber.text = userModel.name;
    [topView addSubview:nameLaber];
    
    UIImageView * sexImg = [[UIImageView alloc] init];
    sexImg.frame = CGRectMake(CGRectGetMaxX(nameLaber.frame)+1, CGRectGetMinY(nameLaber.frame), 20, 20);
    sexImg.layer.masksToBounds = YES;
     sexImg.layer.cornerRadius = 10;
    NSString * stringTwo = userModel.sex;
    if ([stringTwo isEqualToString:@"1"])
    {
        sexImg.image = [UIImage imageNamed:@"test_male"];
    }
    else
    {
        sexImg.image = [UIImage imageNamed:@"test_famale"];
    }
    [topView addSubview:sexImg];

    UIImageView * peoImg = [[UIImageView alloc]init];
    peoImg.frame = CGRectMake(CGRectGetMaxX(sexImg.frame)+5, CGRectGetMinY(sexImg.frame), 20, 20);
    peoImg.image = [UIImage imageNamed:@"test_spouse.png"];
    [topView addSubview:peoImg];

   UILabel * peopLaber = [[UILabel alloc]init];
    peopLaber.frame = CGRectMake(CGRectGetMaxX(peoImg.frame)+3, CGRectGetMinY(peoImg.frame), CGRectGetWidth(nameLaber.frame), CGRectGetHeight(nameLaber.frame));
    peopLaber.textColor = [UIColor lightGrayColor];
    peopLaber.font = [UIFont systemFontOfSize:12.0];
    peopLaber.textAlignment = 1;
    peopLaber.text = userModel.relation_name;
    [topView addSubview:peopLaber];

    UIImageView * dataImg = [[UIImageView alloc]init];
     dataImg.frame = CGRectMake(CGRectGetMaxX(peopLaber.frame)+2, CGRectGetMinY(peopLaber.frame), 20, 20);
     dataImg.image = [UIImage imageNamed:@"test_date.png"];
    [topView addSubview:dataImg];
    
     UILabel * dataLaber = [[UILabel alloc]init];
     dataLaber.frame = CGRectMake(CGRectGetMaxX(dataImg.frame)+2, CGRectGetMinY(dataImg.frame), CGRectGetWidth(nameLaber.frame)*1.8, CGRectGetHeight(nameLaber.frame));
    dataLaber.textColor = [UIColor lightGrayColor];
    dataLaber.text = [WBYRequest timeStr:userModel.birthday];
    dataLaber.font = [UIFont systemFontOfSize:12.0];
    [topView addSubview:dataLaber];

    
    
    
    
    
    
}


-(void)creatHeadView
{
    
        UIView*bgView=[[UIView alloc] initWithFrame:CGRectMake(0,0,wScreenW,44)];
        bgView.contentMode=UIViewContentModeScaleAspectFit;
        self.navigationItem.titleView=bgView;
    
    CGFloat wwww = (wScreenW-120)/3;
    for (NSInteger i=0; i<3; i++)
    {
        UILabel*lab=[[UILabel alloc] initWithFrame:CGRectMake(60+wwww*i,22,(wScreenW-120)/3-4,1)];
        lab.backgroundColor = [UIColor blackColor];
        [bgView addSubview:lab];
    }
    
    for (NSInteger i = 0; i<4; i++)
    {
        UILabel * yuanLan = [UILabel new];
        yuanLan.frame = CGRectMake(60-4+wwww*i,22-2, 4, 4);
        yuanLan.layer.masksToBounds = YES;
        yuanLan.layer.cornerRadius = 2;
        if (i==0)
        {
            yuanLan.backgroundColor = wWhiteColor;
        }
        else
        {
            yuanLan.backgroundColor = [UIColor blueColor];
        }
        [bgView addSubview:yuanLan];
    }
    NSArray * arr = @[@"被保人",@"险种",@"参数",@"完成"];
    
    for (NSInteger i = 0; i<4; i++)
    {
        UILabel *canLab = [UILabel new];
        canLab.frame = CGRectMake(25 + wwww*i , 23, wwww, 20);
        canLab.textAlignment = 1;
        canLab.text = arr[i];
        canLab.font = [UIFont systemFontOfSize:8];
        canLab.textColor = wWhiteColor;
        [bgView addSubview:canLab];
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
