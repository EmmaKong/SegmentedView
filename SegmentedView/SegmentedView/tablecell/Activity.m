//
//  Activity.m
//  Calendar
//
//  Created by emma on 15/5/12.
//  Copyright (c) 2015年 Emma. All rights reserved.
//

#import "Activity.h"

@implementation Activity


- (id)initWithPropertiesDictionary:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        if (dic != nil) {
            self.title = [dic objectForKey:@"title"];
            self.date = [dic objectForKey:@"date"];
            self.address = [dic objectForKey:@"address"];
            self.sponsor = [dic objectForKey:@"sponsor"];
            self.activitytag = [dic objectForKey:@"activitytag"];
            self.begintime = [dic objectForKey:@"begintime"];
            self.endtime = [dic objectForKey:@"endtime"];
            self.detail = [dic objectForKey:@"detail"];
    
        }
    }
    
    return self;
}

- (NSString *)description
{
    NSString *result = @"";
    result = [result stringByAppendingFormat:@"title : %@\n",self.title];
    result = [result stringByAppendingFormat:@"date : %@\n",self.date];
    result = [result stringByAppendingFormat:@"address : %@\n",self.address];
    result = [result stringByAppendingFormat:@"sponsor : %@\n",self.sponsor];
    result = [result stringByAppendingFormat:@"activitytag: %@\n",self.activitytag];
    result = [result stringByAppendingFormat:@"begintime: %@\n",self.begintime];
    result = [result stringByAppendingFormat:@"endtime: %@\n",self.endtime];
    result = [result stringByAppendingFormat:@"detail: %@\n",self.detail];
    return result;
}


@end
