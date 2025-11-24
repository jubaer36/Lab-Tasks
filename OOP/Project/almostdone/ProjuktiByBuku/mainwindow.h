#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QMainWindow>
#include "pomodoro.h"
#include "mysubject.h"
#include "taskmanager.h"
#include "ui_taskmanager.h"
#include "progressbar.h"
#include "ui_progressbar.h"
#include <QDateTime>

QT_BEGIN_NAMESPACE
namespace Ui {
class MainWindow;
}
QT_END_NAMESPACE

class MainWindow : public QMainWindow
{
    Q_OBJECT

public:
    MainWindow(QWidget *parent = nullptr);
    ~MainWindow();

private slots:

    void on_notebook_button_clicked();

    void on_pomodoroPushButton_clicked();

    void on_taskManagerPushButton_clicked();

    void on_progressBarPushButton_clicked();
    void Date_Time_Display_slot();

private:
    Ui::MainWindow *ui;
    pomodoro *pmdo;
    mysubject *msbjt;
    TaskManager *tasker;
    QTimer *DateTime;
    ProgressBar *progress;
};
#endif // MAINWINDOW_H
