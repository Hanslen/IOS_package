//
//  User.h
//  AFNetworkingTutorial
//
//  Created by Hanslen Chen on 2017/6/21.
//  Copyright © 2017年 Jiahe Chen. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum {
    SexMale,
    SexFemale} Sex;
@interface User : NSObject
@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *icon;
@property (assign, nonatomic) int age;
@property (assign, nonatomic) double height;
@property (strong, nonatomic) NSNumber *money;
@property (assign, nonatomic) Sex sex;
@property (strong, nonatomic) User* partner;
@end


@interface Ad : NSObject
@property (copy, nonatomic) NSString *image;
@property (copy, nonatomic) NSString *url;
@end
