#include <CoreGraphics/CoreGraphics.h>
#include <objcipc/objcipc.h>

@interface UIImage (RenderBatteryImage)

+ (UIImage *) renderBatteryImageForTheme:(NSString *)theme height:(int)height percentage:(int)percentage charging:(BOOL)charging lpm:(BOOL)lpm color:(UIColor *)color;

@end
