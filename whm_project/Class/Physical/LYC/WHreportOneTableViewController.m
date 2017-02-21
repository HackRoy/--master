//
//  WHreportOneTableViewController.m
//  whm_project
//
//  Created by 王义国 on 17/1/10.
//  Copyright © 2017年 chenJw. All rights reserved.
//

#import "WHreportOneTableViewController.h"
#import "MacroUtility.h"

@interface WHreportOneTableViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UIView * headView;
@property(nonatomic,strong)UIImageView * Img;
@property(nonatomic,strong)UILabel * nameLaber;
@property(nonatomic,strong)UILabel * ageLaber;
@property(nonatomic,strong)UILabel * zhifuLaber;
@property(nonatomic,strong)UILabel * moneyLaber;
@property(nonatomic,strong)UITableView * tableV;



@end

@implementation WHreportOneTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self settepUI];
    
}

-(void)settepUI
{
    self.tableV = [[UITableView alloc] initWithFrame:CGRectMake(0, kScreenHeight * 0.3, kScreenWitdh, kScreenHeight - 64) style:UITableViewStylePlain];
    _tableV.delegate = self;
    _tableV.dataSource = self;
    _tableV.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableV];
    self.tableV.tableHeaderView = self.headView;
    self.headView = [[UIView alloc]init];
    self.headView.frame = CGRectMake(0, 0, kScreenWitdh, kScreenHeight * 0.25);
    [self.view addSubview:_headView];
    
    self.Img = [[UIImageView alloc]init];
    self.Img.frame = CGRectMake(10, 20, 60, 60);
    self.Img.layer.masksToBounds = YES;
    self.Img.layer.cornerRadius = 30;
    [self.headView addSubview:_Img];
    self.Img.image = [UIImage imageNamed:@"Jw_user"];
    
    self.nameLaber = [[UILabel alloc]init];
    self.nameLaber.frame = CGRectMake(CGRectGetMaxX(self.Img.frame)+10, CGRectGetMinY(self.Img.frame), kScreenWitdh * 0.2, 30);
    self.nameLaber.text = @"段女士";
    [self.headView addSubview:_nameLaber];
    
    self.ageLaber = [[UILabel alloc]init];
    self.ageLaber.frame = CGRectMake(CGRectGetMinX(self.nameLaber.frame), CGRectGetMaxY(self.nameLaber.frame)+2, 40, 30);
    self.ageLaber.text = @"30岁";
    [self.headView addSubview:_ageLaber];
    
    self.zhifuLaber = [[UILabel alloc]init];
    self.zhifuLaber.frame = CGRectMake(CGRectGetMaxX(self.nameLaber.frame)+20, CGRectGetMinY(self.nameLaber.frame), kScreenWitdh * 0.3, 25);
    self.zhifuLaber.text = @"共需支付保费";
    self.zhifuLaber.font  = [UIFont systemFontOfSize:12];
    self.zhifuLaber.textColor = [UIColor lightGrayColor];
    [self.headView addSubview:_zhifuLaber];
    
    self.moneyLaber = [[UILabel alloc]init];
    self.moneyLaber.frame = CGRectMake(CGRectGetMidX(self.zhifuLaber.frame), CGRectGetMinY(self.ageLaber.frame), kScreenWitdh * 0.3, 30);
    self.moneyLaber.textColor = [UIColor redColor];
    self.moneyLaber.text = @"8750";
    [self.headView addSubview:_moneyLaber];
    
    
    
    
    

    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

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
