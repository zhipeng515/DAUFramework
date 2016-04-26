//
//  UIModel.h
//  DAUFramework
//
//  Created by zhipeng on 16/4/22.
//  Copyright © 2016年 zhipeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UI : NSObject<NSCopying, NSMutableCopying>

@property(nonatomic, retain)id ui;

- (id)copyWithZone:(nullable NSZone *)zone;
- (id)mutableCopyWithZone:(nullable NSZone *)zone;

-(id)initWithUI:(id)ui;


@end
