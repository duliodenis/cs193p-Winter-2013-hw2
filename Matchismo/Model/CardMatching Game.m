//
//  CardMatching Game.m
//  Matchismo
//
//  Created by Dulio Denis on 2/3/13.
//  Copyright (c) 2013 Stanford University. All rights reserved.
//

#import "CardMatching Game.h"

@interface CardMatching_Game()
@property (readwrite, nonatomic) int score;
@property (strong, nonatomic) NSMutableArray *cards; // of Card
@end

@implementation CardMatching_Game


-(NSMutableArray *)cards
{
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

#define MATCH_BONUS      4
#define MISMATCH_PENALTY 2
#define FLIP_COST        1

- (void)flipCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtindex:index];
    if (card && !card.isUnplayable) {
        if (!card.isFaceUp) {
            for (Card *otherCard in self.cards) {
                if (otherCard.faceUp && !otherCard.isUnplayable) {
                    int matchscore = [card match:@[otherCard]];
                    if (matchscore) {
                        card.unplayable = YES;
                        otherCard.unplayable = YES;
                        self.score += MATCH_BONUS;
                    } else {
                        otherCard.faceUp = NO;
                        self.score -= MISMATCH_PENALTY;
                    }
                    break;
                }
            }
            self.score -= FLIP_COST;
        }
        card.faceUp = !card.isFaceUp;
    }
}

- (Card *)cardAtindex:(NSUInteger)index
{
    return (index < [self.cards count]) ? self.cards[index] : nil;
}
 
- (id)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck
{
    self = [super init];
    if (self) {
        for (int i=0; i < count; i++) {
            Card *card = [deck drawRandomCard];
            if (card) {
                self.cards[i] = card;
            } else {
                self = nil;
                break;
            }
        }
    }
    return self;
}

@end
