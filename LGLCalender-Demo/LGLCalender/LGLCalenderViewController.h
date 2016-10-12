//
//  LGLCalenderViewController.h
//  LGLProgress
//
//  Created by 李国良 on 2016/10/11.
//  Copyright © 2016年 李国良. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SelectDateBalock)(NSMutableDictionary * paramas);

@interface LGLCalenderViewController : UIViewController

@property (nonatomic, copy) SelectDateBalock block;
- (void)seleDateWithBlock:(SelectDateBalock)block;

@end
