//
//  SBMovieGetter.m
//  SBMovieInfoDemo
//
//  Created by shim on 2014-08-31.
//  Copyright (c) 2014 Bupkis. All rights reserved.
//

#import "SBMovieGetter.h"
#import "AFNetworking.h"
#import "RTKey.h"

static NSString* const SearchMovieURL = @"http://api.rottentomatoes.com/api/public/v1.0/movies.json";
NSInteger const kDefaultPageLimit = 3;
NSInteger const kDefaultPageNumber = 1;
@implementation SBMovieGetter
+ (void) getMoviesForString: (NSString*) search completion: (void (^)(NSArray* results)) completion {
    [self getMoviesForString:search limit:kDefaultPageLimit page:kDefaultPageNumber completion:completion];
}

+ (void) getMoviesForString:(NSString *)search limit: (NSInteger) limit page: (NSInteger) page completion:(void (^)(NSArray * results))completion {
    
    NSString* urlFriendlyName = [search stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    urlFriendlyName = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL,(CFStringRef)urlFriendlyName,NULL,(CFStringRef)@"!*'();:@&=$,/?%#[]", kCFStringEncodingUTF8));
    
    AFHTTPRequestOperationManager* manager = [AFHTTPRequestOperationManager manager];
    NSString* requestURL = [NSString stringWithFormat:@"%@?q=%@&page_limit=%d&page=%d&apikey=%@",SearchMovieURL,urlFriendlyName,limit,page,RTKey];
    [manager GET:requestURL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray* results = responseObject[@"movies"];
        if (completion) {
            completion(results);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
        if (completion) {
            completion(nil);
        }
    }];
}

@end
