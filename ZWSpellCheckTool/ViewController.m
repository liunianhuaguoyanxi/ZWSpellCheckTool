//
//  ViewController.m
//  ZWSpellCheckTool
//
//  Created by 流年划过颜夕 on 16/10/19.
//  Copyright © 2016年 liunian. All rights reserved.
//

#import "ViewController.h"
#import "ZWSpellCheckTool.h"
#import "PopoverView.h"
@interface ViewController ()<UITextViewDelegate>
//输入检测的文字内容
@property (nonatomic, weak) UITextView *textContentView;
//输入需要检测哪个国家的语言简写，支持英语en，法语fr，德语de，意大利语it，班牙语es,葡萄牙语pt.
@property (nonatomic, weak) UIButton *selectBtn;

@property (nonatomic, assign)BOOL isStartSpellCheak;

@property (nonatomic, weak)UIButton *startTest;

@property (nonatomic, strong)NSArray    *ZWLanguageListArr;

@property (nonatomic, assign)int   languageNum;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *ZWLanguageListArr=[NSArray arrayWithObjects:@"en(英语)",@"es(西班牙)",@"fr(法语)",@"de(德语)",@"it(意大利)",@"pt(葡萄牙)" ,nil];
    self.ZWLanguageListArr=ZWLanguageListArr;
    
    UILabel *languageStr=[[UILabel alloc]initWithFrame:CGRectMake(20, 40, self.view.frame.size.width-40, 60)];
    languageStr.text=@"1.(选择语言)choose language\n2.(输入文本)wirte something\n3.(点击开始检测)click button";
    languageStr.numberOfLines=0;
    languageStr.textAlignment=NSTextAlignmentCenter;
    languageStr.font=[UIFont systemFontOfSize:15];
    [self.view addSubview:languageStr];
    
    
    UIButton *selectBtn=[[UIButton alloc]initWithFrame:CGRectMake((self.view.frame.size.width-100)/2, 110, 100, 30)];
    selectBtn.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:selectBtn];
    [selectBtn setTitle:@"en" forState:0];
    [selectBtn setTitleColor:[UIColor blackColor] forState:0];
    selectBtn.titleLabel.font=[UIFont systemFontOfSize:15];
    [selectBtn addTarget:self action:@selector(clickToShowLanguageNameList:) forControlEvents:UIControlEventTouchUpInside];
    self.selectBtn=selectBtn;
    
    self.view.backgroundColor=[UIColor lightGrayColor];
    UITextView *textContentView=[[UITextView alloc]initWithFrame:CGRectMake((self.view.frame.size.width-200)/2, 200, 200, 200)];
    textContentView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:textContentView];
    textContentView.delegate=self;
    textContentView.autocorrectionType = UITextAutocorrectionTypeNo;
    textContentView.spellCheckingType=NO;
    self.textContentView=textContentView;
    
    UIButton *startTest=[UIButton buttonWithType:0];
    startTest.frame=CGRectMake((self.view.frame.size.width-100)/2, 150, 100, 30);
    startTest.backgroundColor=[UIColor redColor];
    [startTest setTitle:@"开始检测" forState:0];
    [startTest addTarget:self action:@selector(startSpellCheck) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:startTest];
    self.startTest=startTest;




}
-(void)clickToShowLanguageNameList:(UIButton *)sender
{
    //点击按钮的响应事件；
    NSMutableArray *tmp=[NSMutableArray array];
        __weak typeof(self) weakSelf = self;
    for (int i=0; i<self.ZWLanguageListArr.count; i++) {
        PopoverAction *action = [PopoverAction actionWithTitle:self.ZWLanguageListArr[i] handler:^(PopoverAction *action) {
            [sender setTitle: [action.title substringWithRange:NSMakeRange(0,2)] forState:0] ;
            NSLog(@"%@ tmpstr",[action.title substringWithRange:NSMakeRange(0,2)]);
            weakSelf.textContentView.text=nil;
            weakSelf.languageNum=i;
        }];
        [tmp addObject:action];
        
        
    }
    
    PopoverView *popoverView = [PopoverView popoverView];
    [popoverView showToView:sender withActions:[NSArray arrayWithArray:tmp]];
}


-(void)spellCheck
{
    

    __weak typeof(self) weakSelf = self;
    dispatch_queue_t downloadQueue = dispatch_queue_create("findErrorWords", NULL);
    //在线程队列里面创建一个子线程，用了查找输入错误的单词
    dispatch_async(downloadQueue, ^{
        
        ZWSpellCheckTool *spellCheckTool =[[ZWSpellCheckTool alloc]init];
        spellCheckTool.languageType=self.languageNum;
        //返回错误的单词
        NSMutableArray *errorArr =[spellCheckTool ZWWordCheckToolWith:weakSelf.textContentView.text];
        
        
               [weakSelf.startTest setTitle:@"检测完成" forState:0];
        
        
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            //在回到主线程，刷新UI，给错误单词标红
            
            weakSelf.textContentView.attributedText=[spellCheckTool addSelectedErrorWordIntext:weakSelf.textContentView.text WithTextFont:weakSelf.textContentView.font WithArr:errorArr WithErrorColor:[UIColor redColor] WithUnderline:YES];
            
                            [weakSelf.startTest setTitle:@"开始检测" forState:0];
        }); });

}

-(void)startSpellCheck
{
    self.isStartSpellCheak=!self.isStartSpellCheak;
    if (self.isStartSpellCheak) {
        [self.startTest setTitle:@"正在检测" forState:0];
        [self spellCheck];
    }else
    {
        [self.startTest setTitle:@"开始检测" forState:0];

    }
    


    }



@end
