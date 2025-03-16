#include <QGuiApplication>
#include <QQmlApplicationEngine>
//#include<QApplication>
#include<QtQml/QQmlContext>
//#include "cppfuctions.h"
#include"abc.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
//    database *DB=database::getinstant();
  // cppfuctions *func=new cppfuctions();
   abc *g=new abc();
    engine.rootContext()->setContextProperty("g",g);

    const QUrl url(QStringLiteral("qrc:/main.qml"));
    engine.load(url);

    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
