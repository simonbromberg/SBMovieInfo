//
//  SBViewController.m
//  SBMovieInfoDemo
//
//  Created by shim on 2014-08-31.
//  Copyright (c) 2014 Bupkis. All rights reserved.
//

#import "SBViewController.h"
#import "SBSegueIdentifiers.h"
#import "SBMovieGetter.h"
#import "SBResultViewController.h"
#import "SBDetailViewController.h"
#import "RTMovieResult.h"

enum Sections {
    kSearchBarSection,
    kSubmitButtonSection,
    NUM_SECTIONS
};

@interface SBViewController () <UITextFieldDelegate>
@property (nonatomic,weak) IBOutlet UITextField* searchField;
@property (nonatomic,strong) NSArray* results;
@end

@implementation SBViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
}

#pragma mark - Table View
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == kSubmitButtonSection) {
        if (self.searchField.text.length > 0) {
            [self doSearchOnFieldText];
        }
        else {
            [self alertNoText];
        }
    }
    if (indexPath.section == kSearchBarSection) {
        [self.searchField becomeFirstResponder];
    }
}

-(void) doSearchOnFieldText {
    [SBMovieGetter getMoviesForString:self.searchField.text completion:^(NSArray *results) {
        self.results = results;
        if (results.count == 0) {
            [self noResults];
        }
        else {
            NSString* segueToPerform = results.count == 1 ? SegueSearchToDetail : SegueSearchToResult;
            [self performSegueWithIdentifier:segueToPerform sender:nil];
        }
    }];
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSString* identifier = segue.identifier;
    if ([identifier isEqualToString:SegueSearchToResult]) {
        SBResultViewController* result = segue.destinationViewController;
        result.results = self.results;
        result.search = self.searchField.text;
    }
    if ([identifier isEqualToString:SegueSearchToDetail]) {
        SBDetailViewController* detail = segue.destinationViewController;
        detail.movie = [RTMovieResult movieWithDictionary:self.results[0]];
    }
}

-(void) noResults {
    [[[UIAlertView alloc] initWithTitle:@"No results" message:@"Try modifying your search" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
}

-(void) alertNoText {
    [[[UIAlertView alloc] initWithTitle:@"No text" message:@"Enter some text to search for a film" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
}

#pragma mark - Text Field
- (BOOL) textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    if (textField.text.length > 0) {
        [self doSearchOnFieldText];
        return YES;
    }
    else {
        [self alertNoText];
    }
    return NO;
}

@end
