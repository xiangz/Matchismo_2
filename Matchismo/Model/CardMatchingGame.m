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
@property(nonatomic,readwrite)NSString *notification;

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
                            self.notification =[NSString stringWithFormat:@"Matched %@ %@ for %d points",card.contents,otherCard.contents,matchScore*MATCH_BONUS];
                            
                        }else{
                            self.notification =[NSString stringWithFormat:@"%@ %@ don’t match! %d points penalty!",card.contents,otherCard.contents,MISMATCH_PENALTY];
                            self.score -= MISMATCH_PENALTY;
                            otherCard.chosen = NO;
                            
                        }
                        break;
                    }
                    self.notification = card.contents;
                    
                }
                
                self.score -= COST_TO_CHOOSE;
                card.chosen=YES;
            }else{
                int count=1;
                for(Card *otherCard in self.cards){
                    if(otherCard.isChosen && !otherCard.isMatched){
                        count++;
                    }
                    
                }

                
                self.notification = card.contents;
                if(count==3){
                    
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
                        if(matchScore==20){
                            self.notification =[NSString stringWithFormat:@"All 3 cards matched, get %d points",matchScore*MATCH_BONUS];
                        }else if(matchScore==4){
                            self.notification = [NSString stringWithFormat:@"2 cards'rank mathed, only get %d points",matchScore*MATCH_BONUS];
                        }else{
                            self.notification = [NSString stringWithFormat:@"2 cards'suit mathed, only get %d points",matchScore*MATCH_BONUS];
                        }
                        
                    }else{
                        for(Card *chosenCard in self.chosenArray){
                            chosenCard.chosen=NO;
                        }
                        
                        self.score -= MISMATCH_PENALTY;
                        self.notification =[NSString stringWithFormat:@" Don’t match! %d points penalty!",MISMATCH_PENALTY ];
                    
                    }
                    [self.chosenArray removeAllObjects];
                
                }
                
            }
        }
    }
    
    
}


@end
