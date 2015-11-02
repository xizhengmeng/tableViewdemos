
//
//  HSViewController.m
//  tableview
//
//  Created by han on 15/11/1.
//  Copyright © 2015年 han. All rights reserved.
//

#import "HSViewController.h"
#import "ViewController.h"
#import "UINavigationController+Extension.h"

@implementation HSViewController

- (instancetype)init {
    if (self = [super init]) {
        self.view.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    ViewController *vc = [[ViewController alloc] init];
    [self.navigationController hs_pushViewController:vc animated:YES];
}
@end
