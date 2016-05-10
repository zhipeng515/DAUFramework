//
//  ViewController.m
//  DAUFramework
//
//  Created by zhipeng on 16/4/21.
//  Copyright © 2016年 zhipeng. All rights reserved.
//

#import "GlobalViewModel.h"
#import "ObjectManager.h"

#import "UICreator.h"
#import "DataCreator.h"
#import "ActionCreator.h"
#import "BinderCreator.h"

#import "Data.h"
#import "Action.h"
#import "UIWrapper.h"
#import "Binder.h"
#import "DAUManager.h"
#import "DAUViewController.h"

#import "JJRSObjectDescription.h"

#import <mach/mach_time.h>  // for mach_absolute_time() and friends


CGFloat BNRTimeBlock (void (^block)(void)) {
    mach_timebase_info_data_t info;
    if (mach_timebase_info(&info) != KERN_SUCCESS) return -1.0;
    
    uint64_t start = mach_absolute_time ();
    block ();
    uint64_t end = mach_absolute_time ();
    uint64_t elapsed = end - start;
    
    uint64_t nanos = elapsed * info.numer / info.denom;
    return (CGFloat)nanos / NSEC_PER_SEC;
    
} // BNRTimeBlock

@implementation GlobalViewModel

- (void)presentDAU:(Action*)action
{
    DAUViewController * viewController = [[DAUViewController alloc] init];
    viewController.controllerName = @"DAUViewController";
}

- (void)benchmark
{
    CGFloat time = BNRTimeBlock(^{
        NSString *path = [[NSBundle mainBundle] pathForResource:@"testdata" ofType:@"json"];
        NSData * configString = [NSData dataWithContentsOfFile:path];
        NSDictionary * creatorDict = [NSJSONSerialization JSONObjectWithData:configString options:NSJSONReadingMutableLeaves error:nil];

        NSString * path1 = [[NSBundle mainBundle] pathForResource:@"testdata_1" ofType:@"json"];
        NSData * configString1 = [NSData dataWithContentsOfFile:path1];
        NSDictionary * creatorDict1 = [NSJSONSerialization JSONObjectWithData:configString1 options:NSJSONReadingMutableLeaves error:nil];

        for(int i = 0; i < 100; i++)
        {
            
            [[DAUManager shareInstance] parseDataModel:creatorDict withScope:@"RegisterView"];
            
            Data * note = [Data dataWithKey:@"175469173324290048" withScope:@"note"];
            note[@"userId"] = @"ccc";
            
            [[DAUManager shareInstance] parseDataModel:creatorDict withScope:@"RegisterView"];
            
            
            [[DAUManager shareInstance] parseDataModel:creatorDict1 withScope:@"RegisterView"];
        }
    });
    NSLog(@"time: %f", time);
}

- (void)viewDidLoad:(nullable Data*)param {
    // Do any additional setup after loading the view, typically from a nib.
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self benchmark];
//    });

//    id notes = [[ObjectManager shareInstance] getObject:@"notes" withScope:@"RegisterView"];
//    NSLog( @"%@", notes[@"notes"]);
    

//    path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
//    path = [path stringByAppendingString:@"/savedata.json"];
//    NSError * error;
//    BOOL write = [[[ObjectManager shareInstance].objectDict JSONStringWithOptions:JKSerializeOptionPretty error:&error]
//                  writeToFile:path atomically:NO encoding:NSUTF8StringEncoding error:nil];
//    NSLog(@"wrtie %@, %d", path, write);

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
    UIWrapper * imageView = [[ObjectManager shareInstance] createObject:image withKey:@"createImageView"];
    [[ObjectManager shareInstance] setObject:imageView withKey:@"userAvatar" withScope:GLOBAL_SCOPE];
    

    
//    UI * label = [[ObjectManager shareInstance] getObject:@"debugInfo" withScope:@"RegisterView"];
//    ((UITextView*)label.ui).frame = CGRectMake(0, 0, 320, 568);
//    [self.view addSubview:label.ui];


//    [[ObjectManager shareInstance] removeAllObject];
    
    Action * tapimage = [[ObjectManager shareInstance] createObject:@{} withKey:@"createAction"];
    [[ObjectManager shareInstance] setObject:tapimage withKey:@"tapimage" withScope:GLOBAL_SCOPE];
    Action * customfunc = [[ObjectManager shareInstance] createObject:@{} withKey:@"createAction"];
    [[ObjectManager shareInstance] setObject:customfunc withKey:@"customfunc" withScope:GLOBAL_SCOPE];

    UIWrapper * button = [[ObjectManager shareInstance] getObject:@"registerButton" withScope:@"registerViewController"];
    
    Data * d1 = [Data dataWithKey:@"ffff" withScope:@"a.bb.ccc.dddd.eeeee"];
    d1[@"ffffff"] = @"ggggggg";
    Data * d2 = [Data dataWithKey:@"ffff" withScope:@"a.bb.ccc.dddd.eeeee"];
    d2[@"fffff"] = @"hhhhhhh";
    d2[0] = @"aaaa";
    
    Data * device = [[Data alloc] init];
    device[@"deviceType"] = @"ios";
    device[@"deviceId"] = @"123123123123123";
    [[ObjectManager shareInstance] setObject:device withKey:@"device" withScope:@"global"];
    
    
    [button addAction:[Action actionWithSelector:@selector(presentDAU:) withTarget:self withParam:nil] withTrigger:@"onTap" withScope:GLOBAL_SCOPE];
    [button addAction:tapimage withTrigger:@"onTap" withScope:GLOBAL_SCOPE];
    [button addAction:customfunc withTrigger:@"onTap" withScope:GLOBAL_SCOPE];
