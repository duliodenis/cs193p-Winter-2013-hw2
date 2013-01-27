//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Dulio Denis on 1/25/13.
//  Copyright (c) 2013 Stanford University. All rights reserved.
//
// Tap through all the cards in the deck.

#import "CardGameViewController.h"
#import "Deck.h"

@interface CardGameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (weak, nonatomic) IBOutlet UILabel *remainingLabel;
@property (nonatomic) int flipCount;
@property (nonatomic) int cardsLeftInDeck;

@end

@implementation CardGameViewController

- (PlayingCardDeck *)deck
{
    if (!_deck) {
        _deck = [[PlayingCardDeck alloc] init];
    }
    return _deck;
}

- (int)cardsLeftInDeck
{
    if (!_cardsLeftInDeck) {
        _cardsLeftInDeck = 52;
    }
    return _cardsLeftInDeck;
}

- (id)init
{
    self = [self init];
    if (self) {
        
        
    }
    return self;
}

-(void)setFlipCount:(int)flipCount
{
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Picked: %d", self.flipCount];
    self.remainingLabel.text = [NSString stringWithFormat:@"Remaining: %d", self.cardsLeftInDeck];
}

- (IBAction)flipCard:(UIButton *)sender
{
    
    sender.selected = !sender.isSelected;
    
    if (sender.selected) {
        if (self.cardsLeftInDeck) {
            Card *randomCard = self.deck.drawRandomCard;
            
            [sender setTitle:randomCard.description forState:UIControlStateSelected];
            
            [self.deck removeCardFromDeck:randomCard];
            
            self.flipCount++;
            self.cardsLeftInDeck--;

        }
    }
}

@end
