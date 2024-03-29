//
//  WordlimitTextView.m
//  TextFieldExtesion
//
//  Created by zly on 15/10/29.
//  Copyright © 2015年 Zhuluyi. All rights reserved.
//

#import "ZLYTextView.h"

#define OSVersionIsAtLeastiOS7 (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1)


@interface ZLYTextView ()//<UITextViewDelegate>

@property (copy , nonatomic) NSString * lastString;
@property (assign , nonatomic) BOOL isFirst;

@end


@implementation ZLYTextView

//初始化及释放
- (id)init{
    self = [super init];
    if (self) {
        [self addTextChangeObserver];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self addTextChangeObserver];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addTextChangeObserver];
    }
    return self;
}

- (void)dealloc{
    [self removeTextChangeObserver];
}

//添加移除输入内容变化的监听事件
- (void)addTextChangeObserver{
    self.LimiType = 1;
    self.isEmoticons = NO;
    self.textPoint = CGPointMake(5, 8);
    
    self.font             = appFontSize(14.0);
    
    // 设置默认提示
    self.placeholder      = @"简单描述您的需求";
    
    // 设置默认颜色
    self.placeholderColor = HexColor(0xEFEFF4);

    self.isFirst = YES;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged:) name:UITextViewTextDidChangeNotification object:self];
}

- (void)removeTextChangeObserver{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

//绘制方法
- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    
    // 如果有文字，就直接返回，不需要画占位文字
    if (self.hasText) return;
    
    // 属性
    NSMutableDictionary *attrs            = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName]            = self.font;
    attrs[NSForegroundColorAttributeName] = self.placeholderColor;
    
    // 画文字
    rect.origin                           =  self.textPoint;
    rect.size.width                      -= 2 * rect.origin.x;
    [self.placeholder drawInRect:rect withAttributes:attrs];
    
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    if (self.text && self.text.length > 0 && self.text.length == 0){
//        CGRect rect = CGRectMake(self.textPoint.x,
//                                 self.textPoint.y,
//                                 self.bounds.size.width - self.textPoint.x,
//                                 self.bounds.size.height - self.textPoint.y);
//        if (OSVersionIsAtLeastiOS7){
//            NSDictionary* attributes = @{NSFontAttributeName:self.font,NSForegroundColorAttributeName:self.textColor};
//            [self.text drawInRect:rect withAttributes:attributes];
//        }
//        else{
//            CGContextSetFillColorWithColor(context, self.textColor.CGColor);
//#pragma clang diagnostic push
//#pragma clang diagnostic ignored "-Wdeprecated"
//            [self.text drawInRect:rect withFont:self.font lineBreakMode:NSLineBreakByCharWrapping];
//#pragma clang diagnostic pop
//        }
//    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self setNeedsDisplay];
}

#pragma mark - Set Method

- (void)setText:(NSString *)text{
    [super setText:text];
    if (self.isFirst && !self.lastString) {
        self.isFirst = NO;
        self.lastString = text;
    }
    [self textChanged:nil];
}

- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = [placeholder copy];
    
    [self setNeedsDisplay];
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    _placeholderColor = placeholderColor;
    
    [self setNeedsDisplay];
}

- (void)setFont:(UIFont *)font
{
    [super setFont:font];
    
    [self setNeedsDisplay];
}

- (void)setAttributedText:(NSAttributedString *)attributedText
{
    [super setAttributedText:attributedText];
    
    [self setNeedsDisplay];
}

-(void)setTextPoint:(CGPoint)textPoint{
    _textPoint = textPoint;
    [self setNeedsDisplay];
}

- (void)textChanged:(NSNotification *)notification {
    if (!notification) {
        return;
    }
//    if (self.text.length == 0){
        [self setNeedsDisplay];
//    }
    if(self.MaxWordNumber>0){
        NSString *toBeString = self.text;
        NSString *lang = [[[UIApplication sharedApplication] textInputMode] primaryLanguage];// 键盘输入模式
        if([lang isEqualToString:@"zh-Hans"]) { //简体中文输入，包括简体拼音，健体五笔，简体手写
            UITextRange *selectedRange = [self markedTextRange];
            //获取高亮部分
            UITextPosition *position = [self positionFromPosition:selectedRange.start offset:0];
            //没有高亮选择的字，则对已输入的文字进行字数统计和限制
            if(!position) {
                if (!self.isEmoticons){
                    [self setDeleteEmojiText];
                }
                if(toBeString.length > self.MaxWordNumber) {
                    switch (self.LimiType) {
                        case 0:
                            self.text = [self.text substringToIndex:self.MaxWordNumber];
                            break;
                        case 1:
                            [self setLastText];
                            break;
                        default:
                            break;
                    }
                    if (self.textDelegate &&[self.textDelegate respondsToSelector:@selector(textViewLimitLengh:)]) {
                        [self.textDelegate textViewLimitLengh:self];
                    }
                }
                self.lastString = self.text;
            }
            //有高亮选择的字符串，则暂不对文字进行统计和限制
            else{
                return;
            }
        }
        //中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
        else{
            if (!self.isEmoticons){
                [self setDeleteEmojiText];
            }
            if(toBeString.length > self.MaxWordNumber) {
                switch (self.LimiType) {
                    case 0:
                        self.text = [self.text substringToIndex:self.MaxWordNumber];
                        break;
                    case 1:
                        [self setLastText];
                        break;
                    default:
                        break;
                }
                if (self.textDelegate &&[self.textDelegate respondsToSelector:@selector(textViewLimitLengh:)]) {
                    [self.textDelegate textViewLimitLengh:self];
                }
            }
            self.lastString = self.text;
        }
    }
    
    _canEnterWordsNumber = self.MaxWordNumber-self.text.length;
    _canEnterWordsNumber = _canEnterWordsNumber>0?_canEnterWordsNumber:0;
    
    if (self.textDelegate && [self.textDelegate respondsToSelector:@selector(lwTextViewDidChange:)]) {
        [self.textDelegate lwTextViewDidChange:self];
    }
}

