//
//  PicUpdateViewController.m
//  动态添加图片
//
//  Created by WHM on 2016/11/1.
//  Copyright © 2016年 WHM. All rights reserved.
//

#import "PicUpdateViewController.h"
#import "PicUpdateCollectionViewCell.h"
#import "AddPicCollectionViewCell.h"
#import "JwUserService.h"
#import "JGProgressHelper.h"
#import "WHgethonor.h"
#import <UIImageView+WebCache.h>
#import "MacroUtility.h"

#define kScreenW [[UIScreen mainScreen] bounds].size.width
#define kScreenH [[UIScreen mainScreen] bounds].size.height
#define IOS8 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0 ? YES : NO)

@interface PicUpdateViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UIPickerViewDelegate, UIImagePickerControllerDelegate,UIActionSheetDelegate,UINavigationControllerDelegate>
{
    UIActionSheet * sheet;
}

@property (nonatomic,strong)UICollectionView *collectionView;

@property (nonatomic, assign) int count;

@property (nonatomic, strong) UIButton * button;
@property (nonatomic,strong)NSMutableArray *picArr;
@property (nonatomic,strong) NSMutableArray * idsArry;
@property(nonatomic,strong) NSString * strID;
@property(nonatomic,strong)NSString * currentDateString;

@property(nonatomic,strong)UIView * noDateView;
@property(nonatomic,strong)UIImageView * noDateImg;
@end

@implementation PicUpdateViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"我的荣誉";

    self.picArr = [NSMutableArray array];
    [self getData];
    [self setUI];
}
-(void)getData
{
    id hud = nil;
    hud = [JGProgressHelper showProgressInView:self.view];
    [self.dataService gethonorWithUid:@"" success:^(NSArray *lists) {
        [hud hide:YES];
        
        self.idsArry = [NSMutableArray arrayWithArray:lists];
        for (WHgethonor *model in lists) {
            [self.picArr addObject:model.img1];
//            [self.idsArry addObject:model.id];
        }
        
        [_collectionView reloadData];
        
    } failure:^(NSError *error) {
        
        [hud hide:YES];
        [JGProgressHelper showError:@"没有数据"];
//        self.noDateView = [[UIView alloc]init];
//        self.noDateView.frame = CGRectMake(0, 0, kScreenWitdh, kScreenHeight);
//        //self.noDateView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"nodate"]];
//        [self.view addSubview:_noDateView];
//        self.noDateImg = [[UIImageView alloc]init];
//        self.noDateImg.frame = CGRectMake(10, 10, kScreenWitdh-20, kScreenWitdh-40);
//        [self.noDateView addSubview:_noDateImg];
//        self.noDateImg.image = [UIImage imageNamed:@"nodate"];
//        self.title = @"我的荣誉";

    }];
}

-(void)setUI
{
    [self.view addSubview:self.collectionView];
    
    NSDate*currentDate= [NSDate date];
    
    //用于格式化NSDate对象
    
    NSDateFormatter*dateFormatter= [[NSDateFormatter alloc]init];
    
    //设置格式：zzz表示时区
    
    [dateFormatter setDateFormat:@"yyyy-MM-ddHH:mm:sszzz"];
    
    //NSDate转NSString
    
   //_currentDateString= [dateFormatter stringFromDate:currentDate];
    
    //输出currentDateString
    
    NSString *  Sdate = [dateFormatter stringFromDate:currentDate];
    self.currentDateString = [Sdate substringToIndex:18];
    

    NSLog(@"pppp%@",_currentDateString);
}


-(UICollectionView *)collectionView
{
    if (_collectionView == nil)
    {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0 , kScreenW, kScreenH) collectionViewLayout:flowLayout];
        //定义每个UICollectionView 的大小
        flowLayout.itemSize = CGSizeMake((kScreenW - 45) / 2, (kScreenW - 45) / 2);
        //定义每个UICollectionView 纵向的间距
        flowLayout.minimumLineSpacing = 15;
        //定义每个UICollectionView 横向的间距
        //flowLayout.minimumInteritemSpacing = 10;
        
       
        //定义每个UICollectionView 的边距距
        flowLayout.sectionInset = UIEdgeInsetsMake(15, 15 , 15, 15);//上左下右
        //注册cell和ReusableView（相当于头部）
        [_collectionView registerClass:[PicUpdateCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
        
        
        
        [_collectionView registerClass:[AddPicCollectionViewCell class] forCellWithReuseIdentifier:@"addcell"];
        
        
        
        //[_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ReusableView"];
        
        //设置代理
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        
        //背景颜色
        _collectionView.backgroundColor = [UIColor clearColor];
        //自适应大小
        //_collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    }
    return _collectionView;
}
#pragma mark 定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.picArr.count + 1;
    
}

#pragma mark 定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

