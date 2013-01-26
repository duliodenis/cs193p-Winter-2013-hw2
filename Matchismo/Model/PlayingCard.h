//
//  PlayingCard.h
//  Matchismo
//
//  Created by Dulio Denis on 1/26/13.
//  Copyright (c) 2013 Stanford University. All rights reserved.
//

#import "Card.h"

@interface PlayingCard : Card

@property (strong, nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;
+ (NSArray *)validSuits;
+ (NSUInteger)maxRank;

@end
