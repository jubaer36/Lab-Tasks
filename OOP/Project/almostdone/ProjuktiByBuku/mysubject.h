#ifndef MYSUBJECT_H
#define MYSUBJECT_H

#include <QDialog>
#include "mylist.h"
#include "mydate.h"


namespace Ui {
class mysubject;
}

class mysubject : public mylist
{
    Q_OBJECT

public:
    explicit mysubject(QWidget *parent = nullptr);
    ~mysubject();
    void save_list();
    void load_list();
    void add_press();
    void remove_press();
    void enter_press();


private slots:
    void on_add_button_clicked();

    void on_enter_button_clicked();

    void on_remove_button_clicked();


private:
    Ui::mysubject *ui;
    mydate *dte;

};

#endif // MYSUBJECT_H
