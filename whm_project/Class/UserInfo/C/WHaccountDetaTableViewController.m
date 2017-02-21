//
//  WHaccountDetaTableViewController.m
//  whm_project
//
//  Created by 王义国 on 16/10/20.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import "WHaccountDetaTableViewController.h"
#import "UIColor+Hex.h"
#define WHhight CGRectGetHeight([UIScreen mainScreen].bounds)
//414x736
#import "WHinsuranceNameViewController.h"
//出生日期选择
#import "ASBirthSelectSheet.h"
#import "WHaddressDetalViewController.h"
#import "WHaccountTableViewCell.h"
#import "WHgetuseinfo.h"
#import "JGProgressHelper.h"
#import "MacroUtility.h"
#import <UIImageView+WebCache.h>
#import "WHcredEntViewController.h"
#import "WHareaLiveTableViewController.h"

#define kScreenWitdh [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define IOS8 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0 ? YES : NO)
@interface WHaccountDetaTableViewController ()<UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>
{
    
    UIActionSheet *sheet;
    NSMutableArray * myArr;
    
}

@property(nonatomic,strong)UIButton * addBut;

@property(nonatomic,strong)UIView * myView;

@property(nonatomic,strong)UIImageView * phoImage;

@property(nonatomic,strong)UIImageView * sexImage;
@property(nonatomic,strong)UILabel * sexLaber;


@property (nonatomic, strong) UITableView *tableV;
@property (nonatomic, strong) WHaccountTableViewCell *cell;

@property (nonatomic, strong)UILabel * StrCert;


//图像data
@property (nonatomic, strong) NSData * picData;
@property (nonatomic, strong)NSString *picStr;
@property(nonatomic,strong)NSMutableArray * dataArry;
@property(nonatomic,strong)UILabel * StrName;

@property(nonatomic,strong)UILabel * StrBirth;

@property(nonatomic,strong)UILabel * StrArea;

@property(nonatomic,strong)UILabel * detalAddress;

@property(nonatomic,strong)NSString * StrSex;

@property(nonatomic,strong)NSString * StrAreaID;
@property(nonatomic,strong)NSString * statues;

@property(nonatomic,strong)NSString * strType;

@end

@implementation WHaccountDetaTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    myArr =[NSMutableArray array];
    
    self.navigationItem.title = @"账户详情";
   self.tableV = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, wScreenW, wScreenH - 64) style:UITableViewStylePlain];
    
    _tableV.delegate = self;
    _tableV.dataSource = self;
    _tableV.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_tableV];
    [self requartDate];

}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self requartDate];
}
-(void)requartDate
{
    self.dataArry = [NSMutableArray array];
    id hud = [JGProgressHelper showProgressInView:self.view];
    [self.dataService get_user_infoWithUid:@"" success:^(NSArray *lists)
    {
        [hud hide:YES];
        
        [myArr addObjectsFromArray:lists];
        
        for (WHgetuseinfo * model in lists)
        {

            self.StrName.text = model.name;
            self.StrCert.text = model.status_name;
            self.picStr = model.avatar;
            self.statues = model.status;
            
            self.strType = model.type;
            
            [self.phoImage sd_setImageWithURL:[NSURL URLWithString:model.avatar] placeholderImage:[UIImage imageNamed:@"Jw_user"]];
            if ([model.sex isEqualToString:@"1"])
            {
                self.sexLaber.text = @"男";
               // self.sexImage.image = [UIImage imageNamed:@"test_male"];

            }else
            {
                self.sexLaber.text = @"女";
                //self.sexImage.image = [UIImage imageNamed:@"test_famale"];

            }
            

            self.StrBirth.text = model.birthday;
            self.StrArea.text = model.area_info;
            self.detalAddress.text = model.address;
        }
        
        
    } failure:^(NSError *error) {
        
    }];
    
}


//
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    
    return 24;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row == 0)
    {
        return WHhight *0.135;
    }
    else
    {
        return  WHhight * 0.081;
    }
}

