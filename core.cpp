/* #ident "$Id: $"
 * @author: rzr@gna.org - rev: $Author: rzr$
 * Copyright: See README file that comes with this distribution
 *****************************************************************************/

#include "config.h"

#include "core.h"

#define FUNCT(...) \
    if ( false ) qDebug()<<__FILE__<<":"<<__LINE__<<":"


Core::Core(QDeclarativeItem *parent)
    : QDeclarativeItem(parent)
{
    FUNCT();
}


bool Core::save(QString content, QString filename)
{
    FUNCT();
    bool status = true;
    QUrl url(filename);
    filename = url.path();

#ifdef Q_OS_SYMBIAN
    filename = filename.mid(1);  //TODO WORAROUND BUG
#endif

    // qDebug()<<"save:" + filename;
    // qDebug()<<"content:" + content;
    QFile file( filename );
    status &= file.open(QIODevice::WriteOnly | QIODevice::Text);
    if ( status ) {
        QTextStream stream( &file );
        stream<<content;
        file.close();
        emit saved();
    }

    if (!status) {
        QString text = "error: io: save: "+filename;
        emit error(QVariant(text));
    }
    return status;
}


QString Core::load(QString filename)
{
    FUNCT();
    // qDebug()<<"load: " + filename;

    bool status = true;

    QString content;

    QUrl url(filename);
    filename = url.path();

#ifdef Q_OS_SYMBIAN
    filename = filename.mid(1);  //TODO WORAROUND BUG
#endif

    QFile file(filename); //TODO: on dir ?

    if ( file.exists() ) {
        status &= file.open(QIODevice::ReadOnly | QIODevice::Text);
        QTextStream stream( &file );
        content = stream.readAll();
        file.close();
        emit loaded();
    } else {
        status &= file.open(QIODevice::WriteOnly | QIODevice::Text);
        content = "# file://" + filename;
        file.close();
        emit loaded();
    }

    if (!status) {
        QString text = "error: io: load: "+filename;
        emit error(QVariant(text));
    }
    return content;
}
