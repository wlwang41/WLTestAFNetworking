//
//  ViewController.m
//  WLTestAFNetworking
//
//  Created by RavenLung on 6/19/15.
//  Copyright (c) 2015 SpiderLab. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	NSString *url = @"http://httpbin.org/get";
	NSDictionary *params = @{ @"key": @"value" };
	NSLog(@"url====> %@", url);
	[NetworkingManager GETWithUrl:url AndParams:params];
	url = @"http://httpbin.org/post";
	params = @{ @"data": @"post data" };
	[NetworkingManager POSTWithUrlFormEncoded:url AndParams:params];
    [NetworkingManager POSTWithMultipartFormData:url AndParams:params AndFilepath: @"file://cherry.png"];
}

- (void)didReceiveMemoryWarning
{
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

@end
