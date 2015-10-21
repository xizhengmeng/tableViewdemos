//
//  HSTableView1.h
//  点击cell，然后在他下边插入一个不变的cell
//
//  Created by shenghuihan on 15/10/21.
//  Copyright © 2015年 shenghuihan. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HSTableViewDelegate <NSObject>
- (NSInteger)tableViewFloat1:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
- (NSInteger)tableViewFloat2:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
- (NSInteger)tableViewFloat3:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;

- (NSInteger)getNumberofsubArr:(NSIndexPath *)indexpath;
- (void)changeSelectedIndexPath:(NSIndexPath *)indexpath withInsertArr:(NSMutableArray *)insertArr;
- (void)changeArrIndexPath:(NSIndexPath *)indexPath;
@end

@protocol HSTableViewDatasource <NSObject>
- (UITableViewCell *)tableViewFloat1:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
- (UITableViewCell *)tableViewFLoat2:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
- (UITableViewCell *)tableViewFloat3:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
@end


@interface HSTableView : UITableView

/**delegate*/
@property (nonatomic, strong) id<HSTableViewDelegate> hsDelegate;

/**datasource*/
@property (nonatomic, strong) id<HSTableViewDatasource> hsDatasource;

@end
