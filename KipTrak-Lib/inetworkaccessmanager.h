#ifndef INETWORKACCESSMANAGER_H
#define INETWORKACCESSMANAGER_H
#include <QNetworkReply>
#include <QNetworkRequest>


class INetworkAccessManager
{
public:
INetworkAccessManager(){}
virtual ~INetworkAccessManager(){}
virtual QNetworkReply* get(const QNetworkRequest& request) = 0;
virtual QNetworkReply* post(const QNetworkRequest& request, const QByteArray& data) = 0;
virtual QNetworkReply* deleteData(const QNetworkRequest& request) = 0;
virtual bool isNetworkAccessible() const = 0;
};
#endif // INETWORKACCESSMANAGER_H
