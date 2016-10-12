//
//  LGLCalenderModel.m
//  LGLProgress
//
//  Created by 李国良 on 2016/10/11.
//  Copyright © 2016年 李国良. All rights reserved.
//  https://github.com/liguoliangiOS/LGLCalender.git

#import "LGLCalenderModel.h"
#import "LGLCalendarDate.h"
#import "LGLCalenderSubModel.h"

@implementation LGLCalenderModel

+ (void)getCalenderDataWithDate:(NSDate *)date block:(CallBackBlock)block {
    NSMutableArray * array = [NSMutableArray array];
    NSDate * cdate = date;
    NSInteger firstday = [LGLCalendarDate firstWeekdayInThisMonth:cdate]; // 本月的第一天是周几
    NSInteger totalDay = [LGLCalendarDate totaldaysInMonth:cdate];  //月份的所有天数
    NSInteger year = [LGLCalendarDate year:cdate];
    NSInteger month = [LGLCalendarDate month:cdate];
    
    for (NSInteger y = year; y < year + 2; y ++) {
        
        for (NSInteger i = month; i < 13; i++) {
            LGLCalenderModel * model = [[LGLCalenderModel alloc] init];
            model.year = y;
            model.month = i;
            model.firstday = firstday;
            for (NSInteger j = 1; j < totalDay  +1; j ++) {
                LGLCalenderSubModel * subModel = [[LGLCalenderSubModel alloc] init];
                subModel.day = j;
                subModel.price = [NSString stringWithFormat:@"%ld", 100 + j];
                [model.details addObject:subModel];
            }
            totalDay = [LGLCalendarDate totaldaysInMonth:[LGLCalendarDate nextMonth:cdate]];
            cdate = [LGLCalendarDate nextMonth:cdate];
            firstday = [LGLCalendarDate firstWeekdayInThisMonth:cdate];

            [array addObject:model];
        }
        month = 1;
    }
    
    block(array);
}

- (NSMutableArray *)details {
    if (!_details) {
        _details = [NSMutableArray array];
    }
    return _details;
}
@end
