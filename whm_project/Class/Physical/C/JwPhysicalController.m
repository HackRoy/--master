//
//  JwPhysicalController.m
//  whm_project
//
//  Created by chenJw on 16/10/18.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import "JwPhysicalController.h"
#import "MacroUtility.h"
#import "HmPhysicalGroupCell.h"   // 高度定值 50
#import "HmPhysicalMainPageCell.h"   // 高度定值 90
#import "UIColor+Hex.h"
#import "HmDetailsCell.h"
#import "HmSelectInsuredController.h"
#import "HmFujiaCell.h"
#import "HmSelectCompanyController.h"
#import "WHageTableViewController.h"
#import "WHperiodTableViewController.h"
//
#import "JSCollectViewController.h"
#import "LYTestOneViewController.h"
#import "LYTestTwoViewController.h"
#import "LYTestThreeViewController.h"
#import "JGProgressHelper.h"
//
#import "JwUserCenter.h"
#import "JwLoginController.h"

#import "HmMultistageTableView.h"
#import "HmPhysicalGroupView.h"
#import "HmPhySicalMainView.h"
#import "HmDetailsCodeCell.h"
#import "HMConfirmView.h"
#import "HmBaoeCell.h"


//数据
#import "WHget_pro_rate.h"
#import "WHrate.h"

#import "WHselectCompanyViewController.h"

#import "WHKNetWorkUtils.h"

#import "HmSelectInsuredCell.h"

//
#import "WHproductSearchTableViewController.h"


typedef enum {
    TYPE_AGE = 0,   // 年龄
    TYPE_PERIOD,   // 保障期间
    TYPE_PAY_PERIOD,   // 缴费期间
    TYPE_PAY_OUT,   // 给付方式
} CONTENT_ENUM_TYPE;


#define kHmPhysicalGroupCellIdentifier @"kHmPhysicalGroupCellIdentifier"
#define kHmPhysicalMainCellIdentifier @"kHmPhysicalMainCellIdentifier"
#define kHmPhysicalDetailsCellIdentifier @"dddkHmPhysicalDetailsCellIdentifier"
#define kHmPhysicalFujiaCellIdentifier @"kHmPhysicalFujiaCellIdentifier"
#define kHmPhysicalBaoeCellIdentifier @"kHmPhysicalBaoeCellIdentifier"


@interface JwPhysicalController ()<HmTableViewDelegate,HmTableViewDataSource,HMConfirmDelegate,UITextFieldDelegate>
{
    UITapGestureRecognizer *tapGesturePic;
    NSArray *keyArr ;
    UITapGestureRecognizer *tapGestureSelect;
}

// 大TableView
@property (nonatomic, strong) HmMultistageTableView *tableVB;

@property (nonatomic, assign) BOOL isOpen;
@property (nonatomic, assign) NSInteger selectedSection;

@property (nonatomic, strong) WHget_user_realtion *firstUser;
@property(nonatomic,strong)UIButton * addBut;
@property(nonatomic,strong)NSString * age;

@property(nonatomic,strong)NSString * period;

@property(nonatomic,strong)UITextField *userNameTextField;

@property(nonatomic,strong)NSString * rela_id; //被保人ID

@property(nonatomic,strong)NSString * rate;

@property(nonatomic,strong)NSString * pay_period;

@property(nonatomic,strong)NSString * payout;

@property(nonatomic,strong)NSString * insured_amount;
//
@property(nonatomic,strong)NSString  * selectRelaID;
//@property(nonatomic,strong)NSString * selectProID;
//
// 性别
@property (nonatomic, strong) NSString *dataSex;

@property(nonatomic,strong)NSMutableArray * dataArry;
@property (nonatomic, strong) UIPickerView *pickerV;
@property (nonatomic, strong) UIToolbar *toolBar;
@property (nonatomic, strong) NSString *contentName;
@property (nonatomic, strong) NSIndexPath *myIndexPath;

@property (nonatomic, strong) HMConfirmView *confir;


@property(nonatomic, strong)NSMutableArray * arr1;
@property(nonatomic, strong)NSMutableArray * arr2;
@property(nonatomic ,strong)NSMutableArray * arr3;

@property(nonatomic,strong)NSMutableArray * ageArry;
//

@property (nonatomic, assign) NSInteger openSection;

//
@property(nonatomic,weak)JSCollectViewController * jsCollView;

@property(nonatomic,strong)UIView * myView;

@property(nonatomic,strong)UILabel * stepLaber;

@property(nonatomic,strong)UIButton * selButton;
@property(nonatomic,strong)UILabel * selectLaber;

@property(nonatomic,strong)NSString * selectModeID;

@property(nonatomic,strong)UILabel * strLaber;

//顶部
@property(nonatomic,strong)UIView * topView;
@property(nonatomic,strong)UILabel * firstLaber;
@property(nonatomic,strong)UILabel * firstLine;
@property(nonatomic,strong)UILabel * twoLaber;
@property(nonatomic,strong)UILabel * twoLine;
@property(nonatomic,strong)UILabel * threeLaber;
@property(nonatomic,strong)UILabel * threeLine;
@property(nonatomic,strong)UILabel * fourLine;
@property(nonatomic,strong)UILabel * fourLaber;
@property(nonatomic,strong)UILabel * line1;
@property(nonatomic,strong)UILabel * line2;
@property(nonatomic,strong)UILabel * line3;
@property(nonatomic,strong)UIImageView * headImg;
@property(nonatomic,strong)UIView * lineView;
@property(nonatomic,assign)NSInteger strSender;
@property (nonatomic, strong) NSDictionary *pay_peType;

//头部创建
@property(nonatomic,strong)UIView * selectView;
@property(nonatomic,strong)UIImageView * selImg;
@property(nonatomic,strong)UIImageView * myImg1;
@property(nonatomic,strong)UIImageView * myImg2;
@property(nonatomic,strong)UILabel * nameLaber;
@property(nonatomic,strong)UIImageView * sexImg;
@property(nonatomic,strong)UIImageView * peoImg;
@property(nonatomic,strong)UILabel * peopLaber;
@property(nonatomic,strong)UIImageView * dataImg;
@property(nonatomic,strong)UILabel * dataLaber;
@property(nonatomic,strong)UIImageView * yearImg;
@property(nonatomic,strong)UILabel * yearIncome;
@property(nonatomic,strong)UIImageView * debtImg;
@property(nonatomic,strong)UILabel * debeLaber;
@property(nonatomic,strong)UIImageView * numImg;
@property(nonatomic,strong)UILabel * numLaber;

@end

@implementation JwPhysicalController
-(void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"" style:(UIBarButtonItemStyleDone) target:self action:@selector(left:)];    
    
    
    self.topView.hidden = NO;
    
    [self.selectView clearsContextBeforeDrawing];
    [self.selectView removeFromSuperview];
    [self.headImg clearsContextBeforeDrawing];
    [self.headImg removeFromSuperview];
    [self settepUi];

    
       if (self.selectProID.length == 0)
       {
           
           [self.myView  clearsContextBeforeDrawing];
           [self.myView removeFromSuperview];
           [self setUI];

    }
    else
    {
        self.line1.hidden = YES;
        self.line2 = [[UILabel alloc]init];
        self.line2.frame = CGRectMake(0, 0, kScreenWitdh *0.4, 1);
        self.line2.backgroundColor = [UIColor whiteColor];
        [self.topView addSubview:_line2];
        self.threeLine.backgroundColor = [UIColor whiteColor];
        self.twoLine.backgroundColor = [UIColor whiteColor];
    }

    

    self.tabBarController.tabBar.hidden= NO;
    
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60)
                                                         forBarMetrics:UIBarMetricsDefault];
    if (self.modelType)
    {
        [self requartData];
    }
   

    [self.tableVB reloadData];
}
-(void)left:(UIBarButtonItem *)sender
{
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    self.modelType = nil;
    self.dataSex = nil;
    self.topView .hidden = YES;
}

