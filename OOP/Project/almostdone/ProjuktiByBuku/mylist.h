#ifndef MYLIST_H
#define MYLIST_H

#include <QDialog>
#include <QListWidget>
#include <fstream>
#include <QFileDialog>
#include <QFile>
#include <QTextStream>
#include <bits/stdc++.h>
#include <string.h>

namespace Ui {
class mylist;
}

class mylist : public QDialog
{
    Q_OBJECT

public:
    explicit mylist(QWidget *parent = nullptr);
    ~mylist();
    virtual void save_list()=0;
    virtual void load_list()=0;
    virtual void add_press()=0;
    virtual void remove_press()=0;
    virtual void enter_press()=0;

private:
    Ui::mylist *ui;
};

#endif // MYLIST_H
