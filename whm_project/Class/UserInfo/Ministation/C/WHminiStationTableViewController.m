//
//  WHminiStationTableViewController.m
//  whm_project
//
//  Created by 王义国 on 16/10/28.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import "WHminiStationTableViewController.h"
#import "UIColor+Hex.h"
#import "WHmyMessageTableViewController.h"
#import "WHintroduceViewController.h"
#import "WHrecommentTableViewController.h"

#import "PicUpdateViewController.h"

#import "WHpreviewTableViewController.h"

//
#import "WHLookforViewController.h"
#import "WHministaViewController.h"


#define kScreenWitdh [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

@interface WHminiStationTableViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableV;

@end

@implementation WHminiStationTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"我的微站";

    
    self.tableV = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWitdh, kScreenHeight - 64) style:UITableViewStylePlain];
    
    
    _tableV.delegate = self;
    _tableV.dataSource = self;
    _tableV.backgroundColor = [UIColor colorWithHex: 0xF5F7F9];
    [self.view addSubview:_tableV];
    
    //右键预览
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"预览" style:(UIBarButtonItemStylePlain) target:self action:@selector(LookAction)];


}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    /**
     *  footer高度
     
     
     */
    
    
    return 24;
}
//预览
-(void)LookAction
{
   
   WHministaViewController * lookfor = [[WHministaViewController alloc]init];
    
    [self.navigationController pushViewController:lookfor animated:YES];
}



//高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kScreenHeight * 0.081;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (section == 0) {
        return 2;
    }
    else
        return 2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"formCell" ];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:@"formCell"];
       
        if (indexPath.row == 0 && indexPath.section == 0) {
            
            cell.textLabel.text = @"我的留言";
            cell.textLabel.font = [UIFont systemFontOfSize:15.0];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

            
        }
        if (indexPath.section == 0 && indexPath.row == 1) {
            cell.textLabel.text = @"我的推荐";
            cell.textLabel.font = [UIFont systemFontOfSize:15.0];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;


        }
        
        if (indexPath.section == 1 && indexPath.row == 0) {
            cell.textLabel.text = @"个人介绍";
            cell.textLabel.font = [UIFont systemFontOfSize:15.0];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;


        }
        
        if (indexPath.section == 1 && indexPath.row == 1) {
            cell.textLabel.text = @"荣誉资质";
            cell.textLabel.font = [UIFont systemFontOfSize:15.0];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;


        }
        
    }
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row == 0) {
        WHmyMessageTableViewController * message = [[WHmyMessageTableViewController alloc]init];
        [self.navigationController pushViewController:message animated:NO];
        
    }
    if (indexPath.section == 1 && indexPath.row == 0) {
        WHintroduceViewController * intro = [[WHintroduceViewController alloc]init];
        [self.navigationController pushViewController:intro  animated:NO];
    }
    
    if (indexPath.section == 0 && indexPath.row == 1) {
        WHrecommentTableViewController * comment = [[WHrecommentTableViewController alloc]init];
        [self.navigationController pushViewController:comment animated:NO];
    }
    if (indexPath.section == 1 && indexPath.row == 1) {
        PicUpdateViewController *picVC = [[PicUpdateViewController alloc]init];
        [self.navigationController pushViewController:picVC animated:YES];
    }
    
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
