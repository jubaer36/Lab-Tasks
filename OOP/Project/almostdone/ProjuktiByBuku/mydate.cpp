#include "mydate.h"
#include "ui_mydate.h"
#include <bits/stdc++.h>
#include <QString>

mydate::mydate(QWidget *parent)
    : ui(new Ui::mydate)
{
    ui->setupUi(this);
    ui->lineEdit->setPlaceholderText("Date:DD.MM.YY");
    load_list();
}

mydate::~mydate()
{
    delete ui;
}

void mydate::on_add_button_clicked()
{
    add_press();
    save_list();
}


void mydate::on_enter_button_clicked()
{
    enter_press();
}


void mydate::on_remove_button_clicked()
{
    remove_press();
    save_list();
}

void mydate::save_list()
{
    QFile file2("current_subject.txt");

    if(!file2.open(QFile::ReadOnly | QFile::Text))
    {

    }

    QTextStream in(&file2);
    QString theSubject = in.readAll();
    file2.close();


    std::ofstream file(theSubject.toStdString()+".txt");
    if (file.is_open()) {
        for (int i = 0; i < ui->listWidget->count(); ++i) {
            QString item = ui->listWidget->item(i)->text();
            file << item.toStdString() << std::endl;
        }
        file.close();
    }
}

void mydate::load_list()
{
    QFile file2("current_subject.txt");

    if(!file2.open(QFile::ReadOnly | QFile::Text))
    {

    }

    QTextStream in(&file2);
    QString theSubject = in.readAll();
    file2.close();


    std::ifstream file(theSubject.toStdString()+".txt");
    if (file.is_open()) {
        std::string line;
        while (getline(file, line)) {
            QString item = QString::fromStdString(line);
            ui->listWidget->addItem(item);
        }
        file.close();
    }
}
void mydate::add_press()
{
    QString text = ui->lineEdit->text().trimmed();

    try{
        QDate date = QDate::fromString(text, "dd.MM.yyyy");

        if(!date.isValid()){
            throw std::invalid_argument("Invalid date format. Please use dd.mm.yyyy.");
        }



        ui->listWidget->addItem(text);
        ui->lineEdit->clear();
    }
    catch(const std::invalid_argument &e){
        QMessageBox::critical(this, "Error", e.what());
    }
}
void mydate::remove_press()
{
    QListWidgetItem* item = ui->listWidget->currentItem();
    if (item)
    {
        delete item;
        ui->listWidget->setCurrentRow(-1);
    }
}
void mydate::enter_press()
{
    QListWidgetItem* item = ui->listWidget->currentItem();
    if (item)
    {
        QString theText = item->text();

        QFile file4("current_date.txt");

        if(!file4.open(QFile::WriteOnly | QFile::Text)){

        }
        QTextStream out4(&file4);

        out4<<theText;
        file4.flush();
        file4.close();

        nte = new mynotebook(this);
        nte->show();
        hide();


    }
}