-(void)settepUi
{
    
    NSUserDefaults * ud = [NSUserDefaults standardUserDefaults];
    self.selectView = [[UIView alloc]init];
    self.selectView.frame = CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetHeight([UIScreen mainScreen].bounds) * 0.16);
    [self.view addSubview:_selectView];
    //
    tapGestureSelect=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClickUILableSelect:)];
    self.selectView .userInteractionEnabled = YES;
    tapGestureSelect.numberOfTapsRequired = 1 ;
    tapGestureSelect.numberOfTouchesRequired = 1 ;
    [self.selectView addGestureRecognizer:tapGestureSelect];
    
    
    //
    self.selImg = [[UIImageView alloc] init];
    self.selImg.frame = CGRectMake(10, 15, 40, 40);
    self.selImg.layer.masksToBounds = YES;
    self.selImg.layer.cornerRadius = 20;
    //self.selImg.image = [UIImage imageNamed:@"policyNum1.png"];
    [self.selectView addSubview:_selImg];
    
    [self.selImg sd_setImageWithURL:[NSURL URLWithString:[ud valueForKey:@"str8"]] placeholderImage:[UIImage imageNamed:@"Jw_user"]];
    
    //
    self.myImg1 = [[UIImageView alloc]init];
    self.myImg1.frame = CGRectMake(CGRectGetMaxX(self.selImg.frame)+5, 15, 20, 20);
    self.myImg1.image = [UIImage imageNamed:@"test_name.png"];
    [self.selectView addSubview:_myImg1];
    //
    self.nameLaber = [[UILabel alloc]init];
    self.nameLaber.frame = CGRectMake(CGRectGetMaxX(self.myImg1.frame)+3, CGRectGetMinY(self.myImg1.frame), kScreenWitdh*0.15, CGRectGetHeight(self.myImg1.frame));
    self.nameLaber.textColor = [UIColor lightGrayColor];
    self.nameLaber.font = [UIFont systemFontOfSize:12.0];
   
    NSString * stringOne = [ud valueForKey:@"str1"];
    
    self.nameLaber.text = stringOne;
    [self.selectView addSubview:_nameLaber];
    //
    self.sexImg = [[UIImageView alloc]init];
    self.sexImg.frame = CGRectMake(CGRectGetMaxX(self.nameLaber.frame)+1, CGRectGetMinY(self.nameLaber.frame), 20, 20);
    [self.selectView addSubview:_sexImg];
    self.sexImg.layer.masksToBounds = YES;
    self.sexImg.layer.cornerRadius = 10;
    //self.selImg.image = [UIImage imageNamed:@"policyNum1.png"];
    
    NSString * stringTwo = [ud valueForKey:@"str2"];
    if ([stringTwo isEqualToString:@"1"]) {
        self.sexImg.image = [UIImage imageNamed:@"test_male"];
    }
    else
    {
        // 女
        self.sexImg.image = [UIImage imageNamed:@"test_famale"];
        
    }
    
    //
    self.peoImg = [[UIImageView alloc]init];
    self.peoImg.frame = CGRectMake(CGRectGetMaxX(self.sexImg.frame)+5, CGRectGetMinY(self.sexImg.frame), 20, 20);
    self.peoImg.image = [UIImage imageNamed:@"test_spouse.png"];
    [self.selectView addSubview:_peoImg];
    //
    self.peopLaber = [[UILabel alloc]init];
    self.peopLaber.frame = CGRectMake(CGRectGetMaxX(self.peoImg.frame)+3, CGRectGetMinY(self.peoImg.frame), CGRectGetWidth(self.nameLaber.frame), CGRectGetHeight(self.nameLaber.frame));
    self.peopLaber.textColor = [UIColor lightGrayColor];
    [self.selectView addSubview:_peopLaber];
    self.peopLaber.font = [UIFont systemFontOfSize:12.0];
   // self.peopLaber.text = @"个人";
    NSString * stringThree = [ud valueForKey:@"str3"];
    NSInteger stateM = [stringThree integerValue];
    switch (stateM) {
        case 0:
            self.peopLaber.text = @"本人";
            break;
        case 1:
            self.peopLaber.text = @"丈夫";
            break;
        case 2:
            self.peopLaber.text = @"妻子";
            break;
        case 3:
            self.peopLaber.text = @"父亲";
            break;
        case 4:
            self.peopLaber.text = @"母亲";
            break;
        case 5:
            self.peopLaber.text = @"儿子";
            break;
        case 6:
            self.peopLaber.text = @"女儿";
            break;
        case 7:
            self.peopLaber.text = @"祖父";
            break;
        case 8:
            self.peopLaber.text = @"祖母";
            break;
        case 9:
            self.peopLaber.text = @"外祖父";
            break;
        case 10:
            self.peopLaber.text = @"外祖母";
            break;
        case 11:
            self.peopLaber.text = @"其他";
            break;
        default:
            break;
    }

    
    
    
    
    //
    self.dataImg = [[UIImageView alloc]init];
    self.dataImg.frame = CGRectMake(CGRectGetMaxX(self.peopLaber.frame)+2, CGRectGetMinY(self.peopLaber.frame), 20, 20);
    self.dataImg.image = [UIImage imageNamed:@"test_date.png"];
    [self.selectView addSubview:_dataImg];
    
    //
    self.dataLaber = [[UILabel alloc]init];
    self.dataLaber.frame = CGRectMake(CGRectGetMaxX(self.dataImg.frame)+2, CGRectGetMinY(self.dataImg.frame), CGRectGetWidth(self.nameLaber.frame)*1.8, CGRectGetHeight(self.nameLaber.frame));
    self.dataLaber.textColor = [UIColor lightGrayColor];
    self.dataLaber.font = [UIFont systemFontOfSize:12.0];
    [self.selectView addSubview:_dataLaber];
    //self.dataLaber.text = @"2017年1月13日";
    self.dataLaber.text = [ud valueForKey:@"str4"];
    
    self.yearImg = [[UIImageView alloc]init];
    self.yearImg.frame = CGRectMake(CGRectGetMinX(self.myImg1.frame), CGRectGetMaxY(self.myImg1.frame)+5, 20, 20);
    self.yearImg.image = [UIImage imageNamed:@"test_year.png"];
    [self.selectView addSubview:_yearImg];
    //
    self.yearIncome = [[UILabel alloc]init];
    self.yearIncome.frame = CGRectMake(CGRectGetMinX(self.nameLaber.frame), CGRectGetMinY(self.yearImg.frame), CGRectGetWidth(self.nameLaber.frame), CGRectGetHeight(self.nameLaber.frame));
    
    self.yearIncome.textColor = [UIColor lightGrayColor];
    [self.selectView addSubview:_yearIncome];
    self.yearIncome.font = [UIFont systemFontOfSize:12.0];
    //self.yearIncome.text = @"100000";
    self.yearIncome.text = [ud valueForKey:@"str5"];
    
    //
    self.debtImg = [[UIImageView alloc]init];
    self.debtImg.frame = CGRectMake(CGRectGetMinX(self.peoImg.frame), CGRectGetMinY(self.yearImg.frame), 20, 20);
    self.debtImg.image = [UIImage imageNamed:@"test_money.png"];
    [self.selectView addSubview:_debtImg];
    //
    self.debeLaber = [[UILabel alloc]init];
    self.debeLaber.frame = CGRectMake(CGRectGetMinX(self.peopLaber.frame), CGRectGetMinY(self.yearIncome.frame), CGRectGetWidth(self.nameLaber.frame), CGRectGetHeight(self.nameLaber.frame));
    self.debeLaber.textColor = [UIColor lightGrayColor];
    //self.debeLaber.text = @"10000";
    [self.selectView addSubview:_debeLaber];
    self.debeLaber.font = [UIFont systemFontOfSize:12.0];
    self.debeLaber.text = [ud valueForKey:@"str6"];
    
    //
    self.numImg = [[UIImageView alloc]init];
    self.numImg.frame = CGRectMake(CGRectGetMinX(self.dataImg.frame), CGRectGetMinY(self.debeLaber.frame), 20, 20);
    
    self.numImg.image = [UIImage imageNamed:@"policyNum.png"];
    [self.selectView addSubview:_numImg];
    
    //
    self.numLaber = [[UILabel alloc]init];
    self.numLaber.frame = CGRectMake(CGRectGetMinX(self.dataLaber.frame), CGRectGetMinY(self.numImg.frame), CGRectGetWidth(self.dataLaber.frame), CGRectGetHeight(self.dataLaber.frame));
    self.numLaber.textColor = [UIColor lightGrayColor];
    //self.numLaber.text = @"12";
    
    [self.selectView addSubview:_numLaber];
    self.numLaber.font = [UIFont systemFontOfSize:12.0];
    self.numLaber.text = [ud valueForKey:@"str7"];
    

}
//图片view选择
-(void)onClickUILableSelect:(UITapGestureRecognizer *)sender
{
    if ([JwUserCenter sharedCenter].uid == nil) {
        [JGProgressHelper showError:@"请登录账号"];
        JwLoginController * loging = [[JwLoginController alloc]init];
        [self.navigationController pushViewController:loging animated:YES];
    } else{
        HmSelectInsuredController *VC = [[HmSelectInsuredController alloc] init];
        [VC returnInsured:^(WHget_user_realtion *user) {
            self.firstUser = user;
            self.headImg.hidden = YES;
            self.selectModeID  = user.id;
            NSString *documentpath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
            //新建文件沙盒
            NSString *filepath = [NSString stringWithFormat:@"%@/用户ID.txt",documentpath];
            NSString *loveContent = user.id;
            [loveContent writeToFile:filepath atomically:YES encoding:NSUTF8StringEncoding error:nil];
            NSString *ss = [NSString stringWithContentsOfFile:filepath encoding:NSUTF8StringEncoding error:nil];
            NSLog(@"%@",ss );
            
            self.nameLaber.text = user.name;
            //
            NSUserDefaults * ud = [NSUserDefaults standardUserDefaults];
            [ud setValue:[NSString stringWithFormat:@"%@",user.name] forKey:@"str1"];
            if ([user.sex isEqualToString:@"1"]) {
                self.sexImg.image = [UIImage imageNamed:@"test_male"];
            }
            else
            {
                // 女
                self.sexImg.image = [UIImage imageNamed:@"test_famale"];
                
            }
            [ud setValue:[NSString stringWithFormat:@"%@",user.sex] forKey:@"str2"];
            
            NSInteger stateM = [user.relation integerValue];
            switch (stateM) {
                case 0:
                    self.peopLaber.text = @"本人";
                    break;
                case 1:
                    self.peopLaber.text = @"丈夫";
                    break;
                case 2:
                    self.peopLaber.text = @"妻子";
                    break;
                case 3:
                    self.peopLaber.text = @"父亲";
                    break;
                case 4:
                    self.peopLaber.text = @"母亲";
                    break;
                case 5:
                    self.peopLaber.text = @"儿子";
                    break;
                case 6:
                    self.peopLaber.text = @"女儿";
                    break;
                case 7:
                    self.peopLaber.text = @"祖父";
                    break;
                case 8:
                    self.peopLaber.text = @"祖母";
                    break;
                case 9:
                    self.peopLaber.text = @"外祖父";
                    break;
                case 10:
                    self.peopLaber.text = @"外祖母";
                    break;
                case 11:
                    self.peopLaber.text = @"其他";
                    break;
                default:
                    break;
            }
            [ud setValue:[NSString stringWithFormat:@"%@",user.relation] forKey:@"str3"];
            //时间戳处理
            
            NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:user.birthday.doubleValue];
            
            
            NSString * s1 = [NSString stringWithFormat:@"%@",confromTimesp];
            
            
            self.dataLaber.text = [s1 substringToIndex:11];
            [ud setValue:[NSString stringWithFormat:@"%@",self.dataLaber.text] forKey:@"str4"];
            
            self.yearIncome.text = user.yearly_income;
            [ud setValue:[NSString stringWithFormat:@"%@",user.yearly_income] forKey:@"str5"];
            
            self.debeLaber.text = user.debt;
            [ud setValue :[NSString stringWithFormat:@"%@",user.debt] forKey:@"str6"];
            
            self.numLaber.text = user.policy_count;
            [ud setValue:[NSString stringWithFormat:@"%@",user.policy_count] forKey:@"str7"];
            
            [self.selImg sd_setImageWithURL:[NSURL URLWithString:user.avatar] placeholderImage:[UIImage imageNamed:@"Jw_user"]];
            [ud setValue:user.avatar forKey:@"str8"];
            
            
            
            if (self.isSelectPersonName) {
                // 选过人了
                [self.groupMutableArr replaceObjectAtIndex:0 withObject:user];
            }else {
                [self.groupMutableArr insertObject:user atIndex:0];
            }
            self.isSelectPersonName = YES;
            self.dataSex = user.sex;
            [self.tableVB reloadData];
        }];
        [self.navigationController pushViewController:VC animated:YES];
    }

    
}

