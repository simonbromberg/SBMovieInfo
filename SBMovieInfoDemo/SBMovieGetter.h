//
//  SBMovieGetter.h
//  SBMovieInfoDemo
//
//  Created by shim on 2014-08-31.
//  Copyright (c) 2014 Bupkis. All rights reserved.
//

#import <Foundation/Foundation.h>
extern NSInteger const kDefaultPageLimit;
extern NSInteger const kDefaultPageNumber;
@interface SBMovieGetter : NSObject
+ (void) getMoviesForString: (NSString*) search
                 completion: (void (^)(NSArray* results)) completion;

+ (void) getMoviesForString:(NSString *)search
                      limit: (NSInteger) limit
                       page: (NSInteger) page
                 completion:(void (^)(NSArray * results)) completion;
@end
