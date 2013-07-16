#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QMainWindow>
#include<QtMultimedia/QAudioBuffer>
#include<QtMultimedia/QAudioDecoder>
#include<QByteArray>

typedef qreal qcomplex[2];

namespace Ui {
class MainWindow;
}

class MainWindow : public QMainWindow
{
    Q_OBJECT
    
public:
    explicit MainWindow(QWidget *parent = 0);
    ~MainWindow();
public slots:
    void doread();
private:
    qreal zcr(qint32*a,int length);
    qreal zcr(QList<qint32>::const_iterator begin, QList<qint32>::const_iterator end);
    qreal ste(QList<qint32>::const_iterator begin,qint32 length);
    void qfft(qcomplex*t, qint64 nn);
    void qFFT(QList<qreal>::iterator begin,QList<qreal>::iterator end,bool direction=true);
    void lFilter(QList<qreal>&b, qint64 limit);
    void lpFilter(qcomplex*t,qint64 n,qint64 limit);
    void four1(double data[], int nn, int isign);
    void four2(double*data, int nn, int dir);
    void expand(QList<qreal>&s,qint32 l);
    void erosion(QList<qreal>&s,qint32 l);
    qreal*mkhamming(qint64 l);
    QAudioDecoder*dec;
    QAudioBuffer buf;
    QByteArray raw;
    QList<qint32> ls;
    QList<qint32> rs;
    QList<qreal> hamming;
};

#endif // MAINWINDOW_H
