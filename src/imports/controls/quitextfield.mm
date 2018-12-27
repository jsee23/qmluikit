#include "quitextfield.h"
#include "quikithelpers.h"

#include <UIKit/UIKit.h>

@interface QUITextFieldEventHandler : NSObject
{
    @public
    QUITextField *textField;
}
-(void) textFieldDidChange : (UITextField*) textField;
@end

@implementation QUITextFieldEventHandler
-(void) textFieldDidChange : (UITextField*) nativeTextField {
    Q_UNUSED(nativeTextField)
    emit textField->textChanged();
}
@end

//////////////////////////
// Qt
//////////////////////////

class QUITextFieldPrivate
{
public:
    QUITextFieldEventHandler* native;
};

QUITextField::QUITextField(QObject *parent)
    : QUIControl(false, parent)
    , d(new QUITextFieldPrivate)
{
    d->native = [[QUITextFieldEventHandler alloc] init];
    m_nativeResource = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 200, 40)];

    QMLUIKIT_NATIVE_CONTROL(UITextField)
    [nativeControl addTarget:d->native action:@selector(textFieldDidChange:)
                   forControlEvents:UIControlEventEditingChanged];
    d->native->textField = this;
}

QUITextField::~QUITextField()
{
    if (d->native)
        [d->native release];
    if (m_nativeResource) {
        QMLUIKIT_NATIVE_CONTROL(UITextField)
        [nativeControl release];
    }

    delete d;
}

QString QUITextField::text() const
{
    QMLUIKIT_NATIVE_CONTROL(UITextField)
    return QString::fromNSString(nativeControl.text);
}

void QUITextField::setText(const QString &text)
{
    if (text == this->text())
        return;

    QMLUIKIT_NATIVE_CONTROL(UITextField)
    nativeControl.text = text.toNSString();
    emit textChanged();
}
