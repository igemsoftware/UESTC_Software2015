#ifndef MAINCONTROLLER_H
#define MAINCONTROLLER_H

#include <QObject>
#include <serverconnector.h>
#include <clusterhdl.h>

class MainController : public QObject
{
    Q_OBJECT
public:
    explicit MainController(QObject *parent = 0);
    ~MainController();

private:
    QJsonDocument jDoc,jDoc2;
    ClusterHdl *cHdl;

signals:
    void response_cluster(QVariant jsonStr, QVariant count);
    void response_compare(QVariant jsonStr, QVariant count, QVariant jsonStatics);
    void response_web_load(QVariant url);

public slots:
    void on_call_clusterResult(QList<ClusterHdl> list);
    void on_call_compareResult(QList<ClusterHdl> list, QVariantMap statics);
    void on_call_web_open_url(QString url);
};

#endif // MAINCONTROLLER_H
