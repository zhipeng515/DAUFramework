//
//  UIModel.m
//  DAUFramework
//
//  Created by zhipeng on 16/4/22.
//  Copyright © 2016年 zhipeng. All rights reserved.
//

#import "UIModel.h"

@implementation UIModel

-(id)initWithUI:(id)ui
{
    if(self = [super init])
    {
        self.ui = ui;
    }
    return self;
}

- (id)copyWithZone:(nullable NSZone *)zone
{
    return self;
}

- (id)mutableCopyWithZone:(nullable NSZone *)zone;
{
    return self;
}


@end
