//
//  LDXScrollLabel.m
//  ScrollLabel
//
//  Created by 刘东旭 on 2017/12/19.
//  Copyright © 2017年 刘东旭. All rights reserved.
//

#import "LDXScrollLabel.h"

@interface LDXScrollLabel () {
    int spase;//两个文字的间距
    int num;//能显示多少遍文字
    BOOL isScroll;//是否需要滚动
}

@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) int offsetX;
@property (nonatomic, assign) CGRect textRect;
@property (nonatomic, strong) NSMutableDictionary *attributesDict;

@end

@implementation LDXScrollLabel

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        spase = 25;
        isScroll = NO;
        self.attributesDict = [NSMutableDictionary dictionary];
        self.attributesDict[NSFontAttributeName] = [UIFont systemFontOfSize:17];
        self.attributesDict[NSForegroundColorAttributeName] = [UIColor blackColor];
        
        self.offsetX = self.frame.size.width;
        self.timer = [NSTimer timerWithTimeInterval:0.05 target:self selector:@selector(scrollText) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
        [self.timer fire];
    }
    return self;
}

- (void)setScrollType:(LDXScrollType)scrollType {
    _scrollType = scrollType;
    if (scrollType == LDXManualScroll) {
        [self stopAnimation];
    } else {
        [self startAnimation];
    }
}

- (void)setFont:(UIFont *)font {
    [super setFont:font];
    
    self.attributesDict[NSFontAttributeName] = font;
    [self setNeedsLayout];
    [self setNeedsDisplay];
}

- (void)setTextColor:(UIColor *)textColor {
    [super setTextColor:textColor];
    
    self.attributesDict[NSForegroundColorAttributeName] = textColor;
    [self setNeedsLayout];
    [self setNeedsDisplay];
}

-(void)setText:(NSString *)text {
    [super setText:text];
    
    [self setNeedsLayout];
    [self setNeedsDisplay];
}
- (void)scrollText {
    self.offsetX--;
    if (self.offsetX<=-(self.textRect.size.width+spase)) {
        //当第一个划出去把offset设置为第二个位置
        self.offsetX += self.textRect.size.width+spase;
    }
    [self setNeedsDisplay];
}

//停止滚动效果
- (void)stopAnimation {
    [self.timer invalidate];
    _scrollType = LDXManualScroll;
    self.offsetX = 0;
    //设置偏移量重新绘制
    [self setNeedsDisplay];
}
//开始滚动效果
- (void)startAnimation {
    if ([self.timer isValid]) {
        [self.timer fire];
    } else {
        self.timer = nil;
        _scrollType = LDXAutoScroll;
        self.timer = [NSTimer timerWithTimeInterval:0.05 target:self selector:@selector(scrollText) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
        [self.timer fire];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    //每次设置文本将偏移量初始化重新开始滚动吧
    //每次设置文本将偏移量初始化重新开始滚动吧
    if (self.scrollDirection == LDXFromLeft) {
        self.offsetX = 0;
    } else {
        self.offsetX = self.frame.size.width;
    }
    
    //计算文本的rect
    self.textRect = [self.text boundingRectWithSize:CGSizeMake(10000, self.frame.size.height) options:NSStringDrawingUsesFontLeading attributes:self.attributesDict context:[[NSStringDrawingContext alloc] init]];
    
    isScroll = (self.textRect.size.width>self.frame.size.width);
    //为了显示的连贯性，最少显示两遍文字
    num = self.frame.size.width/(self.textRect.size.width+spase)+2;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    //如果是手动滚动类型则不滚动直接绘制文字长度过长则...
    if (self.scrollType == LDXManualScroll) {
        //文本超出控件则加上...
        if (isScroll) {
            [super drawRect:rect];
        } else {
            //不超出直接绘制
            [self.text drawAtPoint:CGPointMake(0,0)withAttributes:self.attributesDict];
        }
    } else {
        //自动滚动类型则开始绘制滚动文本
        //如果需要滚动则绘制滚动文字
        if (isScroll) {
            for (int i = 0; i<num; i++) {
                [self.text drawAtPoint:CGPointMake(self.offsetX+i*(self.textRect.size.width+spase),0)withAttributes:self.attributesDict];
            }
        } else {
            //如果不需要滚动则直接绘制文本
            [self.text drawAtPoint:CGPointMake(0,0)withAttributes:self.attributesDict];
        }
    }

}

- (void)dealloc {
    [self.timer invalidate];
    self.timer = nil;
}


@end
