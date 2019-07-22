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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    Movie* movie = self.data[indexPath.row];
    
    CGSize maximumLabelSize = CGSizeMake(tableView.contentSize.width * 0.8 - 8 - 8 - 8, FLT_MAX);
    CGSize maximumLabelSizeOverview = CGSizeMake(tableView.contentSize.width - 8 - 8 - 8, FLT_MAX);
    
    NSDictionary *attributesTitle = @{NSFontAttributeName: [UIFont systemFontOfSize:24]};
    NSDictionary *attributesYear = @{NSFontAttributeName: [UIFont systemFontOfSize:15]};
    NSDictionary *attributesOverview = @{NSFontAttributeName: [UIFont systemFontOfSize:17]};
    
    CGFloat titleHeight = [movie.title boundingRectWithSize:maximumLabelSize
                                                         options:NSStringDrawingUsesLineFragmentOrigin
                                                      attributes:attributesTitle
                                                         context:nil].size.height;
    
    CGFloat yearHeight = [movie.year boundingRectWithSize:maximumLabelSize
                                                         options:NSStringDrawingUsesLineFragmentOrigin
                                                      attributes:attributesYear
                                                         context:nil].size.height;
    
    CGFloat overviewHeight = [movie.overview boundingRectWithSize:maximumLabelSizeOverview
                                              options:NSStringDrawingUsesLineFragmentOrigin
                                           attributes:attributesOverview
                                              context:nil].size.height;
    
    return 8 + titleHeight + 8 + yearHeight + 8 + overviewHeight + 8;
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    float bottomEdge = scrollView.contentOffset.y + scrollView.frame.size.height;
    if (bottomEdge + 1 >= scrollView.contentSize.height)
    {
        self.callback();
    }
}

@end
