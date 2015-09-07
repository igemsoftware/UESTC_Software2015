#include "organismhdl.h"
#include "qdebug.h"

OrganismHdl::OrganismHdl(QObject *parent) : QObject(parent)
{
    prepareOgMap();
}

bool OrganismHdl::validateId(QString id)
{
    if(ogMap.values().contains(id)) {
        return true;
    }else {
        return false;
    }
}

bool OrganismHdl::validateName(QString name)
{
    if(ogMap.keys().contains(name)) {
        return true;
    }else {
        return false;
    }

}

void OrganismHdl::outputOg()
{
    for(int i = 0; i < selOg.count(); i++) {
        qDebug() << selOg.at(i);
    }
}

QList<QString> OrganismHdl::getSelOg()
{
    return selOg;
}

QString OrganismHdl::tran2Name(QString id)
{
    if(validateId(id)) {
        return ogMap.key(id);
    }else {
        return "null";
    }
}

QString OrganismHdl::tran2ID(QString name)
{
    if(validateName(name)) {
        return ogMap.value(name);
    }else {
        return "null";
    }
}

int OrganismHdl::add2SelOg(QString id)
{
    if(validateId(id) && !selOg.contains(id)) {
        selOg.append(id);
        return 1;
    }else {
        return 0;
    }
}

int OrganismHdl::delFromSelOg(QString id)
{
    if(validateId(id) && selOg.contains(id)) {
        selOg.removeOne(id);
        return 1;
    }else {
        return 0;
    }
}

void OrganismHdl::clear()
{
    selOg.clear();
}

void OrganismHdl::prepareOgMap()
{
    ogMap.clear();
    ogMap.insert(QString("Acinetobacter baylyi ADP1"), QString("01"));
    ogMap.insert(QString("Bacillus subtilis 168"), QString("02"));
    ogMap.insert(QString("Escherichia coli MG1655"), QString("03"));
    ogMap.insert(QString("Francisella novicida U112"), QString("04"));
    ogMap.insert(QString("Haemophilus influenzae Rd KW20"), QString("05"));
    ogMap.insert(QString("Helicobacter pylori 26695"), QString("06"));
    ogMap.insert(QString("Mycoplasma genitalium G37"), QString("07"));
    ogMap.insert(QString("Mycoplasma pulmonis UAB CTIP"), QString("08"));
    ogMap.insert(QString("Mycobacterium tuberculosis H37Rv"), QString("09"));
    ogMap.insert(QString("Pseudomonas aeruginosa UCBPP-PA14"), QString("10"));
    ogMap.insert(QString("Staphylococcus aureus NCTC 8325"), QString("11"));
    ogMap.insert(QString("Streptococcus pneumoniae"), QString("12"));
    ogMap.insert(QString("Staphylococcus aureus N315"), QString("13"));
    ogMap.insert(QString("Salmonella typhimurium LT2"), QString("14"));
    ogMap.insert(QString("Salmonella enterica serovar Typhi"), QString("15"));
    ogMap.insert(QString("Vibrio cholerae N16961"), QString("16"));
    ogMap.insert(QString("Caulobacter crescentus"), QString("17"));
    ogMap.insert(QString("Streptococcus sanguinis"), QString("18"));
    ogMap.insert(QString("Porphyromonas gingivalis ATCC 33277"), QString("19"));
    ogMap.insert(QString("Bacteroides thetaiotaomicron VPI-5482"), QString("20"));
    ogMap.insert(QString("Burkholderia thailandensis E264"), QString("21"));
    ogMap.insert(QString("Sphingomonas wittichii RW1"), QString("22"));
    ogMap.insert(QString("Shewanella oneidensis MR-1"), QString("23"));
    ogMap.insert(QString("Salmonella enterica serovar Typhimurium SL1344"), QString("24"));
    ogMap.insert(QString("Bacteroides fragilis 638R"), QString("25"));
    ogMap.insert(QString("Burkholderia pseudomallei K96243"), QString("26"));
    ogMap.insert(QString("Salmonella enterica subsp. enterica serovar Typhimurium str. 14028S"), QString("27"));
    ogMap.insert(QString("Pseudomonas aeruginosa PAO1"), QString("28"));
    ogMap.insert(QString("Campylobacter jejuni subsp. jejuni NCTC 11168 = ATCC 700819"), QString("29"));
}
