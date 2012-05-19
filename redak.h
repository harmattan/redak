/* #ident "$Id: $"
 * @author: rzr@gna.org - rev: $Author: rzr$
 * Copyright: See README file that comes with this distribution
 *****************************************************************************/

#ifndef REDAK_H
#define REDAK_H

#include <QObject>
#include <QDeclarativeItem>
#include <QDeclarativeExtensionPlugin>

class Redak
: public QDeclarativeItem
//: public QDeclarativeExtensionPlugin
{
    Q_OBJECT

public:
    Redak(QDeclarativeItem *parent = 0);
    Q_INVOKABLE bool save(QString content , QString filemame);
    Q_INVOKABLE QString load(QString filemame);
    Q_INVOKABLE QString process(QString const filename);

    void registerTypes(const char *uri);

signals:
    void saved();
    void loaded(QString content);
    void error(QVariant text);
};

#endif // REDAK_H
