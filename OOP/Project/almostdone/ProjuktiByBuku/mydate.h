#ifndef MYDATE_H
#define MYDATE_H

#include <QDialog>
#include "mylist.h"
#include "mynotebook.h"

namespace Ui {
class mydate;
}

class mydate : public mylist
{
    Q_OBJECT

public:
    explicit mydate(QWidget *parent = nullptr);
    ~mydate();
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
    Ui::mydate *ui;
    mynotebook *nte;
};

#endif // MYDATE_H
