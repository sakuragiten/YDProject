//
//  NSMutableArray+RAC.m
//  YDProject_Example
//
//  Created by Simon Koog on 2023/2/7.
//  Copyright © 2023 387970107@qq.com. All rights reserved.
//

#import "NSMutableArray+RAC.h"

@implementation NSMutableArray (RAC)



- (RACSignal *)rac_elementSignal {
    @weakify(self)
    return [[[RACSignal
             defer:^RACSignal *{
                @strongify(self)
                return [RACSignal return:self];
            }]
            merge:[RACSignal
                   merge:@[
//                            [self rac_signalForSelector:@selector(addObject:)],
                            [self rac_signalForSelector:@selector(addObjectsFromArray:)],
                            [self rac_signalForSelector:@selector(insertObject:atIndex:)],
//                            [self rac_signalForSelector:@selector(insertObjects:atIndexes:)],
                            [self rac_signalForSelector:@selector(removeAllObjects)],
//                            [self rac_signalForSelector:@selector(removeLastObject)],
//                            [self rac_signalForSelector:@selector(removeObject:)],
                            [self rac_signalForSelector:@selector(removeObjectAtIndex:)],
//                            [self rac_signalForSelector:@selector(removeObjectsInArray:)],
//                            [self rac_signalForSelector:@selector(removeObjectsAtIndexes:)],
//                            [self rac_signalForSelector:@selector(removeObjectsInRange:)]
                        ]
                  ]
            ]
            map:^id(id value) {
                @strongify(self)
                return [NSNumber numberWithInteger:self.count];
            }];
}


@end
