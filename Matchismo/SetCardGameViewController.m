//
//  SetCardGameViewController.m
//  Matchismo
//
//  Created by Dulio Denis on 2/11/13.
//  Copyright (c) 2013 Stanford University. All rights reserved.
//

#import "SetCardGameViewController.h"
#import "CardMatching Game.h"
#import "GameResult.h"
#import "SetPlayingCardDeck.h"
#import "SetPlayingCard.h"

@interface CardGameViewController()
-(void)updateUI;
-(void)setFlipCount:(int)flipCount;
@end

@interface SetCardGameViewController ()
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *CardButtons;
@property (strong, nonatomic) CardMatching_Game *game;

- (NSString *)makeSetCardFace:(Card *)card;

@end

@implementation SetCardGameViewController

- (CardMatching_Game *)game
{
    if (!_game) _game = [[CardMatching_Game alloc] initWithCardCount:[self.CardButtons count]
                                                           usingDeck:[[SetPlayingCardDeck alloc] init]];
    return _game;
}

- (NSString *)makeSetCardFace:(Card *)card
{
    return card.contents;
}

// attributed string stuff:
/*
 NSMutableAttributedString *as;

 as = [[NSMutableAttributedString alloc] initWithString:symbolMark];
 NSRange range = [symbolMark rangeOfString:symbolMark];
 [as addAttributes:@{NSFontAttributeName : [UIColor redColor]} range:range];
 
 
 NSLog(@"Attributed String = %@", [as string]);
 
> Map these  

 + (NSArray *)rankStrings
 {
 return @[@"1", @"2", @"3"];
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
 
 enumeration = NUMBER-SYMBOL-SHADE-COLOR
 
 RA= [0] 1 | 2 | 3
 SY= [1] 0 | 1 | 2 = ▲, ●, ■
 SH= [2] 0 | 1 | 2 = solid, stripped, open
 CO= [3] 0 | 1 | 2 = red, green, purple
 
 Model Enumeration Encoding Ex: 1231 = 1 Circle Purple Solid
 
*/

- (NSMutableAttributedString *)attributedButtonTitle:(Card *)card
{
    NSMutableAttributedString *myAttributedString;
    NSString *symbolString;
    UIColor *color;
    
    // Symbol Selector
    switch ([card.contents characterAtIndex:1]) {
        case '0': symbolString = @"▲"; break;
        case '1': symbolString = @"●"; break;
        case '2': symbolString = @"■"; break;
    }
    symbolString = [symbolString stringByPaddingToLength:[[card.contents substringWithRange:NSMakeRange(0, 1)] intValue] withString:symbolString startingAtIndex:0];    
    myAttributedString = [[NSMutableAttributedString alloc] initWithString:symbolString];
    NSRange range = [symbolString rangeOfString:symbolString];
    
    // Color Selector
    switch ([card.contents characterAtIndex:3]) {
        case '0': color = [UIColor redColor]; break;
        case '1': color = [UIColor greenColor]; break;
        case '2': color = [UIColor purpleColor]; break;
    }

    // Shading Selector
    switch ([card.contents characterAtIndex:2]) {
        case '0': // solid
            color = [color colorWithAlphaComponent:1.0f];
            [myAttributedString addAttribute:NSForegroundColorAttributeName value:color range:range];
            break;
        case '1': // stripped
            color = [color colorWithAlphaComponent:0.3f];
            [myAttributedString addAttribute:NSForegroundColorAttributeName value:color range:range];
            break;
        case '2': // open
            [myAttributedString addAttribute:NSForegroundColorAttributeName value:[color colorWithAlphaComponent:0.02f] range:range];
            [myAttributedString addAttribute:NSStrokeColorAttributeName value:color range:range];
            [myAttributedString addAttribute:NSStrokeWidthAttributeName value:@4.0f range:range];
            break;
    }
    
    // this works - underlining
    //NSDictionary *attributes = @{NSUnderlineStyleAttributeName: @(NSUnderlineStyleSingle)};
    //[myAttributedString addAttributes:attributes range:range];
    
    return myAttributedString;
}

-(void)updateUI
{
    [super updateUI];
    for (UIButton *cardButton in self.CardButtons) {
        Card *card = [self.game cardAtindex:[self.CardButtons indexOfObject:cardButton]];
        
        [cardButton setAttributedTitle:[self attributedButtonTitle:card] forState:UIControlStateSelected];
        
        // isFaceUp is the new isSelected
        cardButton.selected = card.isFaceUp;
        cardButton.enabled = !card.isUnplayable;
        cardButton.alpha = (card.unplayable ? 0.3 : 1.0);
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self updateUI];
}

@end
