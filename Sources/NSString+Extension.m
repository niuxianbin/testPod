//
//  NSString+Extension.m
//  EloancnBorrower
//
//  Created by WANG on 16/9/19.
//  Copyright © 2016年 xianbinniu. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)


- (BOOL)isStringNotNil{
    return self != nil && self != NULL && (![self isKindOfClass:[NSNull class]]);
}

- (BOOL)isStringNotNilEmpty{
    return [self isStringNotNil] && ![self isEqualToString:@""];
}


- (ELStringType)stringTypeFromValue:(NSString *)string{
    
    if (!string) {
        return ELStringTypeNil;
    }else if (string.length == 0){
        return ELStringTypeEmpty;
    }else{
        NSString *replaceStr = [string stringByReplacingOccurrencesOfString:string withString:@" "];
        if (replaceStr.length == 0) {
            return ELStringTypeAllSapce;
        }else{
            return ELStringTypeHaveValue;
        }
        
        
    }
    
}


- (BOOL)isEmoji{
    const unichar high = [self characterAtIndex: 0];
    
    // Surrogate pair (U+1D000-1F77F)
    if (0xd800 <= high && high <= 0xdbff) {
        const unichar low = [self characterAtIndex: 1];
        const int codepoint = ((high - 0xd800) * 0x400) + (low - 0xdc00) + 0x10000;
        
        return (0x1d000 <= codepoint && codepoint <= 0x1f77f);
        
        // Not surrogate pair (U+2100-27BF)
    } else {
        return (0x2100 <= high && high <= 0x27bf);
    }
}


- (BOOL)isIncludingEmoji{
    BOOL __block result = NO;
    
    [self enumerateSubstringsInRange:NSMakeRange(0, [self length])
                               options:NSStringEnumerationByComposedCharacterSequences
                            usingBlock: ^(NSString* substring, NSRange substringRange, NSRange enclosingRange, BOOL* stop) {
                                if ([substring isEmoji]) {
                                    *stop = YES;
                                    result = YES;
                                }
                            }];
    
    return result;
}

- (NSString *)removedEmojiString{
    NSMutableString* __block buffer = [NSMutableString stringWithCapacity:[self length]];
    
    [self enumerateSubstringsInRange:NSMakeRange(0, [self length])
                               options:NSStringEnumerationByComposedCharacterSequences
                            usingBlock: ^(NSString* substring, NSRange substringRange, NSRange enclosingRange, BOOL* stop) {
                                [buffer appendString:([substring isEmoji])? @"": substring];
                            }];
    
    return buffer;
}


- (NSString *)replaceSpecialCharacter{
    if (self.length == 0) {
        return @"";
    }
    NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@"¥「」\\|$€^•$^&"];
    NSString *trimmedString = [[self componentsSeparatedByCharactersInSet:set] componentsJoinedByString:@""];
    return trimmedString;
}
@end
