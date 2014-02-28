//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by xiang zhang on 14-2-27.
//  Copyright (c) 2014年 xiang zhang. All rights reserved.
//

#import "CardMatchingGame.h"


@interface CardMatchingGame()
@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, strong) NSMutableArray *cards;// of Card
@property (nonatomic,strong) NSMutableArray *chosenArray;
@property(nonatomic) NSInteger count;

@end

@implementation CardMatchingGame

-(NSMutableArray *)chosenArray
{
    if(!_chosenArray)_chosenArray = [[NSMutableArray alloc] init];
    return _chosenArray;
}

-(NSMutableArray *) cards
{
    if(!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

-(instancetype) initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck
{
    self = [super init];
    if(self){
        
        for(int i=0;i<count;i++){
            Card *card = [deck drawRandomCard];
            if(card){
                [self.cards addObject:card];
            }else{
                self = nil;
                break;
            }
        }
        
    }
    return self;
    
}

-(Card *)cardAtIndex:(NSUInteger)index
{
    return (index <[self.cards count])? self.cards[index] : nil;
    
}


static const int MISMATCH_PENALTY =2;
static const int MATCH_BONUS=4;
static const int COST_TO_CHOOSE=1;



-(void)chooseCardAtIndex:(NSUInteger)index forMode:(NSInteger) mode
{
    
    Card *card = [self cardAtIndex:index];
    
    if(!card.isMatched){
        
        if(card.isChosen){
            card.chosen = NO;
        }else{
            if(mode==2){
                for(Card *otherCard in self.cards){
                    if(otherCard.isChosen && !otherCard.isMatched){
                        int matchScore = [card match:@[otherCard] forMode:mode];
                        if(matchScore){
                            self.score += matchScore * MATCH_BONUS;
                            otherCard.matched=YES;
                            card.matched=YES;
                            
                        }else{
                            self.score -= MISMATCH_PENALTY;
                            otherCard.chosen = NO;
                            
                        }
                        break;
                    }
                    
                }
                self.score -= COST_TO_CHOOSE;
                card.chosen=YES;
            }else{
                
                self.count++;
                
                if(self.count==3){
                    
                    for(Card *otherCard in self.cards){
                        if(otherCard.isChosen && !otherCard.isMatched){
                            [self.chosenArray addObject:otherCard];
        
                        }
                        
                    }
                }
                self.score -= COST_TO_CHOOSE;
                card.chosen=YES;
                
                if([self.chosenArray count]==2){
                    int matchScore = [card match:self.chosenArray forMode:mode];
                    
                    if(matchScore){
                        self.score += matchScore * MATCH_BONUS;
                        for(Card *chosenCard in self.chosenArray){
                            chosenCard.matched=YES;
                        }                        
                        card.matched=YES;
                        self.count=0;

                        
                    }else{
                        for(Card *chosenCard in self.chosenArray){
                            chosenCard.chosen=NO;
                        }
                        
                        self.score -= MISMATCH_PENALTY;
                        self.count=1;

                    
                    }
                    [self.chosenArray removeAllObjects];
                
                }
                
            }
        }
    }
    
    
}


@end
