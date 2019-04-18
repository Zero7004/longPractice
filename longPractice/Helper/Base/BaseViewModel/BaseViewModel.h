//
//  BaseViewModel.h
//  XSYTcounselor
//
//  Created by ryan on 2018/4/12.
//  Copyright © 2018年 messcat. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseViewModel : NSObject

- (void)yd_bindTableViewDelegate:(UITableView*)tableView;

- (void)yd_bindCollectionViewDelegate:(UICollectionView*)collectionView;

- (void)yd_bindOtherCollectionViewDelegate:(UICollectionView*)collectionView;

@end
