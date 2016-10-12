//
//  LGLCalendarDate.h
//  LGLProgress
//
//  Created by 李国良 on 2016/10/12.
//  Copyright © 2016年 李国良. All rights reserved.
//  https://github.com/liguoliangiOS/LGLCalender.git

#import <Foundation/Foundation.h>

@interface LGLCalendarDate : NSObject

/** 获取天 */
+ (NSInteger)day:(NSDate *)date;

/** 获取月*/
+ (NSInteger)month:(NSDate *)date;

/** 获取年*/
+ (NSInteger)year:(NSDate *)date;

/** 获取某个月的第一天是周几*/
+ (NSInteger)firstWeekdayInThisMonth:(NSDate *)date;

/** 获取某个月的所有总天数*/
+ (NSInteger)totaldaysInMonth:(NSDate *)date;

/** 获取某个月的上个月*/
+ (NSDate *)lastMonth:(NSDate *)date;

/** 获取某个月的上个月*/
+ (NSDate*)nextMonth:(NSDate *)date;

/** String 转 Date */
+ (NSDate *)dateFromString:(NSString *)dateString;

/** Date 转 String*/
+ (NSString *)stringFromDate:(NSDate *)date;


@end
