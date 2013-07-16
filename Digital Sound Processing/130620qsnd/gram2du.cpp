#include "gram2du.h"
#include<QPainter>
#include<QImageWriter>

Gram2dU::Gram2dU(QWidget *parent) :
    QWidget(parent)
{
}

Gram2dU::Gram2dU(QList<qint32> &s, qint32 m, QWidget *parent):
    QWidget(parent)
{
    qint16 iw=4090,ih=1080;
    p=new QPixmap(iw,ih);
    qreal factor=(qreal)iw/s.size(),valfactor=factor*ih/m;
//    QList<qint32> vals;
//    for(qint32 i=0;i<iw;++i){
//        vals.append(0);
//    }
//    qint64 cnt=0;
//    foreach(qint32 i,s){
//        vals[(qint32)((cnt++)*factor)]+=i*valfactor;
//    }
//    QPainter painter(p);
//    for(qint32 i=0;i<iw;++i){
//        painter.setPen(QColor(255,255,255));
//        painter.drawLine(i,ih,i,ih-vals[i]);
//    }
    QPainter painter(p);
    painter.setPen(QPen(QColor(255,255,255),factor));
    for(int i=0;i<s.size();++i){
        painter.drawLine(QPointF(i*factor,ih),QPointF(i*factor,ih-s[i]*valfactor));
    }
}

Gram2dU::Gram2dU(QList<qreal> &s, qreal m, QWidget *parent):
    QWidget(parent)
{
    qint16 iw=4090,ih=1080;
    p=new QPixmap(iw,ih);
    qreal factor=(qreal)iw/(qreal)s.size(),valfactor=factor*ih/m;
//    QList<qreal> vals;
//    for(qint32 i=0;i<iw;++i){
//        vals.append(0);
//    }
//    qint64 cnt=0;
//    foreach(qreal i,s){
//        vals[(qint32)((cnt++)*factor)]+=i*valfactor;
//    }
//    QPainter painter(p);
//    for(qint32 i=0;i<iw;++i){
//        painter.setPen(QColor(255,255,255));
//        painter.drawLine(i,ih,i,ih-vals[i]);
//    }
    QPainter painter(p);
    painter.setPen(QPen(QColor(255,255,255),factor));
    for(int i=0;i<s.size();++i){
        painter.drawLine(QPointF(i*factor,ih),QPointF(i*factor,ih-s[i]*valfactor));
    }
}


void Gram2dU::paintEvent(QPaintEvent *)
{
    QPainter painter(this);
    painter.setRenderHint(QPainter::Antialiasing);
    painter.drawPixmap(rect(),p->scaled(size(),Qt::IgnoreAspectRatio,Qt::SmoothTransformation));
    //painter.drawImage(rect(),pi->scaled(size(),Qt::IgnoreAspectRatio,Qt::SmoothTransformation));
}
