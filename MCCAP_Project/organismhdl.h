#ifndef ORGANISMHDL_H
#define ORGANISMHDL_H

#include <QObject>
#include <QMap>

class OrganismHdl : public QObject
{
    Q_OBJECT

public:
    explicit OrganismHdl(QObject *parent = 0);
    QMap<QString, QString> ogMap;
    QList<QString> selOg;

    bool validateId(QString id);
    bool validateName(QString name);
    void outputOg();

    QList<QString> getSelOg();
    QString tran2Name(QString id);
    QString tran2ID(QString name);
    int add2SelOg(QString id);
    int delFromSelOg(QString id);
    void clear();

private:
    void prepareOgMap();

signals:

public slots:

};

#endif // ORGANISMHDL_H
