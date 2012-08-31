/* #ident "$Id: $"
 * @author: rzr@gna.org - rev: $Author: rzr$
 * Copyright: See README file that comes with this distribution
 *****************************************************************************/

#include "config.h"
#include <QtGui/QApplication>
#include "qmlapplicationviewer.h"

#include "redak.h"


Q_DECL_EXPORT
int main(int argc, char *argv[])
{
    QScopedPointer<QApplication> app(createApplication(argc, argv));

    qmlRegisterType<Redak>("Redak", 1, 1, "Redak");

    QmlApplicationViewer viewer;
    viewer.setOrientation(QmlApplicationViewer::ScreenOrientationAuto);

    QString filepath="";
    if ( argc > 1 ) {
        char const * const p = argv[1];
        filepath = QString(p);
    }
    QVariant variant(filepath); // variant
    viewer.rootContext()->setContextProperty("parentFilePath", variant );

    QString filename("qml/redak/");

    QString platform("common");

#if defined Q_WS_SIMULATOR
# define Q_OS_SYMBIAN 1
//# define Q_WS_HARMATTAN 1
#endif

#if defined(MEEGO_EDITION_HARMATTAN)
# define Q_WS_HARMATTAN 1
#endif


#if defined(Q_WS_MAEMO_5)
#elif defined(Q_WS_S60)
#endif

#if defined Q_OS_SYMBIAN 
    platform = QString("symbian");
#else // #if defined Q_WS_X11 && defined Q_OS_LINUX && // && defined Q_WS_HARMATTAN
    platform = QString("meego");
//#elif defined CONFIG_LOCAL_PLATFORM_ANDROID
//  platform = QString("symbian");
#endif

    filename += platform;
    filename += "/main.qml";

    viewer.setMainQmlFile( filename );
    viewer.showExpanded();

    return app->exec();
}

