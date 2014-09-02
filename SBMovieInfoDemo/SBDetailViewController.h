//
//  SBDetailViewController.h
//  SBMovieInfoDemo
//
//  Created by shim on 2014-09-01.
//  Copyright (c) 2014 Bupkis. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RTMovieResult;
@interface SBDetailViewController : UIViewController
@property (nonatomic,strong) RTMovieResult* movie;
@end
