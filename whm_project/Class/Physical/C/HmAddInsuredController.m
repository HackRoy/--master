//
//  HmAddInsuredController.m
//  whm_project
//
//  Created by zhaoHm on 16/10/26.
//  Copyright © 2016年 chenJw. All rights reserved.
//

#import "HmAddInsuredController.h"
#import "WHsexViewController.h"
//
#import "ASBirthSelectSheet.h"
#import "WHrelationTableViewController.h"
#define IOS8 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0 ? YES : NO)
#import "JGProgressHelper.h"
#import "UIColor+AddColor.h"

@interface HmAddInsuredController ()<UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate,UITextFieldDelegate>
{
    
    UIActionSheet *sheet;
    UITapGestureRecognizer *tapGesture;

}
@property (weak, nonatomic) IBOutlet UITextField *nameText;
@property (weak, nonatomic) IBOutlet UILabel *sexLaber;
@property (weak, nonatomic) IBOutlet UILabel *birthLaber;

@property (weak, nonatomic) IBOutlet UILabel *relationLaber;

@property (weak, nonatomic) IBOutlet UITextField *yearComeText;

@property (weak, nonatomic) IBOutlet UITextField *yearOutText;
@property (weak, nonatomic) IBOutlet UITextField *debtText;
@property (weak, nonatomic) IBOutlet UIImageView *phoMyimage;
@property (weak, nonatomic) IBOutlet UIButton *trueButon;

@property(nonatomic,strong) NSString * relatID;
//图像data
@property (nonatomic, strong) NSData * picData;
@property (nonatomic, strong)NSString *picStr;

@property(nonatomic,strong)NSString * strSex;
//监听之后的值
@property(nonatomic ,strong)NSString *str0;
@property(nonatomic ,strong)NSString *str1;
@property(nonatomic ,strong)NSString *str2;

@end

@implementation HmAddInsuredController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.title = @"添加被保人";
    [self DateSetUp];
    
    self.yearComeText.delegate = self;
    self.yearOutText.delegate = self;
    self.debtText.delegate = self;
//    if (self.yearComeText.text.length == 0 && self.yearOutText.text.length == 0 && self.picStr.length == 0 && self.strSex.length == 0  && self.birthLaber.text.length == 0) {
//        [self.trueButon setUserInteractionEnabled:YES];
//               self.trueButon.backgroundColor = [UIColor blueColor];
//
//    }
//    else
//    {
////                [self.trueButon setUserInteractionEnabled:NO];
//        self.trueButon.backgroundColor = [UIColor grayColor];
//    }
   
    [self.nameText addTarget:self action:@selector(textFieldDidChange) forControlEvents:UIControlEventEditingChanged];
    
    [self.yearComeText addTarget:self action:@selector(textFieldDidChange) forControlEvents:UIControlEventEditingChanged];
    [self.yearOutText addTarget:self action:@selector(textFieldDidChange) forControlEvents:UIControlEventEditingChanged];
    [self.debtText addTarget:self action:@selector(textFieldDidChange) forControlEvents:UIControlEventEditingChanged];

//   
//    [self.sexLaber addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(textFieldDidChange)]];

//    //注册监听
//    [self.sexLaber addObserver:self forKeyPath:@"text" options:NSKeyValueObservingOptionNew context:nil];
//    [self.birthLaber addObserver:self forKeyPath:@"text" options:NSKeyValueObservingOptionNew context:nil];
//    [self.relationLaber addObserver:self forKeyPath:@"text" options:NSKeyValueObservingOptionNew context:nil];
//
    //处理属性改变事件
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
//    if ([self.sexLaber isEqual:object]) {
//        _str0=nil;
//        _str0= change[NSKeyValueChangeNewKey];
//         NSLog(@"性别%@",change);
//    }
//    if ([self.birthLaber isEqual:object]) {
//        _str1=nil;
//        _str1= change[NSKeyValueChangeNewKey];
//
//        NSLog(@"日期%@",change);
//    }
//    if ([self.relationLaber isEqual:object]) {
//        _str2=nil;
//        _str2= change[NSKeyValueChangeNewKey];
//
//        NSLog(@"日期%@",change);
//    }
    
