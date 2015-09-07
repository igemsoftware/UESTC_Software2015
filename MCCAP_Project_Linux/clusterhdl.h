#ifndef CLUSTERHDL_H
#define CLUSTERHDL_H

#include <QString>
#include <qmap.h>


class ClusterHdl
{
public:
    ClusterHdl();
    ~ClusterHdl();
    QMap<QString, QString> categoryMap;
    int category;
    int group; //for compare function
    QString accessNum, description;

    bool validateCgNum(QString num);
    QString tran2CgName(QString num);

private:
    void prepareCgMap();
};

#endif // CLUSTERHDL_H
