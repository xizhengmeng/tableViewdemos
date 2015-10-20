//
//  ViewController.m
//  tableview的代理的进阶使用
//
//  Created by shenghuihan on 15/10/20.
//  Copyright © 2015年 shenghuihan. All rights reserved.
//

#import "ViewController.h"
#import "UITableViewAdapter.h"

@interface ViewController ()<UITableViewAdapterDeleagte,UITableViewAdapterDataSoure>
/**adapter*/
@property (nonatomic, strong) UITableViewAdapter *adapter;
/**数组 */
@property (nonatomic, strong) NSArray *arr;
@end

@implementation ViewController

/**ar
 */
- (NSArray *)arr {
    if (_arr == nil) {
       
        NSMutableArray *mutableArr = [NSMutableArray array];
        for ( int i = 0; i < 100; i++) {
            [mutableArr addObject:[NSString stringWithFormat:@"%d", i]];
        }
        _arr = [NSArray arrayWithArray:mutableArr];
    }
    return _arr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.adapter = [[UITableViewAdapter alloc] initWithAddedViewController:self];
    
    self.adapter.adapterDatasource = self;
    self.adapter.adapterDelegate = self;
    
    [self.adapter updataArrWithArr:self.arr];
    
}

#pragma mark - UITableViewAdapterDeleagte



#pragma mark - UITableViewAdapterDataSoure
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *ID = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"
                ];
    }
    
    cell.textLabel.text = self.arr[indexPath.row];
    
    return cell;

}


@end
