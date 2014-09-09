ece-739-project
===============

Project for ECE 739 Neural Networks and Machine Learning Project lead by Dr. Simon Haykin. The corresponding report can be found in [ece-739-report](http://github.com/pchrapka/ece-739-report) repo.

The project explores the relative performance between a Support Vector Machine (SVM) classifier and a Multilayer Perceptron Network trained with the Extended Kalman Filter (EKF-trained MLP). 

These simulations demonstrate that although both algorithms achieve similar performance, the SVM algorithm requires 5 times more computational time than the EKF-trained MLP. The EKF-trained MLP also offers a recursive training method. So, if more data becomes available you can simply update the MLP parameters. On the other hand, you would need to completely retrain the SVM.