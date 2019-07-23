//
//  NSString+GetCharacter.m
//  OC-9-1
//
//  Created by Ibokan on 14-11-26.
//  Copyright (c) 2014年 fghf. All rights reserved.
//

#import "NSString+GetCharacter.h"

@implementation NSString (GetCharacter)

- (NSString *)characterStringAtIndex:(NSUInteger)index
{
    unichar character = [self characterAtIndex:index];
    
    return [NSString stringWithFormat:@"%C", character];
    
}

@end





