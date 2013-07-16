#include "mainwindow.h"
#include "ui_mainwindow.h"
#include<QtMultimedia>
#include<QDebug>
#include<sndfile.hh>
#include<fftw3.h>
#include<qmath.h>
#include"gram2ds.h"
#include"gram2du.h"
#include"gram2d5.h"

MainWindow::MainWindow(QWidget *parent) :
    QMainWindow(parent)
{
    SndfileHandle handle("../resources/ToS3.flac");
    qint64 chnl=handle.channels(),length=handle.frames()*chnl,frame=handle.samplerate()*0.05,step=frame*0.04;
    qint32*t=new qint32[length];
    int p=handle.read(t,length);
    qint32 lm=0,rm=0;
    for(int i=0;i<handle.frames();++i){
        qint32 fl=t[i*chnl],fr=t[i*chnl+1];
        if(qFabs(fl)>lm)lm=qFabs(fl);
        if(qFabs(fr)>rm)rm=qFabs(fr);
        ls<<t[i*chnl];
        //        rs<<t[i*chnl+1];
    }
    //read complete

    //    lpFilter(snd,handle.frames(),4000*handle.frames()/handle.samplerate());

    QList<qreal>pzcr;
    qreal maxpzcr=0;
    for(QList<qint32>::const_iterator i=ls.constBegin();i<ls.constEnd()-frame;i+=step){
        qreal z=zcr(i,i+frame);
        pzcr<<z;
        if(z>maxpzcr)maxpzcr=z;
    }
    //stft and prepare
    qint32 fframe=4096,fstep=256;
    qint32 framen=handle.frames()/fframe;
    QList<QList<qreal> >ft,fti;
    qreal max,min;
    qint32 cut=4000*fframe/handle.samplerate();
    qreal*fhamming=mkhamming(fframe);

    for(QList<qint32>::const_iterator i=ls.constBegin();i<ls.constEnd();i+=fstep){
        QList<qreal>ipt;
        for(int j=0;j<fframe;++j){
            ipt.append(*(i+j)*fhamming[j]);
        }
        qFFT(ipt.begin(),ipt.end(),true);
        QList<qreal>ipo;
        //min and max
        for(int j=0;j<fframe;j+=2){
            if(j>cut)ipt[j]=ipt[j+1]=0;
            qreal t=ipt[j];
            ipo<<t;
            if(t>max)max=t;
            else if(t<min)min=t;
        }
        //weaken pitched music
        qint32 blk=fframe/512;
        for(int j=0;j<fframe-blk;j+=blk){
            qint32 max=0,smax=0,maxn=j+blk,min=0,smin=0,minn=j+blk;
            for(int k=0;k<blk;++k){
                qint32 l=k+j;
                if(ipt[l]>max){
                    max=ipt[l];
                    maxn=l;
                }
                else if(ipt[l]>smax){
                    smax=ipt[l];
                }
            }
            if(maxn!=j+blk)ipt[maxn]=smax;
            else{
                for(int k=0;k<blk;++k){
                    qint32 l=k+j;
                    if(ipt[l]<min){
                        min=ipt[l];
                        minn=l;
                    }
                    else if(ipt[l]>smin){
                        smin=ipt[l];
                    }
                }
                if(minn!=j+blk)ipt[minn]=smin;
            }
        }
        ft.append(QList<qreal>(ipo));
        fti.append(QList<qreal>(ipt));
    }

    foreach(QList<qreal> i,fti){
        qFFT(i.begin(),i.end(),false);
    }
    for(int j=0;j<ls.size()/fstep;++j){
        for(int i=0;i<fstep;++i){
            ls[j*fstep+i]=fti[j][i]/fframe;
        }
    }


    for(int i=0;i<frame;++i){
        hamming<<0.54-0.46*qCos(2*M_PI*i/(frame-1));
    }
    QList<qreal> zcrs;
    QList<qreal> engs;
    qreal maxzcr=0,maxeng=0;
    for(QList<qint32>::const_iterator i=ls.constBegin();i<ls.constEnd()-frame;i+=step){
        qreal z=zcr(i,i+frame);
        zcrs<<z;
        if(z>maxzcr)maxzcr=z;
        qreal s=ste(i,frame);
        engs<<s;
        if(s>maxeng)maxeng=s;
    }
    QList<qreal>dzcrs;
    qreal maxd=0,avg=0;
    for(int i=0;i<zcrs.size();++i){
        qreal t=engs[i]/zcrs[i];
        if(pzcr[i]>2175/frame)dzcrs<<t;else dzcrs<<0;
        if(t>maxd)maxd=t;
        avg+=t/zcrs.size();
    }
    qreal limit=avg-maxd/20;
    for(int i=0;i<dzcrs.size();++i){
        if(dzcrs[i]<limit)dzcrs[i]=0;
        else dzcrs[i]=maxd;
    }

//    erosion(dzcrs,20);
//    expand(dzcrs,20);
//    expand(dzcrs,40);
//    erosion(dzcrs,40);

    resize(1000,601);
    Gram2dS*g0=new Gram2dS(ls,lm,this);
    Gram2d5*g1=new Gram2d5(ft,2048,-2048,this);
    Gram2dU*g2=new Gram2dU(engs,maxeng*10,this);
    Gram2dU*g3=new Gram2dU(dzcrs,maxd,this);
    g0->setGeometry(0,0,1000,250);
    g1->setGeometry(0,250,1000,250);
    g2->setGeometry(0,500,1000,50);
    g3->setGeometry(0,551,1000,50);
    setWindowTitle(QString::number(frame)+","+QString::number(handle.frames())+","+QString::number(handle.format(),16)+","+QString::number(handle.channels())+","+QString::number(handle.samplerate()));
}

