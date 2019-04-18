//
//  RYDropDownMenuView.m
//  XinYiYiLiao
//
//  Created by ryan on 2018/5/25.
//  Copyright © 2018年 messcat. All rights reserved.
//

#import "RYDropDownMenuView.h"
#import "RYDropDownMenuButton.h"

#define  CF_Color_TextLightGrayColor HexColor(0x999999)
#define  CF_Color_TextGrayColor HexColor(0x666666)
#define  CF_Color_TextDarkGrayColor HexColor(0x333333)
#define  CF_Color_SepertLineColor HexColor(0xdddddd)
#define  CF_Color_DefaultColor  HexColor(0x1e8cd4)  // 默认的颜色-蓝
#define  CF_Color_DefalutBackGroundColor HexColor(0xf2f2f2)

#define kTitleBarHeight 44
#define kViewTagConstant 1  // 所有tag都加上这个 防止出现为0的tag
#define kButtonTagConstant 5000

@interface RYDropDownMenuView ()<UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet RYDropDownMenuButton *totalButton;
@property (weak, nonatomic) IBOutlet RYDropDownMenuButton *sortButton;

@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UITableView *dropDownMenuTableView;
@property (nonatomic, strong) NSMutableArray *dataSource;

/* 最后点击的按钮 */
@property (nonatomic, strong) UIButton *lastClickedBtn;
@property (nonatomic, assign) NSInteger lastClickedBtnIndex;

@end


@implementation RYDropDownMenuView

- (void)awakeFromNib {
    [super awakeFromNib];
    @weakify(self)
    
    [self.dataSource removeAllObjects];
    
    [[self.totalButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(UIButton *button) {
        @strongify(self)
        button.selected = !button.selected;
        _lastClickedBtn = button;
        _lastClickedBtnIndex = button.tag - kButtonTagConstant;
        
        if (button.selected) {
            [self removeSubviews];
            NSArray *nameArray =  self.dataSourceArr[button.tag - kButtonTagConstant];
            [self.dataSource addObjectsFromArray:nameArray];
            
            [self show];
            [self animationWhenClickTitleBtn:button];
        } else {
            [self hide];
        }
    }];
    
    [[self.sortButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(UIButton *button) {
        @strongify(self)
        button.selected = !button.selected;
        _lastClickedBtn = button;
        _lastClickedBtnIndex = button.tag - kButtonTagConstant;
        
        if (button.selected) {
            [self removeSubviews];
            NSArray *nameArray =  self.dataSourceArr[button.tag - kButtonTagConstant];
            [self.dataSource addObjectsFromArray:nameArray];
            
            [self show];
            [self animationWhenClickTitleBtn:button];
        } else {
            [self hide];
        }
    }];
}

#pragma mark - setter
- (void)setDataSourceArr:(NSMutableArray *)dataSourceArr
{
    _dataSourceArr = dataSourceArr;
    
    self.titleBtnArr = [[NSMutableArray alloc] init];
    [self.titleBtnArr addObject:self.totalButton];  // 分类 按钮数组
    [self.titleBtnArr addObject:self.sortButton];  // 分类 按钮数组
}

// 设置文字 默认
- (void)setDefaulTitleArray:(NSArray *)defaulTitleArray
{
    _defaulTitleArray = defaulTitleArray;
    for (NSInteger i = 0; i < self.titleBtnArr.count; i++) {
        [self.titleBtnArr[i] setTitle:defaulTitleArray[i] forState:UIControlStateNormal];
    }
}

#pragma mark - public

//- (void)addInView:(UIView *)superView {
//    
//    [superView addisDisplayView:self
//                         isShow:^(UIView *superView, UIView *displayView) {
//                             
//                             [displayView mas_remakeConstraints:^(MASConstraintMaker *make) {
//                                 make.edges.equalTo(superView);
//                             }];
//                         }];
//    [self mas_remakeConstraints:^(MASConstraintMaker *make) {
//        make.top.left.right.equalTo(superView);
//        make.height.mas_equalTo(44);
//    }];
//}

- (void)show {
    
    [self.superview.superview addSubview:self.bgView];
    [self.superview.superview addSubview:self.dropDownMenuTableView];
    [UIView animateWithDuration:0.25 animations:^{
        self.dropDownMenuTableView.frame = CGRectMake(0, self.startY, SCREEN_WIDTH, MIN(44 * 5, 44 * self.dataSource.count));
        
    } completion:^(BOOL finished) {
        [self.dropDownMenuTableView reloadData];
    }];
    
    self.targetTableView.scrollEnabled = NO;
}

#pragma mark - public
// 点击按钮动画
- (void)animationWhenClickTitleBtn:(UIButton *)btn
{
    _lastClickedBtn = btn;
    _lastClickedBtnIndex = btn.tag - kButtonTagConstant;
    
    for (UIButton *subBtn in self.titleBtnArr) {
        if (subBtn == btn) {
            [UIView animateWithDuration:0.25 animations:^{
                subBtn.imageView.transform = CGAffineTransformMakeRotation(M_PI);
                subBtn.selected = YES;
                //                subBtn.enabled = NO;
            }];
        } else {
            [UIView animateWithDuration:0.25 animations:^{
                subBtn.imageView.transform = CGAffineTransformMakeRotation(0);
                subBtn.selected = NO;
                //                subBtn.enabled = YES;
            }];
        }
    }
}

#pragma mark - private
- (void)hide {
    [UIView animateWithDuration:0.3 animations:^{
        self.dropDownMenuTableView.frame = CGRectMake(0, self.startY, SCREEN_WIDTH, 0);
        _lastClickedBtn.imageView.transform = CGAffineTransformMakeRotation(0.01);
        //add
        _lastClickedBtn.selected = NO;
    } completion:^(BOOL finished) {
        [self removeSubviews];
        [self btnEnable];
    }];
    
    self.targetTableView.scrollEnabled = YES;
}

- (void)removeSubviews
{
    [UIView animateWithDuration:0.25 animations:^{
        _lastClickedBtn.imageView.transform = CGAffineTransformMakeRotation(0.01);
        //add
        _lastClickedBtn.selected = NO;
    }];
    !_bgView?:[_bgView removeFromSuperview];
    _bgView=nil;
    
    !_dropDownMenuTableView?:[_dropDownMenuTableView removeFromSuperview];
    _dropDownMenuTableView=nil;
    
    self.dataSource = nil;
    
    [self btnEnable];
}

- (void)btnEnable
{
    // 所有 分类按钮  都变为 可点击
    //    for (NSInteger i=0; i<self.dataSourceArr.count; i++) {
    //        UIButton *btn = self.titleBtnArr[i];
    //        btn.enabled = YES;
    //    }
    self.totalButton.enabled = YES;
    self.sortButton.enabled = YES;
}

#pragma mark - UITableViewDelegate/UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count > 0 ? self.dataSource.count : 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cellID";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.textLabel.font = appFontSize(15.0);
    }
    NSString *titleName = self.dataSource[indexPath.row];
    cell.textLabel.text = titleName;
    
    // KVC
    NSArray *textArr = [self.titleBtnArr valueForKeyPath:@"titleLabel.text"];
    
    //    if (self.stateConfigDict[@"selected"]) {
    //        if ([textArr containsObject:cell.textLabel.text]){
    //            cell.accessoryType = UITableViewCellAccessoryCheckmark;
    //            cell.tintColor = self.stateConfigDict[@"selected"][0];
    //            cell.textLabel.textColor = self.stateConfigDict[@"selected"][0];
    //        } else {
    //            cell.accessoryType = UITableViewCellAccessoryNone;
    //            cell.textLabel.textColor = CF_Color_TextDarkGrayColor;
    //        }
    //    }else {
            if ([textArr containsObject:cell.textLabel.text]){
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
                cell.textLabel.textColor = CF_Color_DefaultColor;
                cell.tintColor = CF_Color_DefaultColor;
            } else {
                cell.accessoryType = UITableViewCellAccessoryNone;
                cell.textLabel.textColor = HexColor(0x333333);
            }
    //    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 改变标题展示 及 颜色
//    NSMutableDictionary *currentTitleDic = [[NSMutableDictionary alloc] init];
    NSString *titleName = self.dataSource[indexPath.row];
    
    for (NSInteger i = 0; i < self.dataSourceArr.count; i++) {
        UIButton *btn = self.titleBtnArr[i];
        if (btn.selected) {   //!btn.enabled
            
            if (indexPath.row == 0) {
                if (self.defaulTitleArray.count > 0) {
                    [btn setTitle:self.defaulTitleArray[btn.tag - kButtonTagConstant] forState:UIControlStateNormal];
                }
            } else {
                [btn setTitle:titleName forState:UIControlStateNormal];
            }
            
            //改变(展示颜色)文字颜色及箭头颜色 HexColor(0x1e8cd4)
            [self changTintColorWithTintColor:HexColor(0x77797B) tintColorImgName:@"icon_xjt" ForButton:btn];
        }
    }
    !self.chooseConditionBlock?:
    self.chooseConditionBlock(titleName, indexPath.row, _lastClickedBtnIndex);
    
    [self hide];
    // 移除
//    [self removeSubviews];
}