//数据请求
-(void)requartData
{
    
    NSString *gender;
    if (self.dataSex)
    {
        gender = self.dataSex;
    }else {
        gender = @"1";
    }
    id hud = [JGProgressHelper showProgressInView:self.view];
    [self.dataService getprorateWithPid:self.modelType.id uid:@"" gender:gender success:^(NSArray * lists,NSArray *pay_periodArr, NSArray *payoutArr, NSDictionary *typeDict)
     {
        [hud hide:YES];
        
        self.dataArry = [NSMutableArray array];
        self.ageArry =  [NSMutableArray array];
        



        
        WHget_pro_rate * pro = [lists firstObject];
        WHmongorate * mon = [pro.mongo_rate firstObject];
        NSArray * periods = mon.rate;
        for (WHrate * rate in periods)
       {
//            if (rate.period.length < 1 || rate.age.length <1) {
//                [JGProgressHelper showError:@"该险种没有费率"];
//                return ;
//            }
//            else
//            {
           // 保险期间
           [self.dataArry addObject:rate.period?rate.period:@"暂无"];
          //  年龄
           [self.ageArry addObject:rate.age?rate.age:@"暂无"];
           // }
      }
//        
        keyArr = [self.contentMutableDict allKeys];
        if ([keyArr containsObject:_modelType.id])
        {
            [JGProgressHelper showError:@"已经选过这个险种"];
            
        }
        else
        {
                [self.groupMutableArr addObject:_modelType];
          }

        
        
        //保险期间
        self.arr1 =[NSMutableArray array];
        //self.arr2 = [NSMutableArray array];
        self.arr3 = [NSMutableArray array];

        for (int i = 0 ;i<self.dataArry.count;i++) {
            if ([_arr1 containsObject:[self.dataArry  objectAtIndex:i]] == NO) {
                [_arr1 addObject:[self.dataArry  objectAtIndex:i]];
            }
        }
        //年龄
         self.arr2 = [NSMutableArray array];
        for (int i = 0 ;i<self.dataArry.count;i++)
        {
            if ([_arr2   containsObject:[self.ageArry  objectAtIndex:i]] == NO) {
                [_arr2  addObject:[self.ageArry  objectAtIndex:i]];
                
                
            }
            
        }
         //self.arr2 = [NSMutableArray arrayWithArray:self.arr3];

         for (int k = 0; k < _arr2.count; ++k ) {
             
             //遍历数组的每一个`索引`（不包括最后一个,因为比较的是j+1）
             for (int j = 0; j < _arr2.count-1; ++j) {
                 
                 //根据索引的`相邻两位`进行`比较`
                 if (_arr2[j] > _arr2[j+1]) {
                     
                     [_arr2 exchangeObjectAtIndex:j withObjectAtIndex:j+1];
                     
                 }
                 
             }
         }
         
         NSLog(@"**88%@",self.arr2);
         
        NSMutableDictionary *pickerDict = [NSMutableDictionary dictionary];
        if (payoutArr.count != 0) {
            [pickerDict setObject:payoutArr forKey:@"给付方式"];
        }
        [pickerDict setObject:pay_periodArr forKey:@"缴费方式"];
        [pickerDict setObject:_arr1 forKey:@"保障期间"];
        [pickerDict setObject:_arr2 forKey:@"投保年龄"];

        
        
        if (![self.contentMutableDict.allKeys containsObject:_modelType.id]) {
            // 不存在
            [self.contentMutableDict setObject:pickerDict forKey:self.modelType.id];
            [self fuzhiAge:((NSArray *)[((NSDictionary *)[self.contentMutableDict objectForKey:_modelType.id]) objectForKey:@"投保年龄"]).firstObject
                      Type:((NSArray *)[((NSDictionary *)[self.contentMutableDict objectForKey:_modelType.id]) objectForKey:@"缴费方式"]).firstObject
                  Baozhang:((NSArray *)[((NSDictionary *)[self.contentMutableDict objectForKey:_modelType.id]) objectForKey:@"保障期间"]).firstObject
                      Give:((NSArray *)[((NSDictionary *)[self.contentMutableDict objectForKey:_modelType.id]) objectForKey:@"给付方式"]).firstObject
                       Key:_modelType.id
             ];
        }
        
        
        [self.tableVB reloadData];
    } failure:^(NSError *error) {
        [hud hide:YES];
        [JGProgressHelper showError:@""];
        
    }];
}