MainWindow::~MainWindow()
{
}

void MainWindow::doread()
{
}
qreal MainWindow::zcr(qint32*a,int length){
    qreal c=0.0;
    for(int i=0;i<length-1;++i){
        int t=a[i],p=a[i+1];
        if(a[i]*a[i+1]<0)++c;
        if(i==96000)
            i=96000;
    }
    return c;
}

qreal MainWindow::zcr(QList<qint32>::const_iterator begin, QList<qint32>::const_iterator end)
{
    qint32 c=0;
    QList<qint32>::const_iterator b=begin;
    bool p0=*begin>0,p1=!p0;
    for(;begin!=end-1;){
        c+=qFabs((*begin>0)-(*begin<0)-(*(++begin)>0)+(*begin<0));
    }
    qint32 l=end-begin;
    qreal r=(double)c/(end-b);
    return r/2;
}

qreal MainWindow::ste(QList<qint32>::const_iterator begin, qint32 length)
{
    qreal c=0;
    qint64 t;
    for(int i=0;i<length;++i,++begin){
        c+=qFabs(*begin)*hamming[i];//hamming window
    }
    return c;
}

void MainWindow::qfft(qcomplex *t, qint64 nn)
{
    qint64 j=0,mm=nn>>1;
    for(qint64 i=0;i<nn;++i){
        if(i<j){
            qreal tmp=t[i][0];
            t[i][0]=t[j][0];
            t[j][0]=tmp;
            tmp=t[i][1];
            t[i][1]=t[j][1];
            t[j][1]=tmp;
        }
        qint64 m=mm;
        while(m>0&&m<=j){
            j-=m;
            m>>=1;
        }
        j+=m;
    }
    qint64 N=1;
    qreal dpi=2*M_PIl;//圆周率的两倍
    while(N<nn){
        qint64 istep=N*2;
        qreal theta=-dpi/istep,wtemp=qSin(theta/2),wpr=-2*wtemp*wtemp,wpi=qSin(theta),wr=1,wi=0;
        for(int m=0;m<N;++m){
            for(int i=m;i<nn;i+=istep){
                j=i+N;
                qreal tempr=wr*t[j][0]-wi*t[j][1];
                qreal tempi=wr*t[j][1]+wi*t[j][0];
                t[j][0]=t[i][0]-tempr;
                t[j][1]=t[i][1]-tempi;
                t[i][0]+=tempr;
                t[i][1]+=tempi;
            }
            wr += (wtemp = wr)*wpr - wi*wpi;
            wi += wi*wpr + wtemp*wpi;
        }
        N=istep;
    }
}

