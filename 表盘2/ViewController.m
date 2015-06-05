//
//  ViewController.m
//  表盘2
//
//  Created by skunk  on 15/1/28.
//  Copyright (c) 2015年 skunk . All rights reserved.
//

#import "ViewController.h"
#import "IndexDial.h"
#import "PinView.h"
@interface ViewController ()
{
    NSTimer *_mTimer;
    IndexDial *_index;
    UIButton *_btnTest;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _index=[[IndexDial alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-100)];
    _index.backgroundColor=[UIColor greenColor];
    [self.view addSubview:_index];
    
    //测试速度按钮
    [self createButton];
}
-(void)createButton
{
    _btnTest=[UIButton buttonWithType:UIButtonTypeCustom];
    _btnTest.enabled=YES;
    _btnTest.frame=CGRectMake(200,self.view.frame.size.height-100, 100, 60);
    [_btnTest addTarget:self action:@selector(beginTest) forControlEvents:UIControlEventTouchUpInside];
    [_btnTest setTitle:@"开始" forState:UIControlStateNormal];
    _btnTest.backgroundColor=[UIColor blueColor];
    [self.view addSubview:_btnTest];
}
-(void)beginTest
{
    _btnTest.enabled=NO;
    //调用测速接口 等待扩展
    NSLog(@"test");
    //返回网速
    float speed=500;
    [self startTestWith:speed];
    
}
-(void)startTestWith:(float)speed
{
    int stopNumber=0;
    CGFloat time =0.2f;
    if (speed<=64) {
        time=0.2f;
        stopNumber=(int)(speed/6.4);
    }
    else if (speed<=128)
    {
        time=0.1f;
        stopNumber=(int)(speed/6.4);
    }
    else if (speed<=256)
    {
        time=0.08;
        float num=(float)256.0/30.0;
        stopNumber=(int)(speed/num)+1;
    }
    else if (speed<=512)
    {
        time=0.06;
        float num=(float)512.0/40.0;
        stopNumber=(int)(speed/num);
    }
    else if (speed<=1000) {
        time=0.05f;
        float num=(float)1000/45;
        
        stopNumber=(int)(speed/num)+1;
    }
    else if (speed<=5000)
    {
        time=0.05f;
        stopNumber=(int)(speed/100);
    }
    else if (speed<=10000)
    {
        time=0.05f;

        float num=(float)10000/55;
        
        stopNumber=(int)(speed/num)+1;
        
    }
    else
    {
        time=0.05f;

        stopNumber=58;
       
    }
    
    float addNumberEveryTime=(float )speed/(float)stopNumber;
    
    NSDictionary *dict=[NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:stopNumber],@"stopNumber",[NSNumber numberWithFloat:addNumberEveryTime],@"addNumberEveryTime", nil];
    _mTimer = [NSTimer scheduledTimerWithTimeInterval:time
                                               target:self
                                             selector:@selector(clockMove:)
                                             userInfo:dict
                                              repeats:YES];
}
- (void)clockMove:(NSTimer *)timer
{
    
    
    int stopNumber=[[[timer userInfo] objectForKey:@"stopNumber"]intValue];
    float addNumberEveryTime=[[[timer userInfo] objectForKey:@"addNumberEveryTime"]floatValue];
    PinView *pin = [[_index subviews] lastObject];
    
    static int i = 0 ;
    i++ ;
    if (i==stopNumber) {
        [_mTimer invalidate];
    }
//    if (speed<=128)
//    {
//        if (i==(int)(speed/6.4))
//        {
//            
//            [_mTimer invalidate];
//        }
//    }
//    else if (speed<=256)
//    {
//        float num=(float)256.0/30.0;
//        if (i==(int)(speed/num)+1) {
//            
//            [_mTimer invalidate];
//        }
//    }
//    else if(speed<=512)
//    {
//        float num=(float)512.0/40.0;
//        if (i==(int)(speed/num))  {
//            
//            [_mTimer invalidate];
//        }
//    }
//    else if (speed<=1000)
//    {
//        float num=(float)1000/45;
//        
//        if (i==(int)(speed/num)+1)
//        {
//           
//            [_mTimer invalidate];
//        }
//    }
//    else if (speed<=5000)
//    {
//        
//        if (i==(int)(speed/100)) {
//            
//            [_mTimer invalidate];
//        }
//    }
//    else if (speed<=10000)
//    {
//        float num=(float)10000/55;
//        
//        if (i==(int)(speed/num)+1)
//        {
//            [_mTimer invalidate];
//        }
//
//    }
//    else
//    {
//        if (i==58)
//        {
//            [_mTimer invalidate];
//        }
//    }
    
    _index.speedLabel.text=[NSString stringWithFormat:@"%.2f\nKB/s",addNumberEveryTime*i];
    pin.xPt = 80*sinf(i*M_PI/40+M_PI/4);
    pin.yPt = 80*cosf(i*M_PI/40+M_PI/4);
//    pin.xPt = 80*sinf(360/60*i*M_PI/180+M_PI/4);
//    pin.yPt = 80*cosf(360/60*i*M_PI/180+M_PI/4);
    
    [pin setNeedsDisplay];
    
//    CALayer *layer = [[CALayer alloc] init];
//    [layer setNeedsDisplay];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