#pragma mark 每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row < self.picArr.count)
    {
        NSString *pic = self.picArr[indexPath.row];
        
        static NSString *identify = @"cell";
        PicUpdateCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
        [cell sizeToFit];
        
        [cell.picImage sd_setImageWithURL:[NSURL URLWithString:pic] placeholderImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.png",self.currentDateString]]];
        return cell;
    }
    else
    {
        static NSString *idCell = @"addcell";
        AddPicCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:idCell forIndexPath:indexPath];
        [cell sizeToFit];
        [cell.addBtn setBackgroundImage:[UIImage imageNamed:@"addimage.png"] forState:UIControlStateNormal];
        [cell.addBtn addTarget:self action:@selector(addBtnAction) forControlEvents:UIControlEventTouchUpInside];

         return cell;
    }
   
    
    
   
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    WHgethonor * model = self.idsArry[indexPath.row];
   self.strID = model.id;
   // NSLog(@"%@",s1);
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"你确定要删除该图片吗?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    //  alert.alertViewStyle = UIAlertViewStyleLoginAndPasswordInput;
    [alert show];

  
    
}

//删除图片事件
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
       id hud = [JGProgressHelper showProgressInView:self.view];
       [self.userService delhonorWithId:self.strID uid:@"" success:^{
           [hud hide:YES];
           [ JGProgressHelper showSuccess:@"删除图片成功"];
           [self.navigationController popViewControllerAnimated:YES];
           
       } failure:^(NSError *error) {
           [hud hide:YES];
           [JGProgressHelper showError:@"删除失败"];
       }];
        
    }
    
}


-(void)addBtnAction
{
    

    NSLog(@"点击了上传");
    if (IOS8) {

        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"获取图片" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        ///从相册中选择
        UIAlertAction *defaultAction1 = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //相册
            UIImagePickerController *imagePickerController = [[UIImagePickerController alloc]init];
            imagePickerController.delegate = self;
            imagePickerController.allowsEditing = YES;
            imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            [self presentViewController:imagePickerController animated:YES completion:^{
//                self.count++;
//                [_collectionView reloadData];


            }];

        }];

        UIAlertAction *defaultAction2 = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //相机
            UIImagePickerController *imagePickerController = [[UIImagePickerController alloc]init];
            imagePickerController.delegate = self;
            imagePickerController.allowsEditing = YES;
            imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:imagePickerController animated:YES completion:^{
              

            }];
        }];

        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
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

//裁剪图片
- (UIImage *)cutImage:(UIImage*)image withSize:(CGSize)size
{
    //压缩图片
    CGSize newSize;
    CGImageRef imageRef = nil;

    if ((image.size.width / image.size.height) < (size.width / size.height)) {
        newSize.width = image.size.width;
        newSize.height = image.size.width * size.height / size.width;

        imageRef = CGImageCreateWithImageInRect([image CGImage], CGRectMake(0, fabs(image.size.height - newSize.height) / 2, newSize.width, newSize.height));

    } else {
        newSize.height = image.size.height;
        newSize.width = image.size.height * size.width /size.height;

        imageRef = CGImageCreateWithImageInRect([image CGImage], CGRectMake(fabs(image.size.width - newSize.width) / 2, 0, newSize.width, newSize.height));

        /////
    }
    return [UIImage imageWithCGImage:imageRef];
}

#pragma mark - iOS7 iOS8 都要调用方法，选择完成调用该方法
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{

    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];

    //保存图片到本地，上传图片到服务器需要使用
    [self saveImage:[self imageWithImageSimple:image scaledToSize:CGSizeMake(300, 300)] withName:@"avatar.png"];
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]stringByAppendingPathComponent:@"avatar.png"];

    //存储路径
    NSLog(@"!!!!!!!!!!!!!!!!!!!!!!!!!!存储路径%@", fullPath);
    UIImage *saveImage = [[UIImage alloc]initWithContentsOfFile:fullPath];
    NSLog(@"%@", saveImage);
  
    //1 //UIImage转换为NSData
    NSData *picData = UIImageJPEGRepresentation(saveImage, 1.0);
//    //设置头像图片显示
    NSString *picDataStr = [picData base64Encoding];
    
    //上传图片
    
    id hud = nil;
    hud = [JGProgressHelper showProgressInView:self.view];
    [self.userService savehonorWithUid:@"" img:picDataStr success:^{
        [hud hide:YES];
        //刷新collectview , 刷新请求的数据
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"上传成功" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
        //上传成功重新请求数据,并在请求数据中刷新界面
       // [_collectionView reloadData];
        
        [self.navigationController popViewControllerAnimated:YES];
        
       // [self getData];
        
        
    } failure:^(NSError *error) {
        
        [hud hide:YES];
        [JGProgressHelper showError:nil inView:self.view];
    }];
    
    
    
}
#pragma mark - 调用uiactionsheet iOS7使用
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{

    NSInteger soureType = 0;
    //是否支持相机，模拟器没有相机
    switch (buttonIndex) {
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

#pragma mark - iOS7 iOS8 都要调用方法，拉取取消按钮调用该方法
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES completion:nil];
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
