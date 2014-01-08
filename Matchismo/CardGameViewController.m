//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Nick Freeman on 1/7/14.
//  Copyright (c) 2014 Nick Freeman. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"

@interface CardGameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) int flipCount;
@property (nonatomic) Deck *deckOfPlayingCards;
@end

@implementation CardGameViewController

- (Deck *)deckOfPlayingCards {
    if (!_deckOfPlayingCards) {
        _deckOfPlayingCards = [[PlayingCardDeck alloc] init];
    }
    return _deckOfPlayingCards;
}

- (void) setFlipCount:(int)flipCount {
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
    NSLog(@"flipCount changed to %d", self.flipCount);
}

- (IBAction)touchCardButton:(UIButton *)sender {
    if ([sender.currentTitle length]) {
        [sender setBackgroundImage:[UIImage imageNamed:@"cardback"]
                          forState:UIControlStateNormal];
        [sender setTitle:@"" forState:UIControlStateNormal];
    } else {
        NSString *cardValue = self.deckOfPlayingCards.drawRandomCard.contents;
        if (cardValue) {
            [sender setBackgroundImage:[UIImage imageNamed:@"cardfront"]
                              forState:UIControlStateNormal];
            [sender setTitle:cardValue forState:UIControlStateNormal];
            
        } else {
            [sender setBackgroundImage:[UIImage imageNamed:@"cardfront"]
                              forState:UIControlStateNormal];
            [sender setTitle:@"☹" forState:UIControlStateNormal];
        }
    }
    self.flipCount++;
}


@end
