#include "quikithelpers.h"

UIColor* QUIKitColors::qcolorToUIColor(const QColor &color)
{
    UIColor* uiColor = [UIColor colorWithRed:color.redF() green:color.greenF()
            blue:color.blueF() alpha:color.alphaF()];
    return uiColor;
}

QColor QUIKitColors::uiColorToQColor(UIColor *color)
{
    CGFloat red = 0.0, green = 0.0, blue = 0.0, alpha = 0.0;

    if ([color respondsToSelector:@selector(getRed:green:blue:alpha:)]) {
        [color getRed:&red green:&green blue:&blue alpha:&alpha];
    } else {
        const CGFloat *components = CGColorGetComponents(color.CGColor);
        red = components[0];
        green = components[1];
        blue = components[2];
        alpha = components[3];
    }
    return QColor(red, green, blue, alpha);
}
