//
//  PlayingCard.m
//  Matchismo
//
//  Created by Nick Freeman on 1/7/14.
//  Copyright (c) 2014 Nick Freeman. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

- (int)match:(NSArray *)otherCards {
    int score = 0;
    
    if ([otherCards count] == 1) {
        id card = [otherCards firstObject];
        if ([card isKindOfClass:[PlayingCard class]]) {
            PlayingCard *otherCard = (PlayingCard *)card;
            if ([self.suit isEqualToString:otherCard.suit]) {
                score = 1;
            } else if (self.rank == otherCard.rank) {
                score = 4;
            }
        }
    } else if ([otherCards count] == 2) {
        PlayingCard *firstCard = otherCards[0];
        PlayingCard *secondCard = otherCards[1];
        if ([self.suit isEqualToString:firstCard.suit] && [self.suit isEqualToString:secondCard.suit]) {
            score = 3;
        } else if ([self.suit isEqualToString:firstCard.suit] || [self.suit isEqualToString:secondCard.suit]) {
            score = 1;
        } else if (self.rank == firstCard.rank && self.rank == secondCard.rank) {
            score = 12;
        } else if (self.rank == firstCard.rank || self.rank == secondCard.rank) {
            score = 4;
        }
    }
    return score;
}

- (NSString *)contents {
    NSArray *rankStrings = [PlayingCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}

@synthesize suit = _suit;

+ (NSArray *)validSuits {
    return @[@"♠︎",@"♣︎",@"♥︎",@"♦︎"];
}

- (void) setSuit:(NSString *)suit {
    if ([[PlayingCard validSuits] containsObject:suit]) {
        _suit = suit;
    }
}

- (NSString *)suit {
    return _suit ? _suit: @"?";
}

+ (NSArray *)rankStrings {
    return @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
}

+ (NSUInteger)maxRank {
    return [[self rankStrings] count] - 1;
}

- (void)setRank:(NSUInteger)rank {
    if (rank <= [PlayingCard maxRank]) {
        _rank = rank;
    }
}

@end