//    if (self.nameText.text.length!=0&&self.yearComeText.text.length!=0&&self.yearOutText.text.length!=00&&self.debtText .text.length!=0&&_str0!=nil&&_str1!=nil&&_str2!=nil) {
//        self.trueButon.backgroundColor = wBlue;
//        [self.trueButon setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
//        self.trueButon.enabled=YES;
//    }else if(self.nameText.text.length==0||self.yearComeText.text.length==0||self.yearOutText.text.length==0||self.debtText .text.length==0||self.relationLaber.text.length==0||self.birthLaber.text.length==0||self.sexLaber.text.length==0){
//        self.trueButon.backgroundColor=[UIColor buttonbgcolor];
//        self.trueButon.enabled = NO;
//        [self.trueButon setTitleColor:[UIColor ziticolor]forState:UIControlStateNormal];
//    }
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.trueButon.backgroundColor=[UIColor buttonbgcolor];
    self.trueButon.enabled = NO;
    [self.trueButon setTitleColor:[UIColor ziticolor]forState:UIControlStateNormal];
    
}
-(void)textFieldDidChange{
    
    if (self.nameText.text.length!=0&&self.yearComeText.text.length!=0&&self.yearOutText.text.length!=00&&self.debtText .text.length!=0/*&&_str0!=nil&&_str1!=nil&&_str2!=nil*/) {
        self.trueButon.backgroundColor = wBlue;
        [self.trueButon setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
        self.trueButon.enabled=YES;
    }else if(self.nameText.text.length==0||self.yearComeText.text.length==0||self.yearOutText.text.length==0||self.debtText .text.length==0||self.relationLaber.text.length==0||self.birthLaber.text.length==0||self.sexLaber.text.length==0){
        self.trueButon.backgroundColor=[UIColor buttonbgcolor];
        self.trueButon.enabled = NO;
        [self.trueButon setTitleColor:[UIColor ziticolor]forState:UIControlStateNormal];
        
    }
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
    //滑动效果（动画）
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    
    //将视图的Y坐标向上移动，以使下面腾出地方用于软键盘的显示
    self.view.frame = CGRectMake(0.0f, -100.0f, self.view.frame.size.width, self.view.frame.size.height);//64-216
    
    [UIView commitAnimations];
}

- (void)textFieldDidEndEditing:(UITextField *)textField;{
   
    
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    self.view.frame = CGRectMake(0.0f, 64+0.0f, self.view.frame.size.width, self.view.frame.size.height);
    [UIView commitAnimations];
}
//UI事件
-(void)DateSetUp
{
    //性别选择
  tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClickUILable:)];
    self.sexLaber.userInteractionEnabled = YES;
    //设置手指数 单指
    
    tapGesture.numberOfTouchesRequired=1;
    
    [self.sexLaber addGestureRecognizer:tapGesture];
    
    //出生日期选择
    
    UITapGestureRecognizer *tapGesture1 =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClickUILable1:)];
    self.birthLaber.userInteractionEnabled = YES;
    //设置手指数 单指
    
    tapGesture1.numberOfTouchesRequired=1;
    
    [self.birthLaber addGestureRecognizer:tapGesture1];
    
    //被保人关系
    UITapGestureRecognizer *tapGesture2 =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClickUILable2:)];
    self.relationLaber.userInteractionEnabled = YES;
    //设置手指数 单指
    
    tapGesture2.numberOfTouchesRequired=1;
    
    [self.relationLaber addGestureRecognizer:tapGesture2];
 
    //图片添加触屏事件
    UITapGestureRecognizer *picTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(picTapAction)];
    self.phoMyimage.userInteractionEnabled = YES;
    [self.phoMyimage addGestureRecognizer:picTap];
     self.phoMyimage.layer.masksToBounds = YES;
     self.phoMyimage.layer.cornerRadius = 55;
    
    
    
}

