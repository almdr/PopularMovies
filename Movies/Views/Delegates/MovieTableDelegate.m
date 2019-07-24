//
//  MovieTableDelegate.m
//  Movies
//
//  Created by Alfonso  on 7/19/19.
//  Copyright © 2019 Alfonso . All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "MovieTableDelegate.h"
#import "Movie.h"

@implementation MoviesTableDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    float bottomEdge = scrollView.contentOffset.y + scrollView.frame.size.height;
    if (bottomEdge + 1 >= scrollView.contentSize.height)
    {
        self.callback();
    }
}

@end
