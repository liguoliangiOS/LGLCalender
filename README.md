# LGLCalender
> 使用说明
```
// =================================  开始使用  ===================================================
    LGLCalenderViewController * ctl = [[LGLCalenderViewController alloc] init];
    [ctl seleDateWithBlock:^(NSMutableDictionary *paramas) {
       // 获取回调数据
    }];
    [self.navigationController pushViewController:ctl animated:YES];
// =================================  结束使用  ===================================================
```
