//
//  WBYyyZHXQViewController.m
//  whm_project
//
//  Created by apple on 17/1/18.
//  Copyright © 2017年 chenJw. All rights reserved.
//

#import "WBYyyZHXQViewController.h"
#import "WBYrzxqTableViewCell.h"
#import "WHinsuranceNameViewController.h"
#import "ASBirthSelectSheet.h"
#import "WHcredEntViewController.h"
#import "WHareaLiveTableViewController.h"
#import "WHaddressDetalViewController.h"


#define IOS8 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0 ? YES : NO)

@interface WBYyyZHXQViewController ()<UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>
{
    NSMutableArray * myArr;
    UITableView * myTab;
    NSArray * xmArr;
    NSArray * dzArr;
    UIActionSheet *sheet;
    NSString * StrAreaID;
    

}
@property(nonatomic,strong)UIImageView * phoImage;
@property (nonatomic, strong) NSData * picData;
@property (nonatomic, strong)NSString *picStr;



@end

@implementation WBYyyZHXQViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = wRedColor;
    xmArr = @[@"头像",@"姓名",@"性别",@"出生时间"];
    dzArr = @[@"所在地区",@"详细地址"];
    myArr = [NSMutableArray array];
   
    
//    _perMod.type = @"0";
//    lllArr = @[_perMod.name?_perMod.name:@"选择姓名";];
    self.navigationItem.title = @"账户详情";
    [self creatLeftTtem];
    [self creatUI];
    [self requartDate];
}

-(void)requartDate
{
    id hud = [JGProgressHelper showProgressInView:self.view];
    [self.dataService get_user_infoWithUid:@"" success:^(NSArray *lists)
     {
         [hud hide:YES];
         
         [myArr addObjectsFromArray:lists];
         
     } failure:^(NSError *error)
     {
         
     }];
}

-(void)creatUI
{
    UIView * bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, wScreenW, 70)];
    UIButton * zhifu = [UIButton buttonWithType:UIButtonTypeCustom];
    [zhifu setTitle:@"保存信息" forState:UIControlStateNormal];
    zhifu.frame = CGRectMake(30, 30, wScreenW - 60, 35);
    [zhifu setTitleColor:wWhiteColor forState:UIControlStateNormal];
    zhifu.backgroundColor = wBlue;
    zhifu.layer.masksToBounds = YES;
    zhifu.layer.cornerRadius = 15;
    [zhifu addTarget:self action:@selector(zhifuqian) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:zhifu];
    
    
    myTab = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, wScreenW, wScreenH - 64) style:UITableViewStylePlain];
    myTab.delegate = self;
    myTab.dataSource = self;
    myTab.tableFooterView = bgView;
    [myTab registerClass:[WBYrzxqTableViewCell class] forCellReuseIdentifier:@"cell"];
    myTab.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:myTab];
    
}

-(void)zhifuqian
{
//    cell.llab.tag = 666 + indexPath.row;
    UILabel * xmlab = [myTab viewWithTag:666 + 1];
    UILabel * xblab = [myTab viewWithTag:666 + 2];
    UILabel * csrqlab = [myTab viewWithTag:666 + 3];

    NSString * xbStr;
    if ([xblab.text isEqualToString:@"男"])
    {
        xbStr = @"1";
    }
    if ([xblab.text isEqualToString:@"女"])
    {
        xbStr = @"2";
    }
    else
    {
        xbStr = @"0";
    }
    
    NSString * detileAddress;
    //普通用户
    UILabel * blab;
    if ([_perMod.type isEqualToString:@"0"])
    {
       blab = [myTab viewWithTag:777];

        UILabel * aLab = [myTab viewWithTag:777+1];
        detileAddress = aLab.text;
        
    }
    else
    {
        blab = [myTab viewWithTag:888];

        UILabel * aLab = [myTab viewWithTag:888+1];
        detileAddress = aLab.text;
        
    }
   
    id hud = [JGProgressHelper showProgressInView:self.view];

    [self.userService save_userWithUid:@""
                                avatar:self.picStr.length<1?@"":self.picStr
                                  name:xmlab.text?xmlab.text:@""
                                   sex:xbStr
                              birthday:csrqlab.text?csrqlab.text:@""
                             area_info:blab.text?blab.text:@""
                          area_info_id:StrAreaID.length<1?@"":StrAreaID
                               address:detileAddress?detileAddress:@""
                               success:^{
                                   [hud hide:YES];
                                   [JGProgressHelper showSuccess:@"保存成功"];
                                   [self.navigationController popToRootViewControllerAnimated:YES];
                                   
                               } failure:^(NSError *error)
     {
         [hud hide:YES];
         [JGProgressHelper showError:@"保存失败"];
         
     }];

    
    
    
    
    
    
}

