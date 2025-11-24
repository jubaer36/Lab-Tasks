#ifndef MYNOTEBOOK_H
#define MYNOTEBOOK_H

#include <QDialog>
#include <QDebug>
#include<string.h>
#include <QString>
#include <fstream>
#include <QFileDialog>
#include <QFile>
#include <QTextStream>
#include <QMessageBox>
#include <QFile>

namespace Ui {
class mynotebook;
}

class mynotebook : public QDialog
{
    Q_OBJECT

public:
    explicit mynotebook(QWidget *parent = nullptr);
    ~mynotebook();

private slots:
    void on_pushButton_clicked();
    void load_note();
    void save_note();
private:
    Ui::mynotebook *ui;
};

#endif // MYNOTEBOOK_H
