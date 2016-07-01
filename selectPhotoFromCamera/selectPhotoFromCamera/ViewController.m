//
//  ViewController.m
//  selectPhotoFromCamera
//
//  Created by 李根 on 16/6/13.
//  Copyright © 2016年 ligen. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@end

@implementation ViewController
{
    UIImage *_avatar;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:btn];
    btn.frame = CGRectMake(100, 100, 100, 50);
    [btn setTitle:@"选择相片" forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor orangeColor];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)btnClick:(id)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.allowsEditing = YES;
    [self presentViewController:picker animated:YES completion:NULL];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    _avatar = info[UIImagePickerControllerOriginalImage];
    
    [self saveImage:_avatar WithName:@"userAvatar"];
    
    //处理完毕，回到个人信息页面
    [picker dismissViewControllerAnimated:YES completion:NULL];
//    [_tableView reloadData];
}

//保存图片
- (void)saveImage:(UIImage *)tempImage WithName:(NSString *)imageName
{
    NSData* imageData = UIImagePNGRepresentation(tempImage);
    NSString* documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString* totalPath = [documentPath stringByAppendingPathComponent:imageName];
    NSLog(@"%@", totalPath);
    
    //保存到 document
    [imageData writeToFile:totalPath atomically:NO];
    
    //保存到 NSUserDefaults
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:totalPath forKey:@"avatar"];
    
//    //上传服务器
//    [[HSLoginClass new] uploadAvatar:totalPath];
}

//从document取得图片
- (UIImage *)getImage:(NSString *)urlStr
{
    return [UIImage imageWithContentsOfFile:urlStr];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
