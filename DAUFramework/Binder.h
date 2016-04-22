//
//  Bind.h
//  DAUFramework
//
//  Created by zhipeng on 16/4/22.
//  Copyright © 2016年 zhipeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Binder : NSObject

@property(nonatomic, retain)id srcObject;
@property(nonatomic, retain)id destObject;

-(void)bindObject:(id)src withOtherObject:(id)dest;

@end

@interface ViewDataBind : Binder

@property(nonatomic, retain)NSMutableArray * views;

-(id)init;
-(void)bindObject:(id)src withOtherObject:(id)dest;

@end
