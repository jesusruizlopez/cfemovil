//
//  RequestsCenter.h
//  CFEMovilDemo
//
//  Created by Jesús Ruiz on 08/09/14.
//  Copyright (c) 2014 Pretzel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RequestsCenter : NSObject

+ (NSDictionary *)getFailures;
+ (NSDictionary *)sendReport:(NSDictionary *)report;

@end
