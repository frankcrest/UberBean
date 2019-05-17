//
//  NetworkManager.h
//  UberBean
//
//  Created by Frank Chen on 2019-05-17.
//  Copyright © 2019 Frank Chen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NetworkManager : NSObject

-(void)requestYelp:(CLLocation*)location withApiKey:(NSString*)apiKey withCompletionHandler:(void(^)(NSDictionary* json))completionHandler;

@property(nonatomic,strong)NSDictionary* json;

@end

NS_ASSUME_NONNULL_END
