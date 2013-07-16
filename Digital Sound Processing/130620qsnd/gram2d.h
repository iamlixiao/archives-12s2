#ifndef GRAM2D_H
#define GRAM2D_H

#include <QWidget>
#include<QPixmap>
#include<QList>

class gram2d : public QWidget
{
    Q_OBJECT
    void paintEvent(QPaintEvent *);
    QPixmap*p;
public:
    explicit gram2d(QWidget *parent = 0);
    gram2d(qreal*t,qreal*l,QWidget*parent=0);
    gram2d(qint32*t, qint32 l, QWidget *parent=0);
    gram2d(QList<qint32>&s, qint32 m, QWidget*parent=0);
signals:
    
public slots:
    
};

#endif // GRAM2D_H
