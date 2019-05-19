//
//  CustomImageView.h
//  UberBean
//
//  Created by Frank Chen on 2019-05-19.
//  Copyright © 2019 Frank Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CustomImageView : UIImageView

-(void)loadImageFromWeb:(NSURL*)url;

@end

NS_ASSUME_NONNULL_END
