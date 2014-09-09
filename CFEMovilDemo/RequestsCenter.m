//
//  RequestsCenter.m
//  CFEMovilDemo
//
//  Created by Jesús Ruiz on 08/09/14.
//  Copyright (c) 2014 Pretzel. All rights reserved.
//

#import "RequestsCenter.h"
#define BASE_URL @"http://localhost:3000"
#define TIMEOUT_NORMAL 10

@implementation RequestsCenter

+ (NSDictionary *)getFailures {
    NSError *error;
    NSURLResponse *response;
    
    NSString *url = [NSString stringWithFormat:@"%@/getFailures", BASE_URL];
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
    [request setTimeoutInterval:TIMEOUT_NORMAL];
    [request setHTTPMethod:@"GET"];
    
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    if (error) {
        return @{@"success": @"0", @"message": @"Ocurrió un problema con el servidor"};
    }
    else {
        NSDictionary *results = [NSJSONSerialization JSONObjectWithData:returnData options:NSJSONReadingMutableContainers error:&error];
        return results;
    }
}

+ (NSDictionary *)sendReport:(NSDictionary *)report {
    NSError *error;
    NSURLResponse *response;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:report options:NSJSONWritingPrettyPrinted error:&error];
    
    NSString *url = [NSString stringWithFormat:@"%@/sendReport", BASE_URL];
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
    
    [request setTimeoutInterval:TIMEOUT_NORMAL];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:jsonData];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    if (error) {
        return @{@"success": @"0", @"message": @"Ocurrió un error con el servidor"};
    }
    else {
        NSDictionary *results = [NSJSONSerialization JSONObjectWithData:returnData options:NSJSONReadingMutableContainers error:&error];
        return results;
    }
}

@end
