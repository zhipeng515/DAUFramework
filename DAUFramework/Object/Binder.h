//
//  Bind.h
//  DAUFramework
//
//  Created by zhipeng on 16/4/22.
//  Copyright © 2016年 zhipeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Data.h"

@interface Binder : Data

+ (nonnull id)binderWithObject:(nonnull id)sourceObject withScope:(nonnull NSString*)scope;
- (BOOL)doAction:(nonnull NSString*)condition;

@end
