#ifndef CUSTOM_H
#define CUSTOM_H

#include <QDialog>
#include "alarmwindow.h"

namespace Ui {
class custom;
}

class custom : public QDialog
{
    Q_OBJECT

public:
    explicit custom(QWidget *parent = nullptr);
    ~custom();

private slots:


    void on_save_button_clicked();

    void on_alarm_button_clicked();

    int read_pomo_time();

    int read_sbreak_time();

    int read_lbreak_time();

    void indexChanged(int index);


private:
    Ui::custom *ui;
    alarmwindow *alrm;
    QMediaPlayer *player;
    QAudioOutput *audioOutput;
};

#endif // CUSTOM_H
