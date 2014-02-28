//
//  Card.h
//  Matchismo
//
//  Created by xiang zhang on 14-2-26.
//  Copyright (c) 2014年 xiang zhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject
@property(strong,nonatomic) NSString *contents;

@property(nonatomic,getter = isChosen) BOOL chosen;
@property(nonatomic,getter = isMatched) BOOL matched;

-(int)match:(NSArray *) otherCards;

@end
