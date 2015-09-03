#ifndef OGCONTROLLER_H
#define OGCONTROLLER_H

#include <QObject>
#include <organismhdl.h>

class OgController : public QObject
{
    Q_OBJECT
public:
    explicit OgController(QObject *parent = 0);
    ~OgController();

    Q_INVOKABLE QString tran2Name(QString id);
    Q_INVOKABLE QString tran2ID(QString name);
    Q_INVOKABLE int add2SelOg(QString id);
    Q_INVOKABLE int delFromSelOg(QString id);
    Q_INVOKABLE void clear();
    Q_INVOKABLE void submit_cluster();
    Q_INVOKABLE void submit_compare(QString idStr1, QString idStr2);
    Q_INVOKABLE void submit_wholePw();
    Q_INVOKABLE void submit_metaPw();
    Q_INVOKABLE void submit_wholeMd();
    Q_INVOKABLE void submit_metaMd();

private:
    OrganismHdl *ogHdl;

signals:
    void callServ_cluster(QList<QString> list);
    void callServ_compare(QString idStr1, QString idStr2);
    void callServ_wholePw(QList<QString> list);
    void callServ_metaPw(QList<QString> list);
    void callServ_wholeMd(QList<QString> list);
    void callServ_metaMd(QList<QString> list);

public slots:
};

#endif // OGCONTROLLER_H
