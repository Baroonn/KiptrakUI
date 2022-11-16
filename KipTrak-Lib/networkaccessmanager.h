#ifndef NETWORKACCESSMANAGER_H
#define NETWORKACCESSMANAGER_H

#include <QObject>
#include <QScopedPointer>
#include <inetworkaccessmanager.h>

class NetworkAccessManager : public QObject, public INetworkAccessManager
{
    Q_OBJECT
public:
    explicit NetworkAccessManager(QObject *parent = nullptr);
    ~NetworkAccessManager();
    QNetworkReply* get(const QNetworkRequest& request) override;
    QNetworkReply* post(const QNetworkRequest& request, const QByteArray& data) override;
    QNetworkReply* deleteData(const QNetworkRequest& request) override;
    bool isNetworkAccessible() const override;
private:
    class Implementation;
    QScopedPointer<Implementation> implementation;

signals:

};

#endif // NETWORKACCESSMANAGER_H
