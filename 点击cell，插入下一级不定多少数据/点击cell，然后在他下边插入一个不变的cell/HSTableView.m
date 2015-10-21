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
@property (nonatomic, strong) NSIndexPath *selectedIndexpath;

/**插入的数组*/
@property (nonatomic, strong) NSMutableArray *insertArr;

/**indexpath*/
@property (nonatomic, strong) NSIndexPath *arrIndexPath;
@end

@implementation HSTableView

/**insertArr*/
- (NSMutableArray *)insertArr {
    if (_insertArr == nil) {
        _insertArr = [NSMutableArray array];
    }
    return _insertArr;
}

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
    
    if (self.selectedIndexpath) {
        count += [self.hsDelegate getNumberofsubArr:self.arrIndexPath];
    }
    
    count += [self.hsDelegate tableView:tableView numberOfRowsInSection:section];
    
    return count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([self.insertArr containsObject:indexPath]) {
        NSLog(@"包含");
        return;
    }
    
    //如果现在是展开状态,且点击的就是我这个展开的cell
    if (self.selectedIndexpath && self.selectedIndexpath == indexPath) {
        //删除＋清空selectedIndexpath＋清空数组
        self.selectedIndexpath = nil;
        [self deleteRowsAtIndexPaths:self.insertArr];
        [self.insertArr removeAllObjects];
    //如果是展开状态，但是点击的不是展开的这个cell
    }else if (self.selectedIndexpath) {
        //删除旧的，添加新的+切换selectedIndexpath＋切换数组
        NSInteger count = 0;
        
        if (indexPath.row > self.selectedIndexpath.row) {
            self.arrIndexPath = [NSIndexPath indexPathForRow:indexPath.row - self.insertArr.count inSection:0];
        } else {
            self.arrIndexPath = indexPath;
        }
        
        if ([self.hsDelegate respondsToSelector:@selector(getNumberofsubArr:)]) {
            count = [self.hsDelegate getNumberofsubArr:self.arrIndexPath];
        }
        
        //在这里做一个判断，因为点击在当前选中的cell之前和之后是不一样的
        NSIndexPath *newIndexPath;
        if (indexPath.row > self.selectedIndexpath.row) {
            newIndexPath = [NSIndexPath indexPathForRow:indexPath.row - count inSection:0];
        } else {
            newIndexPath = indexPath;
        }
        
        self.selectedIndexpath = nil;
        [self deleteRowsAtIndexPaths:self.insertArr];
        [self.insertArr removeAllObjects];
        
        for (int i = 1; i < count + 1; i++) {
            NSIndexPath *selectedIndexPath = [NSIndexPath indexPathForRow:newIndexPath.row + i inSection:0];
            [self.insertArr addObject:selectedIndexPath];
        }
        
        self.selectedIndexpath = indexPath;
        
        [self insertRowsAtIndexPaths:self.insertArr];
        
    //如果点击的都不是展开的这个cell
    }else {
        //添加+增加selectedIndexpath＋添加增加cell的indexpath的数组
        //我需要知道增加哪几个？
        //现在数组在外边，我根本不知道数组里边是个啥情况
        //我需要问问外边
        NSInteger count = 0;
        if ([self.hsDelegate respondsToSelector:@selector(getNumberofsubArr:)]) {
            count = [self.hsDelegate getNumberofsubArr:indexPath];
        }
        
        for (int i = 1; i < count + 1; i++) {
            NSIndexPath *selectedIndexPath = [NSIndexPath indexPathForRow:indexPath.row + i inSection:0];
            [self.insertArr addObject:selectedIndexPath];
        }
        
        self.selectedIndexpath = indexPath;
        self.arrIndexPath = indexPath;
        
        [self insertRowsAtIndexPaths:self.insertArr];
        
    }
}


#pragma mark - tableview datasource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = nil;
    
    cell = [self.hsDatasource tableView:tableView cellForRowAtIndexPath:indexPath];
    
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

#pragma mark - setter
//每次切换selectedIndexpath的内容，就通知代理一下
//这个动作相当于切换tableviewcell的number
- (void)setSelectedIndexpath:(NSIndexPath *)selectedIndexpath {
    _selectedIndexpath = selectedIndexpath;
    if ([self.hsDelegate respondsToSelector:@selector(changeSelectedIndexPath:withInsertArr:)]) {
        [self.hsDelegate changeSelectedIndexPath:selectedIndexpath withInsertArr:self.insertArr];
    }
}

- (void)setArrIndexPath:(NSIndexPath *)arrIndexPath {
    _arrIndexPath = arrIndexPath;
    if ([self.hsDelegate respondsToSelector:@selector(changeArrIndexPath:)]) {
        [self.hsDelegate changeArrIndexPath:arrIndexPath];
    }
}
@end
