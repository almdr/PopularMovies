//
//  MoviesUITests.m
//  MoviesUITests
//
//  Created by Alfonso  on 7/19/19.
//  Copyright © 2019 Alfonso . All rights reserved.
//

#import <XCTest/XCTest.h>

@interface MoviesUITests : XCTestCase

@end

@implementation MoviesUITests

- (void)setUp {
    self.continueAfterFailure = NO;

    [[[XCUIApplication alloc] init] launch];

}

- (void)tearDown {

}

- (void) paginatingTable:(XCUIApplication*) app{
    [[app.tables elementBoundByIndex:0] swipeUp];
    [[app.tables elementBoundByIndex:0] swipeUp];
    [[app.tables elementBoundByIndex:0] swipeUp];
    [[app.tables elementBoundByIndex:0] swipeUp];
}

- (void) search:(XCUIApplication*) app text:(NSString*) text{
    [[app.searchFields elementBoundByIndex:0] tap];
    [[app.searchFields elementBoundByIndex:0] typeText:text];
    [[app.searchFields elementBoundByIndex:0] tap];
    [app.buttons[@"Done"] tap];
}

- (void)testUIElementsExists{
    XCUIApplication* app = [[XCUIApplication alloc] init];
    XCTAssertEqual(app.tables.count, 1, "Amount tables wrong");
    XCTAssertEqual(app.searchFields.count, 1, "Amount search fields wrong");
}

- (void)testInitialLoadTenResults{
    XCUIApplication* app = [[XCUIApplication alloc] init];
    XCTAssertEqual(app.cells.count, 10, "Amount cells after initial load wrong");
}

- (void)testSwipeToPaginateInitialResults{
    XCUIApplication* app = [[XCUIApplication alloc] init];
    [self paginatingTable:app];
    XCTAssertEqual(app.cells.count, 20, "Amount cells after paginate initial load wrong");
}

- (void)testTronSearchFiveResults{
    XCUIApplication* app = [[XCUIApplication alloc] init];
    
    [self search:app text:@"Tron"];
    XCTAssertEqual(app.cells.count, 5, "Amount cells after search Tron wrong");
}

- (void)testTronSearch5ResultsPaginating{
    XCUIApplication* app = [[XCUIApplication alloc] init];
    
    [self testTronSearchFiveResults];
    [self paginatingTable:app];
    XCTAssertEqual(app.cells.count, 5, "Amount cells after paginating search Tron wrong");
}

- (void)testAlfonsoSearchResults{
    XCUIApplication* app = [[XCUIApplication alloc] init];
    
    [self search:app text:@"Alfonso"];
    XCTAssertEqual(app.cells.count, 2, "Amount cells after search Alfonso wrong");
}

- (void)testWarSearchResults{
    XCUIApplication* app = [[XCUIApplication alloc] init];
    
    [self search:app text:@"War"];
    XCTAssertEqual(app.cells.count, 10, "Amount cells after search War wrong");
}

- (void)testWarSearchResultsPaginating{
    XCUIApplication* app = [[XCUIApplication alloc] init];
    
    [self testWarSearchResults];
    [self paginatingTable:app];
    XCTAssertEqual(app.cells.count, 20, "Amount cells after paginating search War wrong");
}



@end
