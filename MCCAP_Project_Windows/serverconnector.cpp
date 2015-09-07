#include "serverconnector.h"
#include "qdebug.h"

ServerConnector::ServerConnector(QObject *parent) : QObject(parent)
{
    prepareNetMgr();
    connect(clusterMgr, SIGNAL(finished(QNetworkReply*)), this, SLOT(on_clusterMgr_finished(QNetworkReply*)));
    connect(wholePwMgr, SIGNAL(finished(QNetworkReply*)), this, SLOT(on_wholePwMgr_finsihed(QNetworkReply*)));
    connect(metaPwMgr, SIGNAL(finished(QNetworkReply*)), this, SLOT(on_metaPwMgr_finished(QNetworkReply*)));
    connect(wholeMdMgr, SIGNAL(finished(QNetworkReply*)), this, SLOT(on_wholeMdMgr_finished(QNetworkReply*)));
    connect(metaMdMgr, SIGNAL(finished(QNetworkReply*)), this, SLOT(on_metaMdMgr_finished(QNetworkReply*)));
    connect(compareMgr, SIGNAL(finished(QNetworkReply*)), this, SLOT(on_compareMgr_finished(QNetworkReply*)));
}

ServerConnector::~ServerConnector()
{
    delete clusterMgr;
    delete wholePwMgr;
    delete metaPwMgr;
    delete wholeMdMgr;
    delete metaMdMgr;
}

QString ServerConnector::getHost()
{
    return this->serverHost;
}

void ServerConnector::on_callServ_cluster(QList<QString> list)
{
    QString preUrl = serverHost + QString("api/cegRecord/fetchCeg.php?id=");
    QString param = "";
    for(int i =0;i < list.count();i++) {
        param = param + list.at(i).trimmed();
    }
    QString url = preUrl + param;
    req.setUrl(QUrl(url));
    clusterMgr->get(req);
}

void ServerConnector::on_callServ_compare(QString idStr1, QString idStr2)
{
    QString preUrl = serverHost + QString("api/cegRecord/compare.php?id=");
    QString param = idStr1 + "+" + idStr2;
    QString url = preUrl + param;
    req.setUrl(QUrl(url));
    compareMgr->get(req);
}

void ServerConnector::on_callServ_wholePw(QList<QString> list)
{
    QString preUrl = serverHost + QString("api/kegg/entirePathway.php?id=");
    QString param = "";
    for(int i =0;i < list.count();i++) {
        param = param + list.at(i).trimmed();
    }
    QString url = preUrl + param;
    req.setUrl(QUrl(url));
    wholePwMgr->get(req);
}

void ServerConnector::on_callServ_metaPw(QList<QString> list)
{
    QString preUrl = serverHost + QString("api/kegg/metabolicPathway.php?id=");
    QString param = "";
    for(int i =0;i < list.count();i++) {
        param = param + list.at(i).trimmed();
    }
    QString url = preUrl + param;
    req.setUrl(QUrl(url));
    metaPwMgr->get(req);
}

void ServerConnector::on_callServ_wholeMd(QList<QString> list)
{
    QString preUrl = serverHost + QString("api/kegg/entireModule.php?id=");
    QString param = "";
    for(int i =0;i < list.count();i++) {
        param = param + list.at(i).trimmed();
    }
    QString url = preUrl + param;
    req.setUrl(QUrl(url));
    wholeMdMgr->get(req);
}

void ServerConnector::on_callServ_metaMd(QList<QString> list)
{
    QString preUrl = serverHost + QString("api/kegg/metabolicModule.php?id=");
    QString param = "";
    for(int i =0;i < list.count();i++) {
        param = param + list.at(i).trimmed();
    }
    QString url = preUrl + param;
    req.setUrl(QUrl(url));
    metaMdMgr->get(req);
}

void ServerConnector::on_clusterMgr_finished(QNetworkReply *reply)
{
    int status;
    QTextCodec *codec = QTextCodec::codecForName("utf8");
    QString content = codec->toUnicode(reply->readAll());
    jDoc = QJsonDocument::fromJson(content.toUtf8(), &jErr);
    if(jErr.error == QJsonParseError::NoError) {
        if(jDoc.isObject()) {
            QVariantMap objMap = jDoc.toVariant().toMap();
            status = objMap["status"].toInt();
            if(!status) {
                QList<QVariant> dataList = objMap["data"].toList();
                QList<ClusterHdl> list;
                ClusterHdl c;
                for(int i = 0; i < dataList.size(); i++) {
                    QVariantMap data = dataList.at(i).toMap();
                    int category = data["category"].toInt();
                    QString cluster, description;
                    cluster = data["cluster"].toString();
                    description = data["description"].toString();
                    c.category = category;
                    c.accessNum = cluster;
                    c.description = description;
                    list.append(c);
                }
                emit call_clusterResult(list);
            }
        }
    }else {
        qDebug() << QString("Error!");
    }
}

