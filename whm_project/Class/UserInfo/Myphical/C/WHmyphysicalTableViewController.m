//
//  WHmyphysicalTableViewController.m
//  whm_project
//
//  Created by 王义国 on 16/11/21.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import "WHmyphysicalTableViewController.h"
#import "CMIndexBar.h"
#import "MacroUtility.h"
#import "HmSelectInsuredCell.h"
#import "JGProgressHelper.h"
#import "HmAddInsuredController.h"
#import "WHget_user_realtion.h"
#import "WHslipListTableViewController.h"

#define kCellIdentifierOfInsured @"kCellIdentifierOfInsuredCell"

@interface WHmyphysicalTableViewController ()<UITableViewDelegate,UITableViewDataSource,CMIndexBarDelegate>
{
    CMIndexBar *indexBar;
}
@property (nonatomic ,strong) UITableView *tableV;
@property (nonatomic ,strong) HmSelectInsuredCell * cell;
@property (nonatomic ,strong)NSMutableArray * dataArry;
@property(nonatomic,strong)UIView * noDateView;
@property(nonatomic,strong)UIImageView * noDateImg;

@end

@implementation WHmyphysicalTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self setupUI];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // 请求数据
    [self requestData];
    
}
// 请求数据
-(void)requestData
{
    id hud = [JGProgressHelper showProgressInView:self.view];
    [self.dataService get_user_realtionWithUid:@"" success:^(NSArray *lists) {
        [hud hide:YES];
        // 成功
        self.dataArry = [NSMutableArray arrayWithArray:lists];
        [self.tableV reloadData];
    } failure:^(NSError *error) {
        [hud hide:YES];
        // 失败
        //[JGProgressHelper showError:@"失败"];
        self.noDateView = [[UIView alloc]init];
        self.noDateView.frame = CGRectMake(0, 0, kScreenWitdh, kScreenHeight);
        //self.noDateView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"nodate"]];
        [self.view addSubview:_noDateView];
        self.noDateImg = [[UIImageView alloc]init];
        self.noDateImg.frame = CGRectMake(10, 10, kScreenWitdh-20, kScreenWitdh-40);
        [self.noDateView addSubview:_noDateImg];
        self.noDateImg.image = [UIImage imageNamed:@"nodate"];
        self.title = @"没有保人";
        
    }];

    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -- 布局
-(void)setupUI
{
    if ([self.strPeople isEqualToString:@"a"]) {
        self.title = @"被保人";
    }
    else
    {
    self.title = @"选择被保人";
    }
    self.tableV = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWitdh, kScreenHeight - 64) style:UITableViewStylePlain];
    _tableV.delegate = self;
    _tableV.dataSource = self;
    _tableV.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableV];

    // 添加 (右上角)
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"test_add"] style:UIBarButtonItemStylePlain target:self action:@selector(addNewAction:)];
    

}

#pragma mark -- Private
-(void)addNewAction:(UIBarButtonItem *)sender
{
    HmAddInsuredController *VC = [[HmAddInsuredController alloc] init];
    [self.navigationController pushViewController:VC animated:YES];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataArry.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UINib *nib = [UINib nibWithNibName:NSStringFromClass([HmSelectInsuredCell class]) bundle:nil];
   [tableView registerNib:nib forCellReuseIdentifier:kCellIdentifierOfInsured];

    HmSelectInsuredCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifierOfInsured];
    cell.model = self.dataArry[indexPath.row];
     cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WHget_user_realtion  * model = self.dataArry[indexPath.row];
    NSLog(@"%@",model.id);
    WHslipListTableViewController * sliplist = [[WHslipListTableViewController alloc]init];
    sliplist.rela_id = model.id;
    sliplist.StrName = model.name;
    [self.navigationController pushViewController:sliplist animated:YES];
    
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
