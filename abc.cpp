#include "abc.h"
#include<QDebug>

abc::abc()
{

}
void abc::datafromqml(QString str)
{
    QString v,mc,r,pn;
    QStringList list=str.split(" ");
    pn=list[0];
    v=list[1];
    mc=list[2];
    r=list[3];
   openDB();
   QSqlQuery query;
    query.prepare("INSERT INTO product(PRODUCT_NAME, VOLUME, M_CAPITAL, RATING,TIME) "  // inserting in database
                "VALUES (:pn, :v, :mc, :r ,:dateTimeString)");
      query.bindValue(":v", v);
      query.bindValue(":mc", mc);
      query.bindValue(":r", r);
      query.bindValue(":pn", pn);
      if(query.exec())
      {
          qDebug()<<"Saved ";
      }
      else
          qDebug()<<"Not Saved";

      closeDB();

}

void abc::updateItem(QString update,QString data)
{
    QStringList list = data.split(" ");
     QString v,mc,r,dateTimeString="56.78";
     v=list[0];
     mc=list[1];
     r=list[2];
//qDebug()<<r;
     if(openDB())
     {
    QSqlQuery query;

          query.prepare("UPDATE product SET VOLUME = :v, M_CAPITAL = :mc, RATING = :r, TIME = :dateTimeString WHERE PRODUCT_NAME = :update");
          query.bindValue(":v", v);
          query.bindValue(":mc", mc);
          query.bindValue(":r", r);
       query.bindValue(":update", update);
       query.bindValue(":dateTimeString", dateTimeString);
       if(query.exec())
       {
           qDebug()<<"Updated";
       }
       else
            qDebug()<<"not Updated";
     }

}

QString abc::datatoqml()
{
    int i=0;
   QString wholestr;

   QString p,v,m,r;
     if(openDB())
     {
           QSqlQuery query("SELECT * FROM product");

             while (query.next())           // itreting loop from 1 st entry to last entry
             {
                  p = query.value(0).toString();   //taking data from database in qstring
                   v=query.value(1).toString();
                    m = query.value(2).toString();
                     r = query.value(3).toString();
                 wholestr =p+" "+v+" "+m+" "+r+"|"+wholestr ;
                 i++;
             }

     }
     closeDB();
     return wholestr;

}
void abc::deleteItem(QString str)
{
    if(openDB())
    {   QSqlQuery query;

          query.prepare("DELETE FROM product WHERE PRODUCT_NAME = :str ");
          query.bindValue(":str" ,str);
           if(query.exec())
           {
               qDebug()<<"entry is deleted";
           }
       //    else
         //      QMessageBox::information(this,"Deleted","entry is deleted");
    }
}
void abc::connect()     // connect button
{
    TCPsocket=new QTcpSocket();               // give space to tcp object
    TCPsocket->connectToHost(QHostAddress::LocalHost,8080);   // connect with local host (in same pc)
    TCPsocket->open(QIODevice::ReadWrite);                   // reading and writing throw socket
            if(TCPsocket->isOpen())
            {
                    qDebug()<< "Conected.....";
            }
//            else
//                 QMessageBox::information(this,"Status","Not Conected.....");
}

void abc::send_clicked(QString sendData)
{
    if(TCPsocket)
    {
        if(TCPsocket->isOpen())
        {
          qDebug()<<"open soket";
         TCPsocket->write(sendData.toUtf8()); // writing in server in utf8 formate
        }
    }
    else
        qDebug()<<"soket is not open data not send";

}