void MainWindow::qFFT(QList<qreal>::iterator begin, QList<qreal>::iterator end, bool direction)
{
    qint32 m=(end-begin),n=2*m;
    //    qreal*c=new qreal[n+1];
    QList<qreal> c;
    c<<0;
    if(direction){
        for(QList<qreal>::iterator i=begin;i!=end;++i){
            c<<*i;
            c<<0;
        }
    }
    else{
        for(QList<qreal>::iterator i=begin;i!=end;++i){
            c<<*i;
        }
        c<<0<<0;
        for(qint32 i=1;i<end-begin-1;++i){
            c<<*(end-i);
            ++i;
            c<<-*(end-i);
        }
    }
    qint32 j = 1;
    for (int i = 1; i < n; i += 2) {
        if (j > i) {
            qreal t=c[j];
            c[j]=c[i];
            c[i]=t;
            t=c[j+1];
            c[j+1]=c[i+1];
            c[i+1]=t;
        }
        m = n >> 1;
        while (m >= 2 && j > m) {
            j -= m;
            m >>= 1;
        }
        j += m;
    }
    qint32 mmax = 2;
    while (n > mmax) {
        qint32 istep = 2*mmax;
        qreal theta = 2*M_PI/((2*direction-1)*mmax);
        qreal wtemp = sin(0.5*theta);
        qreal wpr = -2.0*wtemp*wtemp;
        qreal wpi = sin(theta);
        qreal wr = 1.0;
        qreal wi = 0.0;
        for (m = 1; m < mmax; m += 2) {
            for (int i = m; i <= n; i += istep) {
                j =i + mmax;
                qreal tr = wr*c[j]   - wi*c[j+1];
                qreal ti = wr*c[j+1] + wi*c[j];
                c[j]   = c[i]   - tr;
                c[j+1] = c[i+1] - ti;
                c[i] += tr;
                c[i+1] += ti;
            }
            wr = (wtemp = wr)*wpr - wi*wpi + wr;
            wi = wi*wpr + wtemp*wpi + wi;
        }
        mmax = istep;
    }
    if(direction)for(QList<qreal>::const_iterator i=c.constBegin()+1;begin!=end;++begin,++i){
        *begin=*i;
    }
    else{
        for(qint32 i=0;i<end-begin;++i){
            *(begin+i)=c[2*i+1];
        }
    }
}

#define PI	M_PI	/* pi to machine precision, defined in math.h */
#define TWOPI	(2.0*PI)
void MainWindow::lFilter(QList<qreal>&b,qint64 limit)
{
    qint32 nn=b.size();
    qcomplex*t=(qcomplex*)malloc(sizeof(qcomplex)*nn);
    for(qint32 i=0;i<nn;++i){
        t[i][0]=b[i];
        t[i][1]=0;
    }
    qfft(t,nn);
    for(qint32 i=limit;i<nn;++i){
        t[i][0]=0;
        t[i][1]=0;
    }
    fftw_plan pl=fftw_plan_dft_1d(nn,t,t,FFTW_BACKWARD,FFTW_ESTIMATE);
    fftw_execute(pl);
    b.clear();
    for(int i=0;i<nn;++i){
        b.append(t[i][0]);
    }
}

