//
//  Automata.h
//  tactics-ios
//
//  Created by Amos, Grant ext (E IT S MCC) on 6/19/14.
//  Copyright (c) 2014 SomethingCool. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Automata : NSObject

- (id)initWithWidth:(int)width
             height:(int)height
         iterations:(int)iterations
         killAmount:(int)killAmount
      andGrowAmount:(int)growAmount;

- (int*)createAutomata;
- (int**)createAutomata2DArray;
- (NSArray*)createBoxedAutomata;

- (UIImage*)createAutomataImage;

@end
