//
//  ToolMethod.m
//  Calendar
//
//  Created by emma on 15/6/16.
//  Copyright (c) 2015年 Emma. All rights reserved.
//

#import "ToolMethod.h"
#import <objc/runtime.h>

@implementation ToolMethod

+(NSDate*)StringToDate:(NSString*)string formatString:(NSString*)formatstring{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: formatstring];
    NSDate *destDate= [dateFormatter dateFromString:string];
    return destDate;
}
+(NSString*)DateToString:(NSDate*)date formatString:(NSString*)formatstring{
    //    if([date isKindOfClass: [NSString class]])
    //        return (NSString *)date;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: formatstring];
    return [dateFormatter stringFromDate:date];
}
+ (NSInteger)IDToInteger:(id)_number;{
    NSNumber *number=_number;
    return [number intValue];
}
//通过类名得到类
+(id)GetObjectForObjectName:(NSString*)objectName{
    return [[ NSClassFromString(objectName) alloc]init];
}
//将NSDictionary转换成指定的类
+(id)NSDictionaryToObject:(NSDictionary*)dictionary ObjectName:(NSString*)objectName{
    return [ToolMethod NSDictionaryToObject:dictionary Object:[ToolMethod GetObjectForObjectName:objectName]];
}
+(id)NSDictionaryToObject:(NSDictionary*)dictionary Object:(NSObject*)object{
    @try{
        NSArray *keys=[dictionary allKeys];
        for (NSString *key in keys) {
            id value=[dictionary objectForKey:key];
            if([value isKindOfClass:[NSArray class]]){
                NSArray *arr=value;
                NSMutableArray *array=[[NSMutableArray alloc]init];
                if([ToolMethod CheckPropForObject:key forObject:[object class]]){
                    [object setValue:array forKey:key];
                    for (NSDictionary *dic in arr) {
                        
                        id va=[ToolMethod NSDictionaryToObject:dic ObjectName:[ToolMethod removeLastS:key]];
                        [array addObject:va];
                        //                    for (NSString * key in [dic allKeys]) {
                        //                        NSLog(@"%@",[va valueForKey:key]);
                        //                    }
                        
                    }
                }
            }else if([value isKindOfClass:[NSDictionary class]]){
                if([ToolMethod CheckPropForObject:key forObject:[object class]])
                    
                    [object setValue:[ToolMethod NSDictionaryToObject:value ObjectName:[ToolMethod remove_:key]] forKey:key];
            }else{
                if([ToolMethod CheckPropForObject:key forObject:[object class]])
                    [object setValue:value forKey:key];
            }
        }
    }@catch (NSException* ex) {
        
     
    }
    return object;
}
+(NSString*)removeLastS:(NSString*)objectname{
    SubStringHelper *subhelper=[[SubStringHelper alloc]initWithSubString:@"s" before:YES keepsubstring:NO NSStringCompareOptions:NSBackwardsSearch];
    return [ToolMethod SubString:objectname withHelps:@[subhelper]];
}
+(NSString*)remove_:(NSString*)objectname{
    SubStringHelper *subhelper=[[SubStringHelper alloc]initWithSubString:@"_" before:NO keepsubstring:NO NSStringCompareOptions:NSCaseInsensitiveSearch];
    return [ToolMethod SubString:objectname withHelps:@[subhelper]];
}
//检查指定的类里面是否有指定的属性
+(BOOL)CheckPropForObject:(NSString*)propName forObject:(Class) class{
    unsigned int nCount = 0;
    objc_objectptr_t *popertylist = class_copyPropertyList(class,&nCount);
    for (int i = 0; i < nCount; i++) {
        objc_objectptr_t property = popertylist[i];
        if([propName compare:[NSString stringWithUTF8String:property_getName(property)]]==NSOrderedSame)
            return YES;
    }
    return NO;
}
////去除NSDictonary不需要的外壳
//+(id)PeelOfftheSkin:(NSArray*)dictionaryKeys dictionary:(NSDictionary*)dictionary
//{
//    NSDictionary *temp = dictionary;
//    for (int i = 0;i < dictionaryKeys.count; i++) {
//        if(i < dictionaryKeys.count - 1){
//            if(!(temp = [temp objectForKey:dictionaryKeys[i]]))
//                return nil;
//        }else{
//            return [temp objectForKey:dictionaryKeys[i]];
//        }
//    }
//}