void MainWindow::lpFilter(qcomplex *t, qint64 n, qint64 limit)
{
    qfft(t,n);
    for(qint64 i=limit;i<n;++i){
        t[i][0]=0;
        t[i][1]=0;
    }
    fftw_plan pl=fftw_plan_dft_1d(n,t,t,FFTW_BACKWARD,FFTW_ESTIMATE);
    fftw_execute(pl);
    for(qint64 i=0;i<limit;++i){
        t[i][0]/=n;
        t[i][1]/=n;
    }
}
void MainWindow::four1(double data[], int nn, int isign)
{
    int n, mmax, m, j, istep, i;
    double wtemp, wr, wpr, wpi, wi, theta;
    double tempr, tempi;

    n = nn << 1;
    j = 1;
    for (i = 1; i < n; i += 2) {
        if (j > i) {
            tempr = data[j];     data[j] = data[i];     data[i] = tempr;
            tempr = data[j+1]; data[j+1] = data[i+1]; data[i+1] = tempr;
        }
        m = n >> 1;
        while (m >= 2 && j > m) {
            j -= m;
            m >>= 1;
        }
        j += m;
    }
    for(int i=1;i<=16;++i){
        qDebug()<<data[i];
    }
    mmax = 2;
    while (n > mmax) {
        istep = 2*mmax;
        theta = -TWOPI/(isign*mmax);
        wtemp = sin(0.5*theta);
        wpr = -2.0*wtemp*wtemp;
        wpi = sin(theta);
        wr = 1.0;
        wi = 0.0;
        qDebug()<<theta<<","<<wtemp<<","<<wpr<<","<<wpi<<",";
        for (m = 1; m < mmax; m += 2) {
            for (i = m; i <= n; i += istep) {
                j =i + mmax;
                tempr = wr*data[j]   - wi*data[j+1];
                tempi = wr*data[j+1] + wi*data[j];
                data[j]   = data[i]   - tempr;
                data[j+1] = data[i+1] - tempi;
                data[i] += tempr;
                data[i+1] += tempi;
                qDebug()<<"fi"<<tempr<<","<<tempi;
            }
            wr = (wtemp = wr)*wpr - wi*wpi + wr;
            wi = wi*wpr + wtemp*wpi + wi;
            qDebug()<<"fii"<<wr<<","<<wi;
        }
        mmax = istep;
    }
}

void MainWindow::four2(double *data, int nn,int dir)
{
    unsigned long n, mmax, m, j, istep, i;
    double wtemp, wr, wpr, wpi, wi, theta;
    double tempr, tempi;

    // reverse-binary reindexing
    n = nn<<1;
    j=1;
    for (i=1; i<n; i+=2) {
        if (j>i) {
            double t=data[j-1];
            data[j-1]=data[i-1];
            data[i-1]=t;
            t=data[j];
            data[j]=data[i];
            data[i]=t;
        }
        m = nn;
        while (m>=2 && j>m) {
            j -= m;
            m >>= 1;
        }
        j += m;
    };

    // here begins the Danielson-Lanczos section
    mmax=2;
    while (n>mmax) {
        istep = mmax<<1;
        theta = -(2*M_PI/mmax)*dir;
        wtemp = sin(0.5*theta);
        wpr = -2.0*wtemp*wtemp;
        wpi = sin(theta);
        wr = 1.0;
        wi = 0.0;
        for (m=1; m < mmax; m += 2) {
            for (i=m; i <= n; i += istep) {
                j=i+mmax;
                tempr = wr*data[j-1] - wi*data[j];
                tempi = wr * data[j] + wi*data[j-1];

                data[j-1] = data[i-1] - tempr;
                data[j] = data[i] - tempi;
                data[i-1] += tempr;
                data[i] += tempi;
            }
            wtemp=wr;
            wr += wr*wpr - wi*wpi;
            wi += wi*wpr + wtemp*wpi;
        }
        mmax=istep;
    }
}

void MainWindow::expand(QList<qreal> &s, qint32 l)
{
    QList<qreal>t(s);
    for(int i=0;i<s.size()-1;++i){
        if(s[i]>0&&s[i+1]==0){
            for(int j=1;j<l&&i+j<s.size();++j)t[i+j]=s[i];
        }
    }
    for(int i=1;i<s.size();++i){
        if(s[i]>0&&s[i-1]==0){
            for(int j=1;j<l&&i-j>0;++j)t[i-j]=s[i];
        }
    }
    s=QList<qreal>(t);
}

void MainWindow::erosion(QList<qreal> &s, qint32 l)
{
    QList<qreal>t(s);
    for(int i=0;i<s.size()-1;++i){
        if(s[i]==0&&s[i+1]>0){
            for(int j=1;j<l&&i+j<s.size();++j)t[i+j]=s[i];
        }
    }
    for(int i=1;i<s.size();++i){
        if(s[i]==0&&s[i-1]>0){
            for(int j=1;j<l&&i-j>0;++j)t[i-j]=s[i];
        }
    }
    s=QList<qreal>(t);
}

qreal *MainWindow::mkhamming(qint64 l)
{
    qreal lpi=2*M_PI/(l-1);
    qreal*c=(qreal*)fftw_malloc(sizeof(qreal)*l);
    for(int i=0;i<l;++i){
        c[i]=0.54-0.46*qCos(lpi*i);
    }
    return c;
}
