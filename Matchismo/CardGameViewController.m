//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Nick Freeman on 1/7/14.
//  Copyright (c) 2014 Nick Freeman. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"

@interface CardGameViewController ()
@property (nonatomic, strong) Deck *deck;
@property (nonatomic, strong) CardMatchingGame *game;
@property (nonatomic, strong) NSMutableArray *cards;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UISwitch *isThreeCard;
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;
@property (nonatomic) NSInteger prevScore;
@end

@implementation CardGameViewController

- (IBAction)startNewGame:(UIButton *)sender {
    self.isThreeCard.enabled = YES;
    _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                              usingDeck:[self createDeck]];
    [self.cards removeAllObjects];
    [self updateUI];
}

- (NSMutableArray *)cards {
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (CardMatchingGame *)game {
    if (!_game) _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                          usingDeck:[self createDeck]];
    return _game;
}

- (Deck *)createDeck {
    return [[PlayingCardDeck alloc] init];
}

- (IBAction)touchCardButton:(UIButton *)sender {
    self.prevScore = self.game.score;
    if (self.isThreeCard.enabled) {
        self.isThreeCard.enabled = NO;
    }
    NSUInteger cardIndex = [self.cardButtons indexOfObject:sender];
    Card *card = [self.game cardAtIndex:cardIndex];
    [self.cards addObject:card];
    NSLog(@"Card array size: %lu", (unsigned long)[self.cards count]);
    [self.game chooseCardAtIndex:cardIndex isThreeCard:[self.isThreeCard isOn]];
    [self updateUI];
}

- (void)updateUI {
    for (UIButton *cardButton in self.cardButtons) {
        NSUInteger cardIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardIndex];
        [cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
        self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", self.game.score];
    }
    [self.isThreeCard isOn] ? [self updateResultLabelThreeCard:self.cards] : [self updateResultLabelTwoCard:self.cards];
}

- (void)updateResultLabelTwoCard:(NSMutableArray *)cards {
    if ([cards count] == 1) {
        Card *card = [cards firstObject];
        self.resultLabel.text = [NSString stringWithFormat:@"%@", card.contents];
    } else if ([cards count] == 2) {
        Card *card1 = [cards objectAtIndex:0];
        Card *card2 = [cards objectAtIndex:1];
        if (self.game.score > self.prevScore) {
            self.resultLabel.text = [NSString stringWithFormat:@"Matched %@ %@ for %ld points.", card1.contents, card2.contents, self.game.score - self.prevScore];
        } else {
            self.resultLabel.text = [NSString stringWithFormat:@"%@ %@ don't match! %ld point penalty!", card1.contents, card2.contents, self.prevScore + self.game.score];
        }
        [self.cards removeAllObjects];
    }
}

- (void)updateResultLabelThreeCard:(NSMutableArray *)cards {
    if ([cards count] == 1) {
        Card *card = [cards firstObject];
        self.resultLabel.text = [NSString stringWithFormat:@"%@", card.contents];
    } else if ([cards count] == 2) {
        Card *card1 = [cards objectAtIndex:0];
        Card *card2 = [cards objectAtIndex:1];
        self.resultLabel.text = [NSString stringWithFormat:@"%@ %@", card1.contents, card2.contents];
    } else if ([cards count] == 3) {
        Card *card1 = [cards objectAtIndex:0];
        Card *card2 = [cards objectAtIndex:1];
        Card *card3 = [cards objectAtIndex:2];
        if (self.game.score > self.prevScore) {
            self.resultLabel.text = [NSString stringWithFormat:@"Matched %@ %@ %@ for %ld points.", card1.contents, card2.contents, card3.contents, self.game.score - self.prevScore];
        } else {
            self.resultLabel.text = [NSString stringWithFormat:@"%@ %@ %@ don't match! %ld point penalty!", card1.contents, card2.contents, card3.contents, self.prevScore + self.game.score];
        }
        [self.cards removeAllObjects];
    }
}

- (NSString *)titleForCard:(Card *)card {
    return card.isChosen ? card.contents : @"";
}

- (UIImage *)backgroundImageForCard:(Card *)card {
    return [UIImage imageNamed:card.isChosen ? @"cardfront" : @"cardback"];
}

@end
