//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Dulio Denis on 1/25/13.
//  Copyright (c) 2013 Stanford University. All rights reserved.
//
// Tap through all the cards in the deck.

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"
#import "CardMatching Game.h"

@interface CardGameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) int flipCount;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *CardButtons;
@property (strong, nonatomic) CardMatching_Game *game;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (strong, nonatomic) IBOutlet UILabel *resultsLabel;
@property (strong, nonatomic) IBOutlet UISegmentedControl *mode;
@property (nonatomic) int matchMode;

@end

@implementation CardGameViewController

- (IBAction)mode:(UISegmentedControl *)sender
{
    if (sender.selectedSegmentIndex == 0)     {
        NSLog(@"Value Changed to 2-Card Mode"); self.matchMode = 2;
    } else     { NSLog(@"Value Changed to 3-Card Mode"); self.matchMode = 3; }
}

- (IBAction)deal
{
    // realloc game
    self.game = nil;
    self.flipCount = 0;
    // repaint UI
    [self updateUI];
}

- (CardMatching_Game *)game
{
    if (!_game) _game = [[CardMatching_Game alloc] initWithCardCount:[self.CardButtons count]
                                                           usingDeck:[[PlayingCardDeck alloc] init]];
    if (!self.matchMode) self.matchMode = 2; // default to 2 card mode at first
    return _game;
}

- (void)setCardButtons:(NSArray *)CardButtons
{
    _CardButtons = CardButtons;
    [self updateUI];
}

-(void)updateUI
{
    for (UIButton *cardButton in self.CardButtons) {
        Card *card = [self.game cardAtindex:[self.CardButtons indexOfObject:cardButton]];
        [cardButton setTitle:card.contents forState:UIControlStateSelected];
        [cardButton setTitle:card.contents forState:UIControlStateSelected|UIControlStateDisabled];
        cardButton.selected = card.isFaceUp;
        cardButton.enabled = !card.isUnplayable;
        cardButton.alpha = (card.unplayable ? 0.3 : 1.0);
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score = %d", self.game.score];
    self.resultsLabel.text = self.game.flipResult;
}


-(void)setFlipCount:(int)flipCount
{
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Picked: %d", self.flipCount];
}

- (IBAction)flipCard:(UIButton *)sender
{
    [self.game flipCardAtIndex:[self.CardButtons indexOfObject:sender] matchMode:self.matchMode];
    self.flipCount++;
    [self updateUI];
}

@end
