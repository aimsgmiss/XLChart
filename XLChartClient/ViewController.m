//
//  ViewController.m
//  XLChartClient
//
//  Created by JuniorKey on 5/20/17.
//  Copyright © 2017 JuniorKey. All rights reserved.
//

#import "ViewController.h"
#import "XLChart.h"
#import "MainFoldingCell.h"
//#import <MJExtension/MJExtension.h>
#import "MJExtension.h"
@interface ViewController ()


/** the class for chart  */
@property(nonatomic,strong) NSArray* chartClasses;
/** data source*/
@property(nonatomic,strong) NSMutableArray* dataSource;
/** */
@property(nonatomic,strong) NSArray* types;
@end
static NSString* cellIdentify = @"FoldingCell";
@implementation ViewController
XLAddMethodImTemplate(dataSource)


- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setInitdataSource];
    [self.tableView registerNib:[UINib nibWithNibName:@"MainFoldingCell" bundle:nil] forCellReuseIdentifier:cellIdentify];
  
     self.tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 100)];
}



-(void)setInitdataSource
{
    
    NSArray* arr = @[
            @{@"percent" : @0.15,@"name" : @"iphone 6 plus"},
            @{@"percent" : @0.05,@"name" : @"iphone 5 plus"},
            @{@"percent" : @0.45,@"name" : @"iphone 4 plus"},
            @{@"percent" : @0.25,@"name" : @"iphone 7 plus"},
            @{@"percent" : @0.1,@"name" : @"iphone 8 plus"}];
    [self addToDataSource:arr Index:0];
    
    

   
    
    
    arr = @[
              @{@"percent" : @0.15,@"name" : @"iphone 6 plus"},
              @{@"percent" : @0.05,@"name" : @"iphone 5 plus"},
              @{@"percent" : @0.45,@"name" : @"iphone 4 plus"},
              @{@"percent" : @0.25,@"name" : @"iphone 7 plus"},
              @{@"percent" : @0.1,@"name" : @"iphone 8 plus"}];
    
    [self addToDataSource:arr Index:1];
    
    
    arr = @[
     @{
     @"xBottomAxisScaleDatas":@[@10,@20,@30,@40,@50,@60,@70,@80,@90],
     @"yLeftAxisScaleDatas":@[@10,@20,@50,@70,@90],
     @"quadrantMs":@[
               @{@"name" : @"iphone 6 plus" ,@"yAxisData":@53555,@"xAxisData":@0.3,@"trend":@1},
               @{@"name" : @"iphone 4 plus" ,@"yAxisData":@55582,@"xAxisData":@0.5,@"trend":@3},
               @{@"name" : @"iphone 5 plus" ,@"yAxisData":@15555,@"xAxisData":@0.9,@"trend":@3},
               @{@"name" : @"iphone 8 plus" ,@"yAxisData":@75001,@"xAxisData":@0.02,@"trend":@5}
               ]}];
    [self addToDataSource:arr Index:2];
    
    arr = @[
            @{@"yLeftAxisScaleDatas":@[@600,@50000,@100000,@150000,@200000,@300000],
     @"barChartMs":@[
                   @{@"number":@160000,@"number3":@110000,@"number2":@208000,@"name":@"January"},
                   @{@"number":@202300,@"number3":@142000,@"number2":@290000,@"name":@"February"},
                   @{@"number":@230000,@"number3":@200050,@"number2":@280000,@"name":@"March"},
                   @{@"number":@203000,@"number3":@260000,@"number2":@170000,@"name":@"April"},
                   @{@"number":@205000,@"number3":@210000,@"number2":@280000,@"name":@"May"},
                   @{@"number":@280340,@"number3":@210000,@"number2":@200000,@"name":@"June"},
                   @{@"number":@250000,@"number3":@210000,@"number2":@150000,@"name":@"July"},
                   @{@"number":@250000,@"number3":@190000,@"number2":@150000,@"name":@"August"},
                   @{@"number":@180000,@"number3":@210000,@"number2":@180000,@"name":@"Sep"},
                   @{@"number":@200000,@"number3":@150000,@"number2":@110000,@"name":@"October"},
                   @{@"number":@230000,@"number3":@250000,@"number2":@110000,@"name":@"November"},
                   @{@"number":@230000,@"number3":@250000,@"number2":@110000,@"name":@"December"}]}
                   ];
           [self addToDataSource:arr[0] Index:3];
    

 
    arr = @[
                    @{
                         @"xTopAxisScaleDatas":@[@0,@50000,@100000,@150000,@200000,@300000],
                         @"title":@"sale",
                         @"barChartMs":@[
                                 @{@"backgoundNumber":@110000,@"number":@108000,@"name":@"Adeline"},
                                 @{@"backgoundNumber":@112000,@"number":@190000,@"name":@"Alexandra"},
                                 @{@"backgoundNumber":@100050,@"number":@180000,@"name":@"Ailsa"},
                                 @{@"backgoundNumber":@210000,@"number":@170000,@"name":@"Caroline"},
                                 @{@"backgoundNumber":@110000,@"number":@108000,@"name":@"Carrie"},
                                 @{@"backgoundNumber":@112000,@"number":@190000,@"name":@"Cassie"},
                                 @{@"backgoundNumber":@100050,@"number":@180000,@"name":@"Catherine"},
                                 @{@"backgoundNumber":@210000,@"number":@170000,@"name":@"Cheryl"},
                                 @{@"backgoundNumber":@110000,@"number":@108000,@"name":@"Christine"},
                                 @{@"backgoundNumber":@112000,@"number":@190000,@"name":@"Ella"},
                                 @{@"backgoundNumber":@100050,@"number":@180000,@"name":@"Ella"},
                                 @{@"backgoundNumber":@210000,@"number":@170000,@"name":@"Ellb"}
                                 ]}
                     ];
    
    [self addToDataSource:arr[0] Index:4];
    
    
    arr = @[
           @{@"headers":@[@"Name",@"Amount",@"Count",@"Days",@"Salary"],
           @"tableCellMs":@[
                     @{@"items":@[@"Jike emth",@"333354",@"1236645",@"5488",@"1000"]},
                     @{@"items":@[@"Jike June",@"333354",@"1236645",@"5488",@"1000"]},
                     @{@"items":@[@"Tom edit ",@"333354",@"1236645",@"5488",@"1000"]},
                     @{@"items":@[@"Master Mi",@"333354",@"1236645",@"5488",@"1000"]},
                     @{@"items":@[@"Bachelor",@"333354",@"1236645",@"5488",@"1000"]},
                     @{@"items":@[@"Doctor M",@"333354",@"1236645",@"5488",@"1000"]},
                     @{@"items":@[@"Mike Ors",@"333354",@"1236645",@"5488",@"1000"]},
                     @{@"items":@[@"Jike deliver",@"333354",@"1236645",@"5488",@"1000"]},
                     @{@"items":@[@"Jike Order",@"333354",@"1236645",@"5488",@"1000"]},
                     @{@"items":@[@"Jike Mar",@"333354",@"1236645",@"5488",@"1000"]}

                     ]}];
    [self addToDataSource:arr[0] Index:5];
    
    arr = @[
            @{@"headers":@[@"Name",@"Detail Information",@"Days"],
              @"tableCellMs":@[
                      @{@"items":@[@"Adeline",@[@"333354",@"1236645",@"5488"],@"1000"]},
                      @{@"items":@[@"Jike",@[@"333354",@"1236645",@"5488"],@"1000"]},
                       @{@"items":@[@"Mike",@[@"333354",@"1236645",@"5488"],@"1000"]},
                      @{@"items":@[@"Tom",@[@"333354",@"1236645",@"5488"],@"1000"]},
                      @{@"items":@[@"Junior Key",@[@"333354",@"1236645",@"5488"],@"1000"]},
                       @{@"items":@[@"Aimsgmiss ",@[@"333354",@"1236645",@"5488"],@"1000"]},
                       @{@"items":@[@"Jinis",@[@"333354",@"1236645",@"5488"],@"1000"]},
                      @{@"items":@[@"Mothes",@[@"333354",@"1236645",@"5488"],@"1000"]},
                      @{@"items":@[@"Delivery",@[@"333354",@"1236645",@"5488"],@"1000"]},
                    @{@"items":@[@"Deliers ",@[@"333354",@"1236645",@"5488"],@"1000"]}
                      
                      ]}];
    [self addToDataSource:arr[0] Index:6];
    
    
    arr = @[
     @{@"percent":@[@0.5,@0.3,@0.3,@0.6,@0.5,@0.9],@"items":@[@"comprehensive ability",@"economy ability",@"attack ability",@"cure ability",@"assistant ability",@"killer ability"],@"category":@"Alex"},
     @{@"percent":@[@0.5,@0.2,@0.8,@0.8,@0.5,@0.8],@"items":@[@"comprehensive ability",@"economy ability",@"attack ability",@"cure ability",@"assistant ability",@"killer ability"],@"category":@" Lina Inverse"}
    ];
    [self addToDataSource:arr Index:7];
    
    
    
    arr = @[
            @{@"yLeftAxisScaleDatas":@[@-350000,@0,@50000,@100000,@150000,@200000,@350000],
              @"barChartMs":@[
                      @{@"number":@160000,@"number3":@110000,@"number2":@-208000, @"lineNumber":@-10555,@"name":@"January"},
                      @{@"number":@202300,@"number3":@142000,@"number2":@290000,@"lineNumber":@-25555,@"name":@"Febury"},
                      @{@"number":@230000,@"number3":@200050,@"number2":@-280000,@"lineNumber":@10555,@"name":@"March"},
                      @{@"number":@203000,@"number3":@260000,@"number2":@170000,@"lineNumber":@-10555,@"name":@"April"},
                      @{@"number":@205000,@"number3":@210000,@"number2":@-280000,@"lineNumber":@-2555,@"name":@"May"},
                      @{@"number":@280340,@"number3":@210000,@"number2":@-200000,@"lineNumber":@5555,@"name":@"June"},
                      @{@"number":@250000,@"number3":@210000,@"number2":@-150000,@"lineNumber":@65555,@"name":@"July"},
                      @{@"number":@250000,@"number3":@190000,@"number2":@-150000,@"lineNumber":@-30555,@"name":@"Auguest"},
                      @{@"number":@180000,@"number3":@210000,@"number2":@180000,@"lineNumber":@-10555,@"name":@"Sep"},
                      @{@"number":@200000,@"number3":@150000,@"number2":@-110000,@"lineNumber":@82000,@"name":@"October"},
                      @{@"number":@230000,@"number3":@250000,@"number2":@110000,@"lineNumber":@-20555,@"name":@"November"},
                      @{@"number":@230000,@"number3":@250000,@"number2":@-110000,@"lineNumber":@6055,@"name":@"December"}]}
            ];
    [self addToDataSource:arr[0] Index:8];
    
}

