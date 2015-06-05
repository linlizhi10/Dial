//
//  IndexDial.m
//  表盘2
//
//  Created by skunk  on 15/1/28.
//  Copyright (c) 2015年 skunk . All rights reserved.
//

#import "IndexDial.h"
#import "PinView.h"
@implementation IndexDial
{
    CGFloat _radius;
    
    
}
//-(id)initWithFrame:(CGRect)frame
//{
//    self=[super initWithFrame:frame];
//    if (self) {
//        
//    }
//    return self;
//}

- (void)drawRect:(CGRect)rect {
    
    
    
    _radius=(self.bounds.size.width-80)/2;
    NSLog(@"_radains %f",_radius);
    [self createSpeedLabel];
    //标题
    UILabel *titleLabel=[[UILabel alloc]initWithFrame:
                         CGRectMake(self.center.x-30,
                                    self.center.y+(_radius-5-10)*sinf(360/8*6*M_PI/180)+30,
                                    60,
                                    30)];
    titleLabel.textAlignment=NSTextAlignmentCenter;
    titleLabel.text=@"Wi-Fi";
    [self addSubview:titleLabel];
    
    
    CGContextRef context=UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 10);
    //`startAngle' is the angle to the first endpoint of the arc;
    //`endAngle' is the angle to the second endpoint of the arc;
    CGContextSetRGBStrokeColor(context, 0, 0, 255.0, 1);
    CGContextAddArc(context,
                    self.center.x,
                    self.center.y,
                    _radius,
                    (7*M_PI)/4,
                    (3*M_PI)/4, YES);
    CGContextStrokePath(context);
    
    
    
    CGContextSetLineWidth(context, 10);
    CGContextSetRGBStrokeColor(context, 255.0, 0, 0, 1);
    //不画线的区域
    CGContextAddArc(context,
                    self.center.x,
                    self.center.y,
                    _radius,
                    (M_PI)/4,
                    (7*M_PI)/4 , YES);
    CGContextStrokePath(context);
    
    CGContextSetLineWidth(context, 2);
    CGContextSetRGBStrokeColor(context, 0, 0, 255.0, 1);
    //不画线的区域
    CGContextAddArc(context,
                    self.center.x,
                    self.center.y,
                    _radius-8,360/20*1.5*M_PI/180+M_PI/80,
                    M_PI_4-M_PI/70 , NO);
    CGContextStrokePath(context);
    
    
   
    
    NSArray *arrTitle=[NSArray arrayWithObjects:
                   @"0k",
                   @"64k",
                   @"128k",
                   @"256k",
                   @"512k",
                   @"1M",
                   @"5M",
                   @"10M", nil];
    //绘制表盘上的4个刻线及相应的文字
    for (int i = 3; i < 7; i++)
    {
        
        
            CGContextSetStrokeColorWithColor(context, [UIColor
                                                       colorWithRed:255.0
                                                       green:0
                                                       blue:0 alpha:1].CGColor);
            
            float startX = (_radius-5)*cosf(360/8*i*M_PI/180);
            float startY = (_radius-5)*sinf(360/8*i*M_PI/180);
            
            float endX = (_radius-5-10)*cosf(360/8*i*M_PI/180);
            float endY = (_radius-5-10)*sinf(360/8*i*M_PI/180);
            
            UILabel *label=[[UILabel alloc]init];
        
            label.frame=CGRectMake(self.center.x+endX, self.center.y+endY, 40, 30);
            if (i==3) {
            label.frame=CGRectMake(self.center.x+endX-15, self.center.y+endY-25, 40, 30);
            }
            if (i==4) {
            label.frame=CGRectMake(self.center.x+endX+4, self.center.y+endY-15, 40, 30);
            }
            if (i==6) {
            label.frame=CGRectMake(self.center.x-20, self.center.y+endY, 40, 30);
            }
            label.textAlignment=NSTextAlignmentLeft;
        
        
        
            label.text=arrTitle[i-3];
            [self addSubview:label];
        
            CGContextMoveToPoint(context, self.center.x+startX, self.center.y+startY) ;
            CGContextAddLineToPoint(context, self.center.x+endX, self.center.y+endY) ;
        
        
    }
    CGContextStrokePath(context);
    //另外两条不同颜色的线
    for (int i=0; i<2; i++) {
        CGContextSetStrokeColorWithColor(context, [UIColor
                                                   colorWithRed:0
                                                   green:0
                                                   blue:255.0 alpha:1].CGColor);
        
        float startX = (_radius-5)*cosf(360/8*i*M_PI/180);
        float startY = (_radius-5)*sinf(360/8*i*M_PI/180);
        
        float endX = (_radius-5-10)*cosf(360/8*i*M_PI/180);
        float endY = (_radius-5-10)*sinf(360/8*i*M_PI/180);
        //5M
        if (i!=1) {
            UILabel *label=[[UILabel alloc]initWithFrame:
                            CGRectMake(self.center.x+endX-30,
                                       self.center.y+endY-15,
                                       40,
                                       30)];
            label.text=arrTitle[i+6];
            [self addSubview:label];
        }
        
        
        
        CGContextMoveToPoint(context, self.center.x+startX, self.center.y+startY) ;
        CGContextAddLineToPoint(context, self.center.x+endX, self.center.y+endY) ;
    }
    
    CGContextStrokePath(context);
    
    //512刻度
    CGContextSetStrokeColorWithColor(context, [UIColor
                                               colorWithRed:0
                                               green:0
                                               blue:255.0 alpha:1].CGColor);
    
    float startX = (_radius-5)*cosf(360/8*7*M_PI/180);
    float startY = (_radius-5)*sinf(360/8*7*M_PI/180);
    
    float endX = (_radius-5-10)*cosf(360/8*7*M_PI/180);
    float endY = (_radius-5-10)*sinf(360/8*7*M_PI/180);
    
    UILabel *label=[[UILabel alloc]initWithFrame:
                    CGRectMake(self.center.x+endX-30, self.center.y+endY, 40, 30)];
    label.text=arrTitle[4];
    [self addSubview:label];
    CGContextMoveToPoint(context, self.center.x+startX, self.center.y+startY) ;
    CGContextAddLineToPoint(context, self.center.x+endX, self.center.y+endY) ;
    
    //10M标度
    float startX1 = (_radius-5)*cosf(360/20*1.5*M_PI/180);
    float startY1 = (_radius-5)*sinf(360/20*1.5*M_PI/180);
    float endX1 = (_radius-5-10)*cosf(360/20*1.5*M_PI/180);
    float endY1 = (_radius-5-10)*sinf(360/20*1.5*M_PI/180);
    UILabel *label1=[[UILabel alloc]initWithFrame:
                     CGRectMake(self.center.x+endX1-35, self.center.y+endY1-20, 40, 30)];
    label1.text=arrTitle[7];
    [self addSubview:label1];
    CGContextMoveToPoint(context, self.center.x+startX1, self.center.y+startY1) ;
    CGContextAddLineToPoint(context, self.center.x+endX1, self.center.y+endY1) ;

    //1M标度
    float startX2 = (_radius-5)*cosf(360/20*19*M_PI/180);
    float startY2 = (_radius-5)*sinf(360/20*19*M_PI/180);
    float endX2 = (_radius-5-10)*cosf(360/20*19*M_PI/180);
    float endY2 = (_radius-5-10)*sinf(360/20*19*M_PI/180);
    UILabel *label2=[[UILabel alloc]initWithFrame:
                     CGRectMake(self.center.x+endX2-30, self.center.y+endY2-10, 40, 30)];
    label2.text=arrTitle[5];
    [self addSubview:label2];
    CGContextMoveToPoint(context, self.center.x+startX2, self.center.y+startY2) ;
    CGContextAddLineToPoint(context, self.center.x+endX2, self.center.y+endY2) ;
    
    CGContextStrokePath(context);
    
    
    
    //指针
    PinView *pin=[[PinView alloc]initWithFrame:self.bounds];
    pin.radius=_radius;
    pin.backgroundColor=[UIColor clearColor];
    [pin setNeedsDisplay];
    [self addSubview:pin];
    
}
-(void)createSpeedLabel
{
    _speedLabel=[[UILabel alloc]initWithFrame:
                 CGRectMake(self.center.x-60, self.center.y+_radius-60, 120, 60)];
    _speedLabel.text=nil;
    _speedLabel.textAlignment=NSTextAlignmentCenter;
    _speedLabel.text=[NSString stringWithFormat:@"%.2f\nKB/s",0.0];
    _speedLabel.numberOfLines=0;
    [self addSubview:_speedLabel];
}
@end
