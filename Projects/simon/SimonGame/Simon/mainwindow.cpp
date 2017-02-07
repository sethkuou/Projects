#include "mainwindow.h"
#include "ui_mainwindow.h"
#include "model.h"
#include <QVector>
#include <QObject>
#include <iostream>
#include <sstream>

MainWindow::MainWindow(QWidget *parent) :
    QMainWindow(parent),
    ui(new Ui::MainWindow)
{
    model = new Model;

    //model = Model();
    ui->setupUi(this);

    ui->blueButton->setEnabled(false);
    ui->redButton->setEnabled(false);

    //from model to view
    connect(ui->startButton, &QPushButton::pressed, model, &Model::setupGame);
    connect(model,&Model::startGame, this, &MainWindow::beginGame);
    connect(model,&Model::randomSequence, this, &MainWindow::playComputerSeq);
    connect(model,&Model::gameEnded, this, &MainWindow::gameOver);
    connect(model,&Model::progressChanged, this, &MainWindow::updateProgress);
    connect(model,&Model::levelPassed, this, &MainWindow::nextLevel);

    //from view to model
    connect(this,&MainWindow::gameStarted, model, &Model::generateComputerSeq);
    connect(this,&MainWindow::redButtonClick, model, &Model::userClickedRed);
    connect(this,&MainWindow::blueButtonClick, model, &Model::userClickedBlue);
}

MainWindow::~MainWindow()
{
    delete ui;
}

void MainWindow::beginGame(int modelLevel){


    ui->blueButton->setEnabled(false);
    ui->redButton->setEnabled(false);

    level = modelLevel;

    cout << modelLevel << endl;

    QString label = QString("Level: %1")
                    .arg(modelLevel);

    ui->startButton->setText("Restart");
    ui->levelLabel->setText(label);

    ui->message->setText("Watch the sequence carefully...");

    emit gameStarted();
}

void MainWindow::updateProgress(int level, int progress){

    double percent = ((double)progress/level) * 100;
    ui->progressBar->setValue(percent);
}

void MainWindow::on_startButton_clicked()
{

}

void MainWindow::playComputerSeq(QVector<int> modelSequence)
{
    sequence = modelSequence;
    it = sequence.begin();
    highlightButtons();

}

void MainWindow::displayButton(){

}

void MainWindow::highlightButtons(){

    if(it != sequence.end()){
        int color = *it;
        if(color ==0){
            QTimer::singleShot(10, this, &MainWindow::highlightRed);
            //ui->redButton->setStyleSheet("background-color:red");
        }else if(color == 1) {
            QTimer::singleShot(10, this, &MainWindow::highlightBlue);
            //ui->blueButton->setStyleSheet("background-color:blue");
        }
        it++;
    }
    else{

        ui->message->setText("Now replicate it.");
        ui->blueButton->setEnabled(true);
        ui->redButton->setEnabled(true);
    }
}

void MainWindow::highlightRed(){
    cout << "red" << endl;
    ui->redButton->setStyleSheet("background-color:red");
    QTimer::singleShot(1000, this, &MainWindow::clearRed);
}
void MainWindow::highlightBlue(){
    cout << "blue" << endl;
    ui->blueButton->setStyleSheet("background-color:blue");
    QTimer::singleShot(1000, this, &MainWindow::clearBlue);
}
void MainWindow::clearRed(){
    ui->redButton->setStyleSheet("background-color:");
    QTimer::singleShot(100, this, &MainWindow::highlightButtons);
}
void MainWindow::clearBlue(){
    ui->blueButton->setStyleSheet("background-color:");
    QTimer::singleShot(100, this, &MainWindow::highlightButtons);
}

void MainWindow::clearButton(){
    ui->blueButton->setStyleSheet("background-color:");
    ui->redButton->setStyleSheet("background-color:");
}

void MainWindow::on_redButton_clicked()
{
    ui->redButton->setStyleSheet("background-color:red");

    QTimer::singleShot(500, this, SLOT(clearRed()));
    emit redButtonClick();
}

void MainWindow::on_blueButton_clicked()
{
    ui->blueButton->setStyleSheet("background-color:blue");

    QTimer::singleShot(500, this, SLOT(clearBlue()));
    emit blueButtonClick();
}

void MainWindow::nextLevel(int modelLevel){

    ui->blueButton->setEnabled(false);
    ui->redButton->setEnabled(false);

    QString label = QString("Level: %1")
                    .arg(modelLevel);

    ui->levelLabel->setText(label);
    ui->message->setText("Well Done!");

    emit gameStarted();
}

void MainWindow::gameOver(){

    ui->blueButton->setEnabled(false);
    ui->redButton->setEnabled(false);

    QString label = QString("You made it to Level: %1")
                    .arg(level);

    sequence.clear();
    ui->levelLabel->setText(label);
    ui->message->setText("You Lose!");
}
