//
//  HSTableView1.m
//  点击cell，然后在他下边插入一个不变的cell
//
//  Created by shenghuihan on 15/10/21.
//  Copyright © 2015年 shenghuihan. All rights reserved.
//

#import "HSTableView.h"

@interface HSTableView()<UITableViewDelegate,UITableViewDataSource>
/**点击了谁*/
@property (nonatomic, strong) NSIndexPath *selecteFloat1dIndexpath;
@property (nonatomic, strong) NSIndexPath *selecteFloat2dIndexpath;

/**插入的数组*/
@property (nonatomic, strong) NSMutableArray *insertFloat2Arr;
@property (nonatomic, strong) NSMutableArray *insertFloat3Arr;

/**indexpath*/
@property (nonatomic, strong) NSIndexPath *arrFloat1IndexPath;
@property (nonatomic, strong) NSIndexPath *arrFloat2IndexPath;
@end

@implementation HSTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        self.delegate = self;
        self.dataSource = self;
        self.estimatedRowHeight = 50;
        
    }
    return self;
}

#pragma mark - tableview delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSInteger count = 0;
    //判断要加几层个数
    if (self.selecteFloat1dIndexpath) {
        if (self.selecteFloat2dIndexpath) {
            count += [self.hsDelegate tableViewFloat3:tableView numberOfRowsInSection:0];
        }
        count += [self.hsDelegate tableViewFloat2:tableView numberOfRowsInSection:0];
    }
    count += [self.hsDelegate tableViewFloat1:tableView numberOfRowsInSection:0];
    return count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.selecteFloat1dIndexpath) {
        if (self.selecteFloat2dIndexpath) {
            if (self.selecteFloat2dIndexpath == indexPath) {
                //删除二级
                [self deleteRowsAtIndexPaths:self.insertFloat3Arr];
                [self.insertFloat3Arr removeAllObjects];
                self.selecteFloat2dIndexpath = nil;
            }else {
                //删除二级
                [self deleteRowsAtIndexPaths:self.insertFloat3Arr];
                [self.insertFloat3Arr removeAllObjects];
                self.selecteFloat2dIndexpath = nil;
                //展开新的二级
                self.selecteFloat2dIndexpath = indexPath;
                
                NSInteger count;
                
                NSIndexPath *newIndexPath;
                if (indexPath.row > self.selecteFloat2dIndexpath.row) {
                    newIndexPath = [NSIndexPath indexPathForRow:indexPath.row - count inSection:0];
                } else {
                    newIndexPath = indexPath;
                }
                
                for (int i = 1; i < count + 1; i++) {
                    NSIndexPath *selectedIndexPath = [NSIndexPath indexPathForRow:newIndexPath.row + i inSection:0];
                    [self.insertFloat3Arr addObject:selectedIndexPath];
                }
                
                [self insertRowsAtIndexPaths:self.insertFloat3Arr];
            }
        }else {
            //展开二级
        }
    } else {
        //直接插入
    }
   
}


#pragma mark - tableview datasource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = nil;
    
    
    return cell;
}

#pragma mark - private method
- (void)insertRowsAtIndexPaths:(NSArray *)indexPaths {
    
    [self beginUpdates];
    
    [self insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
    
    [self endUpdates];
}

- (void)deleteRowsAtIndexPaths:(NSArray *)indexPaths {
    
    [self beginUpdates];
    
    [self deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
    
    [self endUpdates];
}

- (void)clickTheshowCell:(NSIndexPath *)indexPath {
    
}

#pragma mark - setter
//每次切换selectedIndexpath的内容，就通知代理一下
//这个动作相当于切换tableviewcell的number
//- (void)setSelectedIndexpath:(NSIndexPath *)selectedIndexpath {
//    _selectedIndexpath = selectedIndexpath;
//    if ([self.hsDelegate respondsToSelector:@selector(changeSelectedIndexPath:withInsertArr:)]) {
//        [self.hsDelegate changeSelectedIndexPath:selectedIndexpath withInsertArr:self.insertArr];
//    }
//}
//
//- (void)setArrIndexPath:(NSIndexPath *)arrIndexPath {
//    _arrIndexPath = arrIndexPath;
//    if ([self.hsDelegate respondsToSelector:@selector(changeArrIndexPath:)]) {
//        [self.hsDelegate changeArrIndexPath:arrIndexPath];
//    }
//}
@end
