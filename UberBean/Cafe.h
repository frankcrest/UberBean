//
//  Cafe.h
//  UberBean
//
//  Created by Frank Chen on 2019-05-17.
//  Copyright © 2019 Frank Chen. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Cafe : NSObject

@property (nonatomic,strong) NSString* name;
@property(nonatomic,strong) NSString* phone;
@property(nonatomic,strong) NSString* rating;
@property(nonatomic,strong)NSString* price;

-(instancetype)initWithName:(NSString*)name withPhone:(NSString*)phone withRating:(NSString*)rating withPrice:(NSString*)price;

+(instancetype)parseJson:(NSDictionary*)json;

@end

NS_ASSUME_NONNULL_END
