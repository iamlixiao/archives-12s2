#ifndef GRAM2DS_H
#define GRAM2DS_H

#include <QWidget>
#include<QPixmap>
#include<QImage>
#include<QList>

class Gram2dS : public QWidget
{
    Q_OBJECT
    void paintEvent(QPaintEvent *);
    QImage*p;
public:
    explicit Gram2dS(QWidget *parent = 0);
    Gram2dS(QList<qint32>&s,qint32 m,QWidget*parent=0);
    
signals:
    
public slots:
    
};

#endif // GRAM2DS_H
