//
//  PlayingCardDeck.m
//  Matchismo
//
//  Created by xiang zhang on 14-2-26.
//  Copyright (c) 2014年 xiang zhang. All rights reserved.
//

#import "PlayingCardDeck.h"
#import "PlayingCard.h"

@implementation PlayingCardDeck

-(instancetype)init
{
    self = [super init];
    if(self)
    {
        for (NSString *suit in [PlayingCard validSuits]) {
            for(NSInteger rank=1;rank<=[PlayingCard maxRank];rank++){
                PlayingCard *card = [[PlayingCard alloc] init];
                card.suit = suit;
                card.rank = rank;
                [self addCard:card];
            }
                
        }
        
    }
    return self;
}

@end
