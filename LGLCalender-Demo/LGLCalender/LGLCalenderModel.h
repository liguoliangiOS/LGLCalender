//
//  LGLCalenderModel.h
//  LGLProgress
//
//  Created by 李国良 on 2016/10/11.
//  Copyright © 2016年 李国良. All rights reserved.
//  https://github.com/liguoliangiOS/LGLCalender.git

#import <Foundation/Foundation.h>

typedef void(^CallBackBlock)(NSMutableArray * result);
@interface LGLCalenderModel : NSObject

@property (nonatomic, assign) NSInteger year;
@property (nonatomic, assign) NSInteger month;
@property (nonatomic, assign) NSInteger firstday; // 本月第一天是周几
@property (nonatomic, strong ) NSMutableArray * details;


+ (void)getCalenderDataWithDate:(NSDate *)date block:(CallBackBlock)block;
@end
