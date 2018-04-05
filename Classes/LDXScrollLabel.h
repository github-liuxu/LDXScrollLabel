//
//  LDXScrollLabel.h
//  ScrollLabel
//
//  Created by 刘东旭 on 2017/12/19.
//  Copyright © 2017年 刘东旭. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, LDXScrollType){
    LDXAutoScroll,//自动滚动
    LDXManualScroll,//手动滚动
};

typedef NS_ENUM(NSInteger, LDXScrollDirection){
    LDXFromLeft,//从左边滚动
    LDXFromRight,//从右边滚动
};

@interface LDXScrollLabel : UILabel

@property (assign, nonatomic) LDXScrollType scrollType;

@property (assign, nonatomic) LDXScrollDirection scrollDirection;

//手动滚动需要调用一下两个方法来启动停止label滚动
- (void)stopAnimation;
- (void)startAnimation;

@end

