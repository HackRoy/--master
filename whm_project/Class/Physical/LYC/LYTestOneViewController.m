//
//  LYTestOneViewController.m
//  MYPage
//
//  Created by 赵良育 on 2016/11/10.
//  Copyright © 2016年 赵良育. All rights reserved.
//

#import "LYTestOneViewController.h"
#import "LYTestOneTableViewCell.h"
#import "LYTestTwoTableViewCell.h"
#import "WHpros.h"
#import "WHgetreport.h"
#import "WHscore.h"
#import "WHcov.h"
#import "WHrela.h"
#import <UIImageView+WebCache.h>

@interface LYTestOneViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property(nonatomic,strong)NSMutableArray * dateArry;
@property(nonatomic,strong)NSString * score;
@property(nonatomic,strong)NSString * level;
@property(nonatomic,strong)NSString * Strate;

@property(nonatomic,strong)NSString * StrCov;

@property(nonatomic,strong)NSString * strName;

@property(nonatomic,strong)NSString * headImg;

@property(nonatomic,strong)NSString * Strage;

@property(nonatomic,strong)NSMutableArray * secondArry;

@property(nonatomic,strong)NSString * StrScore;


@end
static NSString * const TestCellIdentifer = @"TestCell";
static NSString * const TestTwoCellIdentifer = @"TestTwoCell";
@implementation LYTestOneViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
   [self requartDate];
      
    
    
}



//数据请求
-(void)requartDate
{
    NSLog(@"%@",self.rela_id);
    NSDictionary * infoDic = @{@"pro_id":self.pro_id,@"main_id":@"0",@"is_main_must":@"0", @"insured_amount":self.insured_amount,@"rate":self.rate, @"pay_period":self.pay_period,@"period":self.period,@"payout":@"1"};
     NSError * error = nil;
    
   // NSArray * array = [NSArray array];
    NSArray * array  = @[infoDic];
    
   NSData * jsonData = [NSJSONSerialization dataWithJSONObject:array options:NSJSONWritingPrettyPrinted error:&error];
    NSString * paramStr = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
     self.dateArry = [NSMutableArray array];
     self.secondArry = [NSMutableArray array];
    [self.dataService getsavepolictWithUid:@""
                                   rela_id:self.rela_id
                                      pros:paramStr
                                   success:^(NSArray *lists){
                                       
                                       NSLog(@"%@", lists);
                                      
                                       WHgetreport * report = [lists firstObject];
                                       
                                       WHtotalrate * totrate = report.total_rate ;
                                       NSLog(@"?????%@",totrate.score);
                                       self.StrScore = totrate.score;
                                      // self.myValue = [self.StrScore doubleValue];
                                       //block传值
                                       if (self.StrScore != nil) {
                                           self.mblock1([self.StrScore doubleValue]);
                                           NSLog(@"%@",self.StrScore);
                                       }

                                       //self.dateArry = [NSMutableArray arrayWithArray:pro];
                                       
                                       [self.dateArry addObjectsFromArray:report.pros];
                                   
                                       self.score = report.score.score;
                                       self.level = report.score.level;
                                       self.Strate = report.score.rate;
                                       //获取cov数据
                                       self.StrCov = report.cov.des; //保障是否全面
                                       NSUserDefaults * ud = [NSUserDefaults standardUserDefaults];
                                       NSString * Strhasnt = report.hasnt.des; //缺少保障项目
                                       
                                       NSString * Straccident = report.accident_insured.des;
                                       //意外保险保额
                                       
                                       NSString * Strdisease_insured = report.disease_insured.des ;
                                       //重大疾病保额
                                       //重大保险是否全面
                                       [ud setObject:[NSString stringWithFormat:@"%@",self.StrCov] forKey:@"Cov"];
                                       
                                       [ud setObject:[NSString stringWithFormat:@"%@",Strdisease_insured] forKey:@"disease"];
                                       
                                       [ud setObject:[NSString stringWithFormat:@"%@",Straccident] forKey:@"accident"];
                                       
                                       [ud setValue:[NSString stringWithFormat:@"%@",Strhasnt] forKey:@"hasnt"];
                                       
                                       [ud setValue:[NSString stringWithFormat:@"%@",self.StrCov] forKey:@"three"];
                                       NSLog(@"==%@",self.StrCov);
                                       
                                       
                                       //姓名的获取
                                       for (WHrela * rela in report.rela) {
                                           NSLog(@"%@",rela.name);
                                           self.strName = rela.name;
                                           self.Strage = rela.birthday;
                                           self.headImg = rela.avatar;
                                       }
                                       
                                       //第二个界面数据的获取
//                                       [self.secondArry addObjectsFromArray:report.second];
//                                       NSLog(@"==%@",self.secondArry);
                                       for (WHsecond * second in report.second) {
                                          // NSLog(@"%@",second.interests);
                                           [self.secondArry addObject:second.interests];
                                           NSLog(@"====%@",self.secondArry);
                                       }
                                       
                                       
                                       [self.tableView reloadData];
                                       
    } failure:^(NSError *error) {
        
    }];
    
    
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self p_setTableView];
    
    
    // Do any additional setup after loading the view from its nib.
}
-(void)p_setTableView
{
    self.tableView.rowHeight = 140;
    [self.tableView registerNib:[UINib nibWithNibName:@"LYTestOneTableViewCell" bundle:nil] forCellReuseIdentifier:TestCellIdentifer];
    [self.tableView registerNib:[UINib nibWithNibName:@"LYTestTwoTableViewCell" bundle:nil] forCellReuseIdentifier:TestTwoCellIdentifer];
    
    
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dateArry.count+1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        LYTestOneTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:TestCellIdentifer forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.moneyLaber.text = self.Strate;
        cell.nameTitLaber.text = self.strName;
        if (self.headImg.length <1) {
            cell.headImage.image = [UIImage imageNamed:@"Jw_user"];
        }
        else
        {
        [cell.headImage sd_setImageWithURL:[NSURL URLWithString:self.headImg]];
        }
         //年龄
        NSDate* dt = [NSDate date];
        
        
        NSLog(@"oooo%@",dt);
        NSDateFormatter * df = [[NSDateFormatter alloc]init];//格式化
        
        [df setDateFormat:@"yyyy"];
        
        NSString * sAge = [df stringFromDate:dt];
        NSInteger  a = [sAge integerValue];
        NSString * s3 = [self.Strage substringToIndex:4];
        NSLog(@"%@",s3);
        NSInteger b = [s3 integerValue];
        
        NSInteger c = a - b ;
        
        NSLog(@"===%@",self.Strage);
        
      NSString * ss =  [[NSString stringWithFormat:@"%ld",c]stringByAppendingString:@"岁"];
        
        //
        
        cell.ageLaber.text = ss ;
        
        return cell;
    }else
    {
        LYTestTwoTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:TestTwoCellIdentifer forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.model = self.dateArry[indexPath.section -1];
        return cell;
    }

}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
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
