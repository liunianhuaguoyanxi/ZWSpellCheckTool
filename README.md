# ZWSpellCheckTool
It’s  easy way to do spell check about many contries’ language.（一种快捷方便的方法来对许多国家的语言做拼写检查.）

## Support to do such languages spell check（支持检查的语言种类如下）
###    en---English-------(英语)
###    es---Spanish-------(西班牙语)
###    fr---French--------(法语）
###    de---German--------(德语)
###    it---Italian-------(意大利语)
###    pt---Portuguese----(葡萄牙语)
##
## How to use（使用方法）
### Import the header file（导入头文件）
##
    #import "ZWSpellCheckTool.h"
##
#### 1. To initialize the ZWSpellCheckTool (初始化)
##
    ZWSpellCheckTool *spellCheckTool =[[ZWSpellCheckTool alloc]init];
##
#### 2. To set the languageTyp (设置检查语言类型，枚举类型)
##
    spellCheckTool.languageType=1；
##
#### 3. To start the language spell check  (检查并返回错误单词数组)
##
    NSMutableArray *errorArr =[spellCheckTool ZWWordCheckToolWith:self.textContentView.text];
##
#### 4. To do the mark about error words  (展示并标记错误单词的位置)
##
    self.textContentView.attributedText=[spellCheckTool addSelectedErrorWordIntext:self.textContentView.text WithTextFont:self.textContentView.font WithArr:errorArr WithErrorColor:[UIColor redColor] WithUnderline:YES];
##
## Exam:

-(void)spellCheck
{
    
       //耗时操作，创建子线程，用于查找输入错误的单词
    
    __weak typeof(self) weakSelf = self;
    dispatch_queue_t downloadQueue = dispatch_queue_create("findErrorWords", NULL);
    dispatch_async(downloadQueue, ^{
        
        ZWSpellCheckTool *spellCheckTool =[[ZWSpellCheckTool alloc]init];
        
        //设置检查语言类型
        spellCheckTool.languageType=1;
        
        //返回错误的单词
        NSMutableArray *errorArr =[spellCheckTool ZWWordCheckToolWith:weakSelf.textContentView.text];
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            //在回到主线程，刷新UI，给错误单词标红
            
            weakSelf.textContentView.attributedText=[spellCheckTool addSelectedErrorWordIntext:weakSelf.textContentView.text WithTextFont:weakSelf.textContentView.font WithArr:errorArr WithErrorColor:[UIColor redColor] WithUnderline:YES];
            
        }); });
    
}
