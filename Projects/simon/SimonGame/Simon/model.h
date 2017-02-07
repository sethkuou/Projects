#ifndef MODEL_H
#define MODEL_H

#include <vector>
#include <QTimer>
#include <QVector>
//#include "mainwindow.h"

using namespace std;

class Model : public QObject {

    Q_OBJECT

    QVector<int> sequence;
    int level;
    int moveCount;
    bool playerTurn;

    QVector<int>::iterator it;

public:
    Model();
    //MainWindow view;

    void generateComputerSeq();
    void userClickedRed();
    void userClickedBlue();
    void restartGame();
    int progress();
    void gameOver();
    //void playComputerSeq();
    //void displayButton(int);
    void highlightButton(int);

public slots:
    //void gameStarted();
    void setupGame();

signals:
    void startGame(int newLevel);
    void randomSequence(QVector<int> seq);
    void levelPassed(int newLevel);
    void gameEnded();
    void progressChanged(int total, int progress);

};


#endif // MODEL_H
