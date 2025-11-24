#include "pomodoro.h"
#include "ui_pomodoro.h"
#include<QDebug>
pomodoro::pomodoro(QWidget *parent)
    : QDialog(parent)
    , ui(new Ui::pomodoro)
{
    ui->setupUi(this);
    timer = new QTimer();
    timer->setInterval(1000);
    setWindowTitle("Time to focus!!!");
    is_timer_running = false;
    breaktime = false;
    remaining_minutes = read_pomo_time();
    remaining_seconds = 0;
    total_sessions = 1;
    lofi_running = false;

    focus_time = 0;


    ui->start_stop_button->setText("START");

    int minutes = remaining_minutes;
    int seconds = remaining_seconds;
    QString timeString = QString("%1:%2").arg(minutes, 2, 10, QLatin1Char('0'))
                             .arg(seconds, 2, 10, QLatin1Char('0'));
    ui->lcdNumber->display(timeString);

    lplayer = new QMediaPlayer;
    laudioOutput = new QAudioOutput;
    lplayer->setAudioOutput(laudioOutput);
    connect(lplayer, SIGNAL(positionChanged(qint64)), this, SLOT(positionChanged(qint64)));
    lplayer->setSource(QUrl::fromLocalFile("sounds/interstellar.m4a"));
    laudioOutput->setVolume(50);


    connect(timer, SIGNAL(timeout()), this, SLOT(updateTimer()));

}

pomodoro::~pomodoro()
{
    delete ui;
}

void pomodoro::on_start_stop_button_clicked()
{
    if(is_timer_running)
    {
        is_timer_running = false;
        timer->stop();
        ui->start_stop_button->setText("START");

    }
    else
    {
        is_timer_running = true;
        timer->start();
        ui->start_stop_button->setText("STOP");
    }

}

void pomodoro::updateTimer()
{

    if(remaining_minutes == 0 && remaining_seconds == 0)
    {
        on_start_stop_button_clicked();
        QString alarm = notification_sound();

        player = new QMediaPlayer;
        audioOutput = new QAudioOutput;
        player->setAudioOutput(audioOutput);
        connect(player, SIGNAL(positionChanged(qint64)), this, SLOT(positionChanged(qint64)));
        player->setSource(QUrl::fromLocalFile("sounds/"+alarm));
        audioOutput->setVolume(50);
        player->play();

        ui->lcdNumber->display("00:00");

        if(breaktime)
        {
            setWindowTitle("Time to Focus!!!");
            total_sessions++;
            QString tempp = QString::number(total_sessions);
            ui->session_no->setText("#" + tempp);
            ui->session_no->show();

            remaining_minutes = read_pomo_time();
            breaktime = false;
        }
        else
        {
            setWindowTitle("Time to Rest!!!");
            saveProgressToFile();
            if(total_sessions%4)
                remaining_minutes = read_sbreak_time();
            else
                remaining_minutes = read_lbreak_time();

            breaktime = true;
        }
    }
    else if(remaining_minutes != 0 && remaining_seconds ==0)
    {
        remaining_minutes--;
        remaining_seconds = 59;
        if(!breaktime)
        {focus_time++;}
    }
    else
    {
        remaining_seconds--;
    }
    int minutes = remaining_minutes;
    int seconds = remaining_seconds;
    QString timeString = QString("%1:%2").arg(minutes, 2, 10, QLatin1Char('0'))
                             .arg(seconds, 2, 10, QLatin1Char('0'));
    ui->lcdNumber->display(timeString);


    // qDebug()<<focus_time;
}



void pomodoro::on_skip_button_clicked()
{
    // is_timer_running = false;
    // breaktime = true;
    remaining_minutes = 0;
    remaining_seconds = 0;
    // total_sessions = 0;
    // timer->stop();
    // ui->lcdNumber->display("00:00");
    // ui->start_stop_button->setText("Tatakae!!!");
}

QString pomodoro::notification_sound()
{
    QFile file("alarm_sound.txt");

    if(!file.open(QFile::ReadOnly | QFile::Text))
    {

    }

    QTextStream in(&file);
    QString the_sound = in.readAll();
    file.close();
    return the_sound;
}

void pomodoro::on_customize_button_clicked()
{
    cstm = new custom(this);

    cstm->show();
}

int pomodoro::read_pomo_time()
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

int pomodoro::read_sbreak_time()
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

int pomodoro::read_lbreak_time()
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








void pomodoro::on_lofi_button_clicked()
{
    if(lofi_running)
    {
        lplayer->pause();
        ui->lofi_button->setText("lofi ON");
        lofi_running = false;
    }
    else
    {
        lplayer->play();
        ui->lofi_button->setText("lofi OFF");
        lofi_running = true;
    }
}

void pomodoro::saveProgressToFile()
{
    QDateTime currentTime = QDateTime::currentDateTime();
    QString formattedDate = currentTime.toString("yyyy-MM-dd");
    QString filePath = QDir::currentPath() + QDir::separator() + "progress.txt";

    int totalRuntime = focus_time;
    focus_time = 0;

    QFile file(filePath);
    if (file.open(QIODevice::ReadWrite | QIODevice::Text)) {
        QTextStream stream(&file);

        QStringList progressList;


        while (!stream.atEnd()) {
            QString line = stream.readLine();
            if (!line.isEmpty()) {
                progressList.append(line);
            }
        }


        bool dateFound = false;
        for (int i = 0; i < progressList.size(); ++i) {
            QString line = progressList.at(i);
            QStringList parts = line.split(' ');
            if (parts.size() == 2) {
                QString date = parts[0];
                if (date == formattedDate) {
                    int runtime = parts[1].toInt();
                    runtime += totalRuntime;
                    progressList.replace(i, date + " " + QString::number(runtime));
                    dateFound = true;
                    break;
                }
            }
        }


        if (!dateFound) {
            progressList.append(formattedDate + " " + QString::number(totalRuntime));
        }


        std::sort(progressList.begin(), progressList.end());

        if (progressList.size() > 7) {
            progressList.removeFirst();
        }

        // Clear the file contents
        file.resize(0);

        // Write the updated progress to the file
        for (const QString& entry : progressList) {
            stream << entry << '\n';
        }

        file.close();
    }

    // firstTime = false;
}
void pomodoro::closeEvent(QCloseEvent *event)
{
    // Stop the player when the window is closed
    lplayer->stop();

    // Call the base class implementation
    QDialog::closeEvent(event);
}
