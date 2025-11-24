#ifndef ALARMWINDOW_H
#define ALARMWINDOW_H

#include <QDialog>
#include <QDebug>
#include <QAudioOutput>
#include<QMediaPlayer>
#include <string.h>
#include <QString>
#include <fstream>
#include <QFileDialog>
#include <QFile>
#include <QTextStream>

namespace Ui {
class alarmwindow;
}

class alarmwindow : public QDialog
{
    Q_OBJECT

public:
    explicit alarmwindow(QWidget *parent = nullptr);
    ~alarmwindow();

private slots:
    void on_bell_button_clicked();

    void on_bird_button_clicked();

    void on_kitchen_button_clicked();

    void on_digital_button_clicked();

    void on_rooster_button_clicked();

private:
    Ui::alarmwindow *ui;
    QMediaPlayer *player;
    QAudioOutput *audioOutput;
};

#endif // ALARMWINDOW_H
