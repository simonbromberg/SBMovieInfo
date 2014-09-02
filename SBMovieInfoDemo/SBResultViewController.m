//
//  SBResultViewController.m
//  SBMovieInfoDemo
//
//  Created by shim on 2014-09-01.
//  Copyright (c) 2014 Bupkis. All rights reserved.
//

#import "SBResultViewController.h"
#import "RTMovieResult.h"
#import "SBSegueIdentifiers.h"
#import "SBDetailViewController.h"
#import "SBMovieGetter.h"
#import "UIImageView+AFNetworking.h"

@interface SBResultViewController ()
@property (nonatomic,assign) NSInteger page;
@end

@implementation SBResultViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.page = kDefaultPageNumber;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.results.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString* const CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: CellIdentifier forIndexPath:indexPath];
    cell.imageView.image = nil;
    RTMovieResult* movie = [self movieForRow:indexPath.row];
    cell.textLabel.text = movie.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%d",movie.year];
//    NSURLRequest* request = [NSURLRequest requestWithURL:movie.posterThumbnailURL];
//    __weak UITableViewCell* blockCell = cell;
//    [cell.imageView setImageWithURLRequest:request placeholderImage:[UIImage new] success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
//        if (blockCell) {
//            blockCell.imageView.image = image;
////            NSArray* indexPaths = [NSArray arrayWithObjects: indexPath, nil];
////            [tableView reloadRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationNone];
//        }
//    } failure:nil ];
    return cell;
}

-(RTMovieResult*) movieForRow: (NSInteger) row {
    return [RTMovieResult movieWithDictionary: self.results[row]];
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:SegueResultToDetail]) {
        SBDetailViewController* detail = segue.destinationViewController;
        detail.movie = [self movieForRow:[self.tableView indexPathForSelectedRow].row];
    }
}
- (IBAction)loadMoreTapped {
    self.page++;
    [SBMovieGetter getMoviesForString:self.search limit:kDefaultPageLimit page:self.page completion:^(NSArray *results) {
        if (results.count > 0) {
            NSMutableArray* temp = [NSMutableArray arrayWithArray:self.results];
            [temp addObjectsFromArray:results];
            
            self.results = temp;
            [self.tableView reloadData];
        }
    }];
}

@end
