#include "gram2d.h"
#include<QtAlgorithms>
#include<QPainter>
#include<math.h>

gram2d::gram2d(QWidget *parent) :
    QWidget(parent)
{
}

gram2d::gram2d(qreal *t, qreal *l, QWidget *parent):
    QWidget(parent)
{
}

gram2d::gram2d(qint32 *t, qint32 l,QWidget *parent) :
    QWidget(parent)
{
    qint32 scaled[1920];
    //linear scale

}

gram2d::gram2d(QList<qint32> &s, qint32 m, QWidget *parent):
    QWidget(parent)
{
    qint16 iw=1920,ih=1080;
    p=new QPixmap(iw,ih);
    qreal factor=(qreal)iw/(qreal)s.size(),valfactor=factor*ih/m/2;
    QList<qint32> vals;
    for(qint32 i=0;i<iw;++i){
        vals.append(0);
    }
    QList<qint32>::const_iterator i;
    qint64 cnt=0;
    foreach(qint32 i,s){
        vals[(qint32)((cnt++)*factor)]+=i*valfactor;
    }
    QPainter painter(p);
    for(qint32 i=0;i<iw;++i){
        painter.setPen(QColor(255,255,255));
        painter.drawLine(i,ih/2,i,ih/2-vals[i]);
    }
}


void gram2d::paintEvent(QPaintEvent *)
{
    QPainter painter(this);
    painter.setRenderHint(QPainter::HighQualityAntialiasing);
    painter.drawPixmap(rect(),*p);
}
