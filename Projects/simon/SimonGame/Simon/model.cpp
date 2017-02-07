#include "model.h"
#include <iostream>
#include <QVector>
#include "mainwindow.h"

using namespace std;

Model::Model(){
    moveCount= 0;
    level = 0;

    //MainWindow view = new MainWindow(QWidget *parent = 0);

}

void Model:: setupGame(){
    level = 2;
    //generateComputerSeq();
    sequence.clear();

    emit startGame(level);
    //QObject::connect(model, SIGNAL(&QPushButton::pressed), &model, SLOT());
}

void Model::userClickedBlue(){

    cout << "blue is: " << *it << endl;

    if (*it == 0){
        gameOver();
    }
    else {
        moveCount++;
        cout << "movecount= " << moveCount << endl;
        //sequence.pop_back();
        emit progressChanged(level, moveCount);
    }

    it++;

    if(moveCount == level){
        //sequence.clear();
        level++;
        moveCount=0;

        cout << "Passed level" << endl;

        emit progressChanged(level, 0);
        emit levelPassed(level);
    }
}

void Model::userClickedRed(){

    cout << "red is: " << *it << endl;

    if (*it == 1){
        gameOver();
    }
    else {
        moveCount++;
        cout << "movecount= " << moveCount << endl;
        //sequence.pop_back();
        emit progressChanged(level, moveCount);
    }

    it++;

    if(moveCount == level){
        //sequence.clear();
        level++;
        moveCount=0;

        emit progressChanged(level, 0);
        emit levelPassed(level);
    }
}

void Model::gameOver(){
    cout << "Game Over" << endl;
    sequence.clear();
    moveCount=0;

    emit gameEnded();
}

void Model::generateComputerSeq()
{
    if(level == 2){
        //generate a random number from 0 to 1
        int value1 = rand() % 2;
        int value2 = rand() % 2;
        //QVector<int>::iterator it;

        //it=sequence.begin();

        cout << " " << value1 << endl;

        sequence.push_back(value1);
        sequence.push_back(value2);

        //sequence.insert(it, value);
    }
    else {
       int value = rand() % 2;

       cout << " " << value << endl;

       sequence.push_back(value);
    }

    it=sequence.begin();

    //for (QVector<string>::iterator it = sequence.begin(); it != sequence.end(); it++)
      //      {
        //       cout << " " << *it << endl;
          //  }


    emit randomSequence(sequence);
}

//void Model::highlightButton(){

//}

//int Model::progress(){

//}

//void Model::restartGame(){
//}


