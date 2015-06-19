//
//  networkingManager.h
//  WLTestAFNetworking
//
//  Created by RavenLung on 6/19/15.
//  Copyright (c) 2015 SpiderLab. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetworkingManager : NSObject

+ (void)GETWithUrl:(NSString *)url AndParams:(NSDictionary *)params;
+ (void)POSTWithUrlFormEncoded:(NSString *)url AndParams:(NSDictionary *)params;
+ (void) POSTWithMultipartFormData:(NSString *)url AndParams:(NSDictionary *)params AndFilepath:(NSString *)fileUrl;

@end
