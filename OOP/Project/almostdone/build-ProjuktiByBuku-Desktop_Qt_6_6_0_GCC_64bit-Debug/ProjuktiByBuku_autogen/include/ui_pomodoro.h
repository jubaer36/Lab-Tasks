/********************************************************************************
** Form generated from reading UI file 'pomodoro.ui'
**
** Created by: Qt User Interface Compiler version 6.6.0
**
** WARNING! All changes made in this file will be lost when recompiling UI file!
********************************************************************************/

#ifndef UI_POMODORO_H
#define UI_POMODORO_H

#include <QtCore/QVariant>
#include <QtWidgets/QApplication>
#include <QtWidgets/QDialog>
#include <QtWidgets/QLCDNumber>
#include <QtWidgets/QLabel>
#include <QtWidgets/QPushButton>

QT_BEGIN_NAMESPACE

class Ui_pomodoro
{
public:
    QLCDNumber *lcdNumber;
    QPushButton *start_stop_button;
    QPushButton *customize_button;
    QPushButton *skip_button;
    QLabel *session_no;
    QPushButton *lofi_button;

    void setupUi(QDialog *pomodoro)
    {
        if (pomodoro->objectName().isEmpty())
            pomodoro->setObjectName("pomodoro");
        pomodoro->resize(451, 337);
        pomodoro->setStyleSheet(QString::fromUtf8("QDialog {\n"
"\n"
" background: rgb(16, 16, 16); \n"
"}\n"
""));
        lcdNumber = new QLCDNumber(pomodoro);
        lcdNumber->setObjectName("lcdNumber");
        lcdNumber->setGeometry(QRect(90, 100, 261, 111));
        QFont font;
        font.setFamilies({QString::fromUtf8("Arial")});
        font.setPointSize(10);
        font.setBold(false);
        font.setItalic(false);
        lcdNumber->setFont(font);
        lcdNumber->setStyleSheet(QString::fromUtf8("QLCDNumber{\n"
"	color:white;\n"
"	border: 1px solid black;\n"
"	font: 10pt \"Arial\";;\n"
"	\n"
"}"));
        start_stop_button = new QPushButton(pomodoro);
        start_stop_button->setObjectName("start_stop_button");
        start_stop_button->setGeometry(QRect(160, 240, 121, 51));
        QFont font1;
        font1.setPointSize(9);
        font1.setBold(true);
        start_stop_button->setFont(font1);
        start_stop_button->setStyleSheet(QString::fromUtf8("QPushButton {\n"
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
        customize_button = new QPushButton(pomodoro);
        customize_button->setObjectName("customize_button");
        customize_button->setGeometry(QRect(340, 0, 111, 31));
        QFont font2;
        font2.setBold(true);
        customize_button->setFont(font2);
        customize_button->setStyleSheet(QString::fromUtf8("QPushButton {\n"
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
        skip_button = new QPushButton(pomodoro);
        skip_button->setObjectName("skip_button");
        skip_button->setGeometry(QRect(340, 30, 111, 31));
        skip_button->setFont(font2);
        skip_button->setStyleSheet(QString::fromUtf8("QPushButton {\n"
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
        session_no = new QLabel(pomodoro);
        session_no->setObjectName("session_no");
        session_no->setGeometry(QRect(210, 60, 31, 31));
        session_no->setStyleSheet(QString::fromUtf8("QLabel {\n"
" color:white;\n"
" \n"
"background: rgb(16, 16, 16) ; \n"
"\n"
"}\n"
"\n"
"\n"
"\n"
""));
        lofi_button = new QPushButton(pomodoro);
        lofi_button->setObjectName("lofi_button");
        lofi_button->setGeometry(QRect(10, 10, 111, 31));
        lofi_button->setFont(font2);
        lofi_button->setStyleSheet(QString::fromUtf8("QPushButton {\n"
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

        retranslateUi(pomodoro);

        QMetaObject::connectSlotsByName(pomodoro);
    } // setupUi

    void retranslateUi(QDialog *pomodoro)
    {
        pomodoro->setWindowTitle(QCoreApplication::translate("pomodoro", "Dialog", nullptr));
        start_stop_button->setText(QCoreApplication::translate("pomodoro", "START", nullptr));
        customize_button->setText(QCoreApplication::translate("pomodoro", "CUSTOMIZE", nullptr));
        skip_button->setText(QCoreApplication::translate("pomodoro", "SKIP", nullptr));
        session_no->setText(QCoreApplication::translate("pomodoro", "#1", nullptr));
        lofi_button->setText(QCoreApplication::translate("pomodoro", "lofi ON", nullptr));
    } // retranslateUi

};

namespace Ui {
    class pomodoro: public Ui_pomodoro {};
} // namespace Ui

QT_END_NAMESPACE

#endif // UI_POMODORO_H
