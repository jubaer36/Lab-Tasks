/********************************************************************************
** Form generated from reading UI file 'taskmanager.ui'
**
** Created by: Qt User Interface Compiler version 6.6.0
**
** WARNING! All changes made in this file will be lost when recompiling UI file!
********************************************************************************/

#ifndef UI_TASKMANAGER_H
#define UI_TASKMANAGER_H

#include <QtCore/QVariant>
#include <QtWidgets/QApplication>
#include <QtWidgets/QCalendarWidget>
#include <QtWidgets/QDateEdit>
#include <QtWidgets/QLabel>
#include <QtWidgets/QLineEdit>
#include <QtWidgets/QListWidget>
#include <QtWidgets/QPushButton>
#include <QtWidgets/QSpinBox>
#include <QtWidgets/QTimeEdit>
#include <QtWidgets/QWidget>

QT_BEGIN_NAMESPACE

class Ui_TaskManager
{
public:
    QCalendarWidget *calendarWidget;
    QLabel *label;
    QLabel *label_2;
    QPushButton *addPushButton;
    QListWidget *taskListWidget;
    QSpinBox *intervalSpinBox;
    QDateEdit *endDateSelect;
    QPushButton *routinePushButton;
    QLineEdit *lineEdit;
    QTimeEdit *timeSelect;
    QPushButton *removePushButton;
    QPushButton *pushSaveAsRoutineButton;

