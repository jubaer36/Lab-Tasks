#ifndef POMODORO_H
#define POMODORO_H
#include "custom.h"

#include <QAudioOutput>
#include<QMediaPlayer>
#include <QDialog>
#include <QDateTime>
#include <iostream>
#include <string>
#include <QStringList>
#include <algorithm>
#include <QMainWindow>
#include <QVBoxLayout>
#include <QLabel>
#include <QPushButton>
#include <QTimer>
#include <QLCDNumber>
#include <QSpinBox>
#include <fstream>
#include <QDir>
#include <QFile>
#include <QDebug>
#include <QTextStream>


namespace Ui {
class pomodoro;
}

class pomodoro : public QDialog
{
    Q_OBJECT

public:
    explicit pomodoro(QWidget *parent = nullptr);
    ~pomodoro();
    void closeEvent(QCloseEvent *event) override;


private slots:
    void on_start_stop_button_clicked();

    void on_customize_button_clicked();

    void updateTimer();

    int read_pomo_time();

    int read_sbreak_time();

    int read_lbreak_time();

    void on_skip_button_clicked();

    QString notification_sound();

    void on_lofi_button_clicked();

    void saveProgressToFile();

private:
    Ui::pomodoro *ui;
    QTimer *timer;
    custom *cstm;
    bool is_timer_running;
    int remaining_minutes;
    int remaining_seconds;
    int total_sessions;
    bool breaktime;
    bool lofi_running;
    QMediaPlayer *player;
    QAudioOutput *audioOutput;
    QMediaPlayer *lplayer;
    QAudioOutput *laudioOutput;

    int focus_time;

};


#endif // POMODORO_H
