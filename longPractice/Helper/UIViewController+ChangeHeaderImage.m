//
//  UIViewController+ChangeHeaderImage.m
//  ShiSanHang
//
//  Created by apple on 16/10/25.
//  Copyright © 2016年 messcat. All rights reserved.
//

#import "UIViewController+ChangeHeaderImage.h"

static void (^successImage)(UIImage *);
static void (^faileImage)(NSError *);

@interface UIViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@end

@implementation UIViewController (ChangeHeaderImage)

-(void)hp_actionAlert:(NSArray<NSString *> *)arrayString
             style:(UIAlertControllerStyle *)style
            alertAction:(UIImagePickerController *(^)(UIAlertAction *))aler
           success:(void (^)(UIImage *))success
             faile:(void (^)(NSError *))faile
{
    successImage=success;
    faileImage=faile;
    
    NSMutableArray *arrayImage=[arrayString mutableCopy];
    [arrayImage addObject:@"取消"];
    
    NSMutableArray *arrayAction=[NSMutableArray array];
     UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    for (int i=0; i<arrayImage.count; i++) {
        UIAlertActionStyle style_action=UIAlertActionStyleDefault;
        if (i==arrayImage.count-1)
        {
            style_action=UIAlertActionStyleCancel;
        }
        UIAlertAction *action=[UIAlertAction actionWithTitle:arrayImage[i] style:style_action handler:^(UIAlertAction * _Nonnull action) {
            aler(action).delegate=self;
        }];
        [arrayAction addObject:action];
    }
    
    for (int i=0; i<arrayAction.count; i++) {
        [alertVC addAction:arrayAction[i]];
    }
    [self presentViewController:alertVC animated:YES completion:nil];
}


#pragma mark - UIImagePickerControllerDelegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    if (successImage!=nil) {
        successImage(image);
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)imageSavedToPhotosAlbum:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    if (error){
        if (faileImage!=nil) {
            faileImage(error);
        }
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
