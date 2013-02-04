//
//  CardMatching Game.h
//  Matchismo
//
//  Created by Dulio Denis on 2/3/13.
//  Copyright (c) 2013 Stanford University. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"
#import "Deck.h"

@interface CardMatching_Game : NSObject

// the designated initializer - we need to know 1. how many cards and 2. the deck
-(id)initWithCardCount:(NSUInteger)count
             usingDeck:(Deck *)deck;

-(void)flipCardAtIndex:(NSUInteger)index;
-(Card *)cardAtindex:(NSUInteger)index;

@property (readonly, nonatomic) int score;

// property that contains the English result of the flip
@property (strong, nonatomic) NSString *flipResult;

@end
