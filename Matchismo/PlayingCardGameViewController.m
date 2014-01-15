//
//  PlayingCardGameViewController.m
//  Matchismo
//
//  Created by Nick Freeman on 1/14/14.
//  Copyright (c) 2014 Nick Freeman. All rights reserved.
//

#import "PlayingCardGameViewController.h"
#import "PlayingCardDeck.h"

@interface PlayingCardGameViewController ()

@end

@implementation PlayingCardGameViewController

- (Deck *)createDeck {
    return [[PlayingCardDeck alloc] init];
}

@end
