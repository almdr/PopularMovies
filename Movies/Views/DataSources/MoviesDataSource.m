//
//  MoviesDataSource.m
//  Movies
//
//  Created by Alfonso  on 7/19/19.
//  Copyright © 2019 Alfonso . All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "MoviesDataSource.h"

#import "MovieCell.h"

static NSString* CellID = @"movieCell";

@implementation MoviesDataSource

- (instancetype)init{
    if(self = [super init]){
        self.data = [NSMutableArray new];
    }
    return self;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSInteger row = indexPath.row;
    
    Movie* movie = self.data[row];
    
    MovieCell* cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    [cell setmovie:movie];
    
    return cell;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.data.count;
}

@end
