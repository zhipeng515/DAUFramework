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

-(id)initWithParam:(NSDictionary*)param;
-(void)doAction;

@end


@interface HttpAction : Action

-(id)initWithParam:(NSDictionary*)param;
-(void)doAction;

@end

@interface UIAction : Action

@property(nonatomic, retain)NSMutableDictionary * param;

-(id)initWithParam:(NSDictionary*)param;
-(void)doAction;

@end

@interface DataAction : Action

@property(nonatomic, retain)NSMutableDictionary * param;

-(id)initWithParam:(NSDictionary*)param;
-(void)doAction;

@end

@interface CustomAction : Action

@property(nonatomic, retain)NSMutableDictionary * param;

-(id)initWithParam:(NSDictionary*)param;
-(void)doAction;

@end
