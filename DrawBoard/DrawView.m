//
//  DrawView.m
//  DrawBoard
//
//  Created by Ze yang on 2018/3/12.
//  Copyright © 2018年 Ze yang. All rights reserved.
//

#import "DrawView.h"

@implementation HYBrush

- (UIBezierPath *)bezierPath {
    UIBezierPath* bezierpath = [UIBezierPath bezierPath];
    [bezierpath removeAllPoints];
    [bezierpath moveToPoint:self.beginPoint];
    [bezierpath addLineToPoint:self.endPoint];
    return bezierpath;
}

@end

@implementation HYCanvas

+ (Class)layerClass
{
    return ([CAShapeLayer class]);
}

- (void)setBrush:(UIBezierPath *)brush
{
    CAShapeLayer *shapeLayer = (CAShapeLayer *)self.layer;
    shapeLayer.strokeColor = [UIColor redColor].CGColor;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.lineJoin = kCALineJoinRound;
    shapeLayer.lineCap = kCALineCapRound;
    shapeLayer.lineWidth = 5;
    ((CAShapeLayer *)self.layer).path = brush.CGPath;
}

@end


@interface DrawView ()

@property(nonatomic,assign)CGPoint startPoint;
@property(nonatomic,assign)CGPoint endPoint;

@property(nonatomic,strong)UIBezierPath *bezierpath;

@property(nonatomic,strong)HYCanvas       *canvas;
@property(nonatomic,strong)NSMutableArray       *bezierpaths;



@end

@implementation DrawView

+ (Class)layerClass {
    return [CAShapeLayer class];
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
//        self.bezierpath = [UIBezierPath bezierPath];
        self.bezierpaths = @[].mutableCopy;
        self.canvas = [[HYCanvas alloc] initWithFrame:self.bounds];
        [self addSubview:self.canvas];
    }
    return self;
}

- (CGPoint)getpointWith:(NSSet *)touches {
    
    UITouch *touch = [touches anyObject];
    return [touch locationInView:self];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    HYBrush *brush = [[HYBrush alloc] init];
    brush.beginPoint = [self getpointWith:touches];
    [self.bezierpaths addObject:brush];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    HYBrush *brush = [self.bezierpaths lastObject];
    brush.endPoint = [self getpointWith:touches];
    [self.canvas setBrush:brush.bezierPath];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    HYBrush *brush = [self.bezierpaths lastObject];
    [self.canvas setBrush:nil];
    [self.bezierpath removeAllPoints];
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.strokeColor = [UIColor redColor].CGColor;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.lineJoin = kCALineJoinRound;
    shapeLayer.lineCap = kCALineCapRound;
    shapeLayer.lineWidth = 5;

    shapeLayer.path = brush.bezierPath.CGPath;
    [self.layer addSublayer: shapeLayer];
}

- (void)drawRect:(CGRect)rect {
    [self drawMyLine:self.endPoint];
    
}

- (void)drawMyLine:(CGPoint)endpoint {
    //draw line
    CGContextRef context = UIGraphicsGetCurrentContext();//获取画布
    CGContextClearRect(context, self.frame);
    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);//线条颜色
    CGContextSetShouldAntialias(context,NO);//设置线条平滑，不需要两边像素宽
    CGContextSetLineWidth(context,5.0f);//设置线条宽度
    CGContextMoveToPoint(context,self.startPoint.x,self.startPoint.y); //线条起始点
    CGContextAddLineToPoint(context,endpoint.x,endpoint.y);//线条结束点
    CGContextStrokePath(context);//结束，也就是开始画
}

- (void)setBrush:(UIBezierPath *)brush
{
    CAShapeLayer *shapeLayer = (CAShapeLayer *)self.layer;
    shapeLayer.strokeColor = [UIColor redColor].CGColor;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.lineJoin = kCALineJoinRound;
    shapeLayer.lineCap = kCALineCapRound;
    shapeLayer.lineWidth = 5;
    ((CAShapeLayer *)self.layer).path = brush.CGPath;
}

@end
