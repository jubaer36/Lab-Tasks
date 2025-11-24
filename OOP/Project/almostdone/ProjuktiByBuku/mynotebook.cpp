#include "mynotebook.h"
#include "ui_mynotebook.h"
#include <iostream>

mynotebook::mynotebook(QWidget *parent)
    : QDialog(parent)
    , ui(new Ui::mynotebook)
{
    ui->setupUi(this);
    load_note();
}

mynotebook::~mynotebook()
{
    delete ui;
}

void mynotebook::on_pushButton_clicked()
{
    save_note();
}

void mynotebook::load_note()
{
    QFile file("current_subject.txt");

    if(!file.open(QFile::ReadOnly | QFile::Text))
    {

    }

    QTextStream in(&file);
    QString theSubject = in.readAll();
    file.close();

    QFile file2("current_date.txt");

    if(!file2.open(QFile::ReadOnly | QFile::Text))
    {

    }

    QTextStream in2(&file2);
    QString theDate = in2.readAll();
    file2.close();

    QFile file3(theSubject+theDate+".txt");
    if (file3.open(QIODevice::ReadOnly | QIODevice::Text)) {
        QTextStream stream(&file3);

        QTextStream in(&file3);
        QString line2 = in.readAll();
        ui->textEdit->setText(line2);

    }
    file3.close();




}

void mynotebook::save_note()
{
    QFile file5("current_subject.txt");

    if(!file5.open(QFile::ReadOnly | QFile::Text))
    {

    }

    QTextStream in(&file5);
    QString theSubject = in.readAll();
    file5.close();

    QFile file2("current_date.txt");

    if(!file2.open(QFile::ReadOnly | QFile::Text))
    {

    }

    QTextStream in2(&file2);
    QString theDate = in2.readAll();
    file2.close();

    QFile file(theSubject+theDate+".txt");
    if (file.open(QIODevice::WriteOnly | QIODevice::Text))
    {
        QTextStream stream(&file);
        QTextStream out(&file);
        QString line2 = ui->textEdit->toPlainText();
        out<<line2;

    }
    file.close();
}

