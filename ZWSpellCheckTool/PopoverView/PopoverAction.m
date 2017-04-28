//
//  PopoverAction.m
//  Popover
//
//  Created by StevenLee on 2016/12/10.
//  Copyright © 2016年 lifution. All rights reserved.
//

#import "PopoverAction.h"

@interface PopoverAction ()

@property (nonatomic, strong, readwrite) UIImage *image; ///< 图标
@property (nonatomic, copy, readwrite) NSString *title; ///< 标题
@property (nonatomic, copy, readwrite) void(^handler)(PopoverAction *action); ///< 选择回调

@property (nonatomic, copy, readwrite) NSString *hidID;

@property (nonatomic, assign, readwrite) int statusNum;

@property (nonatomic, assign, readwrite) int indexNum;

@end

@implementation PopoverAction


+ (instancetype)actionWithTitle:(NSString *)title statusNum:(int)statusNum handler:(void (^)(PopoverAction *action))handler {
    return [self actionWithImage:nil title:title statusNum:statusNum handler:handler];}

+ (instancetype)actionWithTitle:(NSString *)title hidID:(NSString *)hidID handler:(void (^)(PopoverAction *action))handler {
    return [self actionWithImage:nil title:title hidID:hidID handler:handler];}

+ (instancetype)actionWithTitle:(NSString *)title handler:(void (^)(PopoverAction *action))handler {
    return [self actionWithImage:nil title:title handler:handler];
}

+ (instancetype)actionWithImage:(UIImage *)image title:(NSString *)title handler:(void (^)(PopoverAction *action))handler {
    PopoverAction *action = [[self alloc] init];
    action.image = image;
    action.title = title ? : @"";
    action.handler = handler ? : NULL;
    
    return action;
}

+ (instancetype)actionWithImage:(UIImage *)image title:(NSString *)title hidID:(NSString *)hidID handler:(void (^)(PopoverAction *action))handler {
    PopoverAction *action = [[self alloc] init];
    action.image = image;
    action.title = title ? : @"";
    action.handler = handler ? : NULL;
    action.hidID=hidID;
    return action;
}
+ (instancetype)actionWithImage:(UIImage *)image title:(NSString *)title statusNum:(int)statusNum handler:(void (^)(PopoverAction *action))handler {
    PopoverAction *action = [[self alloc] init];
    action.image = image;
    action.title = title ? : @"";
    action.handler = handler ? : NULL;
    action.statusNum=statusNum;
    return action;
}

+ (instancetype)actionWithImage:(UIImage *)image title:(NSString *)title statusNum:(int)statusNum andIndexNum:(int)indexNum handler:(void (^)(PopoverAction *action))handler {
    PopoverAction *action = [[self alloc] init];
    action.image = image;
    action.title = title ? : @"";
    action.handler = handler ? : NULL;
    action.statusNum=statusNum;
    action.indexNum=indexNum;
    return action;
}

@end
