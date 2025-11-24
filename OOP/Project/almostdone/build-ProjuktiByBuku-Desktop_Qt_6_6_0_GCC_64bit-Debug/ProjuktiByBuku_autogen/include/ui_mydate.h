/********************************************************************************
** Form generated from reading UI file 'mydate.ui'
**
** Created by: Qt User Interface Compiler version 6.6.0
**
** WARNING! All changes made in this file will be lost when recompiling UI file!
********************************************************************************/

#ifndef UI_MYDATE_H
#define UI_MYDATE_H

#include <QtCore/QVariant>
#include <QtWidgets/QApplication>
#include <QtWidgets/QDialog>
#include <QtWidgets/QLineEdit>
#include <QtWidgets/QListWidget>
#include <QtWidgets/QPushButton>

QT_BEGIN_NAMESPACE

class Ui_mydate
{
public:
    QListWidget *listWidget;
    QLineEdit *lineEdit;
    QPushButton *add_button;
    QPushButton *enter_button;
    QPushButton *remove_button;

    void setupUi(QDialog *mydate)
    {
        if (mydate->objectName().isEmpty())
            mydate->setObjectName("mydate");
        mydate->resize(241, 326);
        mydate->setStyleSheet(QString::fromUtf8("QDialog {\n"
"\n"
" background: rgb(16, 16, 16); \n"
"}\n"
""));
        listWidget = new QListWidget(mydate);
        listWidget->setObjectName("listWidget");
        listWidget->setGeometry(QRect(0, 20, 241, 281));
        QFont font;
        font.setBold(false);
        listWidget->setFont(font);
        listWidget->setStyleSheet(QString::fromUtf8("QListWidget {color:white;    \n"
" \n"
"    background: rgb(16, 16, 16);\n"
"}"));
        lineEdit = new QLineEdit(mydate);
        lineEdit->setObjectName("lineEdit");
        lineEdit->setGeometry(QRect(0, 0, 151, 25));
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
        add_button = new QPushButton(mydate);
        add_button->setObjectName("add_button");
        add_button->setGeometry(QRect(150, 0, 89, 25));
        QFont font1;
        font1.setBold(true);
        add_button->setFont(font1);
        add_button->setStyleSheet(QString::fromUtf8("QPushButton {\n"
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
        enter_button = new QPushButton(mydate);
        enter_button->setObjectName("enter_button");
        enter_button->setGeometry(QRect(0, 300, 131, 25));
        enter_button->setFont(font1);
        enter_button->setStyleSheet(QString::fromUtf8("QPushButton {\n"
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
        remove_button = new QPushButton(mydate);
        remove_button->setObjectName("remove_button");
        remove_button->setGeometry(QRect(128, 300, 111, 25));
        remove_button->setFont(font1);
        remove_button->setStyleSheet(QString::fromUtf8("QPushButton {\n"
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

        retranslateUi(mydate);

        QMetaObject::connectSlotsByName(mydate);
    } // setupUi

    void retranslateUi(QDialog *mydate)
    {
        mydate->setWindowTitle(QCoreApplication::translate("mydate", "Notes", nullptr));
        add_button->setText(QCoreApplication::translate("mydate", "Add", nullptr));
        enter_button->setText(QCoreApplication::translate("mydate", "Enter", nullptr));
        remove_button->setText(QCoreApplication::translate("mydate", "Remove", nullptr));
    } // retranslateUi

};

namespace Ui {
    class mydate: public Ui_mydate {};
} // namespace Ui

QT_END_NAMESPACE

#endif // UI_MYDATE_H
