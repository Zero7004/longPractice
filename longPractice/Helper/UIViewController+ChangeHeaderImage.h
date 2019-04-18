//
//  UIViewController+ChangeHeaderImage.h
//  ShiSanHang
//
//  Created by apple on 16/10/25.
//  Copyright © 2016年 messcat. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (ChangeHeaderImage)

-(void)hp_actionAlert:(NSArray<NSString *> *)arrayString
                style:(UIAlertControllerStyle *)style
          alertAction:(UIImagePickerController * (^)(UIAlertAction *alerAction))aler  success:(void (^)(UIImage *iamge))success
                faile:(void (^)(NSError *erro))faile;



@end
