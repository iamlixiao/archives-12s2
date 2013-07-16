#include "mainwindow.h"
#include <QApplication>
#include<QtMultimedia/QAudioDecoder>
#include<QtMultimedia/QMediaPlayer>
#include<QFile>

int main(int argc, char *argv[])
{
    QApplication a(argc, argv);
    MainWindow w;
    w.show();
    
    return a.exec();
}