-(NSArray *)chartClasses
{
    return @[
            [XLPieChart class],
            [XLPieChart class],
            [XLQuadrantChart class],
            [XLBarChart class],
           
            [XLBarChart class],
            [XLTableChart class],
            [XLTableChart class],
            [XLRadarChart class],
            [XLBarChart class],
            ];
}

-(NSArray *)types
{
    return @[@"right",
             @"horizontal",
             @"right",
             @"up",
             @"right",
             @"",
             @"",
             @"",
             @"up"
             ];
}

-(void)addToDataSource:(NSArray*)responseObj Index:(NSInteger)index
{
    Class           class;
    id              obj;
    
    if (!responseObj) return;
    class = self.chartClasses[index];
    if (class) {
        if (class == [XLBarChart class]) {
            [XLBarLineChartMs mj_setupObjectClassInArray:^NSDictionary *{
                return @{
                         @"barChartMs":@"XLBarLineChartM"
                         };
            }];
            obj = [XLBarLineChartMs mj_objectWithKeyValues:responseObj];
            [self.dataSource addObject:@[obj]];
        } else if(class == [XLTableChart class]){
            [XLTableCellMs mj_setupObjectClassInArray:^NSDictionary *{
                return @{
                         @"tableCellMs":@"XLTableCellM"
                         };
            }];
            obj = [XLTableCellMs mj_objectWithKeyValues:responseObj];
            [self.dataSource addObject:@[obj]];
        }else if(class == [XLRadarChart class]){
            obj = [XLRadarM mj_objectArrayWithKeyValuesArray:responseObj];
            [self.dataSource addObject:obj];
        }else if(class == [XLPieChart class]){
         
             obj = [XLPieChartM mj_objectArrayWithKeyValuesArray:responseObj];
            [self.dataSource addObject:obj];
        }else if(class == [XLQuadrantChart class]){
            [XLQuadrantMS mj_setupObjectClassInArray:^NSDictionary *{
                return @{
                         @"quadrantMs":@"XLQuadrantM"
                         };
            }];
            obj = [XLQuadrantMS mj_objectWithKeyValues:responseObj[0]];
            [self.dataSource addObject:@[obj]];
        }else if(class == [XLTimeLineChart class]){
            [XLTimeLineMs mj_setupObjectClassInArray:^NSDictionary *{
                return @{
                         @"timeLineMs":@"XLTimeLineM"
                         };
            }];
            obj = [XLTimeLineMs mj_objectWithKeyValues:responseObj];
            [self.dataSource addObject:@[obj]];
        }
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.chartClasses.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  
    EBarChartType           barChartType;
    PieChartType            pieChartType;
    XLBaseChart*            contentChart;
   
    MainFoldingCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    barChartType = barChartType_DirectionRight;
    id obj = self.chartClasses[indexPath.row];
    if(obj == [XLBarChart class])
    {
        if ([self.types[indexPath.row] isEqualToString:kBarChartDirectionRight]) barChartType = barChartType_DirectionRight;
        else barChartType = barChartType_DirectionUp;
        contentChart = [[XLBarChart alloc]initWithFrame:CGRectMake(0, 0, cell.width, kScreenHeight/2) type:barChartType zoomType:ChartZoomTypeNormal];
    }
    else if(obj == [XLPieChart class]){
        
        if ([self.types[indexPath.row] isEqualToString:@"horizontal"]) pieChartType = PieChartType_TitleRectHorizontal;
        else pieChartType = PieChartType_TitleRectVertical;
        contentChart =[[XLPieChart alloc]initWithFrame:CGRectMake(0, 0 ,cell.width , kScreenHeight/2) zoomType:ChartZoomTypeNormal pieChartType:pieChartType];
    }
    else
    {
        contentChart = [[(Class)obj alloc]initWithFrame:CGRectMake(0, 0, cell.width, kScreenHeight/2) zoomType:ChartZoomTypeNormal];
    }
    /*titleRectKey = [NSNumber numberWithInteger:indexPath.row];
     if ([[self.titleRectangleDic allKeys] containsObject:titleRectKey]) {
     titleRectangles = [self.titleRectangleDic objectForKey:titleRectKey];
     if (titleRectangles) {
     [foreBaseChart setValue:titleRectangles forKey:@"titlRectDataSource"];
     [contentChart setValue:titleRectangles forKey:@"titlRectDataSource"];
     }
     }*/
    
    [contentChart setValue:self.dataSource[indexPath.row] forKey:@"dataSource"];
    contentChart.userInteractionEnabled = YES;
    [cell.contentView addSubview:contentChart];

    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kScreenHeight/2;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
