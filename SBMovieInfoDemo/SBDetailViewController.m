//
//  SBDetailViewController.m
//  SBMovieInfoDemo
//
//  Created by shim on 2014-09-01.
//  Copyright (c) 2014 Bupkis. All rights reserved.
//

#import "SBDetailViewController.h"
#import "RTMovieResult.h"
#import "UIImageView+AFNetworking.h"

@interface SBDetailViewController ()
@property (nonatomic,weak) IBOutlet UILabel* name;
@property (nonatomic,weak) IBOutlet UILabel* year;
@property (weak, nonatomic) IBOutlet UITextView *synopsis;
@property (nonatomic,weak) IBOutlet UIImageView* thumbnail;
@property (nonatomic,weak) IBOutlet UILabel* criticsScore;
@property (nonatomic,weak) IBOutlet UILabel* audienceScore;

@end

@implementation SBDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.name.text = self.movie.name;
    self.year.text = [NSString stringWithFormat:@"%d",self.movie.year];
    self.synopsis.text = self.movie.synopsis;
    self.criticsScore.text = [NSString stringWithFormat:@"%d%%",self.movie.criticsScore];
    self.audienceScore.text = [NSString stringWithFormat:@"%d%%",self.movie.audienceScore];
    [self.thumbnail setImageWithURL:self.movie.posterThumbnailURL];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
