//
//  MovieTableDelegate.h
//  Movies
//
//  Created by Alfonso  on 7/19/19.
//  Copyright © 2019 Alfonso . All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^LoadMoviesCallback) (void);

@interface MoviesTableDelegate: NSObject<UITableViewDelegate, UIScrollViewDelegate>

@property (nonatomic,strong) NSArray* data;

@property (nonatomic, copy) LoadMoviesCallback callback;

@end
