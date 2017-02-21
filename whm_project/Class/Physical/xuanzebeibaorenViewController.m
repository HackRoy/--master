//
//  xuanzebeibaorenViewController.m
//  whm_project
//
//  Created by apple on 17/1/13.
//  Copyright © 2017年 chenJw. All rights reserved.
//

#import "xuanzebeibaorenViewController.h"
#import "HmAddInsuredController.h"
#import "HmSelectInsuredCell.h"

#define kCellIdentifierOfInsured @"kCellIdentifierOfInsuredCell"

@interface xuanzebeibaorenViewController ()<UITableViewDelegate,UITableViewDataSource>



@property(nonatomic,strong)NSMutableArray * dataArry;
@property (nonatomic, strong) UITableView *tableV;

@end

@implementation xuanzebeibaorenViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"选择被保人";
    self.dataArry = [NSMutableArray array];
    [self creatLeftTtem];
    [self creasstData];
    [self creatUI];
    
}

-(void)creatUI
{
    self.tableV = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, wScreenW, wScreenH - 64) style:UITableViewStylePlain];
    _tableV.delegate = self;
    _tableV.dataSource = self;
    _tableV.rowHeight = 80;
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


-(void)creasstData
{    
NSMutableDictionary * dic = [NSMutableDictionary dictionary];
[dic setObject:[JwUserCenter sharedCenter].uid forKey:@"uid"];
[dic setObject:[JwUserCenter sharedCenter].key forKey:@"token"];
[dic setObject:[WBYRequest jiami:@"kbj/get_user_realtion"] forKey:@"kb"];

[WBYRequest wbyPostRequestDataUrl:@"kbj/get_user_realtion" addParameters:dic success:^(WBYReqModel *model)
 {
     if ([model.err isEqualToString:TURE])
     {
         [_dataArry addObjectsFromArray:model.data];
     }
     
     if ([model.err isEqualToString:@"1304"])
     {
       TONGZHI
     }
     
     [self.tableV reloadData];
     
 } failure:^(NSError *error)
 {
     
 } isRefresh:YES];
    
    
    
    

}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArry.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
////        UINib *nib = [UINib nibWithNibName:NSStringFromClass([HmSelectInsuredCell class]) bundle:nil];
////        [tableView registerNib:nib forCellReuseIdentifier:kCellIdentifierOfInsured];
////
////    
////    HmSelectInsuredCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifierOfInsured];
////    cell.model = self.dataArry[indexPath.row];
//    
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    return cell;
    
    
    return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DataModel * mod = self.dataArry[indexPath.row];
    self.chuanzhi(mod);
    [self.navigationController popViewControllerAnimated:YES];
    
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
