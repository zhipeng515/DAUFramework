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

@interface ViewController ()

@end

@implementation ViewController

- (void)benchmark
{
    CGFloat time = BNRTimeBlock(^{
        for(int i = 0; i < 100; i++)
        {
            NSString *path = [[NSBundle mainBundle] pathForResource:@"testdata" ofType:@"json"];
            NSData * configString = [NSData dataWithContentsOfFile:path];
            NSDictionary * creatorDict = [NSJSONSerialization JSONObjectWithData:configString options:NSJSONReadingMutableLeaves error:nil];
            
            [[DAUManager shareInstance] parseDataModel:creatorDict withScope:@"RegisterView"];
            
            Data * note = [Data dataWithKey:@"175469173324290048" withScope:@"note"];
            note[@"userId"] = @"ccc";
            
            [[DAUManager shareInstance] parseDataModel:creatorDict withScope:@"RegisterView"];
            
            path = [[NSBundle mainBundle] pathForResource:@"testdata_1" ofType:@"json"];
            configString = [NSData dataWithContentsOfFile:path];
            creatorDict = [NSJSONSerialization JSONObjectWithData:configString options:NSJSONReadingMutableLeaves error:nil];
            
            [[DAUManager shareInstance] parseDataModel:creatorDict withScope:@"RegisterView"];
        }
    });
    NSLog(@"time: %f", time);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSString *path = [[NSBundle mainBundle] pathForResource:@"ObjectCreator" ofType:@"json"];
    NSData * configString = [NSData dataWithContentsOfFile:path];
    NSDictionary * creatorDict = [NSJSONSerialization JSONObjectWithData:configString options:NSJSONReadingMutableLeaves error:nil];

    [[ObjectManager shareInstance] loadObjectCreator:creatorDict];
    
    path = [[NSBundle mainBundle] pathForResource:@"ModelDefine" ofType:@"json"];
    configString = [NSData dataWithContentsOfFile:path];
    creatorDict = [NSJSONSerialization JSONObjectWithData:configString options:NSJSONReadingMutableLeaves error:nil];
    [[DAUManager shareInstance] loadModelDefine:creatorDict];

    path = [[NSBundle mainBundle] pathForResource:@"RegisterViewLayout" ofType:@"json"];
    configString = [NSData dataWithContentsOfFile:path];
    creatorDict = [NSJSONSerialization JSONObjectWithData:configString options:NSJSONReadingMutableLeaves error:nil];
    
    [[DAUManager shareInstance] parseLayoutModel:creatorDict[@"layoutInfo"] withScope:@"RegisterView"];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self benchmark];
    });

    Data * d1 = [Data dataWithKey:@"ffff" withScope:@"a.bb.ccc.dddd.eeeee"];
    d1[@"ffffff"] = @"ggggggg";
    Data * d2 = [Data dataWithKey:@"ffff" withScope:@"a.bb.ccc.dddd.eeeee"];
    d2[@"fffff"] = @"hhhhhhh";

    id notes = [[ObjectManager shareInstance] getObject:@"notes" withScope:@"RegisterView"];
    NSLog( @"%@", notes[@"notes"]);
    
    Data * device = [[Data alloc] init];
    device[@"deviceType"] = @"ios";
    device[@"deviceId"] = @"123123123123123";
    [[ObjectManager shareInstance] setObject:device withKey:@"device" withScope:@"global"];
    
    [[ObjectManager shareInstance] setObject:@"ios" withKey:@"deviceType" withScope:@"global.device"];
    [[ObjectManager shareInstance] setObject:@"123123123123123" withKey:@"deviceId" withScope:@"global.device"];
    

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
    UI * imageView = [[ObjectManager shareInstance] createObject:image withKey:@"createImageView"];
    [[ObjectManager shareInstance] setObject:imageView withKey:@"userAvatar" withScope:GLOBAL_SCOPE];
    

    
    
    
    
    
    NSMutableDictionary * http = [[NSMutableDictionary alloc] init];
    [http setValue:@"http://api.com" forKey:@"url"];
    [http setValue:@"getTop" forKey:@"param"];
    HttpAction * http1 = [[ObjectManager shareInstance] createObject:http withKey:@"createHttpAction"];
    [[ObjectManager shareInstance] setObject:http1 withKey:@"getTopHttp" withScope:GLOBAL_SCOPE];


    

    NSMutableDictionary * custom = [[NSMutableDictionary alloc] init];
    CustomAction * customfunc = [[ObjectManager shareInstance] createObject:custom withKey:@"createCustomAction"];
    [[ObjectManager shareInstance] setObject:customfunc withKey:@"customfunc" withScope:GLOBAL_SCOPE];
    
    UI * label = [[ObjectManager shareInstance] getObject:@"debugInfo" withScope:@"RegisterView"];
    ((UITextView*)label.ui).frame = CGRectMake(0, 0, 320, 568);
    [self.view addSubview:label.ui];
    
    [[ObjectManager shareInstance] removeAllObject];
    
    NSMutableDictionary * tap = [[NSMutableDictionary alloc] init];
    [http setValue:imageView forKey:@"view"];
    [http setValue:@"tap" forKey:@"condition"];
    [http setValue:http1 forKey:@"action"];
    UIAction * tapimage = [[ObjectManager shareInstance] createObject:tap withKey:@"createUIAction"];
    [[ObjectManager shareInstance] setObject:tapimage withKey:@"tapimage" withScope:GLOBAL_SCOPE];

    UI * view = [[ObjectManager shareInstance] createObject:@{} withKey:@"createView"];
    [[ObjectManager shareInstance] setObject:view withKey:@"view" withScope:GLOBAL_SCOPE];

    Data * d3 = [Data dataWithKey:view withScope:@"RegisterView"];
    d3[@"actions"] = tapimage;
    d3[@"datas"] = d2;

    Data * d4 = [Data dataWithKey:d2 withScope:@"RegisterView"];
    d4[@"views"] = view;
    d4[@"actions"] = tapimage;

    UIAction * act = d3[@"tap"];
    [act doAction];
    
    for(id key in [ObjectManager shareInstance].objects)
    {
        NSLog(@"%@", key);
    }

    
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

- (void)viewWillAppear:(BOOL)animated
{
    
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
//    NSLog(@"%@", [ObjectManager shareInstance].objects);
//
//    UI * label = [[ObjectManager shareInstance] getObject:@"debugInfo" withScope:@"RegisterView"];
//    ((UITextView*)label.ui).attributedText = data;
//
//    
//    [[ObjectManager shareInstance] removeAllObject:@"RegisterView"];
    
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
