#include "mysubject.h"
#include "ui_mysubject.h"
#include <bits/stdc++.h>


mysubject::mysubject(QWidget *parent)
    : ui(new Ui::mysubject)
{

    ui->setupUi(this);
    ui->lineEdit->setPlaceholderText("Subject");
    load_list();
}


mysubject::~mysubject()
{
    delete ui;
}

void mysubject::on_add_button_clicked()
{
    add_press();
    save_list();
}


void mysubject::on_enter_button_clicked()
{
    enter_press();
}


void mysubject::on_remove_button_clicked()
{
    remove_press();
    save_list();
}

void mysubject::add_press()
{
    QString text = ui->lineEdit->text().trimmed();


    if (!text.isEmpty())
    {
        ui->listWidget->addItem(text);
        ui->lineEdit->clear();
    }
}

void mysubject::enter_press()
{
    QListWidgetItem* item = ui->listWidget->currentItem();
    if (item)
    {
        QString theText = item->text();

        QFile file4("current_subject.txt");

        if(!file4.open(QFile::WriteOnly | QFile::Text)){

        }
        QTextStream out4(&file4);

        out4<<theText;
        file4.flush();
        file4.close();

        dte = new mydate(this);
        dte->show();
        hide();

    }
}
void mysubject::remove_press()
{
    QListWidgetItem* item = ui->listWidget->currentItem();
    if (item)
    {
        delete item;
        ui->listWidget->setCurrentRow(-1);
    }
}

void mysubject::save_list()
{
    std::ofstream file("subject.txt");
    if (file.is_open()) {
        for (int i = 0; i < ui->listWidget->count(); ++i) {
            QString item = ui->listWidget->item(i)->text();
            file << item.toStdString() << std::endl;
        }
        file.close();
    }
}

void mysubject::load_list()
{
    std::ifstream file("subject.txt");
    if (file.is_open()) {
        std::string line;
        while (getline(file, line)) {
            QString item = QString::fromStdString(line);
            ui->listWidget->addItem(item);
        }
        file.close();
    }
}