#pragma mark====tab代理方法

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
        
    if ([_perMod.type isEqualToString:@"0"])
    {
        return 2;
    }else
    {
      //代理人
        return 3;
        
    }
}
 
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if ([_perMod.type isEqualToString:@"0"])
    {
        if (section == 0)
        {
            return 4;
        }else
        {
            return 2;
        }
        
    }else
    {
        //代理人
//        return 3;
        
        if (section == 0)
        {
            return 4;
        }else if (section == 1)
        {
            return 1;
        }else
        {
            return 2;
        }
        
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WBYrzxqTableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    if (indexPath.section == 0)
    {
        cell.llab.tag = 666 + indexPath.row;
        
        if (indexPath.row == 0)
        {
            cell.llab.hidden = YES;
            cell.rLab.frame = CGRectMake(5, 15, 80,50);
            cell.myBtn.frame=CGRectMake(wScreenW - 50 - 20-10, 15, 50, 50);
            cell.myBtn.tag = 5858;
            cell.myBtn.layer.masksToBounds = YES;
            cell.myBtn.layer.cornerRadius = 25;
            [cell.myBtn sd_setImageWithURL:[NSURL URLWithString:_perMod.avatar] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"Jw_user"]];
                        
        }else
        {
            cell.rLab.frame = CGRectMake(5, 0, 80,45);
            cell.myBtn.hidden = YES;
            if (indexPath.row == 1)
            {
                cell.llab.text = _perMod.name ? _perMod.name : @"修改姓名";
                
            }else if (indexPath.row == 2)
            {
                if ([_perMod.sex isEqualToString:@"1"])
                {
                    cell.llab.text = @"男";
                }else
                {
                    cell.llab.text = @"女";
                }
            }else if (indexPath.row == 3)
            {
                cell.llab.text = _perMod.birthday?_perMod.birthday:@"选择出生日期";
            }
        }
        cell.rLab.text = xmArr[indexPath.row];
    }
     //普通用户
    if ([_perMod.type isEqualToString:@"0"])
    {

        if (indexPath.section == 1)
        {
            cell.rLab.frame = CGRectMake(5, 0, 80,45);
            cell.llab.tag = 777 + indexPath.row;
            cell.rLab.text = dzArr[indexPath.row];
            if (indexPath.row == 0)
            {
                cell.llab.text = _perMod.area_info?_perMod.area_info:@"请选择地区";
            }else
            {
                cell.llab.text = _perMod.address?_perMod.address:@"请选择详细地址";
            }
        }
    }
    else
    {

        if (indexPath.section == 1)
        {
            cell.rLab.frame = CGRectMake(5, 0, 80,45);

//            cell.llab.tag =
            cell.rLab.text = @"我的认证信息";
            cell.llab.textColor = wRedColor;
            cell.llab.text = _perMod.status_name;
            
        }
        
        if (indexPath.section == 2)
        {
            cell.rLab.frame = CGRectMake(5, 0, 80,45);

            cell.llab.tag = 888 + indexPath.row;

            cell.rLab.text = dzArr[indexPath.row];
            if (indexPath.row == 0)
            {
                cell.llab.text = _perMod.area_info?_perMod.area_info:@"请选择地区";
            }else
            {
                cell.llab.text = _perMod.address?_perMod.address:@"请选择详细地址";
            }
        }
     }
       return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0 && indexPath.row == 0)
    {
        return 80;
    }else
    {
        return 45;
    }
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 8;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0)
    {
        
        UILabel * lab = [tableView viewWithTag:666 + indexPath.row];
        
        if (indexPath.row == 0)
        {
           
            [self picTapAction];
            
        }
        else if (indexPath.row == 1)
        {
            WHinsuranceNameViewController * insurance = [[WHinsuranceNameViewController alloc]init];
            insurance.mblock1 = ^(NSString * s1)
            {
                lab.text = s1 ;
                
            };
            
            [self.navigationController pushViewController:insurance animated:NO];

            
        }
        else if (indexPath.row == 2)
        {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:nil preferredStyle:  UIAlertControllerStyleActionSheet];
            [alert addAction:[UIAlertAction actionWithTitle:@"男" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                //点击按钮的响应事件；
                lab.text = @"男";
            }]];
            
            [alert addAction:[UIAlertAction actionWithTitle:@"女" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                //点击按钮的响应事件；
                
                lab.text = @"女";
            }]];
            [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                //点击按钮的响应事件；
            }]];
            
            //弹出提示框；
            [self presentViewController:alert animated:true completion:nil];
            
        }
        else if (indexPath.row == 3)
        {
            ASBirthSelectSheet *datesheet = [[ASBirthSelectSheet alloc] initWithFrame:self.view.bounds];
            //            datesheet.selectDate = cell.detailTextLabel.text;
            datesheet.GetSelectDate = ^(NSString *dateStr)
            {
                
                lab.text = dateStr;
            };
            [self.view addSubview:datesheet];
            
        }
        
        
        
    }
    
    //普通用户
    if ([_perMod.type isEqualToString:@"0"])
    {
     
        if (indexPath.section == 1)
        {
            UILabel * lab = [tableView viewWithTag:777 + indexPath.row];
            if (indexPath.row == 0)
            {
                WHareaLiveTableViewController * areaLive = [[WHareaLiveTableViewController alloc] init];
                areaLive.mblockArea = ^(NSString * s1 ,NSString * s2)
                {
                    lab.text = s1 ;
                    StrAreaID = s2 ;
                };
                [self.navigationController pushViewController:areaLive animated:YES];
                
            }
            else
            {
                WHaddressDetalViewController *address = [[WHaddressDetalViewController alloc] init];
                address.mblock1 = ^(NSString * s1)
                {
                    lab.text = s1 ;
                };
                [self.navigationController pushViewController:address animated:NO];
            }
        }
     }
    else
    {
        if (indexPath.section == 1)
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
        
        if (indexPath.section == 2)
        {
            UILabel * lab = [tableView viewWithTag:888 + indexPath.row];
            if (indexPath.row == 0)
            {
            WHareaLiveTableViewController * areaLive = [[WHareaLiveTableViewController alloc] init];
                areaLive.mblockArea = ^(NSString * s1 ,NSString * s2)
                {
                    lab.text = s1 ;
                    StrAreaID = s2 ;
                };
  [self.navigationController pushViewController:areaLive animated:YES];
                
            }
            else
            {
                WHaddressDetalViewController *address = [[WHaddressDetalViewController alloc] init];
                address.mblock1 = ^(NSString * s1)
                {
                    lab.text = s1 ;
                };
                [self.navigationController pushViewController:address animated:NO];
             }
        }
}
}

-(void)picTapAction
{
    if (IOS8)
    {
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
    if (buttonIndex == 1)
    {
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
- (UIImage *)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize
{
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
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    UIButton * btn = [self.view viewWithTag:5858];

    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    //保存图片到本地，上传图片到服务器需要使用
    [self saveImage:[self imageWithImageSimple:image scaledToSize:CGSizeMake(CGRectGetWidth(btn.frame)*2, CGRectGetHeight(btn.frame)*2)] withName:@"avatar.png"];
    
    
    
    
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]stringByAppendingPathComponent:@"avatar.png"];
    
    //存储路径
    UIImage *saveImage = [[UIImage alloc]initWithContentsOfFile:fullPath];
    
    //1 //UIImage转换为NSData// 提交的时候用的数据
    self.picData = UIImageJPEGRepresentation(saveImage, 1.0);
    //设置头像图片显示
    
    [btn setImage:saveImage forState:UIControlStateNormal];
    
    //数据转化上传
    self.picStr = [self.picData base64Encoding];    
    
    
    
 }





- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
