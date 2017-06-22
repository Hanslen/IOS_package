//
//  Status.h
//  AFNetworkingTutorial
//
//  Created by Hanslen Chen on 2017/6/21.
//  Copyright © 2017年 Jiahe Chen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
@interface Status : NSObject
/** 微博文本内容 */
@property (copy, nonatomic) NSString *text;
/** 微博作者 */
@property (strong, nonatomic) User *user;
/** 转发的微博 */
@property (strong, nonatomic) Status *retweetedStatus;
@end
