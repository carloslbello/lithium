@class UIStatusBarForegroundStyleAttributes, _UILegibilityView;

@interface UIStatusBarItemView : UIView

- (id)contentsImage;
- (id)foregroundStyle;
- (int)legibilityStyle;

@end

@class UIImage;

@interface _UILegibilityImageSet : NSObject

+ (id)imageFromImage:(id)arg1 withShadowImage:(id)arg2;

@end

@class NSMutableDictionary;

@interface UIStatusBarForegroundStyleAttributes : NSObject

- (id)textColorForStyle:(int)arg1;
- (float)height;

@end

@interface LTMPrefsManager : NSObject

@property(nonatomic) BOOL enabled;
@property(nonatomic, retain) NSMutableString *theme;

+ (instancetype)sharedManager;

@end
