//
//  Cafe.m
//  UberBean
//
//  Created by Frank Chen on 2019-05-17.
//  Copyright © 2019 Frank Chen. All rights reserved.
//

#import "Cafe.h"

@implementation Cafe

- (instancetype)initWithName:(NSString *)name withPhone:(NSString *)phone withRating:(NSString *)rating withPrice:(NSString *)price
{
    self = [super init];
    if (self) {
        _name = name;
        _phone = phone;
        _rating = rating;
        _price = price;
    }
    return self;
}

+(instancetype)parseJson:(NSDictionary*)json{
    return [[Cafe alloc]initWithName:json[@"name"] withPhone:json[@"phone"] withRating:json[@"rating"] withPrice:json[@"price"]];
}

@end
