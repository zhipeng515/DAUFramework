//
//  UICreator.h
//  DAUFramework
//
//  Created by zhipeng on 16/4/21.
//  Copyright © 2016年 zhipeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ObjectCreator.h"

// Create UI Object

@interface UICreator : ObjectCreator

@end

@interface UIViewCreator : UICreator


@end

@interface UIImageViewCreator : UIViewCreator


@end

@interface UIButtonCreator : UIViewCreator


@end

@interface UILabelCreator : UIViewCreator


@end

@interface UITextViewCreator : UIViewCreator


@end


@interface UITextFieldCreator : UIViewCreator

@end

@interface UIViewControllerCreator : UICreator

@end

@interface DAUUIViewControllerCreator : UIViewControllerCreator

@end

@interface UINavigationControllerCreator : UIViewControllerCreator

@end
