#include <UIKit/UIKit.h>
#include <CoreGraphics/CoreGraphics.h>

@interface UIImage (RenderBatteryImage)

+ (UIImage *) renderBatteryImageForJavaScript:(NSString *)javascript height:(CGFloat)height percentage:(int)percentage charging:(BOOL)charging lpm:(BOOL)lpm color:(UIColor *)color;

@end