void ServerConnector::on_wholePwMgr_finsihed(QNetworkReply *reply)
{
    int status;
    QTextCodec *codec = QTextCodec::codecForName("utf8");
    QString content = codec->toUnicode(reply->readAll());
    jDoc = QJsonDocument::fromJson(content.toUtf8(), &jErr);
    if(jErr.error == QJsonParseError::NoError) {
        if(jDoc.isObject()) {
            QVariantMap objMap = jDoc.toVariant().toMap();
            status = objMap["status"].toInt();
            if(!status) {
                QString url = objMap["data"].toString();
                emit call_web_open_url(url);
            }
        }
    }else {
        qDebug() << QString("Error!");
    }
}

void ServerConnector::on_metaPwMgr_finished(QNetworkReply *reply)
{
    int status;
    QTextCodec *codec = QTextCodec::codecForName("utf8");
    QString content = codec->toUnicode(reply->readAll());
    jDoc = QJsonDocument::fromJson(content.toUtf8(), &jErr);
    if(jErr.error == QJsonParseError::NoError) {
        if(jDoc.isObject()) {
            QVariantMap objMap = jDoc.toVariant().toMap();
            status = objMap["status"].toInt();
            if(!status) {
                QString url = objMap["data"].toString();
                emit call_web_open_url(url);
            }
        }
    }else {
        qDebug() << QString("Error!");
    }
}

void ServerConnector::on_wholeMdMgr_finished(QNetworkReply *reply)
{
    int status;
    QTextCodec *codec = QTextCodec::codecForName("utf8");
    QString content = codec->toUnicode(reply->readAll());
    jDoc = QJsonDocument::fromJson(content.toUtf8(), &jErr);
    if(jErr.error == QJsonParseError::NoError) {
        if(jDoc.isObject()) {
            QVariantMap objMap = jDoc.toVariant().toMap();
            status = objMap["status"].toInt();
            if(!status) {
                QString url = objMap["data"].toString();
                emit call_web_open_url(url);
            }
        }
    }else {
        qDebug() << QString("Error!");
    }
}

void ServerConnector::on_metaMdMgr_finished(QNetworkReply *reply)
{
    int status;
    QTextCodec *codec = QTextCodec::codecForName("utf8");
    QString content = codec->toUnicode(reply->readAll());
    jDoc = QJsonDocument::fromJson(content.toUtf8(), &jErr);
    if(jErr.error == QJsonParseError::NoError) {
        if(jDoc.isObject()) {
            QVariantMap objMap = jDoc.toVariant().toMap();
            status = objMap["status"].toInt();
            if(!status) {
                QString url = objMap["data"].toString();
                emit call_web_open_url(url);
            }
        }
    }else {
        qDebug() << QString("Error!");
    }
}

void ServerConnector::on_compareMgr_finished(QNetworkReply *reply)
{
    int status;
    QTextCodec *codec = QTextCodec::codecForName("utf8");
    QString content = codec->toUnicode(reply->readAll());
    jDoc = QJsonDocument::fromJson(content.toUtf8(), &jErr);
    if(jErr.error == QJsonParseError::NoError) {
        if(jDoc.isObject()) {
            QVariantMap objMap = jDoc.toVariant().toMap();
            status = objMap["status"].toInt();
            if(!status) {
                QList<QVariant> dataList = objMap["data"].toList();
                QList<ClusterHdl> list;
                ClusterHdl c;
                for(int i = 0; i < dataList.size(); i++) {
                    QVariantMap data = dataList.at(i).toMap();
                    int category = data["category"].toInt();
                    int group = data["group"].toInt();
                    QString cluster, description;
                    cluster = data["cluster"].toString();
                    description = data["description"].toString();
                    c.group = group;
                    c.accessNum = cluster;
                    c.category = category;
                    c.description = description;
                    list.append(c);
                }
                QVariantMap statics = objMap["statics"].toMap();
                emit call_compareResult(list, statics);
            }
        }
    }else {
        qDebug() << QString("Error!");
    }
}

void ServerConnector::prepareNetMgr()
{
    clusterMgr = new QNetworkAccessManager;
    wholePwMgr = new QNetworkAccessManager;
    metaPwMgr = new QNetworkAccessManager;
    wholeMdMgr = new QNetworkAccessManager;
    metaMdMgr = new QNetworkAccessManager;
    compareMgr = new QNetworkAccessManager;
}






