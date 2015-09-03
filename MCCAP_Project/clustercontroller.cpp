#include "clustercontroller.h"

ClusterController::ClusterController(QObject *parent) : QObject(parent)
{
    cHdl = new ClusterHdl;
}

ClusterController::~ClusterController()
{
    delete cHdl;
}

void ClusterController::tran2CgName(QString num)
{
    cHdl->tran2CgName(num);
}

