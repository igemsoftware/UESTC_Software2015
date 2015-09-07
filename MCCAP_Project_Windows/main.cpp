#include <QApplication>
#include <QQmlApplicationEngine>
#include <QtQml>
#include <ogcontroller.h>
#include <clustercontroller.h>
#include <maincontroller.h>
#include <serverconnector.h>
#include <qdebug.h>

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);
    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    QObject *rootObj = NULL;
    QList<QObject*> rootObjs = engine.rootObjects();
    for(int i = 0;i < rootObjs.count();i++) {
        if(rootObjs.at(i)->objectName() == "rootMCCAP") {
            rootObj = rootObjs.at(i);
            break;
        }
    }

    OgController *ogCtl = new OgController;
    ClusterController *clusterCtl = new ClusterController;
    MainController *mainCtl = new MainController;
    ServerConnector *servConn = new ServerConnector;
    engine.rootContext()->setContextProperty("ogCtl", ogCtl);
    engine.rootContext()->setContextProperty("clusterCtl", clusterCtl);
    engine.rootContext()->setContextProperty("mainCtl", mainCtl);

    QObject::connect(ogCtl,SIGNAL(callServ_cluster(QList<QString>)),servConn,SLOT(on_callServ_cluster(QList<QString>)));
    QObject::connect(ogCtl,SIGNAL(callServ_compare(QString,QString)),servConn,SLOT(on_callServ_compare(QString,QString)));
    QObject::connect(ogCtl,SIGNAL(callServ_wholePw(QList<QString>)),servConn,SLOT(on_callServ_wholePw(QList<QString>)));
    QObject::connect(ogCtl,SIGNAL(callServ_metaPw(QList<QString>)),servConn,SLOT(on_callServ_metaPw(QList<QString>)));
    QObject::connect(ogCtl,SIGNAL(callServ_wholeMd(QList<QString>)),servConn,SLOT(on_callServ_wholeMd(QList<QString>)));
    QObject::connect(ogCtl,SIGNAL(callServ_metaMd(QList<QString>)),servConn,SLOT(on_callServ_metaMd(QList<QString>)));
    QObject::connect(servConn,SIGNAL(call_clusterResult(QList<ClusterHdl>)),mainCtl,SLOT(on_call_clusterResult(QList<ClusterHdl>)));
    QObject::connect(servConn, SIGNAL(call_compareResult(QList<ClusterHdl>,QVariantMap)), mainCtl,SLOT(on_call_compareResult(QList<ClusterHdl>,QVariantMap)));
    QObject::connect(servConn,SIGNAL(call_web_open_url(QString)),mainCtl,SLOT(on_call_web_open_url(QString)));
    QObject::connect(mainCtl,SIGNAL(response_cluster(QVariant,QVariant)),rootObj,SLOT(on_response_cluster(QVariant,QVariant)));
    QObject::connect(mainCtl,SIGNAL(response_compare(QVariant,QVariant,QVariant)),rootObj,SLOT(on_response_compare(QVariant,QVariant,QVariant)));
    QObject::connect(mainCtl,SIGNAL(response_web_load(QVariant)),rootObj,SLOT(on_response_web_load(QVariant)));

    return app.exec();
}

//#include<QApplication>
//#include<QQuickView>
//#include<QColor>
//#include<QQmlContext>
//int main(int argc,char* argv[])
//{
//    QApplication app(argc,argv);
//    QQuickView viwer;
//    //无边框，背景透明
//    viwer.setFlags(Qt::FramelessWindowHint);
//    viwer.setColor(QColor(Qt::transparent));
//    //加载qml
//    viwer.setSource(QUrl("qrc:/main.qml"));
//    viwer.show();
//    //将viewer设置为main.qml属性
//    viwer.rootContext()->setContextProperty("mainwindow",&viwer);
//    return app.exec();
//}
