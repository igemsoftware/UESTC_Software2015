#ifndef CLUSTERCONTROLLER_H
#define CLUSTERCONTROLLER_H

#include <QObject>
#include <clusterhdl.h>

class ClusterController : public QObject
{
    Q_OBJECT
public:
    explicit ClusterController(QObject *parent = 0);
    ~ClusterController();

    ClusterHdl *cHdl;

    void tran2CgName(QString num);

signals:

public slots:
};

#endif // CLUSTERCONTROLLER_H
