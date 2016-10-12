//
//  ViewController.m
//  LGLCalender-Demo
//
//  Created by 李国良 on 2016/10/12.
//  Copyright © 2016年 李国良. All rights reserved.
//

#import "ViewController.h"
#import "LGLCalenderViewController.h"
@interface ViewController ()

@property (nonatomic, strong) UILabel * date;
@property (nonatomic, strong) UILabel * price;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.backgroundColor = [UIColor brownColor];
    self.title = @"价格日历-Dome";
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(120, 250, 100, 40);
    btn.layer.borderWidth = 1;
    btn.layer.masksToBounds = YES;
    btn.layer.cornerRadius = 8;
    [btn setBackgroundColor:[UIColor greenColor]];
    [btn setTitle:@"选择日期" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClinck) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    UILabel * dateL = [[UILabel alloc] initWithFrame:CGRectMake(50, 150, 50, 20)];
    dateL.text = @"日期:";
    [self.view addSubview:dateL];
    self.date = [[UILabel alloc] initWithFrame:CGRectMake(100, 150, 200, 20)];
    self.date.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:self.date];
    
    UILabel * priceL = [[UILabel alloc] initWithFrame:CGRectMake(50, 180, 50, 20)];
    priceL.text = @"价格:";
    [self.view addSubview:priceL];
    
    self.price = [[UILabel alloc] initWithFrame:CGRectMake(100, 180, 200, 20)];
    self.price.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:self.price];
    
}

- (void)btnClinck {

// =================================  开始使用  ===================================================
    LGLCalenderViewController * ctl = [[LGLCalenderViewController alloc] init];
    [ctl seleDateWithBlock:^(NSMutableDictionary *paramas) {
        NSString * date = [NSString stringWithFormat:@"%@-%@-%@", paramas[@"year"], paramas[@"month"], paramas[@"day"]];
        NSString * price = paramas[@"price"];
        self.date.text = date;
        self.price.text = price;
    }];
    [self.navigationController pushViewController:ctl animated:YES];
// =================================  结束使用  ===================================================

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
