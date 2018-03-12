//
//  DrawView.h
//  DrawBoard
//
//  Created by Ze yang on 2018/3/12.
//  Copyright © 2018年 Ze yang. All rights reserved.
//

#import <UIKit/UIKit.h>

//封装的画笔类
@interface HYBrush: NSObject

//画笔颜色
@property (nonatomic, strong) UIColor *brushColor;

//画笔宽度
@property (nonatomic, assign) NSInteger brushWidth;

//路径
@property (nonatomic, strong,readonly) UIBezierPath *bezierPath;

//起点
@property (nonatomic, assign) CGPoint beginPoint;
//终点
@property (nonatomic, assign) CGPoint endPoint;

@end


@interface HYCanvas : UIView

- (void)setBrush:(UIBezierPath *)brush;
@end

typedef NS_ENUM(NSUInteger, DrawViewType) {
    DrawViewTypeCross,
    DrawViewTypeExtend,
};

@interface DrawView : UIView


@property (assign,nonatomic) DrawViewType type;


@end
