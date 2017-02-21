//
//  WHperiodTableViewController.m
//  whm_project
//
//  Created by 王义国 on 16/11/11.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import "WHperiodTableViewController.h"
#import "JGProgressHelper.h"
#import "MacroUtility.h"
#import "WHget_pro_rate.h"
#import "WHrate.h"
#import "WHageTableViewCell.h"
@interface WHperiodTableViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, strong) UITableView *tableV;
@property(nonatomic,strong)NSMutableArray * dataArry;
@property(nonatomic,strong)WHageTableViewCell * cell;
@property(nonatomic,strong)NSString * Speriod;
@property(nonatomic, strong)NSMutableArray * arr1;

@end

@implementation WHperiodTableViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    
    [self quartData];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 布局
    [self setupUI];
    self.navigationItem .leftBarButtonItem =[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:(UIBarButtonItemStylePlain) target:self action:@selector(left:)];
    
    [self.tableV registerClass:[WHageTableViewCell class] forCellReuseIdentifier:@"cell"];
}
-(void)left:(UIBarButtonItem *)sender
{
    
    if (self.Speriod != nil) {
        self.mblock2 (self.Speriod);
    }
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark -- 布局
-(void)setupUI
{
    
    self.tableV = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWitdh, kScreenHeight - 64) style:UITableViewStylePlain];
    _tableV.delegate = self;
    _tableV.dataSource = self;
    _tableV.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableV];
    
}
//数据请求
-(void)quartData
{
    id hud = [JGProgressHelper showProgressInView:self.view];
    [self.dataService getprorateWithPid:self.ID uid:@"" gender:@"1" success:^(NSArray * lists,NSArray *pay_periodArr, NSArray *payoutArr, NSDictionary *typeDict) {
        [hud hide:YES];
        
        self.dataArry = [NSMutableArray array];
        //NSMutableArray * arry2 = [NSMutableArray array];
    
        
        WHget_pro_rate * pro = [lists firstObject];
        WHmongorate * mon = [pro.mongo_rate firstObject];
        NSArray * periods = mon.rate;
               for (WHrate * rate in periods) {
           
            [self.dataArry addObject:rate.period];
                   
                   NSLog(@"+++%@",rate.pay_period);
                   
               }
        self.arr1 =[NSMutableArray array];
        for (int i = 0 ;i<self.dataArry.count;i++) {
            if ([_arr1 containsObject:[self.dataArry  objectAtIndex:i]] == NO) {
                [_arr1 addObject:[self.dataArry  objectAtIndex:i]];
                NSLog(@"%@",_arr1);
            }
        }

        
        [self.tableV reloadData];
    } failure:^(NSError *error) {
        [hud hide:YES];
        [JGProgressHelper showError:@""];
        
    }];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of rows
    return self.arr1.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WHageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    // Configure the cell...
    cell.ageLaber.text = self.arr1[indexPath.row];
    
    return cell;
}
-(CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.Speriod = self.arr1[indexPath.row];
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
