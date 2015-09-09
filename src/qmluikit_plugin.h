#ifndef SRC_PLUGIN_H
#define SRC_PLUGIN_H

#include <QQmlExtensionPlugin>

class SrcPlugin : public QQmlExtensionPlugin
{
    Q_OBJECT
    Q_PLUGIN_METADATA(IID "org.qt-project.Qt.QQmlExtensionInterface")

public:
    void registerTypes(const char *uri);
};

#endif // SRC_PLUGIN_H

