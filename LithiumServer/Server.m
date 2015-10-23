#import <objcipc/objcipc.h>
#import <UIKit/UIKit.h>
#import <CoreGraphics/CoreGraphics.h>

#define BLANK_BASE64 @"iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAAAXNSR0IArs4c6QAAAAtJREFUCB1jYAACAAAFAAGNu5vzAAAAAElFTkSuQmCC"

static inline __attribute__((constructor)) void init() {
	@autoreleasepool {
		NSLog(@"LITHIUM: server starting");
		// NSMutableDictionary *themes = [NSMutableDictionary dictionary];
		[OBJCIPC registerIncomingMessageFromAppHandlerForMessageName:@"lithium.render" handler:^NSDictionary *(NSDictionary *msg) {
			NSLog(@"LITHIUM: render request received");
			/*if(![themes objectForKey:msg[@"theme"]]) {
				NSLog(@"LITHIUM: theme not loaded: %@", msg[@"theme"]);
				NSString *fileLocation = [[NSString alloc] initWithFormat:@"/Library/Lithium/%@.js", msg[@"theme"]];
				NSString *script;
				BOOL exists = [[NSFileManager defaultManager] fileExistsAtPath:fileLocation];
				NSLog(@"LITHIUM: file exists at %@: %@", fileLocation, exists ? @"YES" : @"NO");
				if(![[NSFileManager defaultManager] fileExistsAtPath:fileLocation]) script = @"";
				else script = [[NSMutableString alloc] initWithContentsOfFile:fileLocation encoding:NSUTF8StringEncoding error:nil];
				[fileLocation release];
				NSLog(@"LITHIUM: script loaded: %@", script);
				[themes setValue:script forKey:msg[@"theme"]];
			}*/
			NSData *base64Data;
			NSString *fileLocation = [[NSString alloc] initWithFormat:@"/Library/Lithium/%@.js", msg[@"theme"]];
			if(![[NSFileManager defaultManager] fileExistsAtPath:fileLocation]) base64Data = [[NSData alloc] initWithBase64EncodedString:BLANK_BASE64 options:0];
			else {
				NSString *javascript = [[NSString alloc] initWithContentsOfFile:fileLocation encoding:NSUTF8StringEncoding error:nil];
				int height = [msg[@"height"] intValue];
				int percentage = [msg[@"percentage"] intValue];
				BOOL charging = [msg[@"charging"] boolValue];
				BOOL lpm = [msg[@"lpm"] boolValue];
				BOOL low;
				if([(NSString*)[UIDevice currentDevice].model hasPrefix:@"iPad"]) {
					if(percentage <= 10) {
						low = YES;
					}
					else {
						low = NO;
					}
				}
				else {
					if(percentage <= 20) {
						low = YES;
					}
					else {
						low = NO;
					}
				}
				CGFloat r, g, b;
				[msg[@"color"] getRed:&r green:&g blue:&b alpha:nil];
				int rI = (int)(r * 255);
				int gI = (int)(g * 255);
				int bI = (int)(b * 255);
				UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectZero];
				[webView loadHTMLString:@"" baseURL:nil];
				NSString *stringData;
				if ([[[javascript componentsSeparatedByString:@")"][0] componentsSeparatedByString:@","] count] == 6) {
					stringData = [[NSString alloc] initWithString:[webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"(function%@)(%i,%i,%@,%@,%@,[%i,%i,%i])", javascript, height, percentage, charging ? @"true" : @"false", low ? @"true" : @"false", lpm ? @"true" : @"false", rI, gI, bI]]];
				}
				else {
					stringData = [[NSString alloc] initWithString:[webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"(function%@)(%i,%i,%@,%@,[%i,%i,%i])", javascript, height, percentage, charging ? @"true" : @"false", low ? @"true" : @"false", rI, gI, bI]]];
				}
				[webView release];
				if(stringData == nil) {
					NSLog(@"LITHIUM: nil stringData, blank");
					base64Data = [[NSData alloc] initWithBase64EncodedString:BLANK_BASE64 options:0];
				}
				else {
					base64Data = [[NSData alloc] initWithBase64EncodedString:[stringData substringFromIndex:([stringData rangeOfString:@"base64,"].location+7)] options:0];
				}
			}
			[fileLocation release];
			UIImage *image = [UIImage imageWithData:base64Data scale:[UIScreen mainScreen].scale];
			[base64Data release];
			return @{ @"image": image };
		}];

	}
}
