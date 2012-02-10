#ifndef CORE_H
#define CORE_H

#include <QObject>
#include <QDeclarativeItem>

class Core
        : public QDeclarativeItem
{
    Q_OBJECT

public:
    Core(QDeclarativeItem *parent = 0);
    Q_INVOKABLE void save(QString content ,QString filemame);
    Q_INVOKABLE QString load(QString filemame);

signals:
    void saved();
    void loaded();
};

#endif // CORE_H
