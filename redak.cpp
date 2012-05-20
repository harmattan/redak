/* #ident "$Id: $"
 * @author: rzr@gna.org - rev: $Author: rzr$
 * Copyright: See README file that comes with this distribution
 *****************************************************************************/

#include "config.h"

#include "redak.h"
#include <QtPlugin>
#include <QProcess>


Redak::Redak(QDeclarativeItem *parent)
: QDeclarativeItem(parent)
//: QDeclarativeExtensionPlugin(parent)
{
    FUNCT();
}


void Redak::registerTypes(const char *uri)
{
    FUNCT();
    qDebug()<<uri;
    // Q_ASSERT(uri == QLatin1String("redak"));
    uri="redak";
    qmlRegisterType<Redak>(uri, 1, 1, "Redak");
}


bool Redak::save(QString content, QString filename)
{
    FUNCT();
    bool status = true;
    QUrl url(filename);
    filename = url.path();

#if defined Q_OS_SYMBIAN && !defined Q_WS_SIMULATOR
    filename = filename.mid(1);  //TODO WORAROUND BUG
#endif

    // qDebug()<<"save:" + filename;
    // qDebug()<<"content:" + content;
    QFile file( filename );
    status &= file.open(QIODevice::WriteOnly | QIODevice::Text);
    status &= file.isWritable();

    if ( status ) {
        QTextStream stream( &file );
        stream<<content;
        file.close();
        emit saved();
    }

    if (!status) {
        QString text = "error: io: save: "+filename;
        // qDebug()<< text;

        emit error(QVariant(text));
    }
    return status;
}


QString Redak::load(QString filename)
{
    FUNCT();
    // qDebug()<<"load: " + filename;
    QString content = "";
    bool status = true;

    QUrl url(filename);
    filename = url.path();

#if defined Q_OS_SYMBIAN && !defined Q_WS_SIMULATOR
    filename = filename.mid(1);  //TODO WORAROUND BUG
#endif

    QFile file(filename); //TODO: on dir ?

    if ( file.exists() ) {
        status &= file.open(QIODevice::ReadOnly | QIODevice::Text);
        QTextStream stream( &file );
        content = stream.readAll();
        file.close();
        emit loaded(content);
    } else {
        status &= file.open(QIODevice::WriteOnly | QIODevice::Text);
        content = "# file://" + filename + "\n";
        file.close();
        emit loaded(content);
    }

    if (!status) {
        QString text = "error: io: load: "+filename;
        emit error(QVariant(text));
    }

    return content;
}


QString Redak::process(QString const filename)
{
     QProcess tmp;
     tmp.start(filename);
     tmp.closeWriteChannel();
     tmp.waitForFinished();
     QString content = tmp.readAllStandardOutput();

     return (content);
}


Q_EXPORT_PLUGIN2(Redak, Redak);

//qmlRegisterType<Redak>("Redak", 1, 0, "Redak");
