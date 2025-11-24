/********************************************************************************
** Form generated from reading UI file 'progressbar.ui'
**
** Created by: Qt User Interface Compiler version 6.6.0
**
** WARNING! All changes made in this file will be lost when recompiling UI file!
********************************************************************************/

#ifndef UI_PROGRESSBAR_H
#define UI_PROGRESSBAR_H

#include <QtCore/QVariant>
#include <QtWidgets/QApplication>
#include <QtWidgets/QDialog>
#include <QtWidgets/QHBoxLayout>
#include <QtWidgets/QWidget>

QT_BEGIN_NAMESPACE

class Ui_ProgressBar
{
public:
    QWidget *horizontalLayoutWidget;
    QHBoxLayout *horizontalFrame;

    void setupUi(QDialog *ProgressBar)
    {
        if (ProgressBar->objectName().isEmpty())
            ProgressBar->setObjectName("ProgressBar");
        ProgressBar->resize(1031, 533);
        ProgressBar->setStyleSheet(QString::fromUtf8("QDialof { \n"
"  background: rgb(16, 16, 16);\n"
"}"));
        horizontalLayoutWidget = new QWidget(ProgressBar);
        horizontalLayoutWidget->setObjectName("horizontalLayoutWidget");
        horizontalLayoutWidget->setGeometry(QRect(0, 0, 1031, 531));
        horizontalFrame = new QHBoxLayout(horizontalLayoutWidget);
        horizontalFrame->setObjectName("horizontalFrame");
        horizontalFrame->setContentsMargins(0, 0, 0, 0);

        retranslateUi(ProgressBar);

        QMetaObject::connectSlotsByName(ProgressBar);
    } // setupUi

    void retranslateUi(QDialog *ProgressBar)
    {
        ProgressBar->setWindowTitle(QCoreApplication::translate("ProgressBar", "Dialog", nullptr));
    } // retranslateUi

};

namespace Ui {
    class ProgressBar: public Ui_ProgressBar {};
} // namespace Ui

QT_END_NAMESPACE

#endif // UI_PROGRESSBAR_H
