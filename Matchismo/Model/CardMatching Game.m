//
//  CardMatching Game.m
//  Matchismo
//
//  Created by Dulio Denis on 2/3/13.
//  Copyright (c) 2013 Stanford University. All rights reserved.
//

#import "CardMatching Game.h"
#import "PlayingCard.h"

@interface CardMatching_Game()
@property (readwrite, nonatomic) int score;
@property (strong, nonatomic) NSMutableArray *cards; // of Card
-(BOOL)matchTwoCards:(Card *)card;
-(BOOL)matchThreeCards:(Card *)card;
@end

@implementation CardMatching_Game


-(NSMutableArray *)cards
{
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

#define MATCH_THREE_BONUS 8
#define MATCH_BONUS 4
#define MISMATCH_PENALTY 2
#define FLIP_COST 1

-(BOOL)matchThreeCards:(Card *)card
{
    BOOL didMatch, misMatch;
    
    for (int i = 0; i < [self.cards count]; i++) {
        PlayingCard *otherCard1 = [self.cards objectAtIndex:i];
        for (int j = 0; j < [self.cards count]; j++) {
            
            if (i != j) {
                
                PlayingCard *otherCard2 = [self.cards objectAtIndex:j];
                
                if (otherCard1.isFaceUp && otherCard2.isFaceUp && !otherCard1.isUnplayable && !otherCard2.isUnplayable) {
                    int matchscore = [card match:@[otherCard1, otherCard2]];
                    if (matchscore) {
                        card.unplayable = YES;
                        otherCard1.unplayable = YES;
                        otherCard2.unplayable = YES;
                        self.score += MATCH_THREE_BONUS;
                        didMatch = TRUE;
                        self.flipResult = [NSString stringWithFormat:@"Matched %@ %@ %@: %d pts", otherCard1.contents, otherCard2.contents, card.contents, MATCH_THREE_BONUS];
                    } else {
                        otherCard1.faceUp = NO;
                        otherCard2.faceUp = NO;
                        self.score -= MISMATCH_PENALTY;
                        misMatch = TRUE;
                        self.flipResult = [NSString stringWithFormat:@"%@ %@ %@ don't match!", otherCard1.contents, otherCard2.contents, card.contents];
                    }
                }
            }
        }
    }
    BOOL noMatchAndNotAMisMatch = FALSE;
    if (!didMatch && !misMatch) noMatchAndNotAMisMatch = TRUE;
    NSLog(@"%c", noMatchAndNotAMisMatch);
    return (noMatchAndNotAMisMatch);
}

-(BOOL)matchTwoCards:(Card *)card
{
    BOOL didMatch, misMatch;
    
    for (Card *otherCard in self.cards) {
        if (otherCard.faceUp && !otherCard.isUnplayable) {
            int matchscore = [card match:@[otherCard]];
            if (matchscore) {
                card.unplayable = YES;
                otherCard.unplayable = YES;
                self.score += MATCH_BONUS;
                didMatch = TRUE;
                self.flipResult = [NSString stringWithFormat:@"Matched %@ & %@ for %d points", otherCard.contents, card.contents, MATCH_BONUS];
                
            } else {
                otherCard.faceUp = NO;
                self.score -= MISMATCH_PENALTY;
                misMatch = TRUE;
                self.flipResult = [NSString stringWithFormat:@"%@ & %@ don't match! %d point loss", otherCard.contents, card.contents, MATCH_BONUS];
                
            }
            break;
        }
    }
    BOOL noMatchAndNotAMisMatch = FALSE;
    if (!didMatch && !misMatch) noMatchAndNotAMisMatch = TRUE;
    NSLog(@"%c", noMatchAndNotAMisMatch);
    return (noMatchAndNotAMisMatch);
}



- (void)flipCardAtIndex:(NSUInteger)index matchMode:(int)mode
// if matchMode = 3 then need to ignore if not three flipped
{
    BOOL noMatchAndNotAMisMatch = TRUE;
    
    Card *card = [self cardAtindex:index];

        if (card && !card.isUnplayable) {
            if (!card.isFaceUp) {
                
                // loop through and determine how many cards are face-up
                // if 2 other are face-up and mode = 3 then we try to match-3
                int faceUp = 0;
                for (Card *otherCard in self.cards) {
                    if (otherCard.faceUp && !otherCard.isUnplayable) faceUp++;
                }
                
                if (mode == 2) noMatchAndNotAMisMatch = [self matchTwoCards:card];
                else if (mode == 3 && faceUp == 2)
                { noMatchAndNotAMisMatch = [self matchThreeCards:card]; NSLog(@"3 Mode Match %d", noMatchAndNotAMisMatch); }
                self.score -= FLIP_COST;
            }
            card.faceUp = !card.isFaceUp;
            if (noMatchAndNotAMisMatch) self.flipResult = [NSString stringWithFormat:@"Flipped up %@", card.contents];
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
