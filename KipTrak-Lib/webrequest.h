#ifndef WEBREQUEST_H
#define WEBREQUEST_H

#include <QList>
#include <QObject>
#include <QSslError>
#include <inetworkaccessmanager.h>
#include <iwebrequest.h>
#include <assignment.h>

class WebRequest : public QObject, public IWebRequest
{
    Q_OBJECT
public:
    WebRequest(QObject* parent, INetworkAccessManager* networkAccessManager, const QUrl& url);
    WebRequest(QObject* parent = nullptr) = delete;
    ~WebRequest();

public:
    void execute(QString method, QUrl url, QString token) override;
    Q_INVOKABLE void getAssignments(QString token);
    Q_INVOKABLE void getAssignment(QString token, QString id);
    Q_INVOKABLE void createAssignment(Assignment* assignment, QString token);
    Q_INVOKABLE void deleteAssignment(QString token, QString id);
    bool isBusy() const override;
    void setUrl(const QUrl& url) override;
    QUrl url() const override;

signals:
    void error(QString message);
    void isBusyChanged();
    void requestComplete(int statusCode, QByteArray body);
    void assignmentCreated(int statusCode, QByteArray body);
    void assignmentDeleted(int statusCode, QByteArray body);
    void urlChanged();
private slots:
    void replyDelegate();
    void sslErrorsDelegate( const QList<QSslError>& _errors );
private:
    class Implementation;
    QScopedPointer<Implementation> implementation;

};

#endif // WEBREQUEST_H
