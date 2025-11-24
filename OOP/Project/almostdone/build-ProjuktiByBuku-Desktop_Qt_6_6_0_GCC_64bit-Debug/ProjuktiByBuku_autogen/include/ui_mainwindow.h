/********************************************************************************
** Form generated from reading UI file 'mainwindow.ui'
**
** Created by: Qt User Interface Compiler version 6.6.0
**
** WARNING! All changes made in this file will be lost when recompiling UI file!
********************************************************************************/

#ifndef UI_MAINWINDOW_H
#define UI_MAINWINDOW_H

#include <QtCore/QVariant>
#include <QtWidgets/QApplication>
#include <QtWidgets/QLCDNumber>
#include <QtWidgets/QLabel>
#include <QtWidgets/QMainWindow>
#include <QtWidgets/QMenuBar>
#include <QtWidgets/QPushButton>
#include <QtWidgets/QStatusBar>
#include <QtWidgets/QToolBar>
#include <QtWidgets/QWidget>

QT_BEGIN_NAMESPACE

class Ui_MainWindow
{
public:
    QWidget *centralwidget;
    QPushButton *pomodoroPushButton;
    QPushButton *notebook_button;
    QPushButton *taskManagerPushButton;
    QPushButton *progressBarPushButton;
    QLabel *label_2;
    QLabel *label_4;
    QLabel *label;
    QLabel *label_3;
    QLCDNumber *lcdNumber;
    QLabel *labelCalendar;
    QMenuBar *menubar;
    QStatusBar *statusbar;
    QToolBar *toolBar;

