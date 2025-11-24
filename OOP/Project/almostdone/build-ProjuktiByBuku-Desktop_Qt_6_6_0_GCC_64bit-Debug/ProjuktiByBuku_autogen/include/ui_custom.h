/********************************************************************************
** Form generated from reading UI file 'custom.ui'
**
** Created by: Qt User Interface Compiler version 6.6.0
**
** WARNING! All changes made in this file will be lost when recompiling UI file!
********************************************************************************/

#ifndef UI_CUSTOM_H
#define UI_CUSTOM_H

#include <QtCore/QVariant>
#include <QtWidgets/QApplication>
#include <QtWidgets/QComboBox>
#include <QtWidgets/QDialog>
#include <QtWidgets/QLabel>
#include <QtWidgets/QPushButton>
#include <QtWidgets/QSpinBox>

QT_BEGIN_NAMESPACE

class Ui_custom
{
public:
    QSpinBox *pomodoro_spinBox;
    QSpinBox *short_break_spinBox;
    QLabel *label;
    QLabel *label_2;
    QPushButton *save_button;
    QSpinBox *lbreak_spinBox;
    QLabel *label_3;
    QPushButton *alarm_button;
    QComboBox *comboBox;

    void setupUi(QDialog *custom)
    {
        if (custom->objectName().isEmpty())
            custom->setObjectName("custom");
        custom->resize(400, 300);
        custom->setStyleSheet(QString::fromUtf8("QDialog {\n"
"\n"
" background: rgb(16, 16, 16); \n"
"}\n"
""));
        pomodoro_spinBox = new QSpinBox(custom);
        pomodoro_spinBox->setObjectName("pomodoro_spinBox");
        pomodoro_spinBox->setGeometry(QRect(160, 50, 71, 41));
        pomodoro_spinBox->setStyleSheet(QString::fromUtf8("QSpinBox {\n"
" color:white;\n"
" \n"
"background: rgb(16, 16, 16) ; \n"
"\n"
"border: 1px solid green;\n"
"}"));
        short_break_spinBox = new QSpinBox(custom);
        short_break_spinBox->setObjectName("short_break_spinBox");
        short_break_spinBox->setGeometry(QRect(160, 90, 71, 41));
        short_break_spinBox->setStyleSheet(QString::fromUtf8("QSpinBox {\n"
" color:white;\n"
" \n"
"background: rgb(16, 16, 16) ; \n"
"\n"
"border: 1px solid green;\n"
"}"));
        label = new QLabel(custom);
        label->setObjectName("label");
        label->setGeometry(QRect(40, 60, 91, 31));
        QFont font;
        font.setBold(true);
        label->setFont(font);
        label->setStyleSheet(QString::fromUtf8("QLabel {\n"
"\n"
"	color:white;    \n"
" \n"
"    background: rgb(16, 16, 16);\n"
"\n"
"	border: 1px solid green;\n"
"   \n"
"}\n"
""));
        label_2 = new QLabel(custom);
        label_2->setObjectName("label_2");
        label_2->setGeometry(QRect(40, 100, 91, 31));
        label_2->setFont(font);
        label_2->setStyleSheet(QString::fromUtf8("QLabel {\n"
"\n"
"	color:white;    \n"
" \n"
"    background: rgb(16, 16, 16);\n"
"\n"
"	border: 1px solid green;\n"
"   \n"
"}\n"
""));
        save_button = new QPushButton(custom);
        save_button->setObjectName("save_button");
        save_button->setGeometry(QRect(280, 220, 89, 31));
        save_button->setFont(font);
        save_button->setStyleSheet(QString::fromUtf8("QPushButton {\n"
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
        lbreak_spinBox = new QSpinBox(custom);
        lbreak_spinBox->setObjectName("lbreak_spinBox");
        lbreak_spinBox->setGeometry(QRect(160, 130, 71, 41));
        lbreak_spinBox->setStyleSheet(QString::fromUtf8("QSpinBox {\n"
" color:white;\n"
" \n"
"background: rgb(16, 16, 16) ; \n"
"\n"
"border: 1px solid green;\n"
"}"));
        label_3 = new QLabel(custom);
        label_3->setObjectName("label_3");
        label_3->setGeometry(QRect(40, 140, 91, 31));
        label_3->setFont(font);
        label_3->setStyleSheet(QString::fromUtf8("QLabel {\n"
"\n"
"	color:white;    \n"
" \n"
"    background: rgb(16, 16, 16);\n"
"\n"
"	border: 1px solid green;\n"
"   \n"
"}\n"
""));
        alarm_button = new QPushButton(custom);
        alarm_button->setObjectName("alarm_button");
        alarm_button->setGeometry(QRect(30, 220, 111, 31));
        alarm_button->setFont(font);
        alarm_button->setStyleSheet(QString::fromUtf8("QPushButton {\n"
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
        comboBox = new QComboBox(custom);
        comboBox->setObjectName("comboBox");
        comboBox->setGeometry(QRect(290, 60, 86, 25));
        comboBox->setStyleSheet(QString::fromUtf8("\n"
"QComboBox {\n"
"\n"
"	color:white;    \n"
" \n"
"    background: rgb(16, 16, 16);\n"
"\n"
"	border: 1px solid green;\n"
"   \n"
"}\n"
"\n"
"\n"
"\n"
"\n"
"\n"
"QComboBox QAbstractItemView {\n"
"    background-color: black;\n"
"    color: white;\n"
"}\n"
"\n"
""));

        retranslateUi(custom);

        QMetaObject::connectSlotsByName(custom);
    } // setupUi

    void retranslateUi(QDialog *custom)
    {
        custom->setWindowTitle(QCoreApplication::translate("custom", "Dialog", nullptr));
        label->setText(QCoreApplication::translate("custom", "Pomodoro", nullptr));
        label_2->setText(QCoreApplication::translate("custom", "Short Break", nullptr));
        save_button->setText(QCoreApplication::translate("custom", "Save", nullptr));
        label_3->setText(QCoreApplication::translate("custom", "Long Break", nullptr));
        alarm_button->setText(QCoreApplication::translate("custom", "Alarm Sound", nullptr));
    } // retranslateUi

};

namespace Ui {
    class custom: public Ui_custom {};
} // namespace Ui

QT_END_NAMESPACE

#endif // UI_CUSTOM_H
