//
//  MoviesDataSource.h
//  Movies
//
//  Created by Alfonso  on 7/19/19.
//  Copyright © 2019 Alfonso . All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^LoadMoviesCallback) (void);

@interface MoviesDataSource: NSObject<UITableViewDataSource>

@property (nonatomic,strong) NSMutableArray* data;

@end