- (void)fuzhiAge:(NSString *)age Type:(NSString *)type Baozhang:(NSString *)baozhang Give:(NSString *)give Key:(NSString *)key {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
   
    if (((NSMutableDictionary *)[self.contentMutableDict objectForKey:key]).count == 3) {
        if (age != nil) {
            [dict setObject:age forKey:@"投保年龄"];
        }
        if (type != nil) {
            [dict setObject:type forKey:@"缴费方式"];
        }
        if (baozhang != nil) {
            [dict setObject:baozhang forKey:@"保障期间"];
        }
        [dict setObject:@"" forKey:@"保额"];
        [dict setObject:@"" forKey:@"保费"];
    }else {
        if (age != nil) {
            [dict setObject:age forKey:@"投保年龄"];
        }
        if (type != nil) {
            [dict setObject:type forKey:@"缴费方式"];
        }
        if (baozhang != nil) {
            [dict setObject:baozhang forKey:@"保障期间"];
        }
        if (give != nil) {
            [dict setObject:give forKey:@"给付方式"];
        }
        [dict setObject:@"" forKey:@"保额"];
        [dict setObject:@"" forKey:@"保费"];
    }
        [self.fuzhiDict setObject:dict forKey:key];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
      //
    self.openSection = -1;
    [self setupUI];
    
//   [self setUI];
    
    self.topView = [[UIView alloc]init];
    self.topView.frame = CGRectMake(kScreenWitdh *0.2, 20, kScreenWitdh * 0.6, 1);
    self.topView.backgroundColor = [UIColor blackColor];
    [self.navigationController.navigationBar addSubview:_topView];
    //one
    self.firstLine = [[UILabel alloc]init];
    self.firstLine.frame = CGRectMake(0, -3, 6, 6);
    self.firstLine.layer.masksToBounds = YES;
    self.firstLine.layer.cornerRadius = 3;
    self.firstLine.backgroundColor = [UIColor whiteColor];
    [self.topView addSubview:_firstLine];
    self.firstLaber = [[UILabel alloc]init];
    self.firstLaber.frame = CGRectMake(-10, 2, 40, 20);
    self.firstLaber.textColor = [UIColor whiteColor];
    self.firstLaber.text = @"被保人";
    self.firstLaber.font = [UIFont systemFontOfSize:9.0];
    [self.topView addSubview:_firstLaber];
    //two
    self.twoLine =[[UILabel alloc]init];
    self.twoLine.frame = CGRectMake(kScreenWitdh * 0.2, -3, 6, 6);
    self.twoLine.layer.masksToBounds = YES;
    self.twoLine.layer.cornerRadius = 3;
    self.twoLine.backgroundColor = [UIColor blueColor];
    [self.topView addSubview:_twoLine];
    self.twoLaber = [[UILabel alloc]init];
    self.twoLaber.frame = CGRectMake(kScreenWitdh * 0.2-5, 2, 40, 20);
    self.twoLaber.text = @"险种";
    self.twoLaber.textColor = [UIColor whiteColor];
    self.twoLaber.font = [UIFont systemFontOfSize:9.0];
    [self.topView addSubview:_twoLaber];
    //three
    self.threeLine = [[UILabel alloc]init];
    self.threeLine.frame = CGRectMake(kScreenWitdh * 0.4, -3, 6, 6);
    self.threeLine.layer.masksToBounds = YES;
    self.threeLine.layer.cornerRadius = 3;
    self.threeLine.backgroundColor = [UIColor blueColor];
    [self.topView addSubview:_threeLine];
    self.threeLaber = [[UILabel alloc]init];
    self.threeLaber.frame = CGRectMake(kScreenWitdh*0.4-5, 2, 40, 20);
    self.threeLaber.textColor = [UIColor whiteColor];
    self.threeLaber.text = @"参数";
    self.threeLaber.font = [UIFont systemFontOfSize:9.0];
    [self.topView addSubview:_threeLaber];
    //four
    self.fourLine = [[UILabel alloc]init];
    self.fourLine.frame = CGRectMake(kScreenWitdh * 0.6, -3, 6, 6);
    self.fourLine.backgroundColor = [UIColor blueColor];
    self.fourLine.layer.masksToBounds = YES;
    self.fourLine.layer.cornerRadius = 3;
    [self.topView addSubview:_fourLine];
    self.fourLaber = [[UILabel alloc]init];
    self.fourLaber.frame = CGRectMake(kScreenWitdh * 0.6-5, 2, 40, 20);
    self.fourLaber.textColor = [UIColor whiteColor];
    self.fourLaber.text = @"完成";
    self.fourLaber.font = [UIFont systemFontOfSize:9.0];
    [self.topView addSubview:_fourLaber];
}


//文字选择
-(void)setUI
{
    

    if (self.selectModeID.length == 0) {
    self.myView = [[UIView alloc]init];
    self.myView.frame = CGRectMake(0, kScreenHeight*0.12, kScreenWitdh ,kScreenHeight * 0.88);
    self.myView.backgroundColor = [UIColor colorWithRed:243/255.f green:248/255.f blue:249/255.f alpha:1];

    [self.view addSubview:_myView];
    self.stepLaber = [[UILabel alloc]init];
    self.stepLaber.frame = CGRectMake(kScreenWitdh * 0.35, kScreenHeight * 0.15, kScreenWitdh * 0.3, 30);
    self.stepLaber.backgroundColor = [UIColor colorWithRed:63/255.f green:64/255.f blue:65/255.f alpha:1];
    self.stepLaber.textColor = [UIColor whiteColor];
    self.stepLaber.text = @"第一步";
         self.stepLaber.textAlignment = NSTextAlignmentCenter;
    self.stepLaber.font = [UIFont fontWithName:@"Helvetica-Bold" size:19.f];
    self.stepLaber.layer.masksToBounds = YES;
    self.stepLaber.layer.cornerRadius = 15;
    [self.myView addSubview:_stepLaber];
         
         self.lineView = [[UIView alloc]init];
         self.lineView.frame = CGRectMake(10, CGRectGetMaxY(self.stepLaber.frame)+10, kScreenWitdh-20, 1);
         self.lineView.backgroundColor = [UIColor colorWithHex:0xD9D9D9];
         [self.myView addSubview:_lineView];
         
    
    self.selectLaber = [[UILabel alloc]init];
    self.selectLaber.frame = CGRectMake(kScreenWitdh * 0.35, CGRectGetMaxY(self.stepLaber.frame)+20, kScreenWitdh * 0.4, 30);
    self.selectLaber.textColor = [UIColor darkGrayColor];
    self.selectLaber.text = @"首先,来选择被保人!";
         self.selectLaber.font = [UIFont systemFontOfSize:13.0];
    [self.myView addSubview:_selectLaber];
         
    self.strLaber = [[UILabel alloc]init];
         self.strLaber.frame = CGRectMake(kScreenWitdh* 0.25, CGRectGetMaxY(self.selectLaber.frame)+5, kScreenWitdh * 0.6, 30);
         self.strLaber.text = @"(也就是我们要体检的对象哦!)";
         self.strLaber.font = [UIFont systemFontOfSize:13.0];
         self.strLaber.textColor = [UIColor darkGrayColor];
         [self.myView addSubview:_strLaber];
         
         
    
    self.selButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.selButton.frame = CGRectMake(kScreenWitdh * 0.2, kScreenHeight * 0.4, kScreenWitdh * 0.6, 36);
    [self.selButton setTitle:@"选择被保人" forState:(UIControlStateNormal)];
    [self.selButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    self.selButton.layer.masksToBounds = YES;
    self.selButton.layer.cornerRadius = 18;
    self.selButton.backgroundColor = [UIColor colorWithHex:0x4367FF];
   // self.selButton.font = [UIFont systemFontOfSize:19.0];
    [self.myView addSubview:_selButton];
    [self.selButton addTarget:self action:@selector(aa:) forControlEvents:(UIControlEventTouchUpInside)];
         self.selButton.layer.shadowOffset = CGSizeMake(1, 1);
         self.selButton.layer.shadowOpacity = 0.8;
         self.selButton.layer.shadowColor = [UIColor colorWithHex:0x4367FF ].CGColor;
         self.headImg = [[UIImageView alloc]init];
         //默认数据图片处理
         self.headImg.frame = CGRectMake(0, 0, kScreenWitdh, 80);
         self.headImg.image = [UIImage imageNamed:@"headPhy@2x.png"];
        [self.view addSubview:_headImg];

        
         tapGesturePic =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClickUILablePic:)];
         self.headImg.userInteractionEnabled = YES;
         tapGesturePic.numberOfTapsRequired = 1;
         tapGesturePic.numberOfTouchesRequired = 1;
         [self.headImg addGestureRecognizer:tapGesturePic];
        
    }
    else
    {
        self.myView = [[UIView alloc]init];
        self.myView.frame = CGRectMake(0, kScreenHeight*0.12, kScreenWitdh ,kScreenHeight * 0.88);
        self.myView.backgroundColor = [UIColor colorWithRed:243/255.f green:248/255.f blue:249/255.f alpha:1];
        
        [self.view addSubview:_myView];
        self.stepLaber = [[UILabel alloc]init];
        self.stepLaber.frame = CGRectMake(kScreenWitdh * 0.35, kScreenHeight * 0.15, kScreenWitdh * 0.3, 36);
        self.stepLaber.backgroundColor = [UIColor colorWithRed:63/255.f green:64/255.f blue:65/255.f alpha:1];
        self.stepLaber.textColor = [UIColor whiteColor];
        self.stepLaber.text = @"第二步";
        self.stepLaber.textAlignment = NSTextAlignmentCenter;
        self.stepLaber.font = [UIFont systemFontOfSize:19.0];
        self.stepLaber.layer.masksToBounds = YES;
        self.stepLaber.layer.cornerRadius = 18;
        [self.myView addSubview:_stepLaber];
        
        
        self.lineView = [[UIView alloc]init];
        self.lineView.frame = CGRectMake(10, CGRectGetMaxY(self.stepLaber.frame)+10, kScreenWitdh-20, 1);
        self.lineView.backgroundColor = [UIColor colorWithHex:0xD9D9D9];
        [self.myView addSubview:_lineView];

        
        self.selectLaber = [[UILabel alloc]init];
        self.selectLaber.frame = CGRectMake(kScreenWitdh * 0.12, CGRectGetMaxY(self.stepLaber.frame)+20, kScreenWitdh * 0.76, 30);
        self.selectLaber.textColor = [UIColor darkGrayColor];
        self.selectLaber.text = @"选择保险公司,选择您要添加的体检险种";
        self.selectLaber.font = [UIFont systemFontOfSize:13.0];
        self.selectLaber.numberOfLines = 2;
        [self.myView addSubview:_selectLaber];
        
        self.selButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
        self.selButton.frame = CGRectMake(kScreenWitdh * 0.2, kScreenHeight * 0.4, kScreenWitdh * 0.6, 36);
        [self.selButton setTitle:@"添加险种" forState:(UIControlStateNormal)];
        [self.selButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        self.selButton.layer.masksToBounds = YES;
        self.selButton.layer.cornerRadius = 18;
        self.selButton.backgroundColor = [UIColor colorWithHex:0x4367FF];
       // self.selButton.font = [UIFont systemFontOfSize:19.0];
        [self.myView addSubview:_selButton];
        [self.selButton addTarget:self action:@selector(bb:) forControlEvents:(UIControlEventTouchUpInside)];

        self.selButton.layer.shadowOffset = CGSizeMake(1, 1);
        self.selButton.layer.shadowOpacity = 0.8;
        self.selButton.layer.shadowColor = [UIColor colorWithHex:0x4367FF ].CGColor;
        
        self.line1 = [[UILabel alloc]init];
        self.line1.frame = CGRectMake(0, 0, kScreenWitdh * 0.2, 1);
        self.line1.backgroundColor = [UIColor whiteColor];
        [self.topView addSubview:_line1];
        self.twoLine.backgroundColor = [UIColor whiteColor];
        self.headImg.hidden = YES;
      //  [self setUIp];
    }
 }