//被保人关系
-(void)onClickUILable2:(UITapGestureRecognizer *)sender{

    WHrelationTableViewController * relation = [[WHrelationTableViewController alloc]init];
    relation.mblock2 = ^(NSString * s1,NSString * s2)
    {
        self.relationLaber.text = s1;
        self.relatID = s2 ;
        
        
    };
    
    
    [self.navigationController pushViewController:relation animated:NO];
    
}

//出生日期选择
-(void)onClickUILable1:(UITapGestureRecognizer *)sender{
    
    ASBirthSelectSheet *datesheet = [[ASBirthSelectSheet alloc] initWithFrame:self.view.bounds];
    datesheet.selectDate = self.birthLaber.text;
    datesheet.GetSelectDate = ^(NSString *dateStr) {
        self.birthLaber.text = dateStr;
    };
    [self.view addSubview:datesheet];

    
}


//性别选择
-(void)onClickUILable:(UITapGestureRecognizer *)sender{

    

    //相应代码
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:nil preferredStyle:  UIAlertControllerStyleActionSheet];
//    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        //点击按钮的响应事件；
//        NSLog(@"点击了确定");
//    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"男" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //点击按钮的响应事件；
        NSLog(@"点击了男");
        self.sexLaber.text = @"男";
        self.strSex = @"1";
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"女" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //点击按钮的响应事件；
        NSLog(@"点击了女");
        self.sexLaber.text = @"女";
        self.strSex = @"2";
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        //点击按钮的响应事件；
        NSLog(@"点击了取消");
    }]];
    
    
    //弹出提示框；
    [self presentViewController:alert animated:true completion:nil];
    
}
-(void)dealloc
{
    [self.sexLaber removeGestureRecognizer:tapGesture];
}

//图片选取获取事件
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
    [self saveImage:[self imageWithImageSimple:image scaledToSize:CGSizeMake(CGRectGetWidth(self.phoMyimage.frame)*2, CGRectGetHeight(self.phoMyimage.frame)*2)] withName:@"avatar.png"];
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]stringByAppendingPathComponent:@"avatar.png"];
    
    //存储路径
    NSLog(@"!!!!!!!!!!!!!!!!!!!!!!!!!!存储路径%@", fullPath);
    UIImage *saveImage = [[UIImage alloc]initWithContentsOfFile:fullPath];
    
    //1 //UIImage转换为NSData// 提交的时候用的数据
    self.picData = UIImageJPEGRepresentation(saveImage, 1.0);
    //设置头像图片显示
    self.phoMyimage.image = saveImage;
    
    //数据转化上传
    self.picStr = [self.picData base64Encoding];
    NSLog(@"======%@",self.picStr);
}




//点击确定事件
- (IBAction)trueBut:(id)sender {
     NSLog(@"kkk");
    if (self.picStr.length >1) {
        
    
    if (self.nameText.text != 0 && self.sexLaber.text.length != 0 && self.birthLaber.text != 0 && self.relationLaber.text.length != 0 && self.yearComeText.text.length != 0 && self.yearOutText.text.length != 0 && self.debtText.text != 0)
    {
        id hud = [JGProgressHelper showProgressInView:self.view];
          [ self.userService save_user_realtionWithUid:@""
        id:@""
    name:self.nameText.text
    avatar:self.picStr
    sex:self.strSex
    birthday:self.birthLaber.text
    relation:self.relatID
    yearly_income:self.yearComeText.text
    yearly_out:self.yearOutText.text
    debt:self.debtText.text
    success:^{
               
        [hud hide:YES];
        [JGProgressHelper showSuccess:@"保存成功"];
        
//        [self.relationLaber removeObserver:self forKeyPath:@"text"];
//        [self.sexLaber removeObserver:self forKeyPath:@"text"];
//        [self.birthLaber removeObserver:self forKeyPath:@"text"];

        
        [self.navigationController popViewControllerAnimated:YES];
        
           } failure:^(NSError *error) {
               
               [JGProgressHelper showError:@"保存失败"];
           }];
        
        
    }
    else
    {
        [JGProgressHelper showError:@"有未填写项,请填写"];
        
    }
    }else
    {
        
        [JGProgressHelper showError:@"请选择头像"];
    }
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
