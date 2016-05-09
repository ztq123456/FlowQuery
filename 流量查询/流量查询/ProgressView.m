//
//  ProgressView.m
//  CircleAnimationTest
//
//  Created by ly on 15/11/6.
//  Copyright (c) 2015年 zmit. All rights reserved.
//

#import "ProgressView.h"

#define kCColor(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0  blue:b/255.0  alpha:1]


@interface ProgressView() {
    UILabel *labelOen;
    UILabel *labelTwo;
    NSMutableString * str;
    NSString *resultStr;
}


//创建全局属性
@property (nonatomic, strong) CAShapeLayer *shapeLayer;
@property (nonatomic, strong) CAShapeLayer *shapeLayer2;
@property (nonatomic, strong) CAShapeLayer *cycleLayer;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic,assign) float currentValue;
@property (nonatomic,assign) int  increase;
@property(nonatomic,strong)UIView* roundView;

@end
@implementation ProgressView

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
       
    }
    
    return self;
}

- (void)setPercent:(float)haveFinished{
    self.haveFinished =  haveFinished;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect{
    [self initData];
}

- (void)initData {
    resultStr =[NSString stringWithFormat:@"%0.2f",self.haveFinished];
    
    
    self.rect = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);;
    self.lineWidth = 10.0f;
    _increase = 0;
    [self circleAnimationTypeOne];
    [self addLabel];
    if (_haveFinished >0) {
        [self animation];
    }
    

   
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.04
                                              target:self
                                            selector:@selector(numShow)
                                            userInfo:nil
                                             repeats:YES];




    
}


- (void)circleAnimationTypeOne
{
    
    //创建出CAShapeLayer
    self.shapeLayer = [CAShapeLayer layer];
    self.shapeLayer.frame = self.rect;
    self.shapeLayer.fillColor = [UIColor whiteColor].CGColor;
    
    //设置线条的宽度和颜色
    self.shapeLayer.lineWidth = self.lineWidth;
    self.shapeLayer.strokeColor = [UIColor lightGrayColor].CGColor;
    
    
    //创建出圆形贝塞尔曲线
    
    UIBezierPath* circlePath=[UIBezierPath bezierPathWithArcCenter:CGPointMake(self.rect.size.width / 2, self.rect.size.height / 2 )radius:self.rect.size.height / 2 startAngle:M_PI_2 endAngle:2.5*M_PI  clockwise:YES];

    
    //让贝塞尔曲线与CAShapeLayer产生联系
    self.shapeLayer.path = circlePath.CGPath;
    
    //添加并显示
    [self.layer addSublayer:self.shapeLayer];
    
    
    
    
    
    UIBezierPath* circlePath2=[UIBezierPath bezierPathWithArcCenter:CGPointMake(self.rect.size.width / 2, self.rect.size.height / 2 )radius:self.rect.size.height / 2 startAngle:M_PI_2 endAngle:2*M_PI*_haveFinished+M_PI_2 clockwise:YES];
    
    
    
    //创建出CAShapeLayer
    self.shapeLayer2 = [CAShapeLayer layer];
    self.shapeLayer2.frame = self.rect;
    
    self.shapeLayer2.fillColor = [UIColor clearColor].CGColor;
    
    //设置线条的宽度和颜色
    self.shapeLayer2.lineWidth = self.lineWidth;
    self.shapeLayer2.strokeColor =  kCColor(0,174,239).CGColor;

    
    //让贝塞尔曲线与CAShapeLayer产生联系
    self.shapeLayer2.path = circlePath2.CGPath;
    
    //添加并显示
    [self.layer addSublayer:self.shapeLayer2];
    
    
    UIView* view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
    view.center = CGPointMake(self.rect.size.width / 2, self.rect.size.height);
    view.layer.cornerRadius=10;
    view.layer.masksToBounds=YES;
    view.backgroundColor= kCColor(0,174,239);
    _roundView=view;
    [self addSubview:view];
    
}
- (void)animation {
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration = 4*self.haveFinished;
    pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    pathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    pathAnimation.toValue = [NSNumber numberWithFloat:1];
    pathAnimation.autoreverses = NO;
    
    
    CAKeyframeAnimation *keyAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    keyAnimation.path=self.shapeLayer2.path;
    keyAnimation.fillMode = kCAFillModeForwards;
    keyAnimation.calculationMode = kCAAnimationPaced;
    keyAnimation.duration = 4*self.haveFinished;
    keyAnimation.removedOnCompletion = NO;
    [self.shapeLayer2 addAnimation:pathAnimation forKey:@"strokeEndAnimation"];
    [_roundView.layer addAnimation:keyAnimation forKey:nil];
}



- (void)addLabel {
    
    labelOen = [[UILabel alloc] init];
    labelOen.frame = CGRectMake(0,0,180,30);
    CGPoint point =  CGPointMake(self.shapeLayer.position.x, self.shapeLayer.position.y + 40 );
    labelOen.center =  point;
    str=[[NSMutableString alloc]init];
    labelOen.text = @"已用流量";
    labelOen.textAlignment = NSTextAlignmentCenter;
    labelOen.font = [UIFont systemFontOfSize:16];
    labelOen.textColor = [UIColor lightGrayColor];
    [self addSubview:labelOen];
    
    
    labelTwo = [[UILabel alloc] init];
    labelTwo.frame = CGRectMake(0,0,180,40);
    CGPoint point2 =  CGPointMake(self.shapeLayer.position.x, self.shapeLayer.position.y);
    labelTwo.center =  point2;
    str=[[NSMutableString alloc]init];
    labelTwo.text = @"%0";
    labelTwo.textAlignment = NSTextAlignmentCenter;
    labelTwo.font = [UIFont systemFontOfSize:50];
    labelTwo.textColor =  kCColor(0,174,239);
    [self addSubview:labelTwo];
    
    
    
}

- (void) numShow {
    if (self.haveFinished < 0) {
        labelTwo.text = @"0%";
        [_timer invalidate];
        return;
    }
    if (self.haveFinished <= 0.01) {
         labelTwo.text = @"1%";
        [_timer invalidate];
        return;
    }
    if (_increase >=100*self.haveFinished) {
        [_timer invalidate];
        return;
    }
    _increase += 1;
    labelTwo.text = [NSString stringWithFormat:@"%d %%",_increase];
    
}

@end