//
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == 2)
    {
        
    self.myView = [[UIView alloc]init];
    self.myView.backgroundColor = [UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:1.0];
        self.myView.frame = CGRectMake(0, CGRectGetHeight([UIScreen mainScreen].bounds)*0.7, CGRectGetWidth([UIScreen mainScreen].bounds), 30);
        
    self.addBut = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.addBut.frame = CGRectMake(30, CGRectGetMinY(self.myView.frame)+40, CGRectGetWidth(self.view.frame)-60, CGRectGetHeight(self.myView.frame));
    self.addBut.backgroundColor = [UIColor colorWithHex:0x4367FF ];
    
    [self.addBut addTarget:self action:@selector(nextButAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    self.addBut.layer.cornerRadius = 15;
    [self.addBut setTitle:@"保存信息" forState:(UIControlStateNormal)];
    [self.addBut setTintColor:[UIColor whiteColor]];
    
    self.addBut.layer.shadowOffset = CGSizeMake(1, 1);
    self.addBut.layer.shadowOpacity = 0.8;
    self.addBut.layer.shadowColor = [UIColor colorWithHex:0x4367FF ].CGColor;
    
        
    [self.tableV addSubview:_addBut];
    }
    return self.myView;
 }
//提交保存
-(void)nextButAction:(UIBarButtonItem *)sender
{
    if ([self.sexLaber.text isEqualToString:@"男"])
    {
        self.StrSex = @"1";
    }
    if ([self.sexLaber.text isEqualToString:@"女"]) {
        self.StrSex = @"2";
    }
    else
    {
        self.StrSex = @"0";
    }
    
    //NSLog(@"tijiao");
    if (self.StrArea.text.length < 1)
    {
        self.StrArea.text =@"暂无地址";
    }
    
    id hud = [JGProgressHelper showProgressInView:self.view];
    
    [self.userService save_userWithUid:@""
                                avatar:self.picStr.length<1?@"":self.picStr
                                  name:self.StrName.text.length<1?@"":self.StrName.text
                                   sex:self.StrSex
                              birthday:self.StrBirth.text
                             area_info:self.StrArea.text
                          area_info_id:self.StrAreaID.length<1?@"":self.StrAreaID
                               address:self.detalAddress.text.length<1?@"暂无":self.detalAddress.text
                               success:^{
                                   [hud hide:YES];
                                   [JGProgressHelper showSuccess:@"保存成功"];
    } failure:^(NSError *error)
     {
        [hud hide:YES];
        [JGProgressHelper showError:@"保存失败"];
        
    }];
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

       return 3;
   
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    if (section == 0)
    {
        return 4;
    }if (section ==1)
    {
        return 1;
    }
    else
    {
        return 2;
    }
   
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"formCell" ];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:@"formCell"];
        if (indexPath.row == 0 && indexPath.section == 0) {
            cell.textLabel.text = @"头像";
            
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.detailTextLabel.textColor = [UIColor grayColor];
            cell.detailTextLabel.font = [UIFont systemFontOfSize:15.0];
            cell.textLabel.font = [UIFont systemFontOfSize:15.0];
            self.phoImage = [[UIImageView alloc] init];
            self.phoImage.frame = CGRectMake(CGRectGetWidth([UIScreen mainScreen].bounds)*0.75, CGRectGetMaxY(cell.textLabel.frame)+20, CGRectGetWidth([UIScreen mainScreen].bounds)*0.104, CGRectGetWidth([UIScreen mainScreen].bounds)*0.104);
            
            self.phoImage.layer.masksToBounds = YES;
            self.phoImage.layer.cornerRadius = CGRectGetWidth([UIScreen mainScreen].bounds)*0.104/2;
            self.phoImage.userInteractionEnabled = YES;
            UITapGestureRecognizer *picTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(picTapAction)];
            [self.phoImage addGestureRecognizer:picTap];
            [cell.contentView addSubview:_phoImage];
        }
        if (indexPath.row == 1 && indexPath.section == 0)
        {
            cell.textLabel.text = @"姓名";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.textLabel.font = [UIFont systemFontOfSize:15.0];
            self.StrName  = [[UILabel alloc]init];
            self.StrName.frame = CGRectMake(kScreenWitdh * 0.75, CGRectGetMidY(cell.textLabel.frame), kScreenWitdh * 0.2, WHhight*0.081);
            self.StrName.textColor = [UIColor grayColor];
            self.StrName.font = [UIFont systemFontOfSize:15.0];
            [cell.contentView addSubview:_StrName];
            
        }
        if (indexPath.row == 2 && indexPath.section == 0)
        {
            cell.textLabel.text = @"性别";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
            cell.textLabel.font = [UIFont systemFontOfSize:15.0];
            self.sexLaber = [[UILabel alloc]init];
            self.sexLaber.frame = CGRectMake(CGRectGetWidth([UIScreen mainScreen].bounds)*0.85, CGRectGetMidY(cell.textLabel.frame), kScreenWitdh * 0.1, WHhight * 0.081);
            [cell.contentView addSubview:_sexLaber];
            
            self.sexImage = [[UIImageView alloc]init];
            self.sexImage.frame = CGRectMake(CGRectGetMaxX(self.sexLaber.frame)+5, CGRectGetMaxY(cell.textLabel.frame), CGRectGetWidth(self.sexLaber.frame)/2, WHhight * 0.081/2);
            
        }

        
        if (indexPath.row == 3 && indexPath.section == 0) {
            cell.textLabel.text = @"出生时间";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            //cell.detailTextLabel.textColor = [UIColor grayColor];
            cell.detailTextLabel.textColor = [UIColor grayColor];
            cell.detailTextLabel.font = [UIFont systemFontOfSize:15.0];
            
            cell.textLabel.font = [UIFont systemFontOfSize:15.0];
            
            self.StrBirth = [[UILabel alloc]init];
            self.StrBirth.frame = CGRectMake(kScreenWitdh * 0.65, CGRectGetMidY(cell.textLabel.frame), kScreenWitdh * 0.3, WHhight*0.081);
            self.StrBirth.textColor = [UIColor grayColor];
            self.StrBirth.font = [UIFont systemFontOfSize:15.0];
            [cell.contentView addSubview:_StrBirth];
        }
     
        if (indexPath.row == 0 && indexPath.section == 1) {
            
            cell.textLabel.text = @"我的认证信息";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
         
            self.StrCert = [[UILabel alloc]init];
            self.StrCert.frame = CGRectMake(kScreenWitdh * 0.65, CGRectGetMidY(cell.textLabel.frame), kScreenWitdh * 0.3, WHhight * 0.081);
            self.StrCert.textColor = [UIColor redColor];
            self.StrCert.font = [UIFont systemFontOfSize:13.0];
            
            [cell.contentView addSubview:_StrCert];
            cell.textLabel.font = [UIFont systemFontOfSize:15.0];
        }

        if (indexPath.row == 0 && indexPath.section == 2) {
            cell.textLabel.text = @"所在地区";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            //cell.detailTextLabel.textColor = [UIColor grayColor];
            cell.detailTextLabel.textColor = [UIColor grayColor];
            cell.detailTextLabel.font = [UIFont systemFontOfSize:15.0];
            
            cell.textLabel.font = [UIFont systemFontOfSize:15.0];
            self.StrArea = [[UILabel alloc]init];
            self.StrArea.frame = CGRectMake(kScreenWitdh * 0.5, CGRectGetMidY(cell.textLabel.frame), kScreenWitdh * 0.4, WHhight * 0.081);
            self.StrArea.textColor = [UIColor grayColor];
            [cell.contentView addSubview:_StrArea];
        }

        if (indexPath.row == 1 && indexPath.section == 2) {
            cell.textLabel.text = @"详细地址";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            //cell.detailTextLabel.textColor = [UIColor grayColor];
            cell.detailTextLabel.textColor = [UIColor grayColor];
            cell.detailTextLabel.font = [UIFont systemFontOfSize:15.0];
            
            cell.textLabel.font = [UIFont systemFontOfSize:15.0];
            self.detalAddress = [[UILabel alloc]init];
            self.detalAddress.frame = CGRectMake(kScreenWitdh * 0.5, CGRectGetMidY(cell.textLabel.frame), kScreenWitdh * 0.45, WHhight * 0.081);
            self.detalAddress.textColor = [UIColor grayColor];
            self.detalAddress.font = [UIFont systemFontOfSize:15.0];
            [cell.contentView addSubview:_detalAddress];
            
        }

    }
       return cell;
}