-(void)setLastText{
    UITextPosition* beginning = self.beginningOfDocument;
    UITextRange* selectedRange = self.selectedTextRange;
    UITextPosition* selectionStart = selectedRange.start;
    UITextPosition* selectionEnd = selectedRange.end;
    const NSInteger location = [self offsetFromPosition:beginning toPosition:selectionStart];
    const NSInteger length = [self offsetFromPosition:selectionStart toPosition:selectionEnd];
    NSRange range = NSMakeRange(location-(self.text.length-self.lastString.length), length);
    self.text = self.lastString;
    beginning = self.beginningOfDocument;
    UITextPosition* startPosition = [self positionFromPosition:beginning offset:range.location];
    UITextPosition* endPosition = [self positionFromPosition:beginning offset:range.location + range.length];
    UITextRange* selectionRange = [self textRangeFromPosition:startPosition toPosition:endPosition];
    [self setSelectedTextRange:selectionRange];
}

-(void)setDeleteEmojiText{
    UITextPosition* beginning = self.beginningOfDocument;
    UITextRange* selectedRange = self.selectedTextRange;
    UITextPosition* selectionStart = selectedRange.start;
    UITextPosition* selectionEnd = selectedRange.end;
    const NSInteger location = [self offsetFromPosition:beginning toPosition:selectionStart];
    const NSInteger length = [self offsetFromPosition:selectionStart toPosition:selectionEnd];
    NSRange range;
    if([[self deleteEmojiWithString:self.text] length]<self.text.length){
        range = NSMakeRange(location-(self.text.length-self.lastString.length), length);
    }else{
        range = NSMakeRange(location, length);
    }
    [self setText:[self deleteEmojiWithString:self.text]];
    beginning = self.beginningOfDocument;
    UITextPosition* startPosition = [self positionFromPosition:beginning offset:range.location];
    UITextPosition* endPosition = [self positionFromPosition:beginning offset:range.location + range.length];
    UITextRange* selectionRange = [self textRangeFromPosition:startPosition toPosition:endPosition];
    [self setSelectedTextRange:selectionRange];
}


//筛除emoji表情
-(NSString *)deleteEmojiWithString:(NSString *)string{
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]" options:NSRegularExpressionCaseInsensitive error:nil];
    NSString * text = [regex stringByReplacingMatchesInString:string
                                                      options:0
                                                        range:NSMakeRange(0, [self.text length])
                                                 withTemplate:@""];
    return text;
}



- (NSRange) selectedRange{
    UITextPosition* beginning = self.beginningOfDocument;
    UITextRange* selectedRange = self.selectedTextRange;
    UITextPosition* selectionStart = selectedRange.start;
    UITextPosition* selectionEnd = selectedRange.end;
    const NSInteger location = [self offsetFromPosition:beginning toPosition:selectionStart];
    const NSInteger length = [self offsetFromPosition:selectionStart toPosition:selectionEnd];
    return NSMakeRange(location, length);
}

- (void) setSelectedRange:(NSRange) range{
    UITextPosition* beginning = self.beginningOfDocument;
    UITextPosition* startPosition = [self positionFromPosition:beginning offset:range.location];
    UITextPosition* endPosition = [self positionFromPosition:beginning offset:range.location + range.length];
    UITextRange* selectionRange = [self textRangeFromPosition:startPosition toPosition:endPosition];    
    [self setSelectedTextRange:selectionRange];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        if (self.textDelegate &&[self.textDelegate respondsToSelector:@selector(textViewReturnKeyPress:)]) {
            [self.textDelegate textViewReturnKeyPress:self];
        }
        return NO;
    }
    return YES;
}

@end
