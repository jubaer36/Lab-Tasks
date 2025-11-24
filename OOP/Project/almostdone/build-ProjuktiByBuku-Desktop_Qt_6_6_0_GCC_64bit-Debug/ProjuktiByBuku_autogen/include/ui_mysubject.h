/********************************************************************************
** Form generated from reading UI file 'mysubject.ui'
**
** Created by: Qt User Interface Compiler version 6.6.0
**
** WARNING! All changes made in this file will be lost when recompiling UI file!
********************************************************************************/

#ifndef UI_MYSUBJECT_H
#define UI_MYSUBJECT_H

#include <QtCore/QVariant>
#include <QtWidgets/QApplication>
#include <QtWidgets/QDialog>
#include <QtWidgets/QLineEdit>
#include <QtWidgets/QListWidget>
#include <QtWidgets/QPushButton>

QT_BEGIN_NAMESPACE

class Ui_mysubject
{
public:
    QListWidget *listWidget;
    QLineEdit *lineEdit;
    QPushButton *add_button;
    QPushButton *enter_button;
    QPushButton *remove_button;

    void setupUi(QDialog *mysubject)
    {
        if (mysubject->objectName().isEmpty())
            mysubject->setObjectName("mysubject");
        mysubject->resize(251, 331);
        mysubject->setStyleSheet(QString::fromUtf8("QDialog {\n"
"\n"
" background: rgb(16, 16, 16); \n"
"}\n"
""));
        listWidget = new QListWidget(mysubject);
        listWidget->setObjectName("listWidget");
        listWidget->setGeometry(QRect(0, 30, 251, 271));
        listWidget->setStyleSheet(QString::fromUtf8("QListWidget {color:white;    \n"
" \n"
"    background: rgb(16, 16, 16);\n"
"}"));
        lineEdit = new QLineEdit(mysubject);
        lineEdit->setObjectName("lineEdit");
        lineEdit->setGeometry(QRect(0, 0, 141, 31));
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
        add_button = new QPushButton(mysubject);
        add_button->setObjectName("add_button");
        add_button->setGeometry(QRect(140, 0, 111, 31));
        QFont font;
        font.setBold(true);
        add_button->setFont(font);
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
        enter_button = new QPushButton(mysubject);
        enter_button->setObjectName("enter_button");
        enter_button->setGeometry(QRect(0, 300, 131, 31));
        enter_button->setFont(font);
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
""));
        remove_button = new QPushButton(mysubject);
        remove_button->setObjectName("remove_button");
        remove_button->setGeometry(QRect(130, 300, 121, 31));
        remove_button->setFont(font);
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
""));

        retranslateUi(mysubject);

        QMetaObject::connectSlotsByName(mysubject);
    } // setupUi

    void retranslateUi(QDialog *mysubject)
    {
        mysubject->setWindowTitle(QCoreApplication::translate("mysubject", "Subject", nullptr));
        add_button->setText(QCoreApplication::translate("mysubject", "Add", nullptr));
        enter_button->setText(QCoreApplication::translate("mysubject", "Enter", nullptr));
        remove_button->setText(QCoreApplication::translate("mysubject", "Remove", nullptr));
    } // retranslateUi

};

namespace Ui {
    class mysubject: public Ui_mysubject {};
} // namespace Ui

QT_END_NAMESPACE

#endif // UI_MYSUBJECT_H
