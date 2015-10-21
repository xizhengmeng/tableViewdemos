//
//  ViewController.m
//  点击cell，然后在他下边插入一个不变的cell
//
//  Created by shenghuihan on 15/10/21.
//  Copyright © 2015年 shenghuihan. All rights reserved.
//

#import "ViewController.h"
#import "shuzuModal.h"
#import "HSTableView.h"

@interface ViewController ()<HSTableViewDelegate,HSTableViewDatasource>
/**数组*/
@property (nonatomic, strong) NSMutableArray *arr;

/**tableview*/
@property (nonatomic, strong) HSTableView *tableView;

/**selectedIndex*/
@property (nonatomic, strong) NSIndexPath *selectedIndexpath;
/**插入的cell的indexpath的数组*/
@property (nonatomic, strong) NSMutableArray *insertArr;

/**arrIndexPath*/
@property (nonatomic, strong) NSIndexPath *arrIndexPath;

@end

@implementation ViewController

/**tableView*/
- (HSTableView *)tableView {
    if (_tableView== nil) {
        _tableView = [[HSTableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    }
    return _tableView;
}

/**arr*/
- (NSMutableArray *)arr {
    if (_arr == nil) {

        NSArray *arr1 = [NSArray arrayWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"shuzu.plist" ofType:nil]];
        NSMutableArray *arr2 = [NSMutableArray array];
        for (NSDictionary *dic in arr1) {
            shuzuModal *modal = [shuzuModal shuzuModalWithDictionary:dic];
            [arr2 addObject:modal];
        }
        _arr = [NSMutableArray arrayWithArray:arr2];
        
    }
    
    return _arr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
    
    self.tableView.hsDelegate = self;
    self.tableView.hsDatasource = self;
}

#pragma mark - delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arr.count;
}

- (NSInteger)getNumberofsubArr:(NSIndexPath *)indexpath {
    
    shuzuModal *shuzuModal = self.arr[indexpath.row];
    
    return shuzuModal.info.count;
}

- (void)changeSelectedIndexPath:(NSIndexPath *)indexpath withInsertArr:(NSMutableArray *)insertArr{
    self.selectedIndexpath = indexpath;
    self.insertArr = insertArr;
    //每次切换selectedIndexpath就把这个数值变为零
    count = 0;
}

- (void)changeArrIndexPath:(NSIndexPath *)indexPath {
    self.arrIndexPath = indexPath;
}

#pragma mark - datasource
NSInteger count = 0;
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *ID = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    shuzuModal *shuzuModal;
    
    NSInteger countc =  0;
    if (self.selectedIndexpath) {
        if ([self.insertArr containsObject:indexPath]) {
            
            shuzuModal = self.arr[self.arrIndexPath.row];
            
            NSArray *arr = shuzuModal.info;
            
            cell.textLabel.text = arr[count];
            cell.textLabel.textAlignment = NSTextAlignmentCenter;
            NSLog(@"+++%@,%ld", arr[count], count);
            count ++;
            //这里会有一个bug，就是，当你点开了cell，但是并没有完全显示，这个时候，就回错误，所以要在且混啊selectedcell的时候将这个变量再次变为零
            if (count == arr.count) {
                count = 0;
            }
            return cell;
        }
        
        if (indexPath > self.selectedIndexpath) {
            
            countc = self.insertArr.count;
        } else {
            countc = 0;
        }
    }
    
    
    
    shuzuModal = self.arr[indexPath.row - countc];
    
    cell.textLabel.text = shuzuModal.name;
    cell.textLabel.textAlignment = NSTextAlignmentLeft;
    
    return cell;
}

@end
