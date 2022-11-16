#ifndef MASTERCONTROLLER_H
#define MASTERCONTROLLER_H

#include <QObject>
#include <KipTrak-Lib_global.h>
#include <QString>
#include <navigationcontroller.h>
#include <assignment.h>
#include <networkaccessmanager.h>
#include <webrequest.h>

class KIPTRAKLIB_EXPORT MasterController : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString ui_welcomeMessage MEMBER welcomeMessage CONSTANT)
    Q_PROPERTY(NavigationController* ui_navigationController READ navigationController CONSTANT )
    Q_PROPERTY(Assignment* ui_newAssignment READ newAssignment CONSTANT )
    Q_PROPERTY(WebRequest* ui_webRequest READ webRequest CONSTANT )
public:
    QString welcomeMessage= "Keep track of assignments";
    explicit MasterController(QObject *parent = nullptr);
    virtual ~MasterController();
    NavigationController* navigationController();
    //const QString& welcomeMessage() const;
    Assignment* newAssignment();
    WebRequest* webRequest();
    void onReplyReceived(int statusCode, QByteArray body);

signals:

private:
    class Implementation;
    QScopedPointer<Implementation> implementation;

};




#endif // MASTERCONTROLLER_H
