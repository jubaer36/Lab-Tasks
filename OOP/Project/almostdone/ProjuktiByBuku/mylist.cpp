#include "mylist.h"
#include "ui_mylist.h"

mylist::mylist(QWidget *parent)
    : QDialog(parent)
    , ui(new Ui::mylist)
{
    ui->setupUi(this);
}

mylist::~mylist()
{
    delete ui;
}


