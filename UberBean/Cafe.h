//
//  Cafe.h
//  UberBean
//
//  Created by Frank Chen on 2019-05-17.
//  Copyright © 2019 Frank Chen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Cafe : NSObject<MKAnnotation>

@property (nonatomic,strong) NSString* name;
@property(nonatomic,strong) NSString* phone;
@property(nonatomic,strong) NSString* rating;
@property(nonatomic,strong)NSString* price;
@property(nonatomic,copy)NSString* title;
@property(nonatomic,readonly)CLLocationCoordinate2D coordinate;

-(instancetype)initWithName:(NSString*)name withPhone:(NSString*)phone withRating:(NSString*)rating withPrice:(NSString*)price withCoordinate:(CLLocationCoordinate2D)coordinate;

+(instancetype)parseJson:(NSDictionary*)json;

@end

NS_ASSUME_NONNULL_END
