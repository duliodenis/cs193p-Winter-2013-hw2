//
//  SetPlayingCardDeck.m
//  Matchismo
//
//  Created by Dulio Denis on 2/11/13.
//  Copyright (c) 2013 Stanford University. All rights reserved.
//

#import "SetPlayingCardDeck.h"
#import "SetPlayingCard.h"

@implementation SetPlayingCardDeck

- (id)init
{
    self = [super init];
    
    if (self) {
        for (id symbol in [SetPlayingCard validSymbols]) {
            for (id shade in [SetPlayingCard validShades]) {
                for (id color in [SetPlayingCard validColors]) {
                    for (NSUInteger rank =0; rank < [SetPlayingCard maxRank]; rank++) {
                        SetPlayingCard *card = [[SetPlayingCard alloc] init];
                        card.rank = rank;
                        card.color = color;
                        card.shade = shade;
                        card.symbol = symbol;
                        [self addCard:card atTop:NO];
                    }
                }
            }
        }
    }
    // there should be 81 cards in the Set Deck
    if ([self count] != 81) NSLog(@"ERROR: There are %d cards in the new Set Playing Card Deck (81 Expected).", [self count]);
    return self;
}


@end
