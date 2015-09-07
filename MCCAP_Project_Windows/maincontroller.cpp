#include "maincontroller.h"
#include "qdebug.h"

MainController::MainController(QObject *parent) : QObject(parent)
{
    cHdl = new ClusterHdl;
    servConn = new ServerConnector;
}

MainController::~MainController()
{
    delete cHdl;
    delete servConn;
}

QString MainController::getHost()
{
    return servConn->getHost();
}

void MainController::openClusterDetail(QString accessNum)
{
    QString host = getHost();
    QString preUrl = "app/page/clusterDetail.php?access_num=";
    QString param = accessNum;
    QString url = host + preUrl +param;
    emit response_web_load(url);
}

void MainController::on_call_clusterResult(QList<ClusterHdl> list)
{
    QVariantList clusterList;
    int count = list.count();
    for(int i = 0;i < count;i++) {
        QVariantMap cluster;
        cluster.insert("accessNum", list.at(i).accessNum);
        cluster.insert("description", list.at(i).description);
        cluster.insert("category", list.at(i).category);
        clusterList << cluster;
    }
    jDoc = QJsonDocument::fromVariant(clusterList);
    if(!jDoc.isNull()) {
        QString jsonStr(jDoc.toJson(QJsonDocument::Compact));
        emit response_cluster(jsonStr, count);
    }
}

void MainController::on_call_compareResult(QList<ClusterHdl> list, QVariantMap statics)
{
    QVariantList clusterList;
    int count = list.count();
    for(int i = 0;i < count;i++) {
        QVariantMap cluster;
        cluster.insert("accessNum", list.at(i).accessNum);
        cluster.insert("description", list.at(i).description);
        cluster.insert("group", list.at(i).group);
        cluster.insert("category", cHdl->tran2CgName(QString::number(list.at(i).category)));
        clusterList << cluster;
    }
    jDoc = QJsonDocument::fromVariant(clusterList);
    jDoc2 = QJsonDocument::fromVariant(statics);
    if(!jDoc.isNull() && !jDoc2.isNull()) {
        QString jsonStr(jDoc.toJson(QJsonDocument::Compact));
        QString jsonStatics(jDoc2.toJson(QJsonDocument::Compact));
        emit response_compare(jsonStr, count, jsonStatics);
    }
}

void MainController::on_call_web_open_url(QString url)
{
    emit response_web_load(url);
}