#pragma mark - 改变(展示颜色)文字颜色及箭头颜色
- (void)changTintColorWithTintColor:(UIColor *)tintColor tintColorImgName:(NSString *)tintColorArrowImgName ForButton:(UIButton *)btn
{
    //    [btn setTitleColor:tintColor forState:UIControlStateNormal];
    //    [btn setImage:DefaultImage(tintColorArrowImgName) forState:UIControlStateNormal];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint pt = [touch locationInView:self];
    if (!CGRectContainsPoint([self.dropDownMenuTableView frame], pt)) {
        [self hide];
    }
}

- (void)dealloc
{
    [self removeSubviews];
}

#pragma mark - lazy
/* 蒙层view */
- (UIView *)bgView
{
    if (!_bgView) {
        _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, self.startY, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _bgView.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.5];
        UITapGestureRecognizer *tapGest = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)];
        [_bgView addGestureRecognizer:tapGest];
    }
    return _bgView;
}

- (UITableView *)dropDownMenuTableView
{
    if (!_dropDownMenuTableView) {
        _dropDownMenuTableView = [[UITableView alloc] init];
        _dropDownMenuTableView.frame = CGRectMake(0, self.startY, SCREEN_WIDTH, 0);
        _dropDownMenuTableView.backgroundColor = kWhiteColor;
        _dropDownMenuTableView.delegate = self;
        _dropDownMenuTableView.dataSource = self;
        _dropDownMenuTableView.scrollEnabled = YES;
    }
    return _dropDownMenuTableView;
}

- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [[NSMutableArray alloc] init];
    }
    return _dataSource;
}
@end
