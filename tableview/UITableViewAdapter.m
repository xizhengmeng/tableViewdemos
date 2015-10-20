//
//  UITableViewAdapter.m
//  tableview的代理的进阶使用
//
//  Created by shenghuihan on 15/10/20.
//  Copyright © 2015年 shenghuihan. All rights reserved.
//  一次性插入两个cell
// 利用数组记录哪个indexpath是插入的，然后到了那个cell再加载其他的


#import "UITableViewAdapter.h"

@interface UITableViewAdapter()<UITableViewDelegate,UITableViewDataSource>
/**tableView*/
@property (nonatomic, strong)  UITableView *tableView;
/**传入的数组*/
@property (nonatomic, strong) NSMutableArray *showArr;

/**isShowMemu*/
@property (nonatomic, assign) BOOL isShowMenu;

/**indexPath*/
@property (nonatomic, strong) NSIndexPath *TheSelectedIndexpath;

/**special*/
@property (nonatomic, assign) BOOL isSpecial;

/**1arr*/
@property (nonatomic, strong) NSMutableArray *arr1;

/**arr2*/
@property (nonatomic, strong) NSMutableArray *arr2;

@end

@implementation UITableViewAdapter
- (NSMutableArray *)arr1 {
    if (!_arr1) {
        _arr1 = [NSMutableArray array];
    }
    return _arr1;
}

- (NSMutableArray *)arr2 {
    if (!_arr2) {
        _arr2 = [NSMutableArray array];
    }
    return _arr2;
}

static NSInteger count1 = 2;//点击cell增加几个cell
static NSInteger count2 = 2;//点击出现的cell增加几个cell
#pragma mark - lazy load
/**tableView*/
- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];;
    }
    return _tableView;
}

/**showArr*/
- (NSMutableArray *)showArr {
    if (_showArr == nil) {
        _showArr = [NSMutableArray array];
    }
    return _showArr;
}

- (instancetype)initWithAddedViewController:(UIViewController *)VC {
    if (self = [super init]) {
        
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        [VC.view addSubview:self.tableView];
        self.isSpecial = NO;
        
    }
    return self;
}

#pragma mark － tableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (self.isShowMenu) {
        NSInteger count = self.showArr.count;
        
        count = count + count1;
        
        if (self.isSpecial) {
            count = count + count2;
        }
        
        return count;
    }
    
    return self.showArr.count;
}

- (void)updataArrWithArr:(NSArray *)arr {
    [self.showArr addObjectsFromArray:arr];
   
}

#pragma mark - tableView dataSoure
static NSInteger count = 0;
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = nil;
    
    if ([self.arr1 containsObject:indexPath] || [self.arr2 containsObject:indexPath]){
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"123"];
        count ++;
        cell.textLabel.text = [NSString stringWithFormat:@"%ld", count];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.tag = count;
        if (cell.tag != count1) {
            cell.userInteractionEnabled = NO;
        }
    }else {
        if ([self.adapterDatasource respondsToSelector:@selector(tableView:cellForRowAtIndexPath:)]) {
            cell = [self.adapterDatasource tableView:tableView cellForRowAtIndexPath:indexPath];
        }

    }

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //如果现在是显示menu的状态
    if (self.isShowMenu) {
        
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        
        if (cell.tag == count1) {

            if (!self.isSpecial) {
                [self insertTheTableViewL:indexPath];
            }else {
                [self removeTheTableViewL:indexPath];
            }
            
        } else {
            
            if (self.TheSelectedIndexpath == indexPath) {
                
                if (self.isSpecial) {
                    [self removeTheTableViewL:[NSIndexPath indexPathForRow:indexPath.row + 2 + count2 inSection:0]];
                }
                
                [self removeTheTableView:indexPath];
            } else {
                
                NSIndexPath *indexPathInsert;
                
                if (indexPath.row > self.TheSelectedIndexpath.row) {
                    
                    [self removeTheTableView:self.TheSelectedIndexpath];
                    
                    indexPathInsert = [NSIndexPath indexPathForRow:indexPath.row - count1 inSection:0];
                } else {
                    
                    [self removeTheTableView:self.TheSelectedIndexpath];
                    
                    indexPathInsert = indexPath;
                }
                
                [self insertTheTableView:indexPathInsert];
            }

        }
        
    //如果不是显示menu的状态就直接插入就好了
    } else {

        [self insertTheTableView:indexPath];
    }
    
}

#pragma mark - priate method
//主要是控制，插入多少，在那几个位置插入
- (void)insertTheTableView:(NSIndexPath *)indexPath {
    
    NSMutableArray *arr = [NSMutableArray array];
    
    NSInteger countL;
    
    countL = count1;
    self.TheSelectedIndexpath = indexPath;
    
    for (int i = 1; i < countL + 1; i++) {
        
        NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:indexPath.row + i inSection:0];
        [arr addObject:newIndexPath];
    }
    
    [self.arr1 addObjectsFromArray:arr];
    
    self.isShowMenu = YES;
    
    [self.tableView beginUpdates];
    
    [self.tableView insertRowsAtIndexPaths:arr withRowAnimation:UITableViewRowAnimationFade];

    [self.tableView endUpdates];
    
}

- (void)removeTheTableView:(NSIndexPath *)indexPath {
    
    count = 0;
    
    self.TheSelectedIndexpath = nil;
   
    NSMutableArray *arr = [NSMutableArray array];
    
    NSInteger countL;
    
    countL = count1;
    self.TheSelectedIndexpath = indexPath;
    self.isShowMenu = NO;
    
    for (int i = 1; i < countL + 1; i++) {
        
        NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:indexPath.row + i inSection:0];
        [arr addObject:newIndexPath];
    }
    
    [self.arr1 removeAllObjects];
    
    [self.tableView beginUpdates];
    
    [self.tableView deleteRowsAtIndexPaths:arr withRowAnimation:UITableViewRowAnimationFade];

    [self.tableView endUpdates];
}

- (void)insertTheTableViewL:(NSIndexPath *)indexPath {
    
    NSMutableArray *arr = [NSMutableArray array];
    
    NSInteger countL;
    
    countL = count2;
    
    for (int i = 0; i < countL; i++) {
        
        NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:indexPath.row + i inSection:0];
        [arr addObject:newIndexPath];
    }
    
    [self.arr2 addObjectsFromArray:arr];
    
    self.isSpecial = YES;
    
    [self.tableView beginUpdates];
    
    [self.tableView insertRowsAtIndexPaths:arr withRowAnimation:UITableViewRowAnimationFade];
    
    [self.tableView endUpdates];
    
}

- (void)removeTheTableViewL:(NSIndexPath *)indexPath {
    
    NSMutableArray *arr = [NSMutableArray array];
    
    NSInteger countL;
    
    countL = count2;
    
    for (NSInteger i = countL; i > 0; i--) {
        
        NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:indexPath.row - i inSection:0];
        [arr addObject:newIndexPath];
    }
    
    [self.arr2 removeAllObjects];
    
    self.isSpecial = NO;
    [self.tableView beginUpdates];
    
    [self.tableView deleteRowsAtIndexPaths:arr withRowAnimation:UITableViewRowAnimationFade];
    
    [self.tableView endUpdates];
}

@end