    void setupUi(QMainWindow *MainWindow)
    {
        if (MainWindow->objectName().isEmpty())
            MainWindow->setObjectName("MainWindow");
        MainWindow->resize(450, 453);
        MainWindow->setStyleSheet(QString::fromUtf8("QMainWindow {\n"
"\n"
" background: rgb(16, 16, 16); \n"
"}\n"
""));
        centralwidget = new QWidget(MainWindow);
        centralwidget->setObjectName("centralwidget");
        pomodoroPushButton = new QPushButton(centralwidget);
        pomodoroPushButton->setObjectName("pomodoroPushButton");
        pomodoroPushButton->setGeometry(QRect(170, 290, 131, 31));
        QFont font;
        font.setBold(true);
        pomodoroPushButton->setFont(font);
        pomodoroPushButton->setStyleSheet(QString::fromUtf8("QPushButton {\n"
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
"\n"
""));
        notebook_button = new QPushButton(centralwidget);
        notebook_button->setObjectName("notebook_button");
        notebook_button->setGeometry(QRect(310, 140, 121, 31));
        notebook_button->setFont(font);
        notebook_button->setStyleSheet(QString::fromUtf8("QPushButton {\n"
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
"\n"
""));
        taskManagerPushButton = new QPushButton(centralwidget);
        taskManagerPushButton->setObjectName("taskManagerPushButton");
        taskManagerPushButton->setGeometry(QRect(30, 290, 121, 31));
        taskManagerPushButton->setFont(font);
        taskManagerPushButton->setStyleSheet(QString::fromUtf8("QPushButton {\n"
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
"\n"
""));
        progressBarPushButton = new QPushButton(centralwidget);
        progressBarPushButton->setObjectName("progressBarPushButton");
        progressBarPushButton->setGeometry(QRect(310, 290, 121, 31));
        progressBarPushButton->setFont(font);
        progressBarPushButton->setStyleSheet(QString::fromUtf8("QPushButton {\n"
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
"\n"
""));
        label_2 = new QLabel(centralwidget);
        label_2->setObjectName("label_2");
        label_2->setGeometry(QRect(310, 20, 121, 121));
        label_2->setStyleSheet(QString::fromUtf8("border: 1px solid green;"));
        label_2->setPixmap(QPixmap(QString::fromUtf8("../build-ProjuktiByBuku-Desktop_Qt_6_6_0_GCC_64bit-Debug/resized3.jpg")));
        label_2->setScaledContents(true);
        label_4 = new QLabel(centralwidget);
        label_4->setObjectName("label_4");
        label_4->setGeometry(QRect(310, 180, 121, 111));
        label_4->setStyleSheet(QString::fromUtf8("border: 1px solid green;"));
        label_4->setPixmap(QPixmap(QString::fromUtf8("../build-ProjuktiByBuku-Desktop_Qt_6_6_0_GCC_64bit-Debug/resized1.jpg")));
        label_4->setScaledContents(true);
        label = new QLabel(centralwidget);
        label->setObjectName("label");
        label->setGeometry(QRect(170, 180, 131, 111));
        label->setStyleSheet(QString::fromUtf8("border: 1px solid green;"));
        label->setPixmap(QPixmap(QString::fromUtf8("../build-ProjuktiByBuku-Desktop_Qt_6_6_0_GCC_64bit-Debug/resized4.jpg")));
        label->setScaledContents(true);
        label_3 = new QLabel(centralwidget);
        label_3->setObjectName("label_3");
        label_3->setGeometry(QRect(30, 180, 121, 111));
        label_3->setStyleSheet(QString::fromUtf8("border: 1px solid green;"));
        label_3->setPixmap(QPixmap(QString::fromUtf8("../build-ProjuktiByBuku-Desktop_Qt_6_6_0_GCC_64bit-Debug/resized2.jpg")));
        label_3->setScaledContents(true);
        lcdNumber = new QLCDNumber(centralwidget);
        lcdNumber->setObjectName("lcdNumber");
        lcdNumber->setGeometry(QRect(30, 50, 271, 121));
        lcdNumber->setStyleSheet(QString::fromUtf8("border: 1px solid green;"));
        labelCalendar = new QLabel(centralwidget);
        labelCalendar->setObjectName("labelCalendar");
        labelCalendar->setGeometry(QRect(120, 20, 91, 21));
        labelCalendar->setFont(font);
        labelCalendar->setStyleSheet(QString::fromUtf8("QLabel {\n"
" color:white;\n"
" \n"
"background: rgb(16, 16, 16) ; \n"
"\n"
"border: 1px solid green;\n"
"}"));
        MainWindow->setCentralWidget(centralwidget);
        menubar = new QMenuBar(MainWindow);
        menubar->setObjectName("menubar");
        menubar->setGeometry(QRect(0, 0, 450, 22));
        MainWindow->setMenuBar(menubar);
        statusbar = new QStatusBar(MainWindow);
        statusbar->setObjectName("statusbar");
        MainWindow->setStatusBar(statusbar);
        toolBar = new QToolBar(MainWindow);
        toolBar->setObjectName("toolBar");
        MainWindow->addToolBar(Qt::TopToolBarArea, toolBar);

        retranslateUi(MainWindow);

        QMetaObject::connectSlotsByName(MainWindow);
    } // setupUi

    void retranslateUi(QMainWindow *MainWindow)
    {
        MainWindow->setWindowTitle(QCoreApplication::translate("MainWindow", "Projukti", nullptr));
        pomodoroPushButton->setText(QCoreApplication::translate("MainWindow", "Pomodoro", nullptr));
        notebook_button->setText(QCoreApplication::translate("MainWindow", "NoteBook", nullptr));
        taskManagerPushButton->setText(QCoreApplication::translate("MainWindow", "Task Manager", nullptr));
        progressBarPushButton->setText(QCoreApplication::translate("MainWindow", "ProgressBar", nullptr));
        label_2->setText(QString());
        label_4->setText(QString());
        label->setText(QString());
        label_3->setText(QString());
        labelCalendar->setText(QCoreApplication::translate("MainWindow", "Calendar", nullptr));
        toolBar->setWindowTitle(QCoreApplication::translate("MainWindow", "toolBar", nullptr));
    } // retranslateUi

};

namespace Ui {
    class MainWindow: public Ui_MainWindow {};
} // namespace Ui

QT_END_NAMESPACE

#endif // UI_MAINWINDOW_H
