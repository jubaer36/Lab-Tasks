#include "taskmanager.h"
#include "ui_taskmanager.h"

QVariant TaskManager::CheckableListItem::data(int role )const{
    if(role == Qt::ForegroundRole && checkState() == Qt::Checked)
        return QColor(Qt::gray);
    return QListWidgetItem::data(role);
}

TaskManager::TaskManager(QWidget *parent) :
    QDialog(parent),
    ui(new Ui::TaskManager)
{
    setWindowTitle("Task Manager");
    ui->setupUi(this);
    ui->endDateSelect->setDate(QDate::currentDate());
    ui->endDateSelect->hide();
    ui->label->hide();
    ui->label_2->hide();
    ui->pushSaveAsRoutineButton->hide();
    ui->intervalSpinBox->hide();
    QString date1 = ui->calendarWidget->selectedDate().toString();
    loadItemsFromFile(date1);

}

TaskManager::~TaskManager()
{
    delete ui;
}

void TaskManager::on_addPushButton_clicked()
{
   QLineEdit *lineEdit = findChild<QLineEdit *>();
   QString newItemText = ui->timeSelect->time().toString()+ "  " +lineEdit->text() ;

   QString Str = ui->lineEdit->text();

    if (!newItemText.isEmpty())
    {
        //ui->listWidget->addItem(text);
        CheckableListItem* newItem = new CheckableListItem(newItemText);
        ui->taskListWidget->addItem(newItem);
        ui->lineEdit->clear();


    }
    saveItemsToFile(ui->calendarWidget->selectedDate().toString(),Str);

}





void TaskManager::on_removePushButton_clicked()
{
    QListWidgetItem* item = ui->taskListWidget->currentItem();
    if(item){
        delete item;
        ui->taskListWidget->setCurrentRow(-1);
    }
}


void TaskManager::on_calendarWidget_selectionChanged()
{
    QString date= ui->calendarWidget->selectedDate().toString();
    ui->taskListWidget->clear();

    loadItemsFromFile(date);
}


void TaskManager::on_routinePushButton_clicked(bool checked)
{
    ui->endDateSelect->show();
    ui->intervalSpinBox->show();
    ui->label->show();
    ui->label_2->show();
    ui->pushSaveAsRoutineButton->show();
}



void TaskManager::loadItemsFromFile(const QString& date1)
{
    QFile file(date1+".txt");
    if (file.open(QIODevice::ReadOnly | QIODevice::Text)) {
        QTextStream stream(&file);

        /*std::string line;
        while (getline(file, line)) {
            QString item = QString::fromStdString(line);
            ui->listWidget->addItem(item);
        }*/
        while (!stream.atEnd())
        {
            QString line = stream.readLine();
            //QString item = QString::fromStdString(line);
            //ui->listWidget->addItem(line);
            if (line.startsWith("Checked: "))
            {
                QString itemText = line.mid(QString("Checked: ").length());
                CheckableListItem* item = new CheckableListItem(itemText);
                item->setCheckState(Qt::Checked);

                ui->taskListWidget->addItem(item);
                //item->setTextColor(Qt::red);
            }
            else if (line.startsWith("Unchecked: "))
            {
                QString itemText = line.mid(QString("Unchecked: ").length());
                CheckableListItem* item = new CheckableListItem(itemText);
                item->setCheckState(Qt::Unchecked);
                ui->taskListWidget->addItem(item);
            }

        }
        //file.flush();
        file.close();
    }
}


void TaskManager::saveItemsToFile(const QString& date1 , const QString &itemToAdd)
{
    QFile file(date1 + ".txt");
    if (file.open(QIODevice::ReadWrite | QIODevice::Text))
    {
        QTextStream stream(&file);

        QList<QString> items; // to store existing items

        // Read existing items from the file
        while (!stream.atEnd())
        {
            QString line = stream.readLine();
            items.append(line);
        }

        // Append the new items

        items.append("Unchecked: " + ui->timeSelect->time().toString()+" "+ itemToAdd);


        // Sort the items
        std::sort(items.begin(), items.end());

        // Clear the file content
        file.resize(0);

        // Write the sorted items back to the file
        for (const QString& item : items)
        {
            stream << item << "\n";
        }

        file.close();
    }
}





void TaskManager::on_pushSaveAsRoutineButton_clicked()
{
    QDate startDate = ui->calendarWidget->selectedDate();
    QDate endDate = ui->endDateSelect->date();
    int interval = ui->intervalSpinBox->value();

    if (endDate < startDate) endDate = startDate;

    QString itemToAdd = ui->lineEdit->text();

    for (int i = 0; i <= startDate.daysTo(endDate) && interval!=0; i += interval)
    {
        QString currentDate = startDate.addDays(i).toString();
        saveItemsToFile(currentDate, itemToAdd);
    }

    // Clear the line edit after the loop
    ui->lineEdit->clear();
    ui->taskListWidget->clear();
    loadItemsFromFile(startDate.toString());
}


