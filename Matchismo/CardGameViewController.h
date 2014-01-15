//
//  CardGameViewController.h
//  Matchismo
//
//  Created by Nick Freeman on 1/7/14.
//  Copyright (c) 2014 Nick Freeman. All rights reserved.
//
// Abstract class. Must implement methods below.

#import <UIKit/UIKit.h>
#import "Deck.h"

@interface CardGameViewController : UIViewController

// protected
- (Deck *)createDeck; //abstract

@end
