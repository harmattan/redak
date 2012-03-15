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


    qmlRegisterType<Core>("Core", 1, 0, "Core");

    QmlApplicationViewer viewer;
    viewer.setOrientation(QmlApplicationViewer::ScreenOrientationAuto);

    // QString platform("common");
    QString platform("meego");

#if defined Q_WS_SIMULATOR
# define Q_OS_SYMBIAN 1
//# define Q_WS_HARMATTAN 1
#endif

#if defined(Q_WS_MAEMO_5)
#elif defined(Q_WS_S60)
#endif

#if defined Q_WS_HARMATTAN
    platform = QString("meego");
#endif


#ifdef Q_OS_SYMBIAN  //def Q_WS_HARMATTAN
    platform = QString("symbian");
#endif

    QString filename("qml/redak/");
    filename += platform;
    filename += "/main.qml";

    QString string="";
    if ( argc > 1 ) {
        char const * const p = argv[1];
        string = QString(p);
    }

    QVariant variant(string); // variant
    viewer.rootContext()->setContextProperty("parentFilePath", variant );
    //TODO: folderPath

    viewer.setMainQmlFile( filename );
    viewer.showExpanded();

    return app->exec();
}
