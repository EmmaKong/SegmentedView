//
//  Activity.h
//  Calendar
//
//  Created by emma on 15/5/12.
//  Copyright (c) 2015年 Emma. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Activity : NSObject

@property (nonatomic, copy) NSString     *title;
@property (nonatomic, copy) NSString     *date;
@property (nonatomic, copy) NSString     *sponsor;
@property (nonatomic, copy) NSString     *address;
@property (nonatomic, copy) NSString     *activitytag;
@property (nonatomic, copy) NSString     *begintime;
@property (nonatomic, copy) NSString     *endtime;
@property (nonatomic, copy) NSString     *detail;


@property (nonatomic, assign) BOOL      isChecked;

- (id)initWithPropertiesDictionary:(NSDictionary *)dic;

@end
