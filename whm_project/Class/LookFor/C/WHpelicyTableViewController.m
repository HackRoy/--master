//
//  WHpelicyTableViewController.m
//  whm_project
//
//  Created by 王义国 on 16/11/3.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import "WHpelicyTableViewController.h"
#import "WHpecTableViewCell.h"
#import "WHgetprofirst.h"
#import "JGProgressHelper.h"
#import "MacroUtility.h"
@interface WHpelicyTableViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)NSMutableArray * duryArry;
@property (nonatomic, strong) UITableView *tableV;
@property(nonatomic,strong)WHpecTableViewCell * cell;
@property(nonatomic,strong)NSString * Name;

@end

@implementation WHpelicyTableViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    self.duryArry  = [NSMutableArray array];
    [self quartData];
    
}


-(void)quartData
{
    id hud = [JGProgressHelper showProgressInView:self.view];
    [self.dataService getprofirstWithUid:nil success:^(WHgetprofirst *profirst) {
       
        [hud hide:YES];
        for (JwPeriod * per in profirst.period) {
            [self.duryArry addObject:per ];
        }
        
        [self.tableV reloadData];
    } failure:^(NSError *error) {
        [hud hide:YES];
        [JGProgressHelper showError:@""];
    }];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 布局
    [self setupUI];
    
    [self.tableV registerClass:[WHpecTableViewCell class] forCellReuseIdentifier:@"cell"];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back"] style:(UIBarButtonItemStylePlain) target:self action:@selector(left :)];
}
-(void)left:(UIBarButtonItem *)sender
{
    if (self.Name != nil) {
        self.mblock2 (self.Name);
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.duryArry.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WHpecTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.model = self.duryArry[indexPath.row];
    // Configure the cell...
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    JwPeriod * per = self.duryArry[indexPath.row];
    self.Name = per.name;
    //NSLog(@"%@",per.name);
    
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
