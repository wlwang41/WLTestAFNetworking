//
//  networkingManager.m
//  WLTestAFNetworking
//
//  Created by RavenLung on 6/19/15.
//  Copyright (c) 2015 SpiderLab. All rights reserved.
//

#import "NetworkingManager.h"
@interface NetworkingManager ()

@end

@implementation NetworkingManager

+ (AFHTTPRequestOperationManager *)manager
{
	static AFHTTPRequestOperationManager *manager = nil;
	static dispatch_once_t oncePredicate;
	dispatch_once(&oncePredicate, ^{
	    manager = [AFHTTPRequestOperationManager manager];
	});

	return manager;
}

+ (void)GETWithUrl:(NSString *)url AndParams:(NSDictionary *)params
{
	AFHTTPRequestOperationManager *manager = NetworkingManager.manager;
	[manager GET:url parameters:params success: ^(AFHTTPRequestOperation *operation, id responseObject) {
	    NSLog(@"GET JSON: %@", responseObject);
	} failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
	    NSLog(@"GET Error: %@", error);
	}];
}

+ (void)POSTWithUrlFormEncoded:(NSString *)url AndParams:(NSDictionary *)params
{
	AFHTTPRequestOperationManager *manager = NetworkingManager.manager;
	[manager POST:url parameters:params success: ^(AFHTTPRequestOperation *operation, id responseObject) {
	    NSLog(@"POST JSON: %@", responseObject);
	} failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
	    NSLog(@"POST Error: %@", error);
	}];
}

+ (void) POSTWithMultipartFormData:(NSString *)url AndParams:(NSDictionary *)params AndFilepath:(NSString *)fileUrl
{
    AFHTTPRequestOperationManager *manager = NetworkingManager.manager;
    NSURL *filePath = [NSURL fileURLWithPath:fileUrl];
    [manager POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileURL:filePath name:fileUrl error:nil];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"POST JSON: %@", responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"POST Error: %@", error);
    }];
}

+ (void) downloadTask
{
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURL *URL = [NSURL URLWithString:@"http://example.com/download.zip"];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:nil destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        return [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        NSLog(@"File downloaded to: %@", filePath);
    }];
    [downloadTask resume];
}

+ (void) uploadTask
{
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURL *URL = [NSURL URLWithString:@"http://example.com/upload"];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURL *filePath = [NSURL fileURLWithPath:@"file://path/to/image.png"];
    NSURLSessionUploadTask *uploadTask = [manager uploadTaskWithRequest:request fromFile:filePath progress:nil completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
        } else {
            NSLog(@"Success: %@ %@", response, responseObject);
        }
    }];
    [uploadTask resume];
}

@end
