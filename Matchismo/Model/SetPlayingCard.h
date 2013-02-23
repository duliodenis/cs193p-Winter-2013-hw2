//
//  SetPlayingCard.h
//  Matchismo
//
//  Created by Dulio Denis on 2/8/13.
//  Copyright (c) 2013 Stanford University. All rights reserved.
//

#import "Card.h"

@interface SetPlayingCard : Card

@property (nonatomic) NSUInteger rank;          // 1, 2, or 3
@property (strong, nonatomic) NSString *symbol; // triangle, circle, square
@property (strong, nonatomic) NSString *shade;  // solid, striped, or open
@property (strong, nonatomic) NSString *color;  // red, green, or purple
+ (NSArray *)validSymbols;
+ (NSArray *)validShades;
+ (NSArray *)validColors;
+ (NSUInteger)maxRank;
@end
