#include "mainwindow.h"
#include "./ui_mainwindow.h"


MainWindow::MainWindow(QWidget *parent)
    : QMainWindow(parent)
    , ui(new Ui::MainWindow)
{
    ui->setupUi(this);
    DateTime = new QTimer();
    connect(DateTime,SIGNAL(timeout()),this,SLOT(Date_Time_Display_slot()));
    DateTime->setInterval(1000);
    DateTime->start();
}

MainWindow::~MainWindow()
{
    delete ui;
}

void MainWindow::on_pomodoroPushButton_clicked()
{
    pmdo = new pomodoro(this);

    pmdo->show();
}


void MainWindow::on_notebook_button_clicked()
{
    msbjt = new mysubject(this);

    msbjt->show();
}
void MainWindow::Date_Time_Display_slot()
{

    QDateTime dwtee = QDateTime::currentDateTime();
    QString Time = QDateTime :: currentDateTime().toString("HH:mm");
    ui->lcdNumber->display(Time);

    QString Dateee = dwtee.toString("yyyy-MM-dd");
    ui->labelCalendar->setText(Dateee);
    ui->labelCalendar->show();

}



void MainWindow::on_taskManagerPushButton_clicked()
{
    tasker = new TaskManager(this);
    tasker->show();
}


void MainWindow::on_progressBarPushButton_clicked()
{
    progress = new ProgressBar(this);
    progress->show();
}

