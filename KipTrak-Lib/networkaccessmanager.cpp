#include "networkaccessmanager.h"
#include <QNetworkAccessManager>

class NetworkAccessManager::Implementation
{
public:
Implementation()
{}
QNetworkAccessManager networkAccessManager;
};
NetworkAccessManager::NetworkAccessManager(QObject *parent)
    : QObject{parent}, INetworkAccessManager()
{
    implementation.reset(new Implementation());
}

NetworkAccessManager::~NetworkAccessManager()
{
}
QNetworkReply* NetworkAccessManager::get(const QNetworkRequest& request)
{
    return implementation->networkAccessManager.get(request);
}

QNetworkReply* NetworkAccessManager::post(const QNetworkRequest& request, const QByteArray& data)
{
    return implementation->networkAccessManager.post(request, data);
}

QNetworkReply* NetworkAccessManager::deleteData(const QNetworkRequest& request)
{
    return implementation->networkAccessManager.deleteResource(request);
}
bool NetworkAccessManager::isNetworkAccessible() const
{
    return true;
}
