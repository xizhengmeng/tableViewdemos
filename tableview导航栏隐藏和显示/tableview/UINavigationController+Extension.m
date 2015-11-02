//
//  UINavigationController+Extension.m
//  tableview
//
//  Created by han on 15/11/1.
//  Copyright © 2015年 han. All rights reserved.
//

#import "UINavigationController+Extension.h"

@implementation UINavigationController (Extension)
- (void)hs_pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    [self pushViewController:viewController animated:animated];
    
//    self.navigationBar.backgroundColor = [UIColor grayColor];
}
@end
