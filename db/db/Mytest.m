//
//  Mytest.m
//  db
//
//  Created by ekhome on 16/12/21.
//  Copyright © 2016年 xiaofei. All rights reserved.
//

#import "Mytest.h"

@implementation Mytest
- (NSString *)year {
    if(_year == nil) {
        _year = [[NSString alloc] init];
//        _year = @"2016";
    }
    return _year;
}

- (NSString *)month {
    if(_month == nil) {
        _month = [[NSString alloc] init];
        _month = @"12";
    }
    return _month;
}

- (NSString *)day {
    if(_day == nil) {
        _day = [[NSString alloc] init];
        _day = @"08";
    }
    return _day;
}

- (NSString *)houer {
    if(_houer == nil) {
        _houer = [[NSString alloc] init];
        _houer = @"15";
    }
    return _houer;
}

- (NSString *)min {
    if(_min == nil) {
        _min = [[NSString alloc] init];
        _min = @"30";
    }
    return _min;
}

- (NSString *)sex {
    if(_sex == nil) {
        _sex = [[NSString alloc] init];
        _sex  = @"57";
    }
    return _sex;
}

- (NSString *)M {
    if(_M == nil) {
        _M = [[NSString alloc] init];
        _M = @"21";
    }
    return _M;
}


- (NSString *)name {
    if(_name == nil) {
        _name = [[NSString alloc] init];
    }
    return _name;
}
- (NSString *)phone {
    if(_phone == nil) {
        _phone = [[NSString alloc] init];
    }
    return _phone;
}
@end
