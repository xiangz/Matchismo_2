//
//  PlayingCard.m
//  Matchismo
//
//  Created by xiang zhang on 14-2-26.
//  Copyright (c) 2014年 xiang zhang. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard


-(int) match:(NSArray *)otherCards forMode:(NSInteger) mode
{
    int score =0;
    
    
    if (mode==2) {
        if([otherCards count]==1){
            PlayingCard *otherCard = [otherCards firstObject];
            if(otherCard.rank == self.rank){
                score=4;
            }else if(otherCard.suit == self.suit){
                score =1;
            }
        
        }
    }else{
        if([otherCards count]==2){
            PlayingCard *card1 = otherCards[0];
            PlayingCard *card2 = otherCards[1];
            if((card1.suit==card2.suit&&card1.suit==self.suit)||(card1.rank==card2.rank&&card2.rank==self.rank)){
                score = 20;
                
            }else if(card1.suit==card2.suit||card1.suit==self.suit||card2.suit==self.suit){
                score = 1;
            }else if(card1.rank==card2.rank||card2.rank==self.rank||card1.rank==self.rank){
                score=4;
            }
            
        }
        
        
        
    }
    
    
    
    
    
    
    return score;
}

-(NSString *)contents
{
    
    NSArray *rankStrings= [PlayingCard rankStrings];
    
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}

@synthesize suit = _suit;

+(NSArray *)validSuits
{
    return @[@"♥",@"♦",@"♣",@"♠"];
}

-(void)setSuit:(NSString *)suit
{
    if( [[PlayingCard validSuits]containsObject:suit]){
        _suit = suit;
    }
//
}

-(NSString *)suit
{
    return _suit ? _suit:@"?";
}

+(NSArray *)rankStrings
{
    return @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
}
+(NSInteger)maxRank{ return [[self rankStrings] count]-1;}

-(void)setRank:(NSUInteger)rank
{
    if(rank <= [PlayingCard maxRank]){
        _rank = rank;
    }
    
}
@end
