//
//  ToolMethod.h
//  Calendar
//
//  Created by emma on 15/6/16.
//  Copyright (c) 2015年 Emma. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, RelativeBasePoint) {
    RightTop,
    CenterTop,
    LeftTop,
    RightCenter,
    Center,
    LeftCenter,
    RightBottom,
    CenterBottom,
    LeftBottom,
};

@interface ToolMethod : NSObject
//字符型转日期型
+(NSDate*)StringToDate:(NSString*)string formatString:(NSString*)formatstring;
//日期型转字符型
+(NSString*)DateToString:(NSDate*)date formatString:(NSString*)formatstring;
//id转成整数
+(NSInteger)IDToInteger:(id)_number;
//将NSDictionary转换为指定的模型类
+(id)NSDictionaryToObject:(NSDictionary*)dictionary ObjectName:(NSString*)objectName;
+(id)NSDictionaryToObject:(NSDictionary*)dictionary Object:(NSObject*)object;
//将多层嵌套的NSDictionary层层剥皮得到需要的值
+(id)PeelOfftheSkin:(NSArray*)dictionaryKeys dictionary:(NSDictionary*)dictionary;
//截取字符串
+(NSString*)SubString:(NSString*) string withHelps:(NSArray*) subStringHelpers;
//用相对位置设置控件位置,基视图，需要设置的视图，基视图的基点，设置视图的基点，偏移量
+(void)setUiViewLocatin:(UIView*)baseView settedView:(UIView*)settedView relativeBasePoint:(RelativeBasePoint)relativeBasePoint
        settedBasePoint:(RelativeBasePoint) settedBasePoint offset:(CGPoint)offset;
+(NSInteger)getIntegerFromArray:(NSArray*)array index:(NSUInteger)index;
@end
@interface SubStringHelper : NSObject
@property(nonatomic,copy)NSString* substring;
@property(nonatomic,assign)BOOL before;
@property(nonatomic,assign)BOOL keepsubstring;
@property(nonatomic,assign)NSStringCompareOptions CompareOptions;
-(id)initWithSubString:(NSString*) _substring before:(BOOL)_before keepsubstring:(BOOL)_keepsubstring NSStringCompareOptions:(NSStringCompareOptions) CompareOptions;
//关键字，取前面还是后面，是否保留关键字,是否从后搜
@end
