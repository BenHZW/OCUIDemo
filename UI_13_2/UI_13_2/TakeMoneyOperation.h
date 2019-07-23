//
//  TakeMoneyOperation.h
//  UI_13_2
//
//  Created by apple on 15/10/19.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MoneyAccout.h"
@interface TakeMoneyOperation : NSOperation

//哪个人取钱:@"A",@"B",@"C"
@property(nonatomic,copy)NSString *moneyTaker;

//取的是哪个账户的钱
@property(atomic,retain)MoneyAccout *account;



@end
