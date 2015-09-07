#ifndef SERVERCONNECTOR_H
#define SERVERCONNECTOR_H

#include <QObject>
#include <QtWebKitWidgets/QWebView>
#include <QtNetwork>
#include "organismhdl.h"
#include "clusterhdl.h"

class ServerConnector : public QObject
{
    Q_OBJECT
public:
    explicit ServerConnector(QObject *parent = 0);
    ~ServerConnector();
    QString getHost();

signals:
    void call_clusterResult(QList<ClusterHdl>);
    void call_compareResult(QList<ClusterHdl>, QVariantMap statics);
    void call_web_open_url(QString);

public slots:
    void on_callServ_cluster(QList<QString> list);
    void on_callServ_compare(QString idStr1, QString idStr2);
    void on_callServ_wholePw(QList<QString> list);
    void on_callServ_metaPw(QList<QString> list);
    void on_callServ_wholeMd(QList<QString> list);
    void on_callServ_metaMd(QList<QString> list);

private slots:
    void on_clusterMgr_finished(QNetworkReply *reply);
    void on_wholePwMgr_finsihed(QNetworkReply *reply);
    void on_metaPwMgr_finished(QNetworkReply *reply);
    void on_wholeMdMgr_finished(QNetworkReply *reply);
    void on_metaMdMgr_finished(QNetworkReply *reply);
    void on_compareMgr_finished(QNetworkReply *reply);

private:
    QString serverHost;// = "http://cefg.cn/Igem2015/mccap-server/";       //"http://localhost/mccap-server/";
    QNetworkAccessManager* clusterMgr;
    QNetworkAccessManager* wholePwMgr;
    QNetworkAccessManager* metaPwMgr;
    QNetworkAccessManager* wholeMdMgr;
    QNetworkAccessManager* metaMdMgr;
    QNetworkAccessManager* compareMgr;
    QJsonDocument jDoc;
    QJsonParseError jErr;
    QNetworkRequest req;

    void callServer(QString url);
    void prepareNetMgr();
};

#endif // SERVERCONNECTOR_H
