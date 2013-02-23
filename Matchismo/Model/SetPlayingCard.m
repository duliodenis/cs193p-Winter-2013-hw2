//
//  SetPlayingCard.m
//  Matchismo
//
//  Created by Dulio Denis on 2/8/13.
//  Copyright (c) 2013 Stanford University. All rights reserved.
//

#import "SetPlayingCard.h"

@interface SetPlayingCard()

@end

@implementation SetPlayingCard

- (int)match:(NSArray *)otherCards
{
    // the Set match override
    // its either a match or it isn't
    int score =0;
    
    if (otherCards.count == 2) { // in this game you can only match 3 cards
        NSLog(@"Trying to match");
        SetPlayingCard *c1 = self;
        SetPlayingCard *c2 = otherCards[0];
        SetPlayingCard *c3 = otherCards[1];
        
        // define all ways where we have a set (from wikipedia):
        // They all have the same number, or they have three different numbers.
        // They all have the same symbol, or they have three different symbols.
        // They all have the same shading, or they have three different shadings.
        // They all have the same color, or they have three different colors.
        // see: http://en.wikipedia.org/wiki/Set_(game)
        
        if (
            (
             (
              (((c1.rank == c2.rank) && (c2.rank == c3.rank) && (c1.rank == c3.rank)) || ((c1.rank != c2.rank) && (c2.rank != c3.rank) && (c1.rank != c3.rank))) &&
              
              (([c1.symbol isEqualToString:c2.symbol] && [c2.symbol isEqualToString:c3.symbol] && [c1.symbol isEqualToString:c3.symbol]) ||
               (![c1.symbol isEqualToString:c2.symbol] && ![c2.symbol isEqualToString:c3.symbol] && ![c1.symbol isEqualToString:c3.symbol])) &&

              (([c1.shade isEqualToString:c2.shade] && [c2.shade isEqualToString:c3.shade] && [c1.shade isEqualToString:c3.shade]) ||
               (![c1.shade isEqualToString:c2.shade] && ![c2.shade isEqualToString:c3.shade] && ![c1.shade isEqualToString:c3.shade])) &&
              
              (([c1.color isEqualToString:c2.color] && [c2.color isEqualToString:c3.color] && [c1.color isEqualToString:c3.color]) ||
               (![c1.color isEqualToString:c2.color] && ![c2.color isEqualToString:c3.color] && ![c1.shade isEqualToString:c3.color]))
             )
            )
           )
        {
            score = 1;
        }
    }
    
    return score;
}

- (void)setRank:(NSUInteger)rank
{
    if (rank <= [SetPlayingCard maxRank]) {
        _rank = rank;
    }
}

+ (NSArray *)validSymbols
{
    return @[@"▲", @"●", @"■"];
}

+ (NSArray *)validShades
{
    return @[@"solid", @"stripped", @"open"];
}

+ (NSArray *)validColors
{
    return @[@"red", @"green", @"purple"];
}

+ (NSArray *)rankStrings
{
    return @[@"1", @"2", @"3"];
}

// Enumeration Helper Methods
+ (NSInteger)valueofSymbol:(NSString*)value
{
    return [[SetPlayingCard validSymbols] indexOfObject:value];
}

+ (NSInteger)valueofShade:(NSString*)value
{
    return [[SetPlayingCard validShades] indexOfObject:value];
}

+ (NSInteger)valueofColor:(NSString*)value
{
    return [[SetPlayingCard validColors] indexOfObject:value];
}

+ (NSUInteger)maxRank
{
    return [self rankStrings].count;
}

- (void)setSymbol:(NSString *)symbol
{
    if ([[SetPlayingCard validSymbols] containsObject:symbol]) {
        _symbol = symbol;
    }
}

- (void)setShade:(NSString *)shade
{
    if ([[SetPlayingCard validShades] containsObject:shade]) {
        _shade = shade;
    }
}

- (void)setColor:(NSString *)color
{
    if ([[SetPlayingCard validColors] containsObject:color]) {
        _color = color;
    }
}

// in the model have all numbers (an enumeration of 4 digits as a string)
// move all the attributed string stuff to the view
// enumeration = NUMBER-SYMBOL-SHADE-COLOR
//            [1|2|3]-[0|1|2]-[0|1|2]-[0|1|2]

- (NSString *)contents
{
    NSString *symbolMark = @"";
    
    NSArray *rankStrings = [SetPlayingCard rankStrings];
    NSString *symbolString = [NSString stringWithFormat:@"%d", [SetPlayingCard valueofSymbol:self.symbol]];
    NSString *shadeString = [NSString stringWithFormat:@"%d", [SetPlayingCard valueofShade:self.shade]];
    NSString *colorString = [NSString stringWithFormat:@"%d", [SetPlayingCard valueofColor:self.color]];
    
    symbolMark = [[[[symbolMark stringByAppendingString:rankStrings[self.rank]]
                    stringByAppendingString: symbolString]
                   stringByAppendingString: shadeString]
                  stringByAppendingString: colorString];
    
    return symbolMark;
}

@end
