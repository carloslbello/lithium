#include "LTMPrefsManager.h"

@implementation LTMPrefsManager

@synthesize enabled = _enabled, theme = _theme;
static LTMPrefsManager *sharedManager;

+ (instancetype)sharedManager {
	if(!sharedManager) {
		sharedManager = [[self alloc] init];
	}
	return sharedManager;
}

- (instancetype)init {
	self = [super init];
	NSDictionary *preferences = [[NSDictionary alloc] initWithContentsOfFile:@"/var/mobile/Library/Preferences/lithium.plist"];
	_enabled = ([preferences objectForKey:@"lithiumEnabled"] != nil) ? [[preferences objectForKey:@"lithiumEnabled"] boolValue] : YES;
	self.theme = [preferences objectForKey:@"lithiumTheme"] ?: @"Habesha";
	[preferences release];
	return self;
}

- (void)dealloc {
	[_theme release];
	[super dealloc];
}

@end
