//
//  HmSelectProductController.m
//  whm_project
//
//  Created by zhaoHm on 16/10/18.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import "HmSelectProductController.h"
#import "HmSelectProductCell.h"
#import "MacroUtility.h"


#define HmSelectProductCellIdentifier @"HmSelectProductCellIdentifier"

@interface HmSelectProductController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableV;
@property (nonatomic, strong) HmSelectProductCell *cell;

// 选中数组返回
@property (nonatomic, strong) NSMutableArray *selectedArray;

@end

@implementation HmSelectProductController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 布局
    [self setupUI];
    
}

#pragma mark -- 布局
-(void)setupUI
{
    self.selectedArray = [NSMutableArray array];
    self.title = @"选择产品";
    
    self.tableV = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWitdh, kScreenHeight - 64) style:UITableViewStylePlain];
    _tableV.delegate = self;
    _tableV.dataSource = self;
    _tableV.separatorInset = UIEdgeInsetsMake(0, 10, 0, 10);
    _tableV.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_tableV];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:@selector(saveSelectedProduct:)];
}

#pragma mark -- Private
-(void)saveSelectedProduct:(UIBarButtonItem *)sender
{
    // 从哪来回哪去,并带回去一个糖葫芦
}

#pragma mark -- Table View Delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BOOL nibsRegistered = NO;
    if (!nibsRegistered) {
        UINib *nib = [UINib nibWithNibName:NSStringFromClass([HmSelectProductCell class]) bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:HmSelectProductCellIdentifier];
        nibsRegistered = YES;
    }
    self.cell = [tableView dequeueReusableCellWithIdentifier:HmSelectProductCellIdentifier];
    self.cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return _cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HmSelectProductCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if ([cell.imgSelect.image isEqual:[UIImage imageNamed:@"product_selected"]]) {
        cell.imgSelect.image = [UIImage imageNamed:@"product_unselected"];
        for (NSString *str in self.selectedArray) {
            if ([str isEqualToString:[NSString stringWithFormat:@"%ld",(long)indexPath.row]]) {
                [self.selectedArray removeObject:str];
               
                break;
            }
        }
    }
    else
    {
        cell.imgSelect.image = [UIImage imageNamed:@"product_selected"];
        [self.selectedArray addObject:[NSString stringWithFormat:@"%ld",(long)indexPath.row]];
    }
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
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
