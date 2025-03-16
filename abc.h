#ifndef ABC_H
#define ABC_H

#include <QObject>
#include<QtSql>
#include <QSqlDatabase>
#include<QFileInfo>
#include<QtNetwork/QTcpSocket>
#include<QtNetwork/QHostAddress>
#include<QByteArray>

class abc:public QObject
{
    Q_OBJECT
public:
    abc();

    bool openDB()
    {
        QSqlDatabase mydb;
        mydb=QSqlDatabase::addDatabase("QSQLITE");
        mydb.setDatabaseName("C:/QT/product_INFO.db");

        if(mydb.open())
        {
            qDebug()<<"Database is open";
            return true;
        }
        else
        {
             qDebug()<<"Database is FAIELD to open";
            return false;
        }
    }

     void closeDB()
     {
    QSqlDatabase mydb;
    mydb.close();
    mydb.removeDatabase(QSqlDatabase::defaultConnection);
    qDebug()<<"DATA base is closed";
     }
      Q_INVOKABLE void deleteItem(QString);

      Q_INVOKABLE void updateItem(QString,QString);

    Q_INVOKABLE QString datatoqml();


    Q_INVOKABLE void datafromqml(QString);

     Q_INVOKABLE void connect();

    Q_INVOKABLE void send_clicked(QString);

private:
     QTcpSocket *TCPsocket;

};

#endif // ABC_H
