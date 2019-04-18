//
//  CustomBarButtonItem.m
//  HighSpeed
//
//  Created by ryan on 16/9/17.
//  Copyright © 2016年 messcat. All rights reserved.
//

#import "CustomBarButtonItem.h"

//#define DEFAULT_SPACE (IOS7_OR_LATER ? -16 : -2)
#define DEFAULT_SPACE -16

@implementation CustomBarButtonItem


/**
 *  根据类型数组返回按钮数组
 *
 *  @param types    类型数组
 *  @param delegate 代理
 *
 *  @return 按钮数组
 */
+ (NSArray *)barButtonItemsWithTypes:(NSArray *)types delegate:(id)delegate
{
    //如果只有一个按钮，给13像素偏移；如果有多个按钮，给5像素的偏移。
    NSInteger space = (types.count > 1) ? 5 : 15;
    
    NSMutableArray *items = [NSMutableArray array];
    for (NSNumber *type in types) {
        NSArray *oneItems = [self barButtonItemsWithType:type.intValue delegate:delegate space:space];
        for (UIBarButtonItem *oneItem in oneItems) {
            [items addObject:oneItem];
        }
    }
    return items;
}


/**
 *  返回某个类型的按钮数组，带上偏移的空格
 *
 *  @param type     类型
 *  @param delegate 代理
 *  @param space    偏移
 *
 *  @return 数组
 */
+ (NSArray *)barButtonItemsWithType:(CustomBarButtonItemType)type delegate:(id)delegate space:(NSInteger)space
{
    CustomBarButtonItem *buttonItem = [[CustomBarButtonItem alloc] initWithType:type];
    buttonItem.delegate = delegate;
    UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    spaceItem.width = DEFAULT_SPACE + space;
    return @[spaceItem, buttonItem];
}


/**
 *  创建以图片初始化的按钮
 *
 *  @param imageName 图片名
 *
 *  @return 按钮
 */
- (id)initWithType:(CustomBarButtonItemType)type imageName:(NSString *)imageName isWithDot:(BOOL)isWithDot
{
    if (self = [super init]) {
        UIImage *image = [UIImage imageNamed:imageName];
        UIButton *button = [[UIButton alloc] initWithSize:CGSizeMake(18, 44)];
        [button setImage:image forState:UIControlStateNormal];
        [button addTarget:self action:@selector(clickBarButtonItem:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = type;
        self.customView = button;
        self.rigthButton = button;
        
        if (isWithDot) {
//            UIImageView *imageView = [[UIImageView alloc] initWithSize:CGSizeMake(6, 6)];
//            [imageView setPosition:CGPointMake(button.width-1, 3) atAnchorPoint:CGPointMake(0, 1)];
//            imageView.image = [UIImage imageNamed:@"Alumni-Circle_Remind_"];
//            [button addSubview:imageView];
        }
    }
    return self;
}


- (id)initWithType:(CustomBarButtonItemType)type imageName:(NSString *)imageName
{
    return [self initWithType:type imageName:imageName isWithDot:NO];
}


/**
 *  创建文字按钮
 *
 *  @param type  类型
 *  @param title 标题
 *
 *  @return 按钮
 */
- (id)initWithType:(CustomBarButtonItemType)type title:(NSString *)title
{
    if (self = [super init]) {
        CGFloat fontSize = 15;
//        UIButton *button = [[UIButton alloc] initWithSize:CGSizeMake(fontSize * title.length + 10, 30)];
        UIButton *button = [[UIButton alloc] initWithSize:CGSizeMake(200, 30)];
        [button setTitle:title forState:UIControlStateNormal];
        [button setTitleColor:HexColor(0x333333) forState:UIControlStateNormal];
        button.titleLabel.font = appFontSize(fontSize);
        UIImage *image = [UIImage imageNamed:@"login_back"];
        [button setImage:image forState:UIControlStateNormal];
        [button setImage:image forState:UIControlStateHighlighted];
        button.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        button.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [button addTarget:self action:@selector(clickBarButtonItem:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = type;
        self.customView = button;
    }
    return self;
}


- (id)initBackBarButtonItem
{
    if (self = [super init]) {
        UIButton *button = [[UIButton alloc] initWithSize:CGSizeMake(22, 40)];
        button.tag = kCustomBarButtonItemTypeBack;
        
        //返回箭头
        UIImage *image = [UIImage imageNamed:@"fh"];
        [button setImage:image forState:UIControlStateNormal];
        [button setImage:image forState:UIControlStateHighlighted];
        
        //返回文字
        //        button.titleLabel.font = UIFontSize(15);
        //        [button setTitle:SchoLocalizedString(@" 返回") forState:UIControlStateNormal];
        //        [button setTitleColor:HexColor(0xffffff) forState:UIControlStateNormal];
        [button addTarget:self action:@selector(clickBarButtonItem:) forControlEvents:UIControlEventTouchUpInside];
        
        self.customView = button;
    }
    return self;
}


//************************************只需修改下面的方法*************************************


/**
 *  返回某个类型的按钮
 *
 *  @param type 类型
 *
 *  @return 按钮
 */
- (id)initWithType:(CustomBarButtonItemType)type
{
    if (type == kCustomBarButtonItemTypeBack) {
        return [self initBackBarButtonItem];
    }if (type == kCustomBarButtonItemTypeAboutUsBack) {
        return [self initWithType:type imageName:@"fh1"];
    }else {
        return nil;
    }
}


/**
 *  点击按钮
 *
 *  @param sender 按钮
 */
- (void)clickBarButtonItem:(UIBarButtonItem *)sender
{
    CustomBarButtonItemType type = (int)sender.tag;
    
    if (type == kCustomBarButtonItemTypeBack) {
        if ([self.delegate respondsToSelector:@selector(clickBackBarButtonItem:)]) {
            [self.delegate clickBackBarButtonItem:sender];
        } else {
            UIViewController *vc = (UIViewController *)self.delegate;
            if (vc.navigationController.viewControllers.count == 1) {
                [vc dismissViewControllerAnimated:YES completion:nil];
            } else {
                [vc.navigationController popViewControllerAnimated:YES];
            }
        }
    } else {
        //如果有代理的话就调用代理的方法
        if ([self.delegate respondsToSelector:@selector(clickBarButtonItem:withType:)]) {
            [self.delegate clickBarButtonItem:sender withType:type];
        }else {
            UIViewController *vc = (UIViewController *)self.delegate;
            if (vc.navigationController.viewControllers.count == 1) {
                [vc dismissViewControllerAnimated:YES completion:nil];
            } else {
                [vc.navigationController popViewControllerAnimated:YES];
            }
        }
    }
}
@end
