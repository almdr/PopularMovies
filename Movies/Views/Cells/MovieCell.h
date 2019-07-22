//
//  MovieCell.h
//  Movies
//
//  Created by Alfonso  on 7/19/19.
//  Copyright © 2019 Alfonso . All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Movie.h"

@interface MovieCell : UITableViewCell

@property (nonatomic,strong) Movie* movie;

- (void) setmovie:(Movie *)movie;

@end
