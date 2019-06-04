//
//  ViewController.m
//  iOSFlutterDemo
//
//  Created by hu on 2019/6/3.
//  Copyright © 2019 hyy. All rights reserved.
//

#import "ViewController.h"
#import <Flutter/FlutterViewController.h>
#import "DetailViewController.h"
#import <Flutter/Flutter.h>


@interface ViewController ()<FlutterStreamHandler>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *btn = [UIButton new];
    [btn setTitle:@"原生接收值" forState:UIControlStateNormal];
    btn.frame = CGRectMake(30, 120, 100, 70);
    btn.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *btn2 = [UIButton new];
    [btn2 setTitle:@"原生发值" forState:UIControlStateNormal];
    btn2.frame = CGRectMake(180, 120, 100, 70);
    btn2.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:btn2];
    [btn2 addTarget:self action:@selector(btn2Click:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)btnClick:(UIButton*)btn{
    FlutterViewController *flutterVC = [[FlutterViewController alloc] init];
    flutterVC.view.backgroundColor = [UIColor whiteColor];
    flutterVC.title = @"flutter首页";
    [flutterVC setInitialRoute:@"firstpage"];
    
    //这个地方类似于js里的绑定
    
    
//    FlutterEventChannel *eventChannel =  [FlutterEventChannel eventChannelWithName:channelName binaryMessenger:flutterVC];
//    [eventChannel setStreamHandler:self];
    
#pragma mark  FlutterEventChannel  跟  FlutterMethodChannel 有什么区别呢
    NSString *methodName = @"com.pages.your/native_receive";
    FlutterMethodChannel * methodChannel = [FlutterMethodChannel methodChannelWithName:methodName binaryMessenger:flutterVC];
    [methodChannel setMethodCallHandler:^(FlutterMethodCall * _Nonnull call, FlutterResult  _Nonnull result) {
        NSLog(@"%@", call.method);
        NSLog(@"%@", result);
    }];
    
    
   
    [self.navigationController pushViewController:flutterVC animated:YES];
}


#pragma mark 原生给flutter传值
-(void)btn2Click:(UIButton*)btn{
    FlutterViewController *flutterVC = [[FlutterViewController alloc] init];
    [flutterVC setInitialRoute:@"firstpage"];
     flutterVC.navigationItem.title = @"Demo";
    NSString *eventName = @"com.pages.your/native_post";
    FlutterEventChannel *eventChannel = [FlutterEventChannel eventChannelWithName:eventName binaryMessenger:flutterVC];
    [eventChannel setStreamHandler:self];
    [self.navigationController pushViewController:flutterVC animated:YES];
}

#pragma mark  FlutterStreamHandler  这个onListen是Flutter端开始监听这个channel时的回调，第二个参数 EventSink是用来传数据的载体。
- (FlutterError* _Nullable)onListenWithArguments:(id _Nullable)arguments
                                       eventSink:(FlutterEventSink)events{
    NSLog(@"arguments=====:%@ event====:%@",arguments,events);
    if (events) {
        events(@"push传值给flutter的vc");
    }
    return nil;
}

/// flutter不再接收
- (FlutterError* _Nullable)onCancelWithArguments:(id _Nullable)arguments {
    // arguments flutter给native的参数
    NSLog(@"onCancel=====:%@", arguments);
    return nil;
}

@end
