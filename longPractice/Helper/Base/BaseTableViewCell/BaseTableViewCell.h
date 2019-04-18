//
//  BaseTableViewCell.h
//  JinFengHuang
//
//  Created by ryan on 16/12/15.
//  Copyright © 2016年 messcat. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseTableViewCell : UITableViewCell
/**
 *  快速创建一个cell
 返回值用instancetype 代替id苹果的规范
 */

+(instancetype)cellWithTableView:(UITableView *)tableView;

+(instancetype)cellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;

@end