-(void)dealloc
{
    [self.headImg removeGestureRecognizer:tapGesturePic];
    [self.topView removeGestureRecognizer:tapGestureSelect];
    self.headImg.hidden = YES;
}
//图片点击事件
-(void)onClickUILablePic:(UITapGestureRecognizer *)sender
{
    
    if ([JwUserCenter sharedCenter].uid == nil) {
        [JGProgressHelper showError:@"请登录账号"];
        JwLoginController * loging = [[JwLoginController alloc]init];
        [self.navigationController pushViewController:loging animated:YES];
    } else{
        
        
        HmSelectInsuredController *VC = [[HmSelectInsuredController alloc] init];
        [VC returnInsured:^(WHget_user_realtion *user) {
            self.firstUser = user;
            self.selectModeID  = user.id;
            NSString *documentpath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
            //新建文件沙盒
            NSString *filepath = [NSString stringWithFormat:@"%@/用户ID.txt",documentpath];
            NSString *loveContent = user.id;
            [loveContent writeToFile:filepath atomically:YES encoding:NSUTF8StringEncoding error:nil];
            NSString *ss = [NSString stringWithContentsOfFile:filepath encoding:NSUTF8StringEncoding error:nil];
            NSLog(@"%@",ss );
            
            self.nameLaber.text = user.name;
            //
            NSUserDefaults * ud = [NSUserDefaults standardUserDefaults];
            [ud setValue:[NSString stringWithFormat:@"%@",user.name] forKey:@"str1"];
            if ([user.sex isEqualToString:@"1"]) {
                self.sexImg.image = [UIImage imageNamed:@"test_male"];
            }
            else
            {
                // 女
                self.sexImg.image = [UIImage imageNamed:@"test_famale"];
                
            }
            [ud setValue:[NSString stringWithFormat:@"%@",user.sex] forKey:@"str2"];
            
            NSInteger stateM = [user.relation integerValue];
            switch (stateM) {
                case 0:
                    self.peopLaber.text = @"本人";
                    break;
                case 1:
                    self.peopLaber.text = @"丈夫";
                    break;
                case 2:
                    self.peopLaber.text = @"妻子";
                    break;
                case 3:
                    self.peopLaber.text = @"父亲";
                    break;
                case 4:
                    self.peopLaber.text = @"母亲";
                    break;
                case 5:
                    self.peopLaber.text = @"儿子";
                    break;
                case 6:
                    self.peopLaber.text = @"女儿";
                    break;
                case 7:
                    self.peopLaber.text = @"祖父";
                    break;
                case 8:
                    self.peopLaber.text = @"祖母";
                    break;
                case 9:
                    self.peopLaber.text = @"外祖父";
                    break;
                case 10:
                    self.peopLaber.text = @"外祖母";
                    break;
                case 11:
                    self.peopLaber.text = @"其他";
                    break;
                default:
                    break;
            }
            [ud setValue:[NSString stringWithFormat:@"%@",user.relation] forKey:@"str3"];
            //时间戳处理
            
            NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:user.birthday.doubleValue];
            
            
            NSString * s1 = [NSString stringWithFormat:@"%@",confromTimesp];
            
            
            self.dataLaber.text = [s1 substringToIndex:11];
            [ud setValue:[NSString stringWithFormat:@"%@",self.dataLaber.text] forKey:@"str4"];
            
            self.yearIncome.text = user.yearly_income;
            [ud setValue:[NSString stringWithFormat:@"%@",user.yearly_income] forKey:@"str5"];
            
            self.debeLaber.text = user.debt;
            [ud setValue :[NSString stringWithFormat:@"%@",user.debt] forKey:@"str6"];
            
            self.numLaber.text = user.policy_count;
            [ud setValue:[NSString stringWithFormat:@"%@",user.policy_count] forKey:@"str7"];
            
            [self.selImg sd_setImageWithURL:[NSURL URLWithString:user.avatar] placeholderImage:[UIImage imageNamed:@"Jw_user"]];
            [ud setValue:user.avatar forKey:@"str8"];
            
            
            
            if (self.isSelectPersonName) {
                // 选过人了
                [self.groupMutableArr replaceObjectAtIndex:0 withObject:user];
            }else {
                [self.groupMutableArr insertObject:user atIndex:0];
            }
            self.isSelectPersonName = YES;
            self.dataSex = user.sex;
            [self.tableVB reloadData];
        }];
        [self.navigationController pushViewController:VC animated:YES];
    }
    
}

-(void)bb:(UIButton *)sender
{
    
    WHproductSearchTableViewController * produce = [[WHproductSearchTableViewController alloc]init];
 
    
    [produce returnDataToRootVC:^(WHgetproduct *model, NSMutableArray *groupsArr, BOOL isSelectP, NSMutableDictionary *contentDic, NSMutableDictionary *fuzhiDic, NSString *selectProID) {
   
            self.modelType = model;
            self.groupMutableArr = groupsArr;
            self.isSelectPersonName = isSelectP;
            self.contentMutableDict = contentDic;
            self.fuzhiDict = fuzhiDic;
            self.selectProID = selectProID;
            [self viewDidLoad];
       
    } ];
    
    produce.groupsArr = self.groupMutableArr;
    produce.isSelectP = self.isSelectPersonName;
    produce.contentDic = self.contentMutableDict;
    produce.fuzhiDic = self.fuzhiDict;
    
    
    produce.myBlock5 = ^(NSString * name,NSMutableArray * groupsArr1,BOOL isSelectP1)
    {
        self.groupMutableArr = groupsArr1;
        
        
        self.isSelectPersonName = isSelectP1;
        
        [self.tableVB reloadData];
    };
    
    [self.navigationController pushViewController:produce animated:YES];
}

-(void)aa:(UIButton *)sender
{
    if ([JwUserCenter sharedCenter].uid == nil) {
        [JGProgressHelper showError:@"请登录账号"];
        JwLoginController * loging = [[JwLoginController alloc]init];
        [self.navigationController pushViewController:loging animated:YES];
    } else{
        HmSelectInsuredController *VC = [[HmSelectInsuredController alloc] init];
        [VC returnInsured:^(WHget_user_realtion *user) {
            self.firstUser = user;
            self.selectModeID  = user.id;
            NSString *documentpath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
            //新建文件沙盒
            NSString *filepath = [NSString stringWithFormat:@"%@/用户ID.txt",documentpath];
            NSString *loveContent = user.id;
            [loveContent writeToFile:filepath atomically:YES encoding:NSUTF8StringEncoding error:nil];
            NSString *ss = [NSString stringWithContentsOfFile:filepath encoding:NSUTF8StringEncoding error:nil];
            NSLog(@"%@",ss );
            
            self.nameLaber.text = user.name;
            //
            NSUserDefaults * ud = [NSUserDefaults standardUserDefaults];
            [ud setValue:[NSString stringWithFormat:@"%@",user.name] forKey:@"str1"];
            if ([user.sex isEqualToString:@"1"]) {
                self.sexImg.image = [UIImage imageNamed:@"test_male"];
            }
            else
            {
                // 女
                self.sexImg.image = [UIImage imageNamed:@"test_famale"];

            }
              [ud setValue:[NSString stringWithFormat:@"%@",user.sex] forKey:@"str2"];
            
            NSInteger stateM = [user.relation integerValue];
            switch (stateM) {
                case 0:
                    self.peopLaber.text = @"本人";
                    break;
                case 1:
                    self.peopLaber.text = @"丈夫";
                    break;
                case 2:
                    self.peopLaber.text = @"妻子";
                    break;
                case 3:
                    self.peopLaber.text = @"父亲";
                    break;
                case 4:
                    self.peopLaber.text = @"母亲";
                    break;
                case 5:
                    self.peopLaber.text = @"儿子";
                    break;
                case 6:
                    self.peopLaber.text = @"女儿";
                    break;
                case 7:
                    self.peopLaber.text = @"祖父";
                    break;
                case 8:
                    self.peopLaber.text = @"祖母";
                    break;
                case 9:
                    self.peopLaber.text = @"外祖父";
                    break;
                case 10:
                    self.peopLaber.text = @"外祖母";
                    break;
                case 11:
                    self.peopLaber.text = @"其他";
                    break;
                default:
                    break;
            }
            [ud setValue:[NSString stringWithFormat:@"%@",user.relation] forKey:@"str3"];
            //时间戳处理
            
            NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:user.birthday.doubleValue];
            
            
            NSString * s1 = [NSString stringWithFormat:@"%@",confromTimesp];
            
            
            self.dataLaber.text = [s1 substringToIndex:11];
            [ud setValue:[NSString stringWithFormat:@"%@",self.dataLaber.text] forKey:@"str4"];
            
            self.yearIncome.text = user.yearly_income;
            [ud setValue:[NSString stringWithFormat:@"%@",user.yearly_income] forKey:@"str5"];
            
            self.debeLaber.text = user.debt;
            [ud setValue :[NSString stringWithFormat:@"%@",user.debt] forKey:@"str6"];
            
            self.numLaber.text = user.policy_count;
            [ud setValue:[NSString stringWithFormat:@"%@",user.policy_count] forKey:@"str7"];
            
            [self.selImg sd_setImageWithURL:[NSURL URLWithString:user.avatar] placeholderImage:[UIImage imageNamed:@"Jw_user"]];
            [ud setValue:user.avatar forKey:@"str8"];
            

            
            if (self.isSelectPersonName) {
                // 选过人了
                [self.groupMutableArr replaceObjectAtIndex:0 withObject:user];
            }else {
                [self.groupMutableArr insertObject:user atIndex:0];
            }
            self.isSelectPersonName = YES;
            self.dataSex = user.sex;
            [self.tableVB reloadData];
        }];
        [self.navigationController pushViewController:VC animated:YES];
    }

}

