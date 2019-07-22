//
//  APIServices.h
//  Movies
//
//  Created by Alfonso  on 7/19/19.
//  Copyright © 2019 Alfonso . All rights reserved.
//

#ifndef APIServices_h
#define APIServices_h

typedef void (^MoviesCompletion)   (NSArray *movies, NSError *error);

@interface APIServices : NSObject

+ (void) getPopularMovies:(NSString*) query page: (int) page completion:(MoviesCompletion) completion;
+ (void) terminateRequestPopularMovies:(NSString*) query page: (int) page;

@end


#endif /* APIServices_h */
