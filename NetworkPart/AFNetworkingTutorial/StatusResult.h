//
//  StatusResult.h
//  AFNetworkingTutorial
//
//  Created by Hanslen Chen on 2017/6/21.
//  Copyright © 2017年 Jiahe Chen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StatusResult : NSObject
/** 存放着一堆的微博数据（里面都是Status模型） */
@property (strong, nonatomic) NSMutableArray *statuses;
/** 存放着一堆的广告数据（里面都是Ad模型） */
@property (strong, nonatomic) NSArray *ads;
@property (strong, nonatomic) NSNumber *totalNumber;
@end
