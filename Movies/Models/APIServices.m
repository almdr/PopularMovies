//
//  APIServices.m
//  Movies
//
//  Created by Alfonso  on 7/19/19.
//  Copyright © 2019 Alfonso . All rights reserved.
//

#import <Foundation/Foundation.h>

#import "APIServices.h"

#import "Movie.h"

@implementation APIServices

+ (NSString*) buildURL:(NSString*) query page: (int) page{
    NSString *urlString = [NSString stringWithFormat:@"https://api.trakt.tv/movies/popular?page=%i&limit=10&extended=full", page];
    
    if (query != NULL) {
        urlString = [NSString stringWithFormat:@"%@&query=%@&fields=title", urlString, query];
    }

    return urlString;
}

+ (void) getPopularMovies:(NSString*) query page: (int) page completion:(MoviesCompletion) completion{
    
    NSString *urlString = [APIServices buildURL:query page:page];
    
    NSLog(@"Download %@ %i %@", query, page, urlString);
    
    NSURL *URL = [NSURL URLWithString:urlString];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
    [request setHTTPMethod:@"GET"];
    
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"2" forHTTPHeaderField:@"trakt-api-version"];
    [request setValue:@"d52975f0f345d08a72b2400d1261622295bbdf51457ba260f696b4fd334ad027" forHTTPHeaderField:@"trakt-api-key"];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                            completionHandler:
                                  ^(NSData *data, NSURLResponse *response, NSError *error) {
                                      
                                      if (error) {

                                          return;
                                      }
                                      
                                      NSError *jsonError;
                                      NSArray *jsonDataArray = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&jsonError];
                                      
                                      NSMutableArray *movies = [[NSMutableArray alloc] init];
                                      
                                      for (int i = 0; i < jsonDataArray.count; i++) {
                                          
                                          Movie* movie = [[Movie alloc] init];
                                          movie.title = [jsonDataArray[i] objectForKey:@"title"];
                                          movie.year = [NSString stringWithFormat:@"%@", [jsonDataArray[i] objectForKey:@"year"] ];
                                          movie.overview = [NSString stringWithFormat:@"%@", [jsonDataArray[i] objectForKey:@"overview"] ];
                                          
                                          NSString* url = @"https://webservice.fanart.tv/v3/movies/";
                                          NSString* apiKey = @"?api_key=5a08baf2bf37a7ec76a42f127130ed2f";
                                          movie.urlThumb = [NSString stringWithFormat:@"%@%@%@", url, [[jsonDataArray[i] objectForKey:@"ids"] objectForKey:@"imdb"], apiKey];
                                          
                                          [movies addObject:movie];
                                      }
                                      
                                      completion(movies, NULL);
                                  }];
    [task resume];
    
}

+ (void) terminateRequestPopularMovies:(NSString*) query page: (int) page{

    NSString *urlString = [APIServices buildURL:query page:page];
    
    [NSURLSession.sharedSession getTasksWithCompletionHandler:^(NSArray<NSURLSessionDataTask *> * _Nonnull dataTasks, NSArray<NSURLSessionUploadTask *> * _Nonnull uploadTasks, NSArray<NSURLSessionDownloadTask *> * _Nonnull downloadTasks) {
        
        for (NSURLSessionDataTask* task in dataTasks) {
            if ([task.originalRequest.URL.absoluteString isEqualToString:urlString]) {
                [task cancel];
            }
        }
    }];
}

@end