//    [button watchData:device withKey:@"deviceType" withAction:[Action actionWithSelector:@selector(presentDAU:) withTarget:self withParam:nil] withScope:GLOBAL_SCOPE];
    
    [[ObjectManager shareInstance] setObject:@"444444444444" withKey:@"deviceId" withScope:@"global.device"];
    device[@"deviceType"] = @"android";
    
    
//    NSLog(@"%@", [ObjectManager shareInstance].objects);
    
    
//    UIWrapper * controller = [[ObjectManager shareInstance] getObject:@"registerViewController" withScope:@"registerViewController"];
//    [controller addAction:customfunc withTrigger:@"viewDidLoad"];
//    [controller addAction:tapimage withTrigger:@"viewDidLoad"];
//    [controller addAction:customfunc withTrigger:@"viewWillAppear"];
//    [controller addAction:tapimage withTrigger:@"viewWillAppear"];


//    UI * view = [[ObjectManager shareInstance] createObject:@{} withKey:@"createView"];
//    [[ObjectManager shareInstance] setObject:view withKey:@"view" withScope:GLOBAL_SCOPE];
//
//    Data * d3 = [Data dataWithKey:view withScope:@"RegisterView"];
//    d3[@"actions"] = tapimage;
//    d3[@"datas"] = d2;
//
//    Data * d4 = [Data dataWithKey:d2 withScope:@"RegisterView"];
//    d4[@"views"] = view;
//    d4[@"actions"] = tapimage;
//
//    UIAction * act = d3[@"tap"];
//    [act doAction];
//    
//    for(id key in [ObjectManager shareInstance].objects)
//    {
//        NSLog(@"%@", key);
//    }

    
//    NSMutableDictionary * user = [[NSMutableDictionary alloc] init];
//    [user setValue:@"11111" forKey:@"id"];
//    [user setValue:@"张三" forKey:@"name"];
//    [user setValue:@"13811111111" forKey:@"phone"];
//
//    
//    NSMutableDictionary * data = [[NSMutableDictionary alloc] init];
//    [data setValue:user forKey:@"data"];
//    [data setValue:@"clientUser" forKey:@"key"];
//    [data setValue:GLOBAL_SCOPE forKey:@"scope"];
//    Data * user1 = [[ObjectManager shareInstance] createObject:data withKey:@"createData"];
//    
    
//    NSLog(@"user1 %@", [user1 getData]);
    

//    [[DAUManager shareInstance] bindObject:imageView withOtherObject:user1 withScope:@"RegisterView"];
//    [[DAUManager shareInstance] bind:imageView withData:tap];
}

- (void)viewWillAppear:(nullable Data*)param
{
//    DAUViewController * controller = param[@"self"];
    
//    UIModel* imageView = [[ModelManager shareInstance] getModel:@"userAvatar"];
//    HttpAction * http1 = [[ModelManager shareInstance] getModel:@"getTopHttp"];
//    [http1 doAction];
//    DataCore * user1 = [[ModelManager shareInstance] getModel:@"clientUser"];
//    
//    [[DAUManager shareInstance] trigger:imageView];
//    [[DAUManager shareInstance] bind:imageView withData:user1];
    
//    NSLog(@"%@", [ICHObjectPrinter descriptionForObject:[ObjectManager shareInstance].objects]);
//    NSLog(@"%@", [ObjectManager shareInstance].objectDict[GLOBAL_SCOPE]);
//    NSLog(@"%@", [ObjectManager shareInstance].objectDict[@"RegisterView"]);
    
//    NSAttributedString * debugString = [JJRSObjectDescription attributedDescriptionForObject:[ObjectManager shareInstance].objects];
//    [[ObjectManager shareInstance] setObject:debugString withKey:@"debugString" withScope:@"RegisterView"];
//    
//    id data = [[ObjectManager shareInstance] getObject:@"debugString" withScope:@"RegisterView"];
//    
    NSLog(@"%@", [ObjectManager shareInstance].objects);
//
//    UI * label = [[ObjectManager shareInstance] getObject:@"debugInfo" withScope:@"RegisterView"];
//    ((UITextView*)label.ui).attributedText = data;
//
//    
//    [[ObjectManager shareInstance] removeAllObject:@"RegisterView"];
    
//    UIWrapper * controller = [[ObjectManager shareInstance] getObject:@"registerViewController" withScope:@"registerViewController"];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [self presentViewController:controller.ui animated:NO completion:nil];
//    });
}

@end
