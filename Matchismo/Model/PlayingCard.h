//
//  PlayingCard.h
//  Matchismo
//
//  Created by xiang zhang on 14-2-26.
//  Copyright (c) 2014年 xiang zhang. All rights reserved.
//

#import "Card.h"

@interface PlayingCard : Card

@property(strong,nonatomic) NSString *suit;
@property(nonatomic) NSUInteger rank;
+(NSArray *) validSuits;
+(NSArray *) rankStrings;
+(NSInteger) maxRank;
@end
