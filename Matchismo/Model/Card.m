//
//  Card.m
//  Matchismo
//
//  Created by xiang zhang on 14-2-26.
//  Copyright (c) 2014年 xiang zhang. All rights reserved.
//

#import "Card.h"

@interface Card()

@end

@implementation Card

-(int)match:(NSArray *)otherCards forMode:(NSInteger)mode
{
    int score = 0;
    
    for(Card *card in otherCards){
        if([card.contents isEqualToString:self.contents]){
            score =1;
        }
    }
    return score;
}


@end
