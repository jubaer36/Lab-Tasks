#ifndef PROGRESSBAR_H
#define PROGRESSBAR_H

#include <QDialog>
#include <QDialog>
#include <QDir>
#include <QMainWindow>
#include <QtCharts>
#include <QChartView>
#include <QBarSet>
#include <QBarSeries>

namespace Ui {
class ProgressBar;
}

class ProgressBar : public QDialog
{
    Q_OBJECT

public:
    explicit ProgressBar(QWidget *parent = nullptr);
    ~ProgressBar();

private:
    Ui::ProgressBar *ui;
    void extractProgressFromFile(QStringList& dates, QVector<int>& times);
};

#endif // PROGRESSBAR_H
