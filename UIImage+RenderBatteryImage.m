#include "UIImage+RenderBatteryImage.h"

@implementation UIImage (RenderBatteryImage)

+ (UIImage *) renderBatteryImageForTheme:(NSString *)theme height:(int)height percentage:(int)percentage charging:(BOOL)charging lpm:(BOOL)lpm color:(UIColor *)color {
	NSLog(@"LITHIUM: trying to render");
	return [[OBJCIPC sendMessageToSpringBoardWithMessageName:@"lithium.render" dictionary:@{ @"theme": theme, @"height": [NSNumber numberWithInt:(int)height], @"percentage": [NSNumber numberWithInt:percentage], @"charging": [NSNumber numberWithBool:charging], @"lpm": [NSNumber numberWithBool:lpm], @"color": color }] objectForKey:@"image"];
}

@end
