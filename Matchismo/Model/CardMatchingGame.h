//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by xiang zhang on 14-2-27.
//  Copyright (c) 2014年 xiang zhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"
#import "Card.h"

@interface CardMatchingGame : NSObject

-(instancetype) initWithCardCount:(NSUInteger) count
                        usingDeck:(Deck *) deck;

-(void)chooseCardAtIndex:(NSUInteger)index forMode:(NSInteger) mode;

-(Card *)cardAtIndex:(NSUInteger)index;

@property (nonatomic, readonly) NSInteger score;
@property(nonatomic,readonly)NSString *notification;

@end
