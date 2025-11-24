#include "custom.h"
#include "ui_custom.h"
#include <QDebug>
#include <string.h>
#include <QString>
#include <fstream>
#include <QFileDialog>
#include <QFile>
#include <QTextStream>

custom::custom(QWidget *parent)
    : QDialog(parent)
    , ui(new Ui::custom)
{
    ui->setupUi(this);
    ui->pomodoro_spinBox->setValue(read_pomo_time());
    ui->short_break_spinBox->setValue(read_sbreak_time());
    ui->lbreak_spinBox->setValue(read_lbreak_time());
    ui->comboBox->addItem("digital");
    ui->comboBox->addItem("bell");
    ui->comboBox->addItem("rooster");
    ui->comboBox->addItem("bird");
    ui->comboBox->addItem("kitchen");

    player = new QMediaPlayer;
    audioOutput = new QAudioOutput;
    player->setAudioOutput(audioOutput);
    connect(player, SIGNAL(positionChanged(qint64)), this, SLOT(positionChanged(qint64)));
    connect(ui->comboBox, SIGNAL(currentIndexChanged(int)),
            this, SLOT(indexChanged(int)));
    ui->alarm_button->hide();

}

custom::~custom()
{
    delete ui;

}



void custom::on_save_button_clicked()
{
    QFile file("pomodoro_time.txt");

    if(!file.open(QFile::WriteOnly | QFile::Text)){

    }
    QTextStream out(&file);

    int pomo_time = ui->pomodoro_spinBox->value();

    out<<pomo_time;
    file.flush();
    file.close();

    QFile file2("sbreak_time.txt");

    if(!file2.open(QFile::WriteOnly | QFile::Text))
    {

    }
    QTextStream out2(&file2);

    int sbreak_time = ui->short_break_spinBox->value();

    out2<<sbreak_time;
    file2.flush();
    file2.close();

    QFile file3("lbreak_time.txt");

    if(!file3.open(QFile::WriteOnly | QFile::Text))
    {

    }
    QTextStream out3(&file3);

    int lbreak_time = ui->lbreak_spinBox->value();

    out3<<lbreak_time;
    file3.flush();
    file3.close();



    QFile file4("alarm_sound.txt");

    if(!file4.open(QFile::WriteOnly | QFile::Text)){

    }
    QTextStream out4(&file4);



    out4<<ui->comboBox->currentText()+".mp3";
    file4.flush();
    file4.close();


}

int custom::read_pomo_time()
{
    QFile file("pomodoro_time.txt");

    if(!file.open(QFile::ReadOnly | QFile::Text))
    {

    }

    QTextStream in(&file);
    QString pomo_time = in.readAll();
    file.close();
    return pomo_time.toInt();
}

int custom::read_sbreak_time()
{

    QFile file("sbreak_time.txt");

    if(!file.open(QFile::ReadOnly | QFile::Text))
    {

    }

    QTextStream in(&file);
    QString sbreak_time = in.readAll();
    file.close();
    return sbreak_time.toInt();

}

int custom::read_lbreak_time()
{
    QFile file("lbreak_time.txt");

    if(!file.open(QFile::ReadOnly | QFile::Text))
    {

    }

    QTextStream in(&file);
    QString lbreak_time = in.readAll();
    file.close();
    return lbreak_time.toInt();
}


void custom::on_alarm_button_clicked()
{
    alrm = new alarmwindow(this);

    alrm->show();
}

void custom::indexChanged(int index)
{
    // Do something here on ComboBox index change
    player->setSource(QUrl::fromLocalFile("sounds/"+ui->comboBox->currentText()+".mp3"));
    audioOutput->setVolume(50);
    player->play();
}

