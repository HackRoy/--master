//
//  WHzhangwuListTableViewController.m
//  whm_project
//
//  Created by 王义国 on 17/2/10.
//  Copyright © 2017年 chenJw. All rights reserved.
//

#import "WHzhangwuListTableViewController.h"
#import "MJRefresh.h"
#import "WBYcaiwuTableViewCell.h"
#import <UIImageView+WebCache.h>
#import "MacroUtility.h"
@interface WHzhangwuListTableViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray * allArray;
    NSArray * myArr;
    NSInteger numindex;
    UITableView *tableV;
    
}
@property(nonatomic,strong)UIView * noDateView;
@property(nonatomic,strong)UIImageView * noDateImg;

@end

@implementation WHzhangwuListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    allArray = [NSMutableArray array];
    myArr = [NSArray array];
    [self creatLeftTtem];
    [self creatRequest];
    [self creatSetUi];
    
    
    self.navigationItem.title = [self.StrName stringByAppendingString:@"的推荐"];
 
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    numindex = 1;
    
}
-(void)headerRereshing
{
    numindex = 1 ;
   
    [tableV headerEndRefreshing];
   
    
}
//下拉
-(void)footerRefreshing
{
    numindex ++ ;
  
    [tableV footerEndRefreshing];
        
}


-(void)creatSetUi
{
    tableV = [[UITableView alloc] initWithFrame:CGRectMake(0, 10, wScreenW, wScreenH - 64) style:UITableViewStylePlain];
    tableV.delegate = self;
    tableV.dataSource = self;
    [tableV addHeaderWithTarget:self action:@selector(headerRereshing)];
    [tableV addFooterWithTarget:self action:@selector(footerRefreshing)];
    [tableV registerClass:[WBYcaiwuTableViewCell class] forCellReuseIdentifier:@"cell"];
    tableV.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableV];
    
    
}


-(void)creatRequest
{
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setObject:[WBYRequest jiami:@"kbj/get_invited"] forKey:@"kb"];
    [dic setObject:[JwUserCenter sharedCenter].uid forKey:@"uid"];
    [dic setObject:self.invited_ID forKey:@"invited_uid"];
    [dic setObject:[JwUserCenter sharedCenter].key forKey:@"token"];
    [dic setObject:[NSString stringWithFormat:@"%ld",numindex] forKey:@"p"];
    [dic setObject:@"10" forKey:@"pagesize"];
    [WBYRequest wbyPostRequestDataUrl:@"kbj/get_invited" addParameters:dic success:^(WBYReqModel *model)
     {
         
         if ([model.err isEqualToString:SAME])
         {
             TONGZHI
         }
         if ([model.err isEqualToString:TURE])
         {
             if (numindex == 1)
             {
                 [allArray removeAllObjects];
             }
             [allArray addObjectsFromArray:model.data];
             DataModel * mod = allArray[0];
             myArr = mod.invited;
            
            
             
             if (myArr.count < 1)
             {
                 [WBYRequest showMessage:@"没有数据"];
                 [self.noDateView removeFromSuperview];
                 self.noDateView = [[UIView alloc]init];
                 self.noDateView.frame = CGRectMake(0, 0, kScreenWitdh, kScreenHeight);
                 //self.noDateView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"nodate"]];
                 [self.view addSubview:_noDateView];
                 self.noDateImg = [[UIImageView alloc]init];
                 self.noDateImg.frame = CGRectMake(10, 10, kScreenWitdh-20, kScreenWitdh-40);
                 [self.noDateView addSubview:_noDateImg];
                 self.noDateImg.image = [UIImage imageNamed:@"nodate"];
                 self.title = [self.StrName stringByAppendingString:@"的保单"];
             }
         }
        [tableV reloadData];
     } failure:^(NSError *error) {

     } isRefresh:NO];
    

    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return myArr.count;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 75;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WBYcaiwuTableViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    //cell.textLabel.text = @"hhhhh";
    WBYtjrListModel * mod = myArr[indexPath.row];
    
      cell.nameLaber.text = mod.name;
    NSString * a = mod.sex;
    if ([a isEqualToString:@"1"]) {
        cell.sexImg.image = [UIImage imageNamed:@"test_male"];
        
    }
    else
    {
        cell.sexImg.image = [UIImage imageNamed:@"test_famale"];
        
    }
    cell.dateLaber.text = mod.birthday;
    [cell.headImg sd_setImageWithURL:[NSURL URLWithString:mod.avatar] placeholderImage:[UIImage imageNamed:@"Jw_user"]];
    NSString * b = mod.type;
    if ([b isEqualToString:@"0"]) {
        cell.renzhengLaber.text = @"普通用户";
    }
    if ([b isEqualToString:@"1"]) {
        
        if ([mod.status isEqualToString:@"0"]) {
            cell.renzhengLaber.text = @"未认证";
        }
        else if ([mod.status isEqualToString:@"1"])
        {
            cell.renzhengLaber.text = @"已认证";
        }
        else if ([mod.status isEqualToString:@"2"])
        {
            cell.renzhengLaber.text = @"认证驳回";
        }
        else
        {
            cell.renzhengLaber.text = @"审核中";
        }
        
    }
    NSInteger  c = [mod.invited_count integerValue];
    if (c <= 99) {
        cell.tuiJianNum.text = mod.invited_count;
        
    }
    else
    {
        cell.tuiJianNum.text = @"99+";
        
    }
    
    if ([mod.mobile isEqualToString:@"0" ]) {
        cell.telLaber.text = @"暂无";
    }
    cell.telLaber.text = mod.mobile? mod.mobile :@"暂无";
    
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
