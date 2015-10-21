//
//  shuzuModal.m
//  点击cell，然后在他下边插入一个不变的cell
//
//  Created by shenghuihan on 15/10/21.
//  Copyright © 2015年 shenghuihan. All rights reserved.
//

#import "shuzuModal.h"

@implementation shuzuModal
+ (shuzuModal *)shuzuModalWithDictionary:(NSDictionary *)dic {
    return [[shuzuModal alloc] initWithDic:dic];
}

- (instancetype)initWithDic:(NSDictionary *)dic {
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}
@end
