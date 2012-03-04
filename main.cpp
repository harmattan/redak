/* #ident "$Id: $"
 * @author: rzr@gna.org - rev: $Author: rzr$
 * Copyright: See README file that comes with this distribution
 *****************************************************************************/

#include "config.h"
#include <QtGui/QApplication>
#include "qmlapplicationviewer.h"

#include "core.h"


Q_DECL_EXPORT
int main(int argc, char *argv[])
{
    QScopedPointer<QApplication> app(createApplication(argc, argv));

    if ( argc > 1 ) {
        char const * const tmp = argv[1];
        qDebug()<<tmp;
    }

    qmlRegisterType<Core>("Core", 1, 0, "Core");

    QmlApplicationViewer viewer;
    viewer.setOrientation(QmlApplicationViewer::ScreenOrientationAuto);

    // QString platform("common");
    QString platform("meego");

#if defined Q_WS_SIMULATOR
# define Q_OS_SYMBIAN
//# define Q_WS_HARMATTAN
#endif

#if defined(Q_WS_MAEMO_5)
#elif defined(Q_WS_S60)
#endif

#ifdef Q_OS_SYMBIAN  //def Q_WS_HARMATTAN
    platform = QString("symbian");
#endif

#if defined Q_WS_HARMATTAN
    platform = QString("meego");
#endif

    QString filename("qml/redak/");
    filename += platform;
    filename += "/main.qml";

    viewer.setMainQmlFile( filename );
    viewer.showExpanded();

    return app->exec();
}
