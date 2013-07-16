#ifndef GRAM2DU_H
#define GRAM2DU_H

#include <QWidget>
#include<QPixmap>
#include<QList>

class Gram2dU : public QWidget
{
    Q_OBJECT
    void paintEvent(QPaintEvent *);
    QPixmap*p;
public:
    explicit Gram2dU(QWidget *parent = 0);
    Gram2dU(QList<qint32>&s,qint32 m,QWidget*parent=0);
    Gram2dU(QList<qreal>&s,qreal m,QWidget*parent=0);
signals:
    
public slots:
    
};

#endif // GRAM2DU_H
