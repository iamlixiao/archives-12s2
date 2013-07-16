#ifndef GRAM2D5_H
#define GRAM2D5_H

#include <QWidget>
#include<QList>
#include<QImage>

class Gram2d5 : public QWidget
{
    Q_OBJECT
    void paintEvent(QPaintEvent *);
    QImage*p;
public:
    explicit Gram2d5(QWidget *parent = 0);
    Gram2d5(QList<QList<qreal> >&s,qreal m,qreal x,QWidget*parent=0);
signals:
    
public slots:
    
};

#endif // GRAM2D5_H
