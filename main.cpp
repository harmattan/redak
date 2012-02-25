#include <QtGui/QApplication>
#include "qmlapplicationviewer.h"

#include "core.h"


Q_DECL_EXPORT int main(int argc, char *argv[])
{
    QScopedPointer<QApplication> app(createApplication(argc, argv));

    qmlRegisterType<Core>("Core", 1, 0, "Core");

    QmlApplicationViewer viewer;
    viewer.setOrientation(QmlApplicationViewer::ScreenOrientationAuto);


    QString platform("common");

#ifdef Q_OS_SYMBIAN  //def Q_WS_HARMATTAN
    platform = QString("symbian");
#else //if defined Q_WS_SYMBIAN
    platform = QString("harmattan");
#endif

    QString filename("qml/redak/");
    filename += platform;
    filename += "/main.qml";

    viewer.setMainQmlFile( filename );
    viewer.showExpanded();

    return app->exec();
}