//用相对位置设置控件位置
+(void)setUiViewLocatin:(UIView*)baseView settedView:(UIView*)settedView relativeBasePoint:(RelativeBasePoint)relativeBasePoint
        settedBasePoint:(RelativeBasePoint) settedBasePoint offset:(CGPoint)offset{
    CGPoint baseviewLocation=baseView.frame.origin;
    CGSize baseviewSize=baseView.frame.size;
    CGSize settedviewSize=settedView.frame.size;
    CGFloat offsetx=0;
    CGFloat offsety=0;
    if(relativeBasePoint==RightCenter||relativeBasePoint==Center||relativeBasePoint==LeftCenter){
        offsety=baseviewSize.height/2;
    }else if(relativeBasePoint==RightBottom||relativeBasePoint==CenterBottom||relativeBasePoint==LeftBottom){
        offsety=baseviewSize.height;
    }
    
    if(relativeBasePoint==CenterTop||relativeBasePoint==Center||relativeBasePoint==CenterBottom){
        offsetx=baseviewSize.width/2;
    }else if(relativeBasePoint==RightBottom||relativeBasePoint==RightCenter||relativeBasePoint==RightTop){
        offsetx=baseviewSize.width;
    }
    
    if(settedBasePoint==RightCenter||settedBasePoint==Center||settedBasePoint==LeftCenter){
        offsety=offsety-settedviewSize.height/2;
    }else if(settedBasePoint==RightBottom||settedBasePoint==CenterBottom||settedBasePoint==LeftBottom){
        offsety=offsety-settedviewSize.height;
    }
    
    if(settedBasePoint==CenterTop||settedBasePoint==Center||settedBasePoint==CenterBottom){
        offsetx=offsetx-settedviewSize.width/2;
    }else if(settedBasePoint==RightBottom|settedBasePoint==RightCenter||settedBasePoint==RightTop){
        offsetx=offsetx-settedviewSize.width;
    }
    settedView.frame=CGRectMake(baseviewLocation.x+offsetx+offset.x, baseviewLocation.y+offsety+offset.y, settedView.frame.size.width, settedView.frame.size.height);
    
}

//截取字符串
+(NSString*)SubString:(NSString*) string withHelps:(NSArray*) subStringHelpers{
    @try {
        
        for (SubStringHelper* help in subStringHelpers) {
            
            NSRange range=[string rangeOfString:help.substring options:help
                           .CompareOptions];
            if(help.before)
            {
                if(help.keepsubstring){
                    string=[string substringToIndex:range.location+range.length];
                }else{
                    string=[string substringToIndex:range.location];
                }
            }else{
                if(help.keepsubstring){
                    string= [string substringFromIndex:range.location];
                }else{
                    string=[string substringFromIndex:range.location+range.length];
                }
            }
        }
        return string;
        
    }
    @catch (NSException *exception) {
        return string;
    }
    @finally {
        
    }
}

//从Array取出数字
+(NSInteger)getIntegerFromArray:(NSArray*)array index:(NSUInteger)index{
    if(array.count<=index)
        return 0;
    NSNumber *number=[array objectAtIndex:index];
    return [number integerValue];
}
@end

@implementation SubStringHelper
@synthesize substring,before,keepsubstring,CompareOptions;
-(id)initWithSubString:(NSString*) _substring before:(BOOL)_before keepsubstring:(BOOL)_keepsubstring  NSStringCompareOptions:(NSStringCompareOptions) CompareOptions{
    if(self=[super init]){
        self.substring=_substring;
        self.before=_before;
        self.keepsubstring=_keepsubstring;
        self.CompareOptions=CompareOptions;
    }
    
    return self;
}

@end
