//
//  PinView.m
//  表盘2
//
//  Created by skunk  on 15/1/29.
//  Copyright (c) 2015年 skunk . All rights reserved.
//

#import "PinView.h"
#define SCREENWIDTH  [UIScreen mainScreen].bounds.size.width
#define SCREENHEIGHT  [UIScreen mainScreen].bounds.size.height
@implementation PinView

/*
// Only override drawRect: if you perform custom drwing.
// An empty implementation adversely affects performance during animation.
 */
-(id)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor clearColor];
        _xPt = 80*sinf(-360/60*0*M_PI/180+M_PI/4);
        _yPt = 80*cosf(-360/60*0*M_PI/180+M_PI/4);
    }
    return self;

}
- (void)drawRect:(CGRect)rect {
    
    
    
    CGContextRef context=UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor grayColor].CGColor);
    CGContextAddArc(context, self.center.x, self.center.y, 20, 0, 2*M_PI, YES);
    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
    CGContextDrawPath(context, kCGPathFill);
    
    CGContextSetFillColorWithColor(context, [UIColor redColor].CGColor);
    CGContextAddArc(context, self.center.x, self.center.y, 10, 0, 2*M_PI, YES);
    CGContextDrawPath(context, kCGPathFill);
    
    CGContextMoveToPoint(context, self.center.x, self.center.y);
    CGContextAddLineToPoint(context, self.center.x-_xPt, self.center.y+_yPt);
    CGContextSetLineWidth(context, 3);
    CGContextStrokePath(context);
    
}


@end
