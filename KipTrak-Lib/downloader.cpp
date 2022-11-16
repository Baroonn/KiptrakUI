#include "downloader.h"

Downloader::Downloader(QObject *parent)
    : QObject{parent}
{

}

void Downloader::doDownload(QString id)
{
    guid = id;
    manager = new QNetworkAccessManager(this);

    connect(manager, SIGNAL(finished(QNetworkReply*)),
            this, SLOT(replyFinished(QNetworkReply*)));

    manager->get(QNetworkRequest(QUrl("https://kiptrak.blob.core.windows.net/images/" + id + ".pdf")));
}

void Downloader::replyFinished (QNetworkReply *reply)
{
    if(reply->error())
    {
        qDebug() << "ERROR!";
        qDebug() << reply->errorString();
    }
    else
    {
        QDir dir = QStandardPaths::standardLocations(QStandardPaths::DocumentsLocation)[0];
        qDebug() << reply->header(QNetworkRequest::ContentTypeHeader).toString();
        qDebug() << reply->header(QNetworkRequest::LastModifiedHeader).toDateTime().toString();;
        qDebug() << reply->header(QNetworkRequest::ContentLengthHeader).toULongLong();
        qDebug() << reply->attribute(QNetworkRequest::HttpStatusCodeAttribute).toInt();
        qDebug() << reply->attribute(QNetworkRequest::HttpReasonPhraseAttribute).toString();

        QFile *file = new QFile(dir.filePath(guid)+".pdf");
        //Qt.openUrlExternally("http://www.stackoverflow.com/");
        qCritical() << dir.filePath(guid);
        if(file->open(QIODevice::WriteOnly))
        {
            qCritical()<<file->write(reply->readAll(), 7000000);
            file->flush();
            file->close();
        }
        else
        {
            qCritical()<<"Can't open file";
        }
        qCritical() << dir.filePath(guid);
        delete file;
    }

    reply->deleteLater();
}

Downloader::~Downloader()
{

}
