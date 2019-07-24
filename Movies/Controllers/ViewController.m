//
//  ViewController.m
//  Movies
//
//  Created by Alfonso  on 7/19/19.
//  Copyright © 2019 Alfonso . All rights reserved.
//

#import "ViewController.h"
#import "APIServices.h"
#import "MoviesDataSource.h"
#import "MovieTableDelegate.h"
#import "SearchDelegate.h"

@interface ViewController (){
    int page;
    NSString* query;
    int previousSearchPage;
    NSMutableArray* previousSearchData;
    bool inSearchResult;
}

@property (weak, nonatomic) IBOutlet UITableView *tableMovies;
@property (weak, nonatomic) IBOutlet MoviesDataSource *datasource;
@property (weak, nonatomic) IBOutlet MoviesTableDelegate *delegate;
@property (weak, nonatomic) IBOutlet SearchDelegate *searchDelegate;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableMovies.rowHeight = UITableViewAutomaticDimension;
    self.tableMovies.estimatedRowHeight = 100;
    
    [self setPaginationCallback];
    
    [self setSearchDelegateCallbacks];
    
    [self initialLoad];
}

- (void) setPaginationCallback{
    //load more results when the table requires them
    self.delegate.callback = ^{
        self->page++;
        [self getMovies:self->query page:self->page replaceCurrentData:false];
    };
}

- (void) setSearchDelegateCallbacks{
    //search results callback
    self.searchDelegate.callback = ^(NSString *text) {
        if(!self->inSearchResult){
            self->inSearchResult = true;
            self->previousSearchPage = self->page;
            self->previousSearchData = self.datasource.data;
        }
        
        self->page = 1;
        self->query = text;
        [self getMovies:self->query page:self->page replaceCurrentData:true];
    };
    
    //terminate previous query search
    self.searchDelegate.terminatePreviousSearchCallback = ^(NSString *text) {
        [APIServices terminateRequestPopularMovies:text page:self->page];
    };
    
    //cancel search
    self.searchDelegate.cancelCallback = ^{
        self->inSearchResult = false;
        self->page = self->previousSearchPage;
        self->query = NULL;
        self.datasource.data = self->previousSearchData != NULL ? self->previousSearchData : [NSMutableArray new];
        self.delegate.data = self.datasource.data;
        
        [self.tableMovies reloadData];
    };
}

- (void) initialLoad{
    page++;
    [self getMovies:query page:page replaceCurrentData:false];
}

- (void) getMovies:(NSString*) query page:(int) page replaceCurrentData:(bool) replace{
    
    [APIServices getPopularMovies:query page:page completion:^(NSArray *movies, NSError *error) {
        
        //if no result return to the last page
        if(movies.count == 0 && page > 1){
            self->page--;
        }
        
        if(replace){
            self.datasource.data = [movies mutableCopy];
        }
        else{
            [self.datasource.data addObjectsFromArray:movies];
        }
        
        self.delegate.data = self.datasource.data;
        
        //avoid reload without changes
        if (movies.count != 0 || replace){
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableMovies reloadData];
            });
        }
    }];
}

@end

