#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include "model.h"
#include <QMainWindow>
#include <vector>
#include <QTimer>

namespace Ui {
class MainWindow;
}

class MainWindow : public QMainWindow
{
    Q_OBJECT

public:
    explicit MainWindow(QWidget *parent = 0);
    ~MainWindow();
    int level;
    QVector<int> sequence;
    QVector<int>::iterator it;

    void playComputerSeq(QVector<int>);
    void gameOver();
    void nextLevel(int);
    void beginGame(int);


public slots:

    void highlightButtons();
    void on_startButton_clicked();
    void displayButton();
    void clearButton();
    void updateProgress(int, int);

    void highlightRed();
    void highlightBlue();
    void clearRed();
    void clearBlue();

private slots:
    void on_redButton_clicked();

    void on_blueButton_clicked();

signals:
    void gameStarted();
    void redButtonClick();
    void blueButtonClick();

private:
    Ui::MainWindow *ui;
    Model *model;
};

#endif // MAINWINDOW_H
