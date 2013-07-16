#include "gram2d5.h"
#include<QPainter>
#include<QImage>
#include<qmath.h>

Gram2d5::Gram2d5(QWidget *parent) :
    QWidget(parent)
{
}

Gram2d5::Gram2d5(QList<QList<qreal> > &s, qreal m, qreal x, QWidget *parent):
    QWidget(parent)
{
    qreal max=0;
    for(int i=0;i<s.size();++i){
        for(int j=0;j<s[0].size();++j){
            qreal t=qFabs(s[i][j]);
            if(t>max)max=t;
        }
    }
    max/=3;
    qreal c=255/(m-x);
    qint16 iw=4090,ih=1080;
    p=new QImage(iw,ih,QImage::Format_RGB32);
    qreal hfactor=(qreal)iw/(qreal)s.size(),hvalfactor=hfactor*c,vfactor=(qreal)ih/s[0].size(),vvalfactor=vfactor,valfactor=hfactor*vfactor*c;
//    QList<qreal>valc;
//    for(qint32 i=0;i<ih;++i){
//        valc.append(0);
//    }
//    QList<QList<qreal> >vals;
//    for(qint32 i=0;i<iw;++i){
//        vals.append(QList<qreal>(valc));
//    }
//    qint64 cnt=0;
//    foreach(QList<qreal> i,s){
//        qint64 vcnt=0;
//        QList<qreal> valv(valc);
//        foreach(qreal j,i){
//            valv[(qint32)((vcnt++)*vfactor)]+=j*vvalfactor;
//        }
//        qint64 ccnt=0;
//        foreach(qreal j,valv){
//            vals[(qint32)((cnt)*hfactor)][ccnt++]+=j*hvalfactor;
//        }
//        ++cnt;
//    }
    QPainter painter(p);
    painter.fillRect(p->rect(),Qt::black);
    for(qint16 i=0;i<s.size();++i){
        for(qint16 j=0;j<s[0].size();++j){
            qint64 k=qFabs(s[i][j])/max*255;
            if(k>255)k=255;else if(k<0)k=0;
            painter.fillRect(QRectF(i*hfactor,j*vfactor,hfactor,1),QColor(255,255,255,k));
        }
    }
    p->save("out.png");
}

void Gram2d5::paintEvent(QPaintEvent *)
{
    QPainter painter(this);
    painter.setRenderHint(QPainter::Antialiasing);
    painter.drawImage(rect(),p->scaled(size(),Qt::IgnoreAspectRatio,Qt::SmoothTransformation));
    //painter.drawImage(rect(),pi->scaled(size(),Qt::IgnoreAspectRatio,Qt::SmoothTransformation));
}
