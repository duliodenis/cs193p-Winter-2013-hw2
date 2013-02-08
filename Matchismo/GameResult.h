//
//  GameResult.h
//  Matchismo
//
//  Created by Dulio Denis on 2/7/13.
//  Copyright (c) 2013 Stanford University. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GameResult : NSObject

+(NSArray *)allGameResults; // of GameResults

@property (readonly, nonatomic) NSDate *start;
@property (readonly, nonatomic) NSDate *end;
@property (readonly, nonatomic) NSTimeInterval duration;
@property (nonatomic) int score;

// To-DO: need methods to compare one game result to another
//        in order to support SEL to sort
//        1. by date, by score, by duration

@end
