//
//  LGLCalenderViewController.m
//  LGLProgress
//
//  Created by 李国良 on 2016/10/11.
//  Copyright © 2016年 李国良. All rights reserved.
//  https://github.com/liguoliangiOS/LGLCalender.git

#import "LGLCalenderViewController.h"
#import "LGLCalenderCell.h"
#import "LGLHeaderView.h"
#import "LGLCalenderModel.h"
#import "LGLCalenderSubModel.h"
#import "LGLCalendarDate.h"
#import "LGLWeekView.h"

#import "XLPlainFlowLayout.h"
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height
#define LGLColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

@interface LGLCalenderViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>
{
    NSInteger _year;
    NSInteger _month;
    NSInteger _day;
}
@property (nonatomic, strong) UICollectionView * collectionView;
@property (nonatomic, strong) NSMutableArray * dataSource;
@property (nonatomic, strong) NSMutableDictionary *cellDic; // 用来存放Cell的唯一标示符
@end

@implementation LGLCalenderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initOtherData];
    [self addHeaderWeekView];
    [self getData];
    [self createCalendarView];
    
}
- (void)addHeaderWeekView {
    LGLWeekView * week = [[LGLWeekView alloc] initWithFrame:CGRectMake(0, 64, WIDTH, 40)];
    [self.view addSubview:week];
}

- (void)initOtherData {
    self.title = @"LGL价格日历";
    
    //获取当前的年月日
     _year = [LGLCalendarDate year:[NSDate date]];
     _month = [LGLCalendarDate month:[NSDate date]];
     _day = [LGLCalendarDate day:[NSDate date]];
}


-(void)createCalendarView
{
    XLPlainFlowLayout * layout = [[XLPlainFlowLayout alloc] init];
    layout.naviHeight = 0.0;
    //布局
    //UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc] init];
    //设置item的宽高
    layout.itemSize=CGSizeMake(WIDTH / 7, WIDTH / 7);
    //设置滑动方向
    layout.scrollDirection=UICollectionViewScrollDirectionVertical;
    //设置行间距
    layout.minimumLineSpacing=0.0f;
    //每列的最小间距
    layout.minimumInteritemSpacing = 0.0f;
    //四周边距
    layout.sectionInset=UIEdgeInsetsMake(0, 0, 0, 0);
    self.collectionView=[[UICollectionView alloc] initWithFrame:CGRectMake(0, 103, WIDTH, HEIGHT - 103) collectionViewLayout:layout];
    self.collectionView.backgroundColor=[UIColor whiteColor];
    self.collectionView.delegate=self;
    self.collectionView.dataSource=self;
    self.collectionView.showsVerticalScrollIndicator=NO;
    [self.view addSubview:self.collectionView];
   // [self.collectionView registerClass:[LGLCalenderCell class] forCellWithReuseIdentifier:@"calender"];
    [self.collectionView registerClass:[LGLHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"calenderHeaderView"];
    
}

- (void)getData {
    [LGLCalenderModel getCalenderDataWithDate:[NSDate date] block:^(NSMutableArray *result) {
        [self.dataSource addObjectsFromArray:result];
        [self.collectionView reloadData];
    }];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.dataSource.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    LGLCalenderModel * model = self.dataSource[section];
    return model.details.count + model.firstday;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
   
    // 每次先从字典中根据IndexPath取出唯一标识符
    NSString *identifier = [_cellDic objectForKey:[NSString stringWithFormat:@"%@", indexPath]];
    // 如果取出的唯一标示符不存在，则初始化唯一标示符，并将其存入字典中，对应唯一标示符注册Cell
    if (identifier == nil) {
        identifier = [NSString stringWithFormat:@"LGLCalenderCell%@", [NSString stringWithFormat:@"%@", indexPath]];
        [_cellDic setValue:identifier forKey:[NSString stringWithFormat:@"%@", indexPath]];
        // 注册Cell
        [self.collectionView registerClass:[LGLCalenderCell class]  forCellWithReuseIdentifier:identifier];
    }
    
    LGLCalenderCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    if (self.dataSource.count) {
         LGLCalenderModel * model = self.dataSource[indexPath.section];
        if (indexPath.item >= model.firstday) {
            NSInteger index = indexPath.item - model.firstday;
            LGLCalenderSubModel * subModel = model.details[index];
            cell.dateL.text = [NSString stringWithFormat:@"%ld",(long)subModel.day];
            cell.priceL.text = [NSString stringWithFormat:@"￥%@", subModel.price];
            cell.backgroundColor = LGLColor(244, 243, 231);
            if ((model.year == _year) && (model.month == _month) && (subModel.day == _day))  {
                cell.backgroundColor =  LGLColor(65, 207, 79);
            }
            
            if ((model.year == _year) && (model.month == _month) && (subModel.day < _day)) {
                cell.backgroundColor = LGLColor(239, 239, 239);
                cell.dateL.textColor = [UIColor lightGrayColor];
                cell.priceL.textColor = LGLColor(239, 239, 239);//[UIColor lightGrayColor];
                cell.priceL.textColor = [UIColor lightGrayColor];
                cell.userInteractionEnabled = NO;
            }
        } else {
            cell.userInteractionEnabled = NO;
        
        }
    }
    return cell;
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    LGLHeaderView * headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"calenderHeaderView" forIndexPath:indexPath];
    LGLCalenderModel * model = self.dataSource[indexPath.section];
    headerView.dateL.text = [NSString stringWithFormat:@"%ld年%ld月",model.year, model.month];
    return headerView;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(WIDTH, 40);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    LGLCalenderModel * model = self.dataSource[indexPath.section];
    NSInteger index = indexPath.row - model.firstday;
    LGLCalenderSubModel * subModel = model.details[index];
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setValue: [NSString stringWithFormat:@"%ld", model.year] forKey:@"year"];
    [dic setValue: [NSString stringWithFormat:@"%ld", model.month] forKey:@"month"];
    [dic setValue: [NSString stringWithFormat:@"%ld", subModel.day] forKey:@"day"];
    [dic setValue: [NSString stringWithFormat:@"%@",  subModel.price] forKey:@"price"];
    self.block(dic);
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)seleDateWithBlock:(SelectDateBalock)block {
    self.block = block;
}

- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (NSMutableDictionary *)cellDic {
    if (!_cellDic) {
        _cellDic = [NSMutableDictionary dictionary];
    }
    return _cellDic;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
