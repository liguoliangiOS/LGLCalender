//
//  LGLHeaderView.m
//  LGLProgress
//
//  Created by 李国良 on 2016/10/11.
//  Copyright © 2016年 李国良. All rights reserved.
//  https://github.com/liguoliangiOS/LGLCalender.git

#import "LGLHeaderView.h"
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height
#define LGLColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

@implementation LGLHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.dateL = [[UILabel alloc] initWithFrame:CGRectMake(0, 1, WIDTH, frame.size.height - 7)];
        self.dateL.textAlignment = NSTextAlignmentCenter;
        self.dateL.textColor = [UIColor blackColor];
        self.dateL.font = [UIFont systemFontOfSize:14];
        self.dateL.backgroundColor = LGLColor(236, 236, 236);
        [self addSubview:self.dateL];
        
        UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, frame.size.height - 5, WIDTH, 5)];
        view.backgroundColor = [UIColor whiteColor];
        [self addSubview:view];
    }
    return self;
}


@end
