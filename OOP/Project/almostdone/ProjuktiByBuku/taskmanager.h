#ifndef TASKMANAGER_H
#define TASKMANAGER_H

#include <QWidget>
#include <QListWidget>
#include <QPushButton>
#include <iostream>
#include <QMainWindow>
#include<QDialog>
#include <QDebug>
#include <string.h>
#include <QString>
#include <fstream>
#include <QFileDialog>
#include <QFile>
#include <QTimer>
#include <QMessageBox>
#include <QTextStream>

namespace Ui {
class TaskManager;
}

class TaskManager : public QDialog
{
    Q_OBJECT

public:
    explicit TaskManager(QWidget *parent = nullptr);
    ~TaskManager();

private slots:
    void on_addPushButton_clicked();

//    void on_savePushButton_clicked();

    void on_removePushButton_clicked();

    void on_calendarWidget_selectionChanged();

    void on_routinePushButton_clicked(bool checked);

    void loadItemsFromFile(const QString& date1);

    void saveItemsToFile(const QString& date1 , const QString &itemToAdd);




    void on_pushSaveAsRoutineButton_clicked();

private:
    Ui::TaskManager *ui;


    class CheckableListItem : public QListWidgetItem{
    public:
        CheckableListItem(const QString& text) :QListWidgetItem(text){
            setFlags((flags() | Qt::ItemIsUserCheckable));
            setCheckState(Qt::Unchecked);
        }
        QVariant data(int role)const override;

    };

};

#endif // TASKMANAGER_H
