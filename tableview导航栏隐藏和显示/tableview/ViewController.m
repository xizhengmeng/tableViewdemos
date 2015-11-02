//
//  ViewController.m
//  tableview
//
//  Created by han on 15/10/31.
//  Copyright © 2015年 han. All rights reserved.
//

#import "ViewController.h"
#import "One.h"
#import "UINavigationController+Extension.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
/**tableview*/
@property (nonatomic, strong) UITableView *tableView;
/**view*/
@property (nonatomic, strong) UIView *headerView;
/**Image*/
@property (nonatomic, strong) UIImageView *imageView;
/**backView*/
@property (nonatomic, strong) UIView *barBackgroundView;

/**backgroud*/
@property (nonatomic, strong) UIView *backGroundView;

@end

@implementation ViewController

- (UIView *)headerView {
    if (!_headerView) {
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 150)];
        _headerView.backgroundColor = [UIColor blueColor];
        NSLog(@"---%f", _headerView.frame.size.height);
        [_headerView addSubview:self.imageView];
    }
    return _headerView;
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"liu1"]];
        _imageView.frame = CGRectMake(0, -64, [UIScreen mainScreen].bounds.size.width, 214) ;
        _imageView.contentMode = UIViewContentModeScaleToFill;
    }
    return _imageView;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
    
    self.tableView.tableHeaderView = self.headerView;
    
//    self.navigationItem.title = @"哈哈哈哈";
    NSLog(@"%@", self.navigationItem.title);
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"123" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn sizeToFit];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];

    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, -20, [UIScreen mainScreen].bounds.size.width, 20)];
    
    self.barBackgroundView = view;    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    for (UIView *view in self.navigationController.navigationBar.subviews) {
        if ([view isKindOfClass:NSClassFromString(@"_UINavigationBarBackground")]) {
            
            self.backGroundView = view;
            [view removeFromSuperview];
            
        }
    }
    
    [self.navigationController.navigationBar addSubview:self.barBackgroundView];

}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
   [self.navigationController.navigationBar insertSubview:self.backGroundView atIndex:0];
    [self.barBackgroundView removeFromSuperview];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
     NSLog(@"%@", self.navigationItem.title);
}
#pragma mark - delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 100;
}
#pragma mark - datasource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%ld", indexPath.row];
    
    return cell;
}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//
//}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UITableViewCell *)view forSection:(NSInteger)section {
    view.contentView.backgroundColor = [UIColor orangeColor];
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"爱你";
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    One *one = [[One alloc] init];
    [self.navigationController hs_pushViewController:one animated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offSetY = scrollView.contentOffset.y;
    
    if (offSetY < -64) {
        CGFloat y = -(offSetY + 64);
        CGRect frame = self.imageView.frame;
        frame.origin.y = offSetY;
        frame.origin.x = -y/2;
        frame.size.height = 214 + y;
        frame.size.width = [UIScreen mainScreen].bounds.size.width + y;
        self.imageView.frame = frame;
//        self.navigationController.navigationBar.backgroundColor = [UIColor colorWithRed:y/100 green:arc4random_uniform(100)/100 blue:arc4random_uniform(100)/100 alpha:1];
        
        
    }
    CGFloat al = offSetY / 64;
//    CGFloat r = arc4random_uniform(100)/100.0;
//    CGFloat g = arc4random_uniform(100)/100.0;
//    CGFloat b = arc4random_uniform(100)/100.0;
//
//    self.barBackgroundView.backgroundColor = [UIColor colorWithRed:r green:g blue:b alpha:0.2];
//    self.navigationController.navigationBar.backgroundColor = [UIColor colorWithRed:r green:g blue:b alpha:0.2];

    
    self.navigationController.navigationBar.backgroundColor = [UIColor colorWithRed:0.7 green:0.1 blue:0.3 alpha:al];
    self.barBackgroundView.backgroundColor = [UIColor colorWithRed:0.7 green:0.1 blue:0.3 alpha:al];
    self.navigationItem.title = @"456322";
}
@end