#pragma mark -- 布局
-(void)setupUI
{
    self.view.backgroundColor = [UIColor colorWithRed:244 / 255.0 green:244 / 255.0 blue:244 / 255.0 alpha:1];
    self.tableVB = [[HmMultistageTableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWitdh, kScreenHeight - 64 - 44 -15)];
    _tableVB.delegate = self;
    _tableVB.dataSource = self;
    _tableVB.backgroundColor = [UIColor colorWithRed:244 / 255.0 green:244 / 255.0 blue:244 / 255.0 alpha:1];
    [_tableVB mRegisterClass:[HmDetailsCodeCell class] forCellReuseIdentifier:kHmPhysicalDetailsCellIdentifier];
    [self.view addSubview:_tableVB];
    
    

          // 底部  开始体检 按钮
    UIView *bottomV = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_tableVB.frame)-44, CGRectGetWidth(_tableVB.frame), 44)];
    bottomV.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomV];
    
    UIButton *btnStart = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWitdh / 4, 7, kScreenWitdh / 2, 30)];
    [btnStart setTitle:@"开始体检" forState:UIControlStateNormal];
    [btnStart setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnStart setBackgroundColor:[UIColor colorWithHex:0x4367FF]];
    btnStart.layer.masksToBounds = YES;
    btnStart.layer.cornerRadius = 15;
    [bottomV addSubview:btnStart];
    
    [btnStart addTarget:self action:@selector(btnStart:) forControlEvents:(UIControlEventTouchUpInside)];
    
      self.addBut = [ UIButton buttonWithType:(UIButtonTypeSystem)];
    self.addBut.frame = CGRectMake(kScreenWitdh * 0.80, CGRectGetMinY(btnStart.frame)-30, 40, 40);
    [bottomV addSubview:_addBut];
    self.addBut .backgroundColor = [UIColor colorWithRed:243/255.f green:248/255.f blue:249/255.f alpha:1];

    [self.addBut setBackgroundImage:[UIImage imageNamed:@"p_addGroup"] forState:(UIControlStateNormal)];
    [self.addBut addTarget:self action:@selector(addButAtion:) forControlEvents:(UIControlEventTouchUpInside)];
    self.addBut.layer.cornerRadius = 20;
    //
   
    
 }


//开始体检事件
-(void)btnStart:(UIButton *)sender
{
    
    NSString *documentpath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    //读取文件路径
    NSString *filepath = [NSString stringWithFormat:@"%@/用户ID.txt",documentpath];
    
    NSString *s = [NSString stringWithContentsOfFile:filepath encoding:NSUTF8StringEncoding error:nil];
    NSLog(@"%@",s );
    
    
    self.selectRelaID = s ;
    if (self.selectRelaID != nil)
    {
    
    if (self.selectProID  != nil && self.pay_period != nil && self.rate != nil) {
        
       
  LYTestOneViewController * oneVC = [[LYTestOneViewController alloc]initWithNibName:@"LYTestOneViewController" bundle:nil];
        oneVC.rela_id = self.selectRelaID; //被保人ID
        oneVC.pro_id = self.selectProID;//险种ID
        //oneVC.is_main_must = self.is_main;
        oneVC.pay_period = self.pay_period;//缴费期间
        oneVC.rate = self.rate; //保费
        oneVC.period = self.period; //保障期间
        oneVC.payout = self.payout;
        oneVC.insured_amount = self.insured_amount; //保额
        oneVC.mblock1 = ^(CGFloat s1)
        {
           
            if (s1 == 0) {
                s1 = 20;
            }
            
            [self.jsCollView getprogressValue:s1];
        };
        
    LYTestTwoViewController * twoVC = [[LYTestTwoViewController alloc]initWithNibName:@"LYTestTwoViewController" bundle:nil];
        twoVC.rela_id = self.selectRelaID; //被保人ID
        twoVC.pro_id = self.selectProID;//险种ID
        //oneVC.is_main_must = self.is_main;
        twoVC.pay_period = self.pay_period;//缴费期间
        twoVC.rate = self.rate; //保费
        twoVC.period = self.period; //保障期间
        twoVC.payout = self.payout;
        twoVC.insured_amount = self.insured_amount; //保额
    LYTestThreeViewController * threeVC = [[LYTestThreeViewController alloc]initWithNibName:@"LYTestThreeViewController" bundle:nil];
    
    JSCollectViewController * collectVC = [[JSCollectViewController alloc]initWithAddVCARY:@[oneVC,twoVC,threeVC] TitleS:@[@"基本信息",@"保险利益",@"分析建议"]];
        self.jsCollView = collectVC;
       
       // [collectVC getprogressValue:50.f];
    [self presentViewController:collectVC animated:YES completion:nil];
    }
    else
    {
        [JGProgressHelper showError:@"请选择险种的信息"];
    }

    }
    else
    {
        [JGProgressHelper showError:@"请选择保险险种"];
    }

}



#pragma mark --添加事件
-(void)addButAtion:(UIButton *)sender
{
    WHproductSearchTableViewController * produce = [[WHproductSearchTableViewController alloc]init];
    
    
    [produce returnDataToRootVC:^(WHgetproduct *model, NSMutableArray *groupsArr, BOOL isSelectP, NSMutableDictionary *contentDic, NSMutableDictionary *fuzhiDic, NSString *selectProID) {
        
        self.modelType = model;
        self.groupMutableArr = groupsArr;
        self.isSelectPersonName = isSelectP;
        self.contentMutableDict = contentDic;
        self.fuzhiDict = fuzhiDic;
        self.selectProID = selectProID;
        [self .tableVB reloadData];
        
        

        
    } ];
    
    produce.groupsArr = self.groupMutableArr;
    produce.isSelectP = self.isSelectPersonName;
    produce.contentDic = self.contentMutableDict;
    produce.fuzhiDic = self.fuzhiDict;
    
    produce.myBlock5 = ^(NSString * name,NSMutableArray * groupsArr1,BOOL isSelectP1)
    {
        self.groupMutableArr = groupsArr1;
        
        
        self.isSelectPersonName = isSelectP1;
        
    };
    
    [self.navigationController pushViewController:produce animated:YES];

}


#pragma mark -- HmMultistageTableView DataSource
// 返回组数
- (NSInteger)numberOfSectionsInTableView:(HmMultistageTableView *)mTableView {
    return self.groupMutableArr.count;

}

// 返回组内行数
- (NSInteger)mTableView:(HmMultistageTableView *)mTableView numberOfRowsInSection:(NSInteger)section {
    if (self.isSelectPersonName)
    {
        // 有人
        if (section == 0)
        {
            return 1;
        }
    }
    
//    if (((NSDictionary *)[self.contentMutableDict objectForKey:((WHgetproduct *)self.groupMutableArr[section]).id]).count == 0) {
//        return  0;
//    }
    
    return ((NSDictionary *)[self.contentMutableDict objectForKey:((WHgetproduct *)self.groupMutableArr[section]).id]).count + 2;
//    return 3;
    
    
}

