//
//  GameResultViewController.m
//  Matchismo
//
//  Created by Dulio Denis on 2/7/13.
//  Copyright (c) 2013 Stanford University. All rights reserved.
//

#import "GameResultViewController.h"
#import "GameResult.h"

@interface GameResultViewController ()
@property (weak, nonatomic) IBOutlet UITextView *display;

@end

@implementation GameResultViewController

// TO-DO: Date formatter for result.end below.

- (void)updateUI
{
    NSLog(@"CALLED");
    NSString *displayText = @"";
    NSLog(@"GameResults = %d", [[GameResult allGameResults] count]);
    for (GameResult *result in [GameResult allGameResults]) {
        displayText = [displayText stringByAppendingFormat:@"Score: %d (%@ %0gs)\n", result.score, result.end, round(result.duration)];
        NSLog(@"Score: %d (%@ %0g)", result.score, result.end, round(result.duration));
    }
    self.display.text = displayText;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self updateUI];
}

-(void)setup
{
    // initilization that can't wait until viewDidLoad
}

- (void)awakeFromNib
{
    [self setup];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    [self setup];
    return self;
}

@end
