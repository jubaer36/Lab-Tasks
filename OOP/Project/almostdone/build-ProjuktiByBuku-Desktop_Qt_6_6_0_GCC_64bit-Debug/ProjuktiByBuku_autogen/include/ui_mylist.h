/********************************************************************************
** Form generated from reading UI file 'mylist.ui'
**
** Created by: Qt User Interface Compiler version 6.6.0
**
** WARNING! All changes made in this file will be lost when recompiling UI file!
********************************************************************************/

#ifndef UI_MYLIST_H
#define UI_MYLIST_H

#include <QtCore/QVariant>
#include <QtWidgets/QApplication>
#include <QtWidgets/QDialog>

QT_BEGIN_NAMESPACE

class Ui_mylist
{
public:

    void setupUi(QDialog *mylist)
    {
        if (mylist->objectName().isEmpty())
            mylist->setObjectName("mylist");
        mylist->resize(400, 300);

        retranslateUi(mylist);

        QMetaObject::connectSlotsByName(mylist);
    } // setupUi

    void retranslateUi(QDialog *mylist)
    {
        mylist->setWindowTitle(QCoreApplication::translate("mylist", "Dialog", nullptr));
    } // retranslateUi

};

namespace Ui {
    class mylist: public Ui_mylist {};
} // namespace Ui

QT_END_NAMESPACE

#endif // UI_MYLIST_H
