//
//  StatusResult.m
//  AFNetworkingTutorial
//
//  Created by Hanslen Chen on 2017/6/21.
//  Copyright © 2017年 Jiahe Chen. All rights reserved.
//

#import "StatusResult.h"

@implementation StatusResult
+ (NSDictionary *)objectClassInArray{
    return @{
             @"statuses" : @"Status",
             @"ads" : @"Ad"
             };
}
@end
