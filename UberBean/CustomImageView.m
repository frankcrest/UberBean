//
//  CustomImageView.m
//  UberBean
//
//  Created by Frank Chen on 2019-05-19.
//  Copyright © 2019 Frank Chen. All rights reserved.
//

#import "CustomImageView.h"

@implementation CustomImageView

-(void)loadImageFromWeb:(NSURL*)url{
    
    if (self.image == nil) {
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration]; // 2
        NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration]; // 3
        
        NSURLSessionDownloadTask *downloadTask = [session downloadTaskWithURL:url completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            
            if (error) {
                NSLog(@"error: %@", error.localizedDescription);
                return;
            }
            
            NSData* data = [NSData dataWithContentsOfURL:location];
            UIImage* image = [UIImage imageWithData:data];
            
            [[NSOperationQueue mainQueue]addOperationWithBlock:^{
                self.image = image;
            }];
            
        }]; // 4
        
        [downloadTask resume]; // 5
    }
}

@end