// cell
- (UITableViewCell *)mTableView:(HmMultistageTableView *)mTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    HmDetailsCodeCell *cell = [mTableView dequeueReusableCellWithIdentifier:kHmPhysicalDetailsCellIdentifier];
    if (cell == nil) {
        
        cell = [[HmDetailsCodeCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:kHmPhysicalDetailsCellIdentifier];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    HmBaoeCell *baoeCell = [self setBaoeCell:mTableView];

    NSString *key = ((WHgetproduct *)self.groupMutableArr[indexPath.section]).id;
    id result = [self setupDataForCellCode:cell IndexPath:indexPath Age:[[_fuzhiDict objectForKey:key] objectForKey:@"投保年龄"] Type:[[_fuzhiDict objectForKey:key] objectForKey:@"缴费方式"] Baozhang:[[_fuzhiDict objectForKey:key] objectForKey:@"保障期间"] Give:[[_fuzhiDict objectForKey:key] objectForKey:@"给付方式"] BaoE:baoeCell BaoEData:[[_fuzhiDict objectForKey:key] objectForKey:@"保额"] BaoFei:[[_fuzhiDict objectForKey:key] objectForKey:@"保费"]];
    
    return result;
}

- (HmBaoeCell *)setBaoeCell:(HmMultistageTableView *)mTableView {
    HmBaoeCell *cell = [mTableView dequeueReusableCellWithIdentifier:kHmPhysicalBaoeCellIdentifier];
    if (cell == nil) {
        cell = [[HmBaoeCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:kHmPhysicalBaoeCellIdentifier];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)fuzhiForCellDataAge:(NSString *)age Type:(NSString *)type Baozhang:(NSString *)baozhang Give:(NSString *)give IndexPath:(NSIndexPath *)indexPath
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    
    
        if (((NSMutableDictionary *)[self.contentMutableDict objectForKey:((WHgetproduct *)self.groupMutableArr[indexPath.section]).id]).count == 3) {
        [dict setObject:age forKey:@"投保年龄"];
        [dict setObject:type forKey:@"缴费方式"];
        [dict setObject:baozhang forKey:@"保障期间"];
    }else {
        [dict setObject:age forKey:@"投保年龄"];
        [dict setObject:type forKey:@"缴费方式"];
        [dict setObject:baozhang forKey:@"保障期间"];
        [dict setObject:give forKey:@"给付方式"];
    }
    [self.fuzhiDict setObject:dict forKey:[NSString stringWithFormat:@"%ld",indexPath.section]];
    
}

#pragma mark==点击顶端
- (id)setupDataForCellCode:(HmDetailsCodeCell *)cell IndexPath:(NSIndexPath *)indexPath Age:(NSString *)age Type:(NSString *)type Baozhang:(NSString *)baozhang Give:(NSString *)give BaoE:(HmBaoeCell *)baoeCell BaoEData:(NSString *)baoeData BaoFei:(NSString *)baofei {
    if (indexPath.row == 0) {
        // 投保年两
        cell.headImg.image = [UIImage imageNamed:@"p_safeYear"];
        cell.myLaber.text = @"投保年龄";
        cell.selectLaber.text = age;
        NSLog(@"吴豪%@",age);
        return cell;
    }else if (indexPath.row == 1) {
        // 缴费方式
        cell.headImg.image = [UIImage imageNamed:@"p_payType"];
        cell.myLaber.text = @"缴费方式";
        cell.selectLaber.text = type;
        self.pay_period = type;
        NSLog(@"ming%@",type);
        return cell;
    }else if (indexPath.row == 2) {
        // 保险期间
        cell.headImg.image = [UIImage imageNamed:@"p_dateDuration"];
        cell.myLaber.text = @"保障期间";
        cell.selectLaber.text = baozhang;
        self.period = baozhang;
        return cell;
    }
    if (((NSDictionary *)[self.contentMutableDict objectForKey:((WHgetproduct *)self.groupMutableArr[indexPath.section]).id]).count == 4) {
        if (indexPath.row == 3) {
            // 给付方式
            cell.headImg.image = [UIImage imageNamed:@"p_safePosition"];
            cell.myLaber.text = @"给付方式";
            cell.selectLaber.text = give;
            self.payout = give;
            return cell;
        }else if (indexPath.row == 4) {
            // 保额
            baoeCell.headImg.image = [UIImage imageNamed:@"p_safePosition"];
            baoeCell.myLaber.text = @"保额";
            baoeCell.selectLaber.enabled = YES;
            baoeCell.selectLaber.placeholder = @"请输入保额";
            [baoeCell.selectLaber addTarget:self action:@selector(baoeSelectLaberAction:) forControlEvents:UIControlEventAllEditingEvents];
            baoeCell.selectLaber.text = baoeData;
            self.insured_amount = baoeData;
            return baoeCell;
        }else {
            // 保费
            baoeCell.headImg.image = [UIImage imageNamed:@"p_safePosition"];
            baoeCell.myLaber.text = @"保费";
            baoeCell.selectLaber.enabled = NO;
            baoeCell.selectLaber.text = baofei;
            self.rate = baofei;
            return baoeCell;
        }
    }else {
        if (indexPath.row == 3) {
            // 保额
            baoeCell.headImg.image = [UIImage imageNamed:@"p_safePosition"];
            baoeCell.myLaber.text = @"保额";
            baoeCell.selectLaber.enabled = YES;
            baoeCell.selectLaber.placeholder = @"请输入保额";
            [baoeCell.selectLaber addTarget:self action:@selector(baoeSelectLaberAction:) forControlEvents:UIControlEventAllEditingEvents];
            baoeCell.selectLaber.text = baoeData;
            self.insured_amount = baoeData;
            return baoeCell;
        }else {
            // 保费
            baoeCell.headImg.image = [UIImage imageNamed:@"p_safePosition"];
            baoeCell.myLaber.text = @"保费";
            baoeCell.selectLaber.enabled = NO;
            baoeCell.selectLaber.text = baofei;
            self.rate = baofei;
            return baoeCell;
        }
    }
}

- (void)baoeSelectLaberAction:(UITextField *)sender {
    NSLog(@"sender.text:%@",sender.text);
    sender.delegate = self;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [self requestForBaofeiData:textField.text];
}

- (void)requestForBaofeiData:(NSString *)sender {
//    id hud = [JGProgressHelper showProgressInView:self.view];
    NSString *uid = ((WHget_user_realtion *)self.groupMutableArr.firstObject).id;
    NSString *pid = ((WHgetproduct *)self.groupMutableArr[self.openSection]).id;
   // NSString *gender = ((WHget_user_realtion *)self.groupMutableArr.firstObject).sex;
      NSUserDefaults * ud = [NSUserDefaults standardUserDefaults];
    
    NSString * gender = [ud valueForKey:@"str2"];
    [self.dataService getprorateWithPid:pid uid:uid gender:gender success:^(NSArray *lists, NSArray *pay_periodArr, NSArray *payoutArr, NSDictionary *typeDict) {
        WHget_pro_rate * pro = [lists firstObject];
        WHmongorate * mon = [pro.mongo_rate firstObject];
        NSMutableDictionary *mineValue = [_fuzhiDict objectForKey:((WHgetproduct *)self.groupMutableArr[_myIndexPath.section]).id];
//        WHget_user_realtion *user = self.groupMutableArr.firstObject;
        float i = 0;
        for (WHrate *sRate in mon.rate) {
            
            if (sRate.payout) {
              if ([sRate.age isEqualToString:[mineValue objectForKey:@"投保年龄"]] && [sRate.period isEqualToString:[mineValue objectForKey:@"保障期间"]] && [sRate.gender isEqualToString:([[ud valueForKey:@"str2"] isEqualToString:@"2"] ? @"0" : @"1")]&& [sRate.payout isEqualToString:[mineValue objectForKey:@"给付方式"]]) {
                if ([[self.pay_peType objectForKey:[mineValue objectForKey:@"缴费方式"]] isEqualToString:@"year15"]) {
                    i = [sRate.pay_period.year15 floatValue];
                }else if ([[self.pay_peType objectForKey:[mineValue objectForKey:@"缴费方式"]] isEqualToString:@"year20"]) {
                    i = [sRate.pay_period.year20 floatValue];
                }else if ([[self.pay_peType objectForKey:[mineValue objectForKey:@"缴费方式"]] isEqualToString:@"year10"]) {
                    i = [sRate.pay_period.year10 floatValue];
                }else if ([[self.pay_peType objectForKey:[mineValue objectForKey:@"缴费方式"]] isEqualToString:@"year5"]) {
                    i = [sRate.pay_period.year5 floatValue];
                }else {
                    i = [sRate.pay_period.year floatValue];
                }
                
            }
        }
            
            else
            {
                if ([sRate.age isEqualToString:[mineValue objectForKey:@"投保年龄"]] && [sRate.period isEqualToString:[mineValue objectForKey:@"保障期间"]] && [sRate.gender isEqualToString:([[ud valueForKey:@"str2"] isEqualToString:@"2"] ? @"0" : @"1")]) {
                    if ([[self.pay_peType objectForKey:[mineValue objectForKey:@"缴费方式"]] isEqualToString:@"year15"]) {
                        i = [sRate.pay_period.year15 floatValue];
                    }else if ([[self.pay_peType objectForKey:[mineValue objectForKey:@"缴费方式"]] isEqualToString:@"year20"]) {
                        i = [sRate.pay_period.year20 floatValue];
                    }else if ([[self.pay_peType objectForKey:[mineValue objectForKey:@"缴费方式"]] isEqualToString:@"year10"]) {
                        i = [sRate.pay_period.year10 floatValue];
                    }else if ([[self.pay_peType objectForKey:[mineValue objectForKey:@"缴费方式"]] isEqualToString:@"year5"]) {
                        i = [sRate.pay_period.year5 floatValue];
                    }else {
                        i = [sRate.pay_period.year floatValue];
                    }
                }
            }
        }
//        NSArray * periods = mon.rate;
        if ([mon.bee_type isEqualToString:@"1"]) {
            // 1   保费= 保额(自己输入的值) * 基本保费(pay_period) / 基本保额(insured)
            NSMutableDictionary *dict = [_fuzhiDict objectForKey:((WHgetproduct *)self.groupMutableArr[self.openSection]).id];
//            NSString *pay = [dict objectForKey:@"缴费方式"];
            CGFloat baofei = [sender floatValue] * i / [mon.insured floatValue];
           
            [dict setObject:sender forKey:@"保额"];
            NSLog(@"%@",[NSString stringWithFormat:@"%.3f",baofei]);
            [dict setObject:[NSString stringWithFormat:@"%.3f",baofei] forKey:@"保费"];
            [self.tableVB reloadData];
        }else {
            // 1   保费= 保额(自己输入的值) * 基本保费(insured) / 基本保额(pay_period)
        }
    } failure:^(NSError *error) {
        [JGProgressHelper showError:nil];
    }];
}

#pragma mark -- HmMultistageTableView Delegate
- (CGFloat)mTableView:(HmMultistageTableView *)mTableView heightForHeaderInSection:(NSInteger)section {
    if (self.isSelectPersonName) {
        // 有人
        if (section == 0) {
            return 90;
        }
    }
    return 44;
}

- (CGFloat)mTableView:(HmMultistageTableView *)mTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (CGFloat)mTableView:(HmMultistageTableView *)mTableView heightForAtomAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

// 返回组头(两种)
- (UIView *)mTableView:(HmMultistageTableView *)mTableView viewForHeaderAtSection:(NSInteger)section
{
    if (self.isSelectPersonName)
    {
        // 有人
        if (section == 0) {
            // 第一行

            HmPhySicalMainView *mainV = [[HmPhySicalMainView alloc] initWithFrame:CGRectMake(0, 0, kScreenWitdh, 80)];
      
            
            return mainV;
            

        }
        
     }
    // 没人
    HmPhysicalGroupView *groupV = [[HmPhysicalGroupView alloc] initWithFrame:CGRectMake(0, 0, kScreenWitdh, 44)];
    [groupV.btnDelete addTarget:self action:@selector(buttonAction:) forControlEvents:(UIControlEventTouchUpInside)];
    groupV.model = self.groupMutableArr[section];
    
    groupV.btnDelete.tag = 200 + section;
//    groupV.backgroundColor = [UIColor redColor];
    
    
    return groupV;
}
//删除事件
-(void)buttonAction:(UIButton *)sender
{
    
    UIAlertView *view = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"你确定要删除吗？" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
    
    [view show];

    self.strSender = sender.tag -201;
    
}

//根据被点击按钮的索引处理点击事件
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0 )
    {
       
        if (self.groupMutableArr.count == 1)
        {

            [self.tableVB.tableV deleteSections:[NSIndexSet indexSetWithIndex:self.strSender +1] withRowAnimation:UITableViewRowAnimationRight];

            _isSelectPersonName = NO;
          
            [self.contentMutableDict removeObjectForKey:_modelType.id];
   
        }
        else
        {
        
        [self.groupMutableArr removeObjectAtIndex:self.strSender];
        
        [self.tableVB.tableV deleteSections:[NSIndexSet indexSetWithIndex:self.strSender+1 ] withRowAnimation:UITableViewRowAnimationRight];
            
           
//            [self.contentMutableDict removeObjectForKey:_modelType.id];
            
            
            
        }

    }
        
}

