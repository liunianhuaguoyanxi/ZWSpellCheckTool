//
//  ZWSpellCheckTool.m
//  data
//
//  Created by 流年划过颜夕 on 16/8/3.
//  Copyright © 2016年 流年划过颜夕. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "ZWSpellCheckTool.h"
@interface ZWSpellCheckTool()
{
    NSArray *dicFromTxtArr;
    NSArray *dicFromTypeArr;
    NSDictionary *underlineDictAtt;
}
@property (nonatomic, strong) NSMutableArray *correctWordArr;
@property (nonatomic, strong) NSMutableArray *errorWordArr;
@end
@implementation ZWSpellCheckTool
-(NSMutableArray *)correctWordArr
{
    if (!_correctWordArr) {
        _correctWordArr=[NSMutableArray array];
    }
    return _correctWordArr;
}
-(NSMutableArray *)errorWordArr
{
    if(!_errorWordArr){
        _errorWordArr=[NSMutableArray array];
    }
    return _errorWordArr;
}

-(NSMutableArray *)ZWWordCheckToolWith:(NSString *)text
{
    
    switch (self.languageType) {
            
        case en:
        {
            //English
            NSString*filePath=[[NSBundle mainBundle] pathForResource:@"english"ofType:@"txt"];
            
            dicFromTxtArr= [[NSString stringWithContentsOfFile:filePath encoding:CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingISOLatin1) error:nil] componentsSeparatedByString:@"\r\n"] ;
            
        }
            break;
            
        case es:
        {
            //spainsh run
            
            NSString*filePath=[[NSBundle mainBundle] pathForResource:@"spanish"ofType:@"txt"];
            
            dicFromTxtArr= [[NSString stringWithContentsOfFile:filePath encoding: CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingISOLatin1) error:nil] componentsSeparatedByString:@"\r"];
        }
            break;
        case fr:
            //French run
            
            {
                NSString*filePath=[[NSBundle mainBundle] pathForResource:@"french"ofType:@"txt"];
                
                dicFromTxtArr= [[NSString stringWithContentsOfFile:filePath encoding: CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingISOLatin1) error:nil] componentsSeparatedByString:@"\n"];
            }
            break;
            
        case de:
            //german run
             {
                NSString*filePath=[[NSBundle mainBundle] pathForResource:@"german"ofType:@"txt"];
                
                dicFromTxtArr= [[NSString stringWithContentsOfFile:filePath encoding:kCFStringEncodingUTF8 error:nil] componentsSeparatedByString:@"\r"];
             }
                
            break;
            
        case it:
            
            //italian
            {
                NSString*filePath=[[NSBundle mainBundle] pathForResource:@"italian"ofType:@"txt"];
                
                dicFromTxtArr= [[NSString stringWithContentsOfFile:filePath encoding:kCFStringEncodingUTF8 error:nil] componentsSeparatedByString:@"\r"];
            }
            break;
            
        case pt:
            //portugues
            {
                
                NSString*filePath=[[NSBundle mainBundle] pathForResource:@"portugues"ofType:@"txt"];
                
                dicFromTxtArr= [[NSString stringWithContentsOfFile:filePath encoding: CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingISOLatin1) error:nil] componentsSeparatedByString:@"\r"];
            }
            break;
            
         default:
        {
            NSString*filePath=[[NSBundle mainBundle] pathForResource:@"english"ofType:@"txt"];
            
            dicFromTxtArr= [[NSString stringWithContentsOfFile:filePath encoding:kCFStringEncodingUTF8 error:nil] componentsSeparatedByString:@"\r\n"];
        }
            
            break;

    }
    
    
    dicFromTypeArr=[text componentsSeparatedByString:@" "];
    
    [self.errorWordArr removeAllObjects];
    [self.correctWordArr removeAllObjects];

    
    for(int i=0;i<dicFromTypeArr.count;i++)
    {
        NSString *str2=[self unicode2ISO88591:dicFromTypeArr[i]];

       NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@"@／：!！?:；;:,，。.（）¥「」＂、_-———[]{}#%-*+=-_\\|~＜＞$€^•'@#$%^&*()_'\""];
        
        NSString *trimmedString = [str2 stringByTrimmingCharactersInSet:set];
        NSString *lowerCaseString = [trimmedString  lowercaseString];
        [self.errorWordArr addObject:str2];
        
        if ([dicFromTxtArr containsObject:lowerCaseString]) {
            [self.correctWordArr addObject:str2];
            //这样也可以

        }
