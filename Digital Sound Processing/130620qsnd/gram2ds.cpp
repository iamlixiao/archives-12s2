#include "gram2ds.h"
#include<qmath.h>
#include<QPainter>

Gram2dS::Gram2dS(QWidget *parent) :
    QWidget(parent)
{
}

Gram2dS::Gram2dS(QList<qint32> &s, qint32 m, QWidget *parent):
    QWidget(parent)
{
    qint16 iw=4090,ih=1080;
    p=new QImage(iw,ih,QImage::Format_RGB32);
    qint32 lm=0;
    foreach(qint32 i,s){
        if(qFabs(i)>lm)lm=qFabs(i);
    }

    qreal factor=(qreal)iw/(qreal)s.size(),valfactor=factor*ih/lm,vfactor=ih/2.0/lm;
//    QList<qint32> vals,valx;
//    for(qint32 i=0;i<iw;++i){
//        vals.append(0);
//        valx.append(0);
//    }
//    qint64 cnt=0;
//    foreach(qint32 i,s){
//        if(i>0)vals[(qint32)((cnt++)*factor)]+=i*valfactor;
//        else valx[(qint32)((cnt++)*factor)]+=i*valfactor;
//    }
//    QPainter painter(p);
//    for(qint32 i=0;i<iw;++i){
//        painter.setPen(QColor(255,255,255));
//        painter.drawLine(i,ih/2,i,ih/2-vals[i]);
//        painter.drawLine(i,ih/2,i,ih/2-valx[i]);
//    }
    QPainter painter(p);
    painter.fillRect(p->rect(),QColor(0,0,0));
    painter.setPen(QPen(QColor(255,255,255),0.5));
    for(int i=0;i<s.size();++i){
        qreal ix=i*factor,sih=ih/2;
        painter.drawLine(QPointF(ix,sih),QPointF(ix,sih-s[i]*vfactor));
    }
    p->save("ot.png");
}


void Gram2dS::paintEvent(QPaintEvent *)
{
    QPainter painter(this);
    painter.setRenderHint(QPainter::HighQualityAntialiasing);
    painter.drawImage(rect(),p->scaled(size(),Qt::IgnoreAspectRatio,Qt::SmoothTransformation));
}