    void setupUi(QWidget *TaskManager)
    {
        if (TaskManager->objectName().isEmpty())
            TaskManager->setObjectName("TaskManager");
        TaskManager->resize(475, 638);
        TaskManager->setStyleSheet(QString::fromUtf8("QWidget { \n"
" \n"
"    background: rgb(16, 16, 16);\n"
"}"));
        calendarWidget = new QCalendarWidget(TaskManager);
        calendarWidget->setObjectName("calendarWidget");
        calendarWidget->setGeometry(QRect(10, 40, 451, 241));
        calendarWidget->setStyleSheet(QString::fromUtf8("QCalendarWidget QToolButton{\n"
"color:white;\n"
"background-color:black;\n"
"}\n"
"\n"
"QCalendarWidget QWidget{\n"
"color:white;\n"
"alternate-background-color:black;\n"
"}\n"
"\n"
" QCalendarWidget QAbstractItemView:enabled \n"
"  {\n"
"  	\n"
"  	color: rgb(180, 180, 180);  \n"
"  	background-color: black;  \n"
"  	selection-background-color: rgb(64, 64, 64); \n"
"  	selection-color: rgb(0, 255, 0); \n"
"  }"));
        label = new QLabel(TaskManager);
        label->setObjectName("label");
        label->setGeometry(QRect(350, 540, 67, 21));
        QFont font;
        font.setBold(true);
        label->setFont(font);
        label->setStyleSheet(QString::fromUtf8("QLabel { \n"
"	color : white;\n"
" \n"
"    background: rgb(16, 16, 16);\n"
"}"));
        label_2 = new QLabel(TaskManager);
        label_2->setObjectName("label_2");
        label_2->setGeometry(QRect(370, 430, 91, 21));
        label_2->setFont(font);
        label_2->setStyleSheet(QString::fromUtf8("QLabel { \n"
"	color : white;\n"
" \n"
"    background: rgb(16, 16, 16);\n"
"}"));
        addPushButton = new QPushButton(TaskManager);
        addPushButton->setObjectName("addPushButton");
        addPushButton->setGeometry(QRect(180, 590, 161, 41));
        addPushButton->setFont(font);
        addPushButton->setStyleSheet(QString::fromUtf8("QPushButton {\n"
" color:white;\n"
" \n"
"background: rgb(16, 16, 16) ; \n"
"\n"
"border: 1px solid green;\n"
"}\n"
"\n"
"QPushButton:hover {\n"
"	color:white;\n"
"     background-color: green;\n"
"    \n"
"}\n"
""));
        taskListWidget = new QListWidget(TaskManager);
        taskListWidget->setObjectName("taskListWidget");
        taskListWidget->setGeometry(QRect(0, 330, 341, 261));
        taskListWidget->setStyleSheet(QString::fromUtf8("QListWidget {color:white;    \n"
" \n"
"    background: rgb(16, 16, 16);\n"
"border: 1px solid green;\n"
"}"));
        intervalSpinBox = new QSpinBox(TaskManager);
        intervalSpinBox->setObjectName("intervalSpinBox");
        intervalSpinBox->setGeometry(QRect(420, 540, 41, 26));
        intervalSpinBox->setStyleSheet(QString::fromUtf8("QSpinBox{ \n"
"	color : white;\n"
" \n"
"    background: rgb(16, 16, 16);\n"
"border: 1px solid green;\n"
"}"));
        endDateSelect = new QDateEdit(TaskManager);
        endDateSelect->setObjectName("endDateSelect");
        endDateSelect->setGeometry(QRect(350, 470, 111, 31));
        endDateSelect->setStyleSheet(QString::fromUtf8("QDateEdit { \n"
"	color: white;\n"
" \n"
"    background: rgb(16, 16, 16);\n"
"border: 1px solid green;\n"
"}"));
        routinePushButton = new QPushButton(TaskManager);
        routinePushButton->setObjectName("routinePushButton");
        routinePushButton->setGeometry(QRect(350, 360, 111, 41));
        routinePushButton->setFont(font);
        routinePushButton->setStyleSheet(QString::fromUtf8("QPushButton {\n"
" color:white;\n"
" \n"
"background: rgb(16, 16, 16) ; \n"
"\n"
"border: 1px solid green;\n"
"}\n"
"\n"
"QPushButton:hover {\n"
"	color:white;\n"
"     background-color: green;\n"
"    \n"
"}\n"
""));
        lineEdit = new QLineEdit(TaskManager);
        lineEdit->setObjectName("lineEdit");
        lineEdit->setGeometry(QRect(0, 300, 341, 31));
        lineEdit->setStyleSheet(QString::fromUtf8("QLineEdit {\n"
"\n"
"	color:white;    \n"
" \n"
"    background: rgb(16, 16, 16);\n"
"\n"
"	border: 1px solid green;\n"
"   \n"
"}\n"
""));
        timeSelect = new QTimeEdit(TaskManager);
        timeSelect->setObjectName("timeSelect");
        timeSelect->setGeometry(QRect(350, 300, 118, 41));
        timeSelect->setStyleSheet(QString::fromUtf8("QTimeEdit{ \n"
" color:white ;\n"
" \n"
"    background: rgb(16, 16, 16);\n"
"	border: 1px solid green;\n"
"}"));
        removePushButton = new QPushButton(TaskManager);
        removePushButton->setObjectName("removePushButton");
        removePushButton->setGeometry(QRect(0, 590, 181, 41));
        removePushButton->setFont(font);
        removePushButton->setStyleSheet(QString::fromUtf8("QPushButton {\n"
" color:white;\n"
" \n"
"background: rgb(16, 16, 16) ; \n"
"\n"
"border: 1px solid green;\n"
"}\n"
"\n"
"QPushButton:hover {\n"
"	color:white;\n"
"     background-color: green;\n"
"    \n"
"}\n"
""));
        pushSaveAsRoutineButton = new QPushButton(TaskManager);
        pushSaveAsRoutineButton->setObjectName("pushSaveAsRoutineButton");
        pushSaveAsRoutineButton->setGeometry(QRect(340, 590, 131, 41));
        pushSaveAsRoutineButton->setFont(font);
        pushSaveAsRoutineButton->setStyleSheet(QString::fromUtf8("QPushButton {\n"
" color:white;\n"
" \n"
"background: rgb(16, 16, 16) ; \n"
"\n"
"border: 1px solid green;\n"
"}\n"
"\n"
"QPushButton:hover {\n"
"	color:white;\n"
"     background-color: green;\n"
"    \n"
"}\n"
""));
        QWidget::setTabOrder(calendarWidget, addPushButton);
        QWidget::setTabOrder(addPushButton, taskListWidget);
        QWidget::setTabOrder(taskListWidget, intervalSpinBox);
        QWidget::setTabOrder(intervalSpinBox, endDateSelect);
        QWidget::setTabOrder(endDateSelect, routinePushButton);
        QWidget::setTabOrder(routinePushButton, lineEdit);
        QWidget::setTabOrder(lineEdit, timeSelect);

        retranslateUi(TaskManager);

        QMetaObject::connectSlotsByName(TaskManager);
    } // setupUi

    void retranslateUi(QWidget *TaskManager)
    {
        TaskManager->setWindowTitle(QCoreApplication::translate("TaskManager", "Task Manager", nullptr));
        label->setText(QCoreApplication::translate("TaskManager", "Interval", nullptr));
        label_2->setText(QCoreApplication::translate("TaskManager", "End Date", nullptr));
        addPushButton->setText(QCoreApplication::translate("TaskManager", "Add", nullptr));
        routinePushButton->setText(QCoreApplication::translate("TaskManager", "Routine", nullptr));
        removePushButton->setText(QCoreApplication::translate("TaskManager", "Remove", nullptr));
        pushSaveAsRoutineButton->setText(QCoreApplication::translate("TaskManager", "Save As Routine", nullptr));
    } // retranslateUi

};

namespace Ui {
    class TaskManager: public Ui_TaskManager {};
} // namespace Ui

QT_END_NAMESPACE

#endif // UI_TASKMANAGER_H
