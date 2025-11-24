/********************************************************************************
** Form generated from reading UI file 'mynotebook.ui'
**
** Created by: Qt User Interface Compiler version 6.6.0
**
** WARNING! All changes made in this file will be lost when recompiling UI file!
********************************************************************************/

#ifndef UI_MYNOTEBOOK_H
#define UI_MYNOTEBOOK_H

#include <QtCore/QVariant>
#include <QtWidgets/QApplication>
#include <QtWidgets/QDialog>
#include <QtWidgets/QPushButton>
#include <QtWidgets/QTextEdit>

QT_BEGIN_NAMESPACE

class Ui_mynotebook
{
public:
    QTextEdit *textEdit;
    QPushButton *pushButton;

    void setupUi(QDialog *mynotebook)
    {
        if (mynotebook->objectName().isEmpty())
            mynotebook->setObjectName("mynotebook");
        mynotebook->resize(271, 328);
        textEdit = new QTextEdit(mynotebook);
        textEdit->setObjectName("textEdit");
        textEdit->setGeometry(QRect(0, 0, 271, 301));
        textEdit->setStyleSheet(QString::fromUtf8("QTextEdit {color:white;    \n"
" \n"
"    background: rgb(16, 16, 16);\n"
"}"));
        pushButton = new QPushButton(mynotebook);
        pushButton->setObjectName("pushButton");
        pushButton->setGeometry(QRect(0, 300, 271, 31));
        QFont font;
        font.setBold(true);
        pushButton->setFont(font);
        pushButton->setStyleSheet(QString::fromUtf8("QPushButton {\n"
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

        retranslateUi(mynotebook);

        QMetaObject::connectSlotsByName(mynotebook);
    } // setupUi

    void retranslateUi(QDialog *mynotebook)
    {
        mynotebook->setWindowTitle(QCoreApplication::translate("mynotebook", "Dialog", nullptr));
        pushButton->setText(QCoreApplication::translate("mynotebook", "SAVE", nullptr));
    } // retranslateUi

};

namespace Ui {
    class mynotebook: public Ui_mynotebook {};
} // namespace Ui

QT_END_NAMESPACE

#endif // UI_MYNOTEBOOK_H
