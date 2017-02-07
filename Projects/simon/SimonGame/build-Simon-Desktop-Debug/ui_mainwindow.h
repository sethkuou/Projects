/********************************************************************************
** Form generated from reading UI file 'mainwindow.ui'
**
** Created by: Qt User Interface Compiler version 4.8.5
**
** WARNING! All changes made in this file will be lost when recompiling UI file!
********************************************************************************/

#ifndef UI_MAINWINDOW_H
#define UI_MAINWINDOW_H

#include <QtCore/QVariant>
#include <QtGui/QAction>
#include <QtGui/QApplication>
#include <QtGui/QButtonGroup>
#include <QtGui/QHeaderView>
#include <QtGui/QLabel>
#include <QtGui/QMainWindow>
#include <QtGui/QMenu>
#include <QtGui/QMenuBar>
#include <QtGui/QProgressBar>
#include <QtGui/QPushButton>
#include <QtGui/QStatusBar>
#include <QtGui/QToolBar>
#include <QtGui/QWidget>

QT_BEGIN_NAMESPACE

class Ui_MainWindow
{
public:
    QWidget *centralWidget;
    QPushButton *startButton;
    QPushButton *redButton;
    QPushButton *blueButton;
    QProgressBar *progressBar;
    QLabel *levelLabel;
    QLabel *message;
    QMenuBar *menuBar;
    QMenu *menuSimon_Game;
    QToolBar *mainToolBar;
    QStatusBar *statusBar;

    void setupUi(QMainWindow *MainWindow)
    {
        if (MainWindow->objectName().isEmpty())
            MainWindow->setObjectName(QString::fromUtf8("MainWindow"));
        MainWindow->resize(388, 295);
        centralWidget = new QWidget(MainWindow);
        centralWidget->setObjectName(QString::fromUtf8("centralWidget"));
        startButton = new QPushButton(centralWidget);
        startButton->setObjectName(QString::fromUtf8("startButton"));
        startButton->setGeometry(QRect(140, 180, 111, 41));
        redButton = new QPushButton(centralWidget);
        redButton->setObjectName(QString::fromUtf8("redButton"));
        redButton->setGeometry(QRect(60, 90, 131, 71));
        blueButton = new QPushButton(centralWidget);
        blueButton->setObjectName(QString::fromUtf8("blueButton"));
        blueButton->setGeometry(QRect(200, 90, 131, 71));
        progressBar = new QProgressBar(centralWidget);
        progressBar->setObjectName(QString::fromUtf8("progressBar"));
        progressBar->setGeometry(QRect(130, 10, 131, 21));
        progressBar->setValue(0);
        levelLabel = new QLabel(centralWidget);
        levelLabel->setObjectName(QString::fromUtf8("levelLabel"));
        levelLabel->setGeometry(QRect(120, 40, 71, 21));
        QFont font;
        font.setPointSize(15);
        font.setBold(true);
        font.setWeight(75);
        levelLabel->setFont(font);
        levelLabel->setLayoutDirection(Qt::RightToLeft);
        levelLabel->setAlignment(Qt::AlignRight|Qt::AlignTrailing|Qt::AlignVCenter);
        message = new QLabel(centralWidget);
        message->setObjectName(QString::fromUtf8("message"));
        message->setGeometry(QRect(50, 70, 291, 20));
        message->setLayoutDirection(Qt::RightToLeft);
        message->setAlignment(Qt::AlignCenter);
        MainWindow->setCentralWidget(centralWidget);
        menuBar = new QMenuBar(MainWindow);
        menuBar->setObjectName(QString::fromUtf8("menuBar"));
        menuBar->setGeometry(QRect(0, 0, 388, 27));
        menuSimon_Game = new QMenu(menuBar);
        menuSimon_Game->setObjectName(QString::fromUtf8("menuSimon_Game"));
        MainWindow->setMenuBar(menuBar);
        mainToolBar = new QToolBar(MainWindow);
        mainToolBar->setObjectName(QString::fromUtf8("mainToolBar"));
        MainWindow->addToolBar(Qt::TopToolBarArea, mainToolBar);
        statusBar = new QStatusBar(MainWindow);
        statusBar->setObjectName(QString::fromUtf8("statusBar"));
        MainWindow->setStatusBar(statusBar);

        menuBar->addAction(menuSimon_Game->menuAction());

        retranslateUi(MainWindow);

        QMetaObject::connectSlotsByName(MainWindow);
    } // setupUi

    void retranslateUi(QMainWindow *MainWindow)
    {
        MainWindow->setWindowTitle(QApplication::translate("MainWindow", "MainWindow", 0, QApplication::UnicodeUTF8));
        startButton->setText(QApplication::translate("MainWindow", "Start", 0, QApplication::UnicodeUTF8));
        redButton->setText(QApplication::translate("MainWindow", "Red", 0, QApplication::UnicodeUTF8));
        blueButton->setText(QApplication::translate("MainWindow", "Blue", 0, QApplication::UnicodeUTF8));
        levelLabel->setText(QApplication::translate("MainWindow", "Level: 0", 0, QApplication::UnicodeUTF8));
        message->setText(QApplication::translate("MainWindow", "Press Start to Begin!", 0, QApplication::UnicodeUTF8));
        menuSimon_Game->setTitle(QApplication::translate("MainWindow", "Simon Game", 0, QApplication::UnicodeUTF8));
    } // retranslateUi

};

namespace Ui {
    class MainWindow: public Ui_MainWindow {};
} // namespace Ui

QT_END_NAMESPACE

#endif // UI_MAINWINDOW_H
