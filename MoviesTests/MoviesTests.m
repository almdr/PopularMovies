//
//  MoviesTests.m
//  MoviesTests
//
//  Created by Alfonso  on 7/19/19.
//  Copyright © 2019 Alfonso . All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OHHTTPStubs/OHHTTPStubs.h>
#import <OHHTTPStubs/OHPathHelpers.h>

#import "APIServices.h"
#import "Movie.h"

@interface MoviesTests : XCTestCase

@end

@implementation MoviesTests

- (void)setUp {
    
}

- (void)tearDown {
    
}

- (void) setStubRequest:(NSString*) url filename:(NSString*) filename{
    [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
        return [request.URL.absoluteString isEqualToString:url];
    } withStubResponse:^OHHTTPStubsResponse*(NSURLRequest *request) {
        NSString* json = OHPathForFile(filename, self.class);
        return [OHHTTPStubsResponse responseWithFileAtPath:json
                                                statusCode:200 headers:@{@"Content-Type":@"application/json"}];
    }];
}

- (void)testGetMoviesPageOne{
    [self setStubRequest:@"https://api.trakt.tv/movies/popular?page=1&limit=10&extended=full"
                filename:@"data.json"];
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"Stub request expectation"];
    
    [APIServices getPopularMovies:NULL page:1 completion:^(NSArray *movies, NSError *error) {
        XCTAssertEqual(movies.count, 10, "Amount movies wrong");
        Movie* firstMovie = [movies objectAtIndex:0];
        Movie* lastMovie = [movies objectAtIndex:9];
        XCTAssertTrue([firstMovie.title isEqualToString:@"DADOpool"], "Title first movie wrong");
        XCTAssertTrue([lastMovie.title isEqualToString:@"Suicide Squad"], "Title last movie wrong");
        NSLog(@"%@", firstMovie.title);
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:5.0 handler:nil];

}

- (void) testSearchTronPageOne{
    [self setStubRequest:@"https://api.trakt.tv/movies/popular?page=1&limit=10&extended=full&query=Tron&fields=title"
                filename:@"tron_page_1.json"];
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"Stub request expectation"];
    
    [APIServices getPopularMovies:@"Tron" page:1 completion:^(NSArray *movies, NSError *error) {
        XCTAssertEqual(movies.count, 5, "Amount movies wrong");
        Movie* firstMovie = [movies objectAtIndex:0];
        Movie* lastMovie = [movies objectAtIndex:4];
        XCTAssertTrue([firstMovie.title isEqualToString:@"TRON: Legacy"], "Title first movie wrong");
        XCTAssertTrue([lastMovie.title isEqualToString:@"TRON: Destiny"], "Title last movie wrong");
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:5.0 handler:nil];
}

- (void) testSearchTronPageTwo{
    [self setStubRequest:@"https://api.trakt.tv/movies/popular?page=2&limit=10&extended=full&query=Tron&fields=title"
                filename:@"tron_page_2.json"];
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"Stub request expectation"];
    
    [APIServices getPopularMovies:@"Tron" page:2 completion:^(NSArray *movies, NSError *error) {
        XCTAssertEqual(movies.count, 0, "Amount movies wrong");
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:5.0 handler:nil];
}


@end
