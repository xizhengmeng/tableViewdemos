//
//  UITableViewAdapter.h
//  tableview的代理的进阶使用
//
//  Created by shenghuihan on 15/10/20.
//  Copyright © 2015年 shenghuihan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@protocol UITableViewAdapterDeleagte <NSObject>



@end

@protocol UITableViewAdapterDataSoure <NSObject>
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
@end


@interface UITableViewAdapter : NSObject
- (instancetype)initWithAddedViewController:(UIViewController *)VC;
- (void)updataArrWithArr:(NSArray *)arr;
/**delegate*/
@property (nonatomic, weak) id<UITableViewAdapterDeleagte> adapterDelegate;
/**datasource*/
@property (nonatomic, weak) id<UITableViewAdapterDataSoure> adapterDatasource;

@end
