//
//  WHorgselectTableViewController.m
//  whm_project
//
//  Created by 王义国 on 16/12/15.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import "WHorgselectTableViewController.h"
#import "WHorgSelectTableViewCell.h"
#import "MacroUtility.h"
#import "WHorganization.h"
#import "JGProgressHelper.h"
@interface WHorgselectTableViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView * tableV;
@property(nonatomic,strong)WHorgSelectTableViewCell * cell;
@property(nonatomic,strong)NSMutableArray * dataArry;

@end

@implementation WHorgselectTableViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self requDate];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableV = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWitdh, kScreenHeight - 64) style:UITableViewStylePlain];
    _tableV.delegate = self;
    _tableV.dataSource = self;
    _tableV.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableV];
    
    [self.tableV registerClass:[WHorgSelectTableViewCell class] forCellReuseIdentifier:@"cell"];

    self.title = @"机构名字";
    
}

-(void)requDate
{
    id hud = [JGProgressHelper showProgressInView:self.view];
    [self.dataService getorgProvinceWithProvince:@""
                                            city:@""
                                          county:@""
                                          com_id:self.com_id
                                        distance:@""
                                             map:@"1" success:^(NSArray *lists) {
                                                 [hud hide:YES];
                                                 self.dataArry = [NSMutableArray arrayWithArray:lists];
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArry.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  WHorgSelectTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    WHorganization  * model = self.dataArry[indexPath.row];
    cell.myTitLaber.font = [UIFont systemFontOfSize:12];
    cell.myTitLaber.numberOfLines = 0;
    cell.myTitLaber.text = model.name;
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WHorganization  * model = self.dataArry[indexPath.row];
    if (model.id != nil && model.name != nil ) {
        self.mblock2 (model.id ,model.name,model.address);
    }
    [self.navigationController popViewControllerAnimated:YES];
    

}


@end
