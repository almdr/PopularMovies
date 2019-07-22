//
//  SearchDelegate.h
//  Movies
//
//  Created by Alfonso  on 7/20/19.
//  Copyright © 2019 Alfonso . All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^SearchMoviesCallback) (NSString* text);
typedef void (^TerminatePreviousSearchMoviesCallback) (NSString* text);
typedef void (^CancelSearchMoviesCallback) (void);

@interface SearchDelegate: NSObject<UISearchBarDelegate>

@property (nonatomic, copy) SearchMoviesCallback callback;
@property (nonatomic, copy) TerminatePreviousSearchMoviesCallback terminatePreviousSearchCallback;
@property (nonatomic, copy) CancelSearchMoviesCallback cancelCallback;

@end
