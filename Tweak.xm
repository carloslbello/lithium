#include "LTMPrefsManager.m"
#include "UIImage+RenderBatteryImage.m"

@interface NSUserDefaults (Lithium)
- (id)objectForKey:(NSString *)key inDomain:(NSString *)domain;
- (void)setObject:(id)value forKey:(NSString *)key inDomain:(NSString *)domain;
@end



static void notificationCallback(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo) {
	NSNumber *n = (NSNumber*)[[NSUserDefaults standardUserDefaults] objectForKey:@"lithiumEnabled" inDomain:@"lithium"];
	if(n) [LTMPrefsManager sharedManager].enabled = [n boolValue];
	NSString *theme = [[NSUserDefaults standardUserDefaults] objectForKey:@"lithiumTheme" inDomain:@"lithium"];
	if(theme) [LTMPrefsManager sharedManager].theme = (NSMutableString*)theme;
}

%ctor {
	CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), nil, notificationCallback, (CFStringRef)@"lithium.prefs-changed", nil, CFNotificationSuspensionBehaviorCoalesce);
}

%hook UIStatusBarBatteryItemView

- (BOOL)_needsAccessoryImage {
	return ([LTMPrefsManager sharedManager].enabled) ? NO : %orig;
}

- (id)contentsImage {
	if([LTMPrefsManager sharedManager].enabled) {
		int level = MSHookIvar<int>(self, "_capacity");
		int state = MSHookIvar<int>(self, "_state");
		CGFloat height = MSHookIvar<CGFloat>([self foregroundStyle], "_height") * [UIScreen mainScreen].scale;
		BOOL lpm = false;
		if ([[[UIDevice currentDevice] systemVersion] compare:@"9.0" options:NSNumericSearch] != NSOrderedAscending) {
			lpm = [[NSProcessInfo processInfo] isLowPowerModeEnabled];
		}
		NSLog(@"LITHIUM: asking for render")
		UIImage *image = [UIImage renderBatteryImageForTheme:[LTMPrefsManager sharedManager].theme height:height percentage:level charging:state lpm:lpm color:[[self foregroundStyle] textColorForStyle:[self legibilityStyle]]];
		return [%c(_UILegibilityImageSet) imageFromImage:image withShadowImage:image];
	}
	else {
		return %orig;
	}
}

%end
