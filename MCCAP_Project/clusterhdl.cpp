#include "clusterhdl.h"

ClusterHdl::ClusterHdl()
{
    prepareCgMap();
}

ClusterHdl::~ClusterHdl()
{

}

bool ClusterHdl::validateCgNum(QString num)
{
    if(categoryMap.keys().contains(num)) {
        return true;
    }else {
        return false;
    }
}

QString ClusterHdl::tran2CgName(QString num)
{
    if(validateCgNum(num)) {
        return categoryMap.value(num);
    }else {
        return "null";
    }
}

ClusterHdl::prepareCgMap()
{
    categoryMap.insert("1", "Transport & Metabolism");
    categoryMap.insert("2", "Transcription & Translation");
    categoryMap.insert("3", "General function prediction only");
    categoryMap.insert("4", "Others");
}