//        for ( NSString *str in dicFromTxtArr) {
//
//
//
//            
//            NSString *lowerstr = [str  lowercaseString];
//            NSRange range1 = [lowerstr rangeOfString:lowerCaseString];//返回long类型范围最大值
//            if (range1.location==NSNotFound) {
//            }
//            else
//            {
//                
//                [self.correctWordArr addObject:str2];
//
//
//                break;
//            }
//
//        }
        
    }
    
    NSMutableArray *tmpErrorWordArr=[NSMutableArray array];
    [tmpErrorWordArr addObjectsFromArray:self.errorWordArr];
    for (int i=0; i<tmpErrorWordArr.count; i++) {
        for (NSString *correctStr in self.correctWordArr) {


            if ([correctStr isEqualToString:tmpErrorWordArr[i]]) {
                [self.errorWordArr removeObject:tmpErrorWordArr[i]];

            }
            if ([tmpErrorWordArr[i] isEqualToString:@""]) {
                 [self.errorWordArr removeObject:@""];
                
            }
        }
    }

    for (int i=0; i<self.errorWordArr.count; i++) {

    }
    
    return self.errorWordArr;
}


//选择对应的单词，确定位置
-(NSMutableAttributedString *)addSelectedErrorWordIntext:(NSString *)text WithTextFont:(UIFont *)font WithArr:(NSMutableArray *)arr WithErrorColor:(UIColor *)color WithUnderline:(BOOL)isUnderline
{
    if (text) {
        NSAttributedString *attributes =[[NSAttributedString alloc]initWithString:text];
        NSMutableAttributedString *matt = [attributes mutableCopy];
        NSDictionary *fontSizeAttr = @{NSFontAttributeName: [UIFont systemFontOfSize:12]};
        
        for (int i=0; i<arr.count; i++) {
            NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@"@／：!！?:；;:,，。.（）¥「」＂、_-———[]{}#%-*+=-_\\|~＜＞$€^•'@#$%^&*()_'\""];
            

            if ([self isPureInt:[[self unicode2ISO88591:arr[i]] stringByTrimmingCharactersInSet:set]]) {
                
            }
            else if([self isPureFloat:[[self unicode2ISO88591:arr[i]] stringByTrimmingCharactersInSet:set]])
            {
                
            }
            else{
            
            NSRange range = [[attributes string]rangeOfString:[self unicode2ISO88591:arr[i]]];
            
            if (range.location != NSNotFound) {
                //                NSLog(@" %@",attributes);
                NSDictionary *colorAttribute = @{NSForegroundColorAttributeName: color?color:[UIColor redColor]};
                if (isUnderline) {
                  underlineDictAtt = @{NSUnderlineStyleAttributeName : @(NSUnderlineStyleSingle)};
                  [matt addAttributes:underlineDictAtt range:range];
                }

                
                [matt addAttributes:fontSizeAttr range:range];
                [matt addAttributes:colorAttribute  range:range];

                
            }
                
            }
        }
        return matt;
    }
    
    return nil;
    

    
}

- (NSString *)unicode2ISO88591:(NSString *)string {
    
    
    NSStringEncoding enc =      CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingISOLatin9);
    
    
    return [NSString stringWithCString:[string UTF8String] encoding:enc];
    
    
}
- (BOOL)isPureInt:(NSString*)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return[scan scanInt:&val] && [scan isAtEnd];
}

- (BOOL)isPureFloat:(NSString*)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    float val;
    return[scan scanFloat:&val] && [scan isAtEnd];
}
@end
