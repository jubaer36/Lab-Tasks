#include "alarmwindow.h"
#include "ui_alarmwindow.h"

alarmwindow::alarmwindow(QWidget *parent)
    : QDialog(parent)
    , ui(new Ui::alarmwindow)
{
    ui->setupUi(this);
    player = new QMediaPlayer;
    audioOutput = new QAudioOutput;
    player->setAudioOutput(audioOutput);
    connect(player, SIGNAL(positionChanged(qint64)), this, SLOT(positionChanged(qint64)));
}

alarmwindow::~alarmwindow()
{
    delete ui;
}

void alarmwindow::on_bell_button_clicked()
{
    QFile file("alarm_sound.txt");

    if(!file.open(QFile::WriteOnly | QFile::Text)){

    }
    QTextStream out(&file);



    out<<"bell.mp3";
    file.flush();
    file.close();
    player->setSource(QUrl::fromLocalFile("/mnt/frustration/Coding101/projukti/build-projukti-Desktop_Qt_6_6_1_GCC_64bit-Debug/sounds/bell.mp3"));
    audioOutput->setVolume(50);
    player->play();

}


void alarmwindow::on_bird_button_clicked()
{
    QFile file("alarm_sound.txt");

    if(!file.open(QFile::WriteOnly | QFile::Text)){

    }
    QTextStream out(&file);



    out<<"bird.mp3";
    file.flush();
    file.close();
    player->setSource(QUrl::fromLocalFile("/mnt/frustration/Coding101/projukti/build-projukti-Desktop_Qt_6_6_1_GCC_64bit-Debug/sounds/bird.mp3"));
    audioOutput->setVolume(50);
    player->play();
}


void alarmwindow::on_kitchen_button_clicked()
{
    QFile file("alarm_sound.txt");

    if(!file.open(QFile::WriteOnly | QFile::Text)){

    }
    QTextStream out(&file);



    out<<"kitchen.mp3";
    file.flush();
    file.close();
    player->setSource(QUrl::fromLocalFile("/mnt/frustration/Coding101/projukti/build-projukti-Desktop_Qt_6_6_1_GCC_64bit-Debug/sounds/kitchen.mp3"));
    audioOutput->setVolume(50);
    player->play();
}


void alarmwindow::on_digital_button_clicked()
{
    QFile file("alarm_sound.txt");

    if(!file.open(QFile::WriteOnly | QFile::Text)){

    }
    QTextStream out(&file);



    out<<"digital.mp3";
    file.flush();
    file.close();
    player->setSource(QUrl::fromLocalFile("/mnt/frustration/Coding101/projukti/build-projukti-Desktop_Qt_6_6_1_GCC_64bit-Debug/sounds/digital.mp3"));
    audioOutput->setVolume(50);
    player->play();
}


void alarmwindow::on_rooster_button_clicked()
{
    QFile file("alarm_sound.txt");

    if(!file.open(QFile::WriteOnly | QFile::Text)){

    }
    QTextStream out(&file);



    out<<"rooster.mp3";
    file.flush();
    file.close();
    player->setSource(QUrl::fromLocalFile("/mnt/frustration/Coding101/projukti/build-projukti-Desktop_Qt_6_6_1_GCC_64bit-Debug/sounds/rooster.mp3"));
    audioOutput->setVolume(50);
    player->play();
}

