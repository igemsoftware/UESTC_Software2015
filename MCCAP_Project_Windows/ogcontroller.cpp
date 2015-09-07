#include "ogcontroller.h"
#include "qdebug.h"

OgController::OgController(QObject *parent) : QObject(parent)
{
    ogHdl = new OrganismHdl;
}

OgController::~OgController()
{
    delete ogHdl;
}

QString OgController::tran2Name(QString id)
{
    return ogHdl->tran2Name(id);
}

QString OgController::tran2ID(QString name)
{
    return ogHdl->tran2ID(name);
}

int OgController::add2SelOg(QString id)
{
    return ogHdl->add2SelOg(id);
}

int OgController::delFromSelOg(QString id)
{
    return ogHdl->delFromSelOg(id);
}

void OgController::clear()
{
    ogHdl->clear();
}

void OgController::submit_cluster()
{
    emit callServ_cluster(ogHdl->getSelOg());
}

void OgController::submit_compare(QString idStr1, QString idStr2)
{
    emit callServ_compare(idStr1, idStr2);
}

void OgController::submit_wholePw()
{
    emit callServ_wholePw(ogHdl->getSelOg());
}

void OgController::submit_metaPw()
{
    emit callServ_metaPw(ogHdl->getSelOg());
}

void OgController::submit_wholeMd()
{
    emit callServ_wholeMd(ogHdl->getSelOg());
}

void OgController::submit_metaMd()
{
    emit callServ_metaMd(ogHdl->getSelOg());
}