-(void)picTapAction
{
    if (IOS8) {        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"获取图片" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        ///从相册中选择
        UIAlertAction *defaultAction1 = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //相册
            UIImagePickerController *imagePickerController = [[UIImagePickerController alloc]init];
            imagePickerController.delegate = self;
            imagePickerController.allowsEditing = YES;
            imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            [self presentViewController:imagePickerController animated:YES completion:^{}];
            
        }];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }];
        
        UIAlertAction *defaultAction2 = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //相册
            UIImagePickerController *imagePickerController = [[UIImagePickerController alloc]init];
            imagePickerController.delegate = self;
            imagePickerController.allowsEditing = YES;
            imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:imagePickerController animated:YES completion:^{}];
            
        }];
        
        [alertController addAction:defaultAction2];
        [alertController addAction:cancelAction];
        [alertController addAction:defaultAction1];
        
        //弹出视图，使用uiviewController的方法
        [self presentViewController:alertController animated:YES completion:nil];
    }else{
        
        sheet = [[UIActionSheet alloc]initWithTitle:@"获取图片" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"取消" otherButtonTitles:@"相册", nil];
        [sheet showInView:self.view];
    }

}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    NSInteger soureType = 0;
    //是否支持相机，模拟器没有相机
    switch (buttonIndex)
    {
        case 1://相册
            soureType = UIImagePickerControllerSourceTypePhotoLibrary;
            break;
        default:
            break;
    }
    if (buttonIndex == 1) {
        soureType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    }
    
    //跳转到相机或相册页面
    UIImagePickerController *imagePick = [[UIImagePickerController alloc]init];
    imagePick.delegate = self;
    imagePick.allowsEditing = YES;
    imagePick.sourceType = soureType;
    [self presentViewController:imagePick animated:YES completion:nil];
}

