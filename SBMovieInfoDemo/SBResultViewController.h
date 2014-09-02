//
//  SBResultViewController.h
//  SBMovieInfoDemo
//
//  Created by shim on 2014-09-01.
//  Copyright (c) 2014 Bupkis. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SBResultViewController : UITableViewController
@property (nonatomic,strong) NSArray* results;
@property (nonatomic,copy) NSString* search;
@end
