#ifndef IWEBREQUEST_H
#define IWEBREQUEST_H
#include <QUrl>

class IWebRequest
{
public:
IWebRequest(){}
virtual ~IWebRequest(){}
virtual void execute(QString method, QUrl url, QString token) = 0;
virtual bool isBusy() const = 0;
virtual void setUrl(const QUrl& url) = 0;
virtual QUrl url() const = 0;
};
#endif // IWEBREQUEST_H
