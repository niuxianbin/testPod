//
//  NSString+Extension.h
//  EloancnBorrower
//
//  Created by WANG on 16/9/19.
//  Copyright © 2016年 xianbinniu. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,ELStringType) {
    ELStringTypeNil,
    ELStringTypeEmpty,
    ELStringTypeAllSapce,
    ELStringTypeHaveValue,
};


@interface NSString (Extension)

- (BOOL)isStringNotNil;

//有值且不是空串
- (BOOL)isStringNotNilEmpty;


//字符串类型
- (ELStringType)stringTypeFromValue:(NSString *)string;

/** 判断字符是否是 emoji */
- (BOOL)isEmoji;

/** 判断字符串是否包含 emoji */
- (BOOL)isIncludingEmoji;

/** 删除字符串中的emoji */
- (NSString *)removedEmojiString;


- (NSString *)replaceSpecialCharacter;

@end
