//
//  ZWSpellCheckTool.h
//  data
//
//  Created by 流年划过颜夕 on 16/8/3.
//  Copyright © 2016年 流年划过颜夕. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZWSpellCheckTool : NSObject
typedef enum : NSUInteger {
    en,                       //English    (英语)
    es,                       //Spanish    (西班牙语)
    fr,                       //French    （法语）
    de,                       //German    （德语）
    it,                       //Italian    (意大利语)
    pt,                       //Portuguese（葡萄牙语）
    
}LanguageType;
@property (nonatomic, assign) LanguageType languageType;

//从text中取出拼写错误的单词封装成数组(From the text get misspelled words in the array)
-(NSMutableArray *)ZWWordCheckToolWith:(NSString *)text;


/**
 *  //导入数组，给拼写错误的单词标红(Import the array,make the mark for misspelled words)
 *
 *  @param text       text文本内容
 *  @param arr        装有错误单词的数组
 *
 *  @return 标红后的text文本  (do mark about  misspelled words in NSMutableAttributedString )
 */
-(NSMutableAttributedString *)addSelectedErrorWordIntext:(NSString *)text WithTextFont:(UIFont *)font WithArr:(NSMutableArray *)arr WithErrorColor:(UIColor *)color WithUnderline:(BOOL)isUnderline;
@end
