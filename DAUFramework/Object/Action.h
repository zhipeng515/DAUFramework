//
//  Action.h
//  DAUFramework
//
//  Created by zhipeng on 16/4/22.
//  Copyright © 2016年 zhipeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Action : NSObject

@property(nonatomic, retain)NSString * condition;
@property(nonatomic, retain)NSMutableDictionary * param;
@property(nonatomic, retain)Action * complete;
@property(nonatomic, retain)Action * failed;

-(id)initWithParam:(NSDictionary*)param;
-(void)doAction;

@end


@interface HttpAction : Action

-(id)initWithParam:(NSDictionary*)param;
-(void)doAction;

@end

@interface UIAction : Action

-(id)initWithParam:(NSDictionary*)param;
-(void)doAction;

@end

@interface DataAction : Action

-(id)initWithParam:(NSDictionary*)param;
-(void)doAction;

@end

@interface CustomAction : Action

-(id)initWithParam:(NSDictionary*)param;
-(void)doAction;

@end
