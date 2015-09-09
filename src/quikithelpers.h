#ifndef QUIKITHELPERS
#define QUIKITHELPERS

/*
 ToDo
 * convert UIImage to QImage and vice versa

*/

#include <UIKit/UIKit.h>
#include <QColor>

class QUIKitColors
{
public:
    static UIColor* qcolorToUIColor(const QColor &color);
    static QColor uiColorToQColor(UIColor* color);
};

#endif // QUIKITHELPERS

