//
//  NetworkManager.m
//  UberBean
//
//  Created by Frank Chen on 2019-05-17.
//  Copyright © 2019 Frank Chen. All rights reserved.
//

#import "NetworkManager.h"

@implementation NetworkManager

- (instancetype)init
{
    self = [super init];
    if (self) {
        _json = [[NSDictionary alloc]init];
    }
    return self;
}

-(void)requestYelp:(CLLocation*)location withApiKey:(NSString*)apiKey withCompletionHandler:(void(^)(NSDictionary*json))completionHandler{
    
    NSNumber* tempLat = [[NSNumber alloc]initWithDouble:location.coordinate.latitude];
    NSNumber* tempLon = [[NSNumber alloc]initWithDouble:location.coordinate.longitude];
    
    NSString* urlString = [NSString stringWithFormat:@"https://api.yelp.com/v3/businesses/search?term=cafe&latitude=%@&longitude=%@",tempLat,tempLon];
    NSURL* url = [NSURL URLWithString:urlString];
    
    NSMutableURLRequest* urlRequest = [NSMutableURLRequest requestWithURL:url];
    
    [urlRequest addValue:[NSString stringWithFormat:@"Bearer %@",apiKey] forHTTPHeaderField:@"Authorization"];
    
    NSURLSession* session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    NSURLSessionDataTask* dataTask = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error != nil) {
            NSLog(@"session error :%@",error.localizedDescription);
            return;
        }
        
        NSError* jsonError = nil;
        NSDictionary* cafes = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
        
        if (jsonError) { // 3
            // Handle the error
            NSLog(@"jsonError: %@", jsonError.localizedDescription);
            return;
        }
        
        completionHandler(cafes);
        
        
    }];
    
    [dataTask resume];
}

@end
