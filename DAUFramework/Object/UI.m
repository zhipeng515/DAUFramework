//
//  UIModel.m
//  DAUFramework
//
//  Created by zhipeng on 16/4/22.
//  Copyright © 2016年 zhipeng. All rights reserved.
//

#import "UI.h"
#import "JJRSObjectDescription.h"

@implementation UI

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

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.ui forKey:@"ui"];
}

- (nonnull NSString*)description
{
    NSString * desc = [JJRSObjectDescription descriptionForObject:self.ui];
    return desc;
}
@end
