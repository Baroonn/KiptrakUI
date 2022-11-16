#include "webrequest.h"

#include <QMap>
#include <QNetworkReply>
#include <QNetworkRequest>
#include <QJsonDocument>

static const QMap<QNetworkReply::NetworkError, QString> networkErrorMapper = {
    {QNetworkReply::ConnectionRefusedError, "The remote server refused the connection (the server is not accepting requests)."},
    /* ...section shortened in print for brevity...*/
    {QNetworkReply::UnknownServerError, "An unknown error related to the server response was detected."}
};

class WebRequest::Implementation
{
public:
    Implementation(WebRequest* _webRequest, INetworkAccessManager* _networkAccessManager, const QUrl& _url)
        : webRequest(_webRequest)
        , networkAccessManager(_networkAccessManager)
        , url(_url)
    {
    }
    WebRequest* webRequest{nullptr};
    INetworkAccessManager* networkAccessManager{nullptr};
    QUrl url {};
    QNetworkReply* reply {nullptr};
public:

    bool isBusy() const
    {
        return isBusy_;
    }

    void setIsBusy(bool value)
    {
        if (value != isBusy_) {
            isBusy_ = value;
            emit webRequest->isBusyChanged();
        }
    }

private:
    bool isBusy_{false};
};


WebRequest::WebRequest(QObject* parent, INetworkAccessManager* networkAccessManager, const QUrl& url)
    : QObject(parent)
    , IWebRequest()
{
    implementation.reset(new WebRequest::Implementation(this, networkAccessManager, url));
}

WebRequest::~WebRequest()
{
}
void WebRequest::getAssignments(QString token)
{
    execute("GET", QUrl("https://kiptrak.azurewebsites.net/api/assignments"), token);
}

void WebRequest::getAssignment(QString token, QString id)
{
    execute("GET", QUrl("https://kiptrak.azurewebsites.net/api/assignments/"+id), token);
}

void WebRequest::createAssignment(Assignment* assignment, QString token)
{
    if(implementation->isBusy()) {
        return;
    }

    if(!implementation->networkAccessManager->isNetworkAccessible()) {
        emit error("Network not accessible");
        return;
    }

    implementation->setIsBusy(true);
    QNetworkRequest request;
    request.setUrl(QUrl("https://kiptrak.azurewebsites.net/api/assignments/"));
    //
    QString s = "Bearer ";
    s.append(token);
    request.setRawHeader("Authorization", s.toUtf8());
    request.setHeader(QNetworkRequest::ContentTypeHeader, QVariant("application/json"));
    //
    QJsonDocument doc(assignment->toJson());
    QByteArray bytes = doc.toJson();
    qDebug()<<bytes;
    implementation->reply = implementation->networkAccessManager->post(request, bytes);
    if(implementation->reply != nullptr) {
        connect(implementation->reply, &QNetworkReply::finished, this, &WebRequest::replyDelegate);
        connect(implementation->reply, &QNetworkReply::sslErrors, this, &WebRequest::sslErrorsDelegate);
    }
}

void WebRequest::deleteAssignment(QString token, QString id)
{
    execute("DELETE", QUrl("https://kiptrak.azurewebsites.net/api/assignments/"+id), token);
}

void WebRequest::execute(QString method, QUrl url, QString token)
{
    if(implementation->isBusy()) {
        return;
    }

    if(!implementation->networkAccessManager->isNetworkAccessible()) {
        emit error("Network not accessible");
        return;
    }

    implementation->setIsBusy(true);
    QNetworkRequest request;
    request.setUrl(url);
    //
    QString s = "Bearer ";
    s.append(token);
    request.setRawHeader("Authorization", s.toUtf8());
    //
    if(method=="GET"){
        implementation->reply = implementation->networkAccessManager->get(request);
    }
    else if(method == "DELETE")
    {
        implementation->reply = implementation->networkAccessManager->deleteData(request);
    }

    if(implementation->reply != nullptr) {
        connect(implementation->reply, &QNetworkReply::finished, this, &WebRequest::replyDelegate);
        connect(implementation->reply, &QNetworkReply::sslErrors, this, &WebRequest::sslErrorsDelegate);
    }
}

bool WebRequest::isBusy() const
{
    return implementation->isBusy();
}

void WebRequest::setUrl(const QUrl& url)
{
    if(url != implementation->url) {
        implementation->url = url;
        emit urlChanged();
    }
}

QUrl WebRequest::url() const
{
    return implementation->url;
}

void WebRequest::replyDelegate()
{
    implementation->setIsBusy(false);
    if (implementation->reply == nullptr) {
        emit error("Unexpected error - reply object is null");
        return;
    }
    disconnect(implementation->reply, &QNetworkReply::finished, this, &WebRequest::replyDelegate);
    disconnect(implementation->reply, &QNetworkReply::sslErrors, this, &WebRequest::sslErrorsDelegate);
    auto statusCode = implementation->reply->attribute(QNetworkRequest::HttpStatusCodeAttribute).toInt();
    auto responseBody = implementation->reply->readAll();
    auto replyStatus = implementation->reply->error();
    implementation->reply->deleteLater();
    if (replyStatus != QNetworkReply::NoError) {
        emit error(networkErrorMapper[implementation->reply->error()]);
    }
    emit requestComplete(statusCode, responseBody);
}

void WebRequest::sslErrorsDelegate(const QList<QSslError>& errors)
{
    QString sslError;
    for (const auto& error : errors) {
        sslError += error.errorString() + "\n";
    }
    emit error(sslError);
}