- (void)mTableView:(HmMultistageTableView *)mTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
       NSString *key = ((WHgetproduct *)self.groupMutableArr[indexPath.section]).id;
    
    if (((NSDictionary *)[self.contentMutableDict objectForKey:key]).count != 3) {
        // 有给付方式
        if (indexPath.row == 0) {
            self.contentName = @"投保年龄";
//            [self showPickerViewAndToolBar];
            [self showAlertViewWithArr:[((NSDictionary *)[self.contentMutableDict objectForKey:key]) objectForKey:@"投保年龄"] Key:@"投保年龄"];
        }else if (indexPath.row == 1) {
            self.contentName = @"缴费方式";
//            [self showPickerViewAndToolBar];
            [self showAlertViewWithArr:[((NSDictionary *)[self.contentMutableDict objectForKey:key]) objectForKey:@"缴费方式"] Key:@"缴费方式"];
        }else if (indexPath.row == 2) {
            self.contentName = @"保障期间";
//            [self showPickerViewAndToolBar];
            [self showAlertViewWithArr:[((NSDictionary *)[self.contentMutableDict objectForKey:key]) objectForKey:@"保障期间"] Key:@"保障期间"];
        }else if (indexPath.row == 3) {
            self.contentName = @"给付方式";
//            [self showPickerViewAndToolBar];
            [self showAlertViewWithArr:[((NSDictionary *)[self.contentMutableDict objectForKey:key]) objectForKey:@"给付方式"] Key:@"给付方式"];
        }
    }else {
        if (indexPath.row == 0) {
            self.contentName = @"投保年龄";

            [self showAlertViewWithArr:[((NSDictionary *)[self.contentMutableDict objectForKey:key]) objectForKey:@"投保年龄"] Key:@"投保年龄"];
            
        }else if (indexPath.row == 1) {
            self.contentName = @"缴费方式";
//            [self showPickerViewAndToolBar];
            [self showAlertViewWithArr:[((NSDictionary *)[self.contentMutableDict objectForKey:key]) objectForKey:@"缴费方式"] Key:@"缴费方式"];
        }else if (indexPath.row == 2) {
            self.contentName = @"保障期间";
//            [self showPickerViewAndToolBar];
            [self showAlertViewWithArr:[((NSDictionary *)[self.contentMutableDict objectForKey:key]) objectForKey:@"保障期间"] Key:@"保障期间"];
        }
    }
    self.myIndexPath = indexPath;
    
    [self.tableVB reloadData];
        

}

#pragma mark -- Header Open Or Close
- (void)mTableView:(HmMultistageTableView *)mTableView willOpenHeaderAtSection:(NSInteger)section {
    NSLog(@"Oper Header ----%ld",(long)section);
    self.openSection = section;
}

- (void)mTableView:(HmMultistageTableView *)mTableView willCloseHeaderAtSection:(NSInteger)section {
    NSLog(@"Close Header ----%ld",(long)section);
}

#pragma mark -- Row Open Or Close
- (void)mTableView:(HmMultistageTableView *)mTableView willOpenRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"Open Row ----%ld",(long)indexPath.row);
}

- (void)mTableView:(HmMultistageTableView *)mTableView willCloseRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"Close Row ----%ld",(long)indexPath.row);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- GETTER
-(NSMutableArray *)groupMutableArr {
    if (_groupMutableArr == nil) {
        _groupMutableArr = [NSMutableArray array];
    }
    return _groupMutableArr;
}

- (NSMutableDictionary *)contentMutableDict {
    if (_contentMutableDict == nil) {
        
        _contentMutableDict = [NSMutableDictionary dictionary];
        
    }
    return _contentMutableDict;
}

- (NSMutableDictionary *)fuzhiDict {
    if (_fuzhiDict == nil) {
        _fuzhiDict = [NSMutableDictionary dictionary];
    }
    return _fuzhiDict;
}

- (NSDictionary *)pay_peType {
    if (_pay_peType == nil) {
        _pay_peType = @{@"15年期缴":@"year15",
                        @"5年期缴":@"year5",
                        @"趸缴":@"year",
                        @"10年期缴":@"year10",
                        @"20年期缴":@"year20"};
    }
    return _pay_peType;
}


#pragma mark -- HMConfirmView Setting
- (void)showAlertViewWithArr:(NSArray *)arr Key:(NSString *)key {
    _confir = [[HMConfirmView alloc] initWithFrame:[self.navigationController.view superview].bounds];
   
//    arr = [NSArray arrayWithObjects:@"1",@"2" nil]
    
    //NSMutableArray *myAr=[NSMutableArray arrayWithArray:arr];
    
    //arr = [NSArray arrayWithArray:self.arr2];
    
    _confir.itemArr = arr;
    _confir.delegate = self;
    _confir.key = key;
    _confir.backgroundColor = [UIColor colorWithRed:0 / 255.0 green:0 / 255.0 blue:0 / 255.0 alpha:0.3];
    [self.view addSubview:_confir];
    
}

#pragma mark -- HMConfirmView Delegate
- (void)confirmActionWithIndexOfArr:(NSInteger)index SelectName:(NSString *)name Key:(NSString *)key
{
    NSMutableDictionary *dict = [_fuzhiDict objectForKey:((WHgetproduct *)self.groupMutableArr[_myIndexPath.section]).id];
    [dict setObject:name forKey:key];
    [self requestForBaofeiData:[dict objectForKey:@"保额"]];
    [self.tableVB reloadData];   
    [_confir removeFromSuperview];
}


- (void)cancelActionWithNothing {
    [_confir removeFromSuperview];
}



@end
