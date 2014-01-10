//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Nick Freeman on 1/8/14.
//  Copyright (c) 2014 Nick Freeman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"

@interface CardMatchingGame : NSObject

// designated initializer
- (instancetype)initWithCardCount:(NSUInteger)count
                        usingDeck:(Deck *)deck;

- (void)chooseCardAtIndex:(NSUInteger)index
              isThreeCard:(BOOL)threeCard;
- (Card *)cardAtIndex:(NSUInteger)index;

@property (nonatomic, readonly) NSInteger score;

@end
