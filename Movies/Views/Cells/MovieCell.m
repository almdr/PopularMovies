//
//  MovieCell.m
//  Movies
//
//  Created by Alfonso  on 7/19/19.
//  Copyright © 2019 Alfonso . All rights reserved.
//

#import "AFNetworking.h"
#import "UIImageView+AFNetworking.h"

#import "MovieCell.h"

@interface MovieCell()
{
    NSURLSessionDataTask *task;
}

@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblYear;
@property (weak, nonatomic) IBOutlet UILabel *lblOverview;
@property (weak, nonatomic) IBOutlet UIImageView *thumb;
@end

@implementation MovieCell

- (void) setmovie:(Movie *)movie{
    
    self.movie = movie;
    self.lblTitle.text = self.movie.title;
    self.lblYear.text = self.movie.year;
    self.lblOverview.text = self.movie.overview;
    self.thumb.image = nil;
    
    [self.thumb cancelImageDownloadTask];
    [self getUrlDownloadImage];
    
}

- (void) getUrlDownloadImage{
    
    [self getUrls:^(NSArray *urls, NSError *error) {
        
        NSDictionary *movieThumbUrlObject = urls[0];
        NSString *movieThumbUrl = [movieThumbUrlObject objectForKey:@"url"];
        
        [self downloadImage:movieThumbUrl];
    }];
    
}

- (void) getUrls:(void (^)(NSArray *urls, NSError *error)) completion{
    
    NSURL *URL = [NSURL URLWithString:self.movie.urlThumb];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
    [request setHTTPMethod:@"GET"];
    
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"2" forHTTPHeaderField:@"trakt-api-version"];
    [request setValue:@"d52975f0f345d08a72b2400d1261622295bbdf51457ba260f696b4fd334ad027" forHTTPHeaderField:@"trakt-api-key"];
    [request setCachePolicy:NSURLRequestReturnCacheDataElseLoad];
    
    NSURLSession *session = [NSURLSession sharedSession];
    task = [session dataTaskWithRequest:request
                                            completionHandler:
                                  ^(NSData *data, NSURLResponse *response, NSError *error) {
                                      
                                      if (error) {
                                          
                                          return;
                                      }
                                      
                                      NSError *jsonError;
                                      NSDictionary *jsonDataObject = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&jsonError];
                                      
                                      NSArray *movieThumbUrls = [jsonDataObject objectForKey:@"moviethumb"];
                                      
                                      completion(movieThumbUrls, nil);
                                  }];
    [task resume];
    
}

- (void) downloadImage:(NSString *) url{
    
    UIImage *placeholder = [UIImage imageNamed:@"placeholder"];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self.thumb setImageWithURLRequest:request
                          placeholderImage:placeholder
                                   success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                                       
                                       dispatch_async(dispatch_get_main_queue(), ^{
                                           self.thumb.image = image;
                                           [self.thumb setNeedsLayout];
                                       });
                                       
                                   }
                                   failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
                                   }];
    
    });
    
}

- (void)prepareForReuse{
    [super prepareForReuse];
    [self->task cancel];
    [self.thumb cancelImageDownloadTask];
    self.thumb.image = nil;
}




@end
