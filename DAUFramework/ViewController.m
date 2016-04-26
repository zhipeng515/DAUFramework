//
//  ViewController.m
//  DAUFramework
//
//  Created by zhipeng on 16/4/21.
//  Copyright © 2016年 zhipeng. All rights reserved.
//

#import "ViewController.h"
#import "ObjectManager.h"

#import "UICreator.h"
#import "DataCreator.h"
#import "ActionCreator.h"
#import "BinderCreator.h"

#import "Data.h"
#import "Action.h"
#import "UI.h"
#import "DAUManager.h"

#import "JSONKit.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSString *path = [[NSBundle mainBundle] pathForResource:@"ModelCreator" ofType:@"json"];
    NSString * configString = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    NSDictionary * creatorDict = [configString objectFromJSONString];

    [[ObjectManager shareInstance] loadObjectCreator:creatorDict];

    path = [[NSBundle mainBundle] pathForResource:@"RegisterViewLayout" ofType:@"json"];
    configString = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    creatorDict = [configString objectFromJSONString];
    
    [[DAUManager shareInstance] buildModel:creatorDict];
    
    return;

//    [[ModelManager shareInstance] registerModelCreator:[[UIViewCreator alloc]init] withKey:@"createView"];
//    [[ModelManager shareInstance] registerModelCreator:[[UILabelCreator alloc]init] withKey:@"createLabel"];
//    [[ModelManager shareInstance] registerModelCreator:[[UIButtonCreator alloc]init] withKey:@"createButton"];
//    [[ModelManager shareInstance] registerModelCreator:[[UIImageViewCreator alloc]init] withKey:@"createImageView"];
//    [[ModelManager shareInstance] registerModelCreator:[[DataCreator alloc]init] withKey:@"createData"];
//    [[ModelManager shareInstance] registerModelCreator:[[HttpActionCreator alloc]init] withKey:@"createHttpAction"];
//    [[ModelManager shareInstance] registerModelCreator:[[UIActionCreator alloc]init] withKey:@"createUIAction"];
//    [[ModelManager shareInstance] registerModelCreator:[[DataActionCreator alloc]init] withKey:@"createDataAction"];
//    [[ModelManager shareInstance] registerModelCreator:[[CustomActionCreator alloc]init] withKey:@"createCustomAction"];
//    [[ModelManager shareInstance] registerModelCreator:[[ViewDataBinderCreator alloc]init] withKey:@"createViewDataBind"];
    
    
    
    
    
    
    NSMutableDictionary * image = [[NSMutableDictionary alloc ]init];
    [image setValue:@"10" forKey:@"x"];
    [image setValue:@"20" forKey:@"y"];
    [image setValue:@"100" forKey:@"width"];
    [image setValue:@"100" forKey:@"height"];
    UI * imageView = [[ObjectManager shareInstance] createObject:image withKey:@"createImageView"];
    [[ObjectManager shareInstance] setObject:imageView withKey:@"userAvatar"];
    

    
    
    
    
    
    NSMutableDictionary * http = [[NSMutableDictionary alloc] init];
    [http setValue:@"http://api.com" forKey:@"url"];
    [http setValue:@"getTop" forKey:@"param"];
    HttpAction * http1 = [[ObjectManager shareInstance] createObject:http withKey:@"createHttpAction"];
    [[ObjectManager shareInstance] setObject:http1 withKey:@"getTopHttp"];


    
    
    
    NSMutableDictionary * tap = [[NSMutableDictionary alloc] init];
    [http setValue:imageView forKey:@"view"];
    [http setValue:@"tap" forKey:@"condition"];
    [http setValue:http1 forKey:@"action"];
    UIAction * tapimage = [[ObjectManager shareInstance] createObject:tap withKey:@"createUIAction"];
    [[ObjectManager shareInstance] setObject:tapimage withKey:@"tapimage"];

    NSMutableDictionary * custom = [[NSMutableDictionary alloc] init];
    CustomAction * customfunc = [[ObjectManager shareInstance] createObject:custom withKey:@"createCustomAction"];
    [[ObjectManager shareInstance] setObject:customfunc withKey:@"customfunc"];

    
    NSMutableDictionary * data = [[NSMutableDictionary alloc] init];
    [data setValue:@"11111" forKey:@"id"];
    [data setValue:@"张三" forKey:@"name"];
    [data setValue:@"13811111111" forKey:@"phone"];
    Data * user1 = [[ObjectManager shareInstance] createObject:data withKey:@"createData"];
    [[ObjectManager shareInstance] setObject:user1 withKey:@"clientUser"];

    [[DAUManager shareInstance] bindObject:imageView withOtherObject:user1];
//    [[DAUManager shareInstance] bind:imageView withData:tap];
}

- (void)viewWillAppear:(BOOL)animated
{
    
//    UIModel* imageView = [[ModelManager shareInstance] getModel:@"userAvatar"];
//    HttpAction * http1 = [[ModelManager shareInstance] getModel:@"getTopHttp"];
//    [http1 doAction];
//    DataCore * user1 = [[ModelManager shareInstance] getModel:@"clientUser"];
//    
//    [[DAUManager shareInstance] trigger:imageView];
//    [[DAUManager shareInstance] bind:imageView withData:user1];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
