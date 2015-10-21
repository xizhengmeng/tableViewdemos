//
//  shuzuModal.h
//  点击cell，然后在他下边插入一个不变的cell
//
//  Created by shenghuihan on 15/10/21.
//  Copyright © 2015年 shenghuihan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface shuzuModal : NSObject
/**name*/
@property (nonatomic, strong) NSString *name;

/**arr*/
@property (nonatomic, strong) NSArray *info;

+ (shuzuModal *)shuzuModalWithDictionary:(NSDictionary *)dic;

@end
