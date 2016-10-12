//
//  LGLWeekView.m
//  LGLProgress
//
//  Created by 李国良 on 2016/10/12.
//  Copyright © 2016年 李国良. All rights reserved.
//  https://github.com/liguoliangiOS/LGLCalender.git

#import "LGLWeekView.h"

#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height
#define LGLColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
@implementation LGLWeekView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        NSArray * wekAr = @[@"日", @"一", @"二", @"三", @"四", @"五", @"六"];
        UIView * titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, frame.size.height)];
        titleView.backgroundColor = LGLColor(65, 207, 79);//LGLColor(19, 115, 113);
        for (NSInteger i = 0; i < 7; i++) {
            UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake((WIDTH / 7) * i, 10, WIDTH / 7, frame.size.height - 20);
            btn.titleLabel.font = [UIFont systemFontOfSize:14];
            [btn setTitle:wekAr[i] forState:UIControlStateNormal];
            [titleView addSubview:btn];
        }
        [self addSubview:titleView];
    }
    return self;
}


@end