#pragma mark - 保存图片到沙盒中
-(void)saveImage:(UIImage *)currentImage withName:(NSString *)imageName{
    NSData *imageData = UIImageJPEGRepresentation(currentImage, 1); //返回的数据大小(1~0.0)
    //获取沙盒目录
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]stringByAppendingPathComponent:imageName];
    
    //将图片写入文件
    [imageData writeToFile:fullPath atomically:NO];
}
#pragma mark -  压缩图片
- (UIImage *)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize{
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    // End the context
    UIGraphicsEndImageContext();
    // Return the new image.
    return newImage;
}



#pragma mark - iOS7 iOS8 都要调用方法，选择完成调用该方法
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    //保存图片到本地，上传图片到服务器需要使用
    [self saveImage:[self imageWithImageSimple:image scaledToSize:CGSizeMake(CGRectGetWidth(self.phoImage.frame)*2, CGRectGetHeight(self.phoImage.frame)*2)] withName:@"avatar.png"];
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]stringByAppendingPathComponent:@"avatar.png"];
    
    //存储路径
    NSLog(@"!!!!!!!!!!!!!!!!!!!!!!!!!!存储路径%@", fullPath);
    UIImage *saveImage = [[UIImage alloc]initWithContentsOfFile:fullPath];
    
    //1 //UIImage转换为NSData// 提交的时候用的数据
    self.picData = UIImageJPEGRepresentation(saveImage, 1.0);
    //设置头像图片显示
    self.phoImage.image = saveImage;
    
    //数据转化上传
    self.picStr = [self.picData base64Encoding];
}



//选中事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0 && indexPath.row == 1) {
      
        WHinsuranceNameViewController * insurance = [[WHinsuranceNameViewController alloc]init];
        insurance.mblock1 = ^(NSString * s1)
        {
            self.StrName.text = s1 ;
            
           
        };
        
        [self.navigationController pushViewController:insurance animated:NO];
        
    }
    
    //
    if (indexPath.section == 0 && indexPath.row == 3) {
        UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
        ASBirthSelectSheet *datesheet = [[ASBirthSelectSheet alloc] initWithFrame:self.view.bounds];
        datesheet.selectDate = cell.detailTextLabel.text;
        datesheet.GetSelectDate = ^(NSString *dateStr)
        {
            self.StrBirth.text = dateStr;
        };
        [self.view addSubview:datesheet];
        
    }
   
        if (indexPath.section == 2 && indexPath.row == 1)
        {
        WHaddressDetalViewController *address = [[WHaddressDetalViewController alloc] init];
       address.mblock1 = ^(NSString * s1)
        {
           self.detalAddress.text = s1 ;
        };
        [self.navigationController pushViewController:address animated:NO];
    }
    //所在地区
    if (indexPath.section == 2 && indexPath.row == 0) {
        
        WHareaLiveTableViewController * areaLive = [[WHareaLiveTableViewController alloc] init];
        
        areaLive.mblockArea = ^(NSString * s1 ,NSString * s2)
        {
            self.StrArea.text = s1 ;
            self.StrAreaID = s2 ;
            
        };
        
        [self.navigationController pushViewController:areaLive animated:YES];
        
    }
        if (indexPath.section == 1 && indexPath.row == 0)
        {
                    if ([self.strType isEqualToString:@"0"]) {
            
                        [JGProgressHelper showError:@"只有代理人才具有该权限"];
                    }
                    else
                    {
            
            if (myArr.count >= 1)
            {
                WHgetuseinfo * model = myArr[0];
                WHcredEntViewController * cred = [[WHcredEntViewController alloc] init];
                cred.xingming = model.name;
                cred.shenfenzhenghao = model.id_number;
                cred.gsdz = model.job_address;
                cred.shanchang = model.specialize_in;
                cred.zhiwu = model.profession;
                cred.staues = model.status;
                
                cred.org_name = model.org_name;
                cred.company_type = model.company_type;
                cred.company_type_name = model.company_type_name;
                cred.company = model.company;
                cred.comid = model.company_id;
                cred.orgId = model.org_id;
                [self.navigationController pushViewController:cred animated:YES];
              }
                    }
            
        }


    if (indexPath.section == 0 && indexPath.row == 2) {
      
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:nil preferredStyle:  UIAlertControllerStyleActionSheet];
               [alert addAction:[UIAlertAction actionWithTitle:@"男" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //点击按钮的响应事件；
            self.sexLaber.text = @"男";
        }]];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"女" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //点击按钮的响应事件；
            self.sexLaber.text = @"女";
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action)
        {
            //点击按钮的响应事件；
        }]];
        
        //弹出提示框；
        [self presentViewController:alert animated:true completion:nil];
       
    }
    
    
    
}


@end
