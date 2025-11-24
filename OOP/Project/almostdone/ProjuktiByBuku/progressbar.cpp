#include "progressbar.h"
#include "ui_progressbar.h"

ProgressBar::ProgressBar(QWidget *parent) :
    QDialog(parent),
    ui(new Ui::ProgressBar)
{

    try{
        setWindowTitle("Progress Bar");
        ui->setupUi(this);
        QStringList dates;
        QVector<int> times;
        QBarSet *set = new QBarSet("Progress");
        extractProgressFromFile(dates,times);
        if (dates.size() < 7 || times.size() < 7) {
            throw std::runtime_error("Insufficient data points in the file.");
        }
        *set << times[0] << times[1]<< times[2]<< times[3]<< times[4]<< times[5]<< times[6];
        QBarSeries *series = new QBarSeries();
        series->append(set);
        QChart *chart = new QChart();
        chart->addSeries(series);
        chart->setTitle("Progress Bar");
        chart->setAnimationOptions(QChart::SeriesAnimations);
        QStringList categories;
        categories << dates[0]<< dates[1]<< dates[2]<< dates[3]<< dates[4]<< dates[5]<< dates[6];
        QBarCategoryAxis *axis = new QBarCategoryAxis();
        axis->append(categories);
        chart->createDefaultAxes();
        chart->setAxisX(axis);

        // QLinearGradient backgroundGradient;
        // backgroundGradient.setStart(QPointF(0, 0));
        // backgroundGradient.setFinalStop(QPointF(0, 1));
        // backgroundGradient.setColorAt(0.0, QRgb(000000));
        // backgroundGradient.setColorAt(0.0, QRgb(000000));
        // backgroundGradient.setCoordinateMode(QGradient::ObjectBoundingMode);
        // chart->setBackgroundBrush(backgroundGradient);




        QChartView *chartView = new QChartView(chart);
        chartView->setRenderHint(QPainter::Antialiasing);

        QHBoxLayout *layout = new QHBoxLayout();
        layout->addWidget(chartView);



        ui->horizontalFrame->addLayout(layout);
    }
    catch(const std::exception &e){
        QMessageBox::critical(this, "Error", e.what());

    }


}

void ProgressBar::extractProgressFromFile(QStringList& dates, QVector<int>& times) {
    QString filePath = QDir::currentPath() + QDir::separator() + "progress.txt";
    QFile file(filePath);

    if (file.open(QIODevice::ReadOnly | QIODevice::Text)) {
        QTextStream stream(&file);

        while (!stream.atEnd()) {
            QString line = stream.readLine();
            QStringList parts = line.split(' ');
            if (parts.size() == 2) {
                dates.append(parts[0]);
                times.append(parts[1].toInt());
            }
        }

        file.close();
    }
    else{
        throw std::runtime_error("Failed to open the file");
    }
}
ProgressBar::~ProgressBar()
{
    delete ui;
}
