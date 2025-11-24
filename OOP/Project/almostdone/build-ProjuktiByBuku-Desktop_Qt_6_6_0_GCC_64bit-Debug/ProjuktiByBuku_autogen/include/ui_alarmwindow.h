/********************************************************************************
** Form generated from reading UI file 'alarmwindow.ui'
**
** Created by: Qt User Interface Compiler version 6.6.0
**
** WARNING! All changes made in this file will be lost when recompiling UI file!
********************************************************************************/

#ifndef UI_ALARMWINDOW_H
#define UI_ALARMWINDOW_H

#include <QtCore/QVariant>
#include <QtWidgets/QApplication>
#include <QtWidgets/QDialog>
#include <QtWidgets/QPushButton>

QT_BEGIN_NAMESPACE

class Ui_alarmwindow
{
public:
    QPushButton *bell_button;
    QPushButton *bird_button;
    QPushButton *kitchen_button;
    QPushButton *digital_button;
    QPushButton *rooster_button;

    void setupUi(QDialog *alarmwindow)
    {
        if (alarmwindow->objectName().isEmpty())
            alarmwindow->setObjectName("alarmwindow");
        alarmwindow->resize(400, 300);
        bell_button = new QPushButton(alarmwindow);
        bell_button->setObjectName("bell_button");
        bell_button->setGeometry(QRect(130, 50, 81, 41));
        bird_button = new QPushButton(alarmwindow);
        bird_button->setObjectName("bird_button");
        bird_button->setGeometry(QRect(130, 90, 81, 41));
        kitchen_button = new QPushButton(alarmwindow);
        kitchen_button->setObjectName("kitchen_button");
        kitchen_button->setGeometry(QRect(130, 130, 81, 41));
        digital_button = new QPushButton(alarmwindow);
        digital_button->setObjectName("digital_button");
        digital_button->setGeometry(QRect(130, 170, 81, 41));
        rooster_button = new QPushButton(alarmwindow);
        rooster_button->setObjectName("rooster_button");
        rooster_button->setGeometry(QRect(130, 210, 81, 41));

        retranslateUi(alarmwindow);

        QMetaObject::connectSlotsByName(alarmwindow);
    } // setupUi

    void retranslateUi(QDialog *alarmwindow)
    {
        alarmwindow->setWindowTitle(QCoreApplication::translate("alarmwindow", "Dialog", nullptr));
        bell_button->setText(QCoreApplication::translate("alarmwindow", "Bell", nullptr));
        bird_button->setText(QCoreApplication::translate("alarmwindow", "Bird", nullptr));
        kitchen_button->setText(QCoreApplication::translate("alarmwindow", "Kitchen", nullptr));
        digital_button->setText(QCoreApplication::translate("alarmwindow", "Digital", nullptr));
        rooster_button->setText(QCoreApplication::translate("alarmwindow", "Rooster", nullptr));
    } // retranslateUi

};

namespace Ui {
    class alarmwindow: public Ui_alarmwindow {};
} // namespace Ui

QT_END_NAMESPACE

#endif // UI_ALARMWINDOW_H
