#include "config.h"

#include "core.h"

#define FUNCT(...) \
    if ( false ) qDebug()<<__FILE__<<":"<<__LINE__<<":"


Core::Core(QDeclarativeItem *parent)
    : QDeclarativeItem(parent)
{
    FUNCT();
}


void Core::save(QString content, QString filename)
{
    FUNCT();

    QUrl url(filename);
    filename = url.path();
    // qDebug()<<"save:" + filename;
    // qDebug()<<"content:" + content;
    QFile file( filename );
    file.open(QIODevice::WriteOnly | QIODevice::Text);
    QTextStream stream( &file );
    stream<<content;
    file.close();

    emit saved();
}


QString Core::load(QString filename)
{
    FUNCT();

    QString content;

    QUrl url(filename);
    filename = url.path();
    QFile file(filename); //TODO: on dir ?
    //qDebug()<<"open:" + filename;

    if ( file.exists() ) {
        file.open(QIODevice::ReadOnly | QIODevice::Text);
        QTextStream stream( &file );
        content = stream.readAll();
    } else {
        file.open(QIODevice::WriteOnly | QIODevice::Text);
        content = "# file://" + filename;
    }

    file.close();
    emit loaded();

    return content;
}
