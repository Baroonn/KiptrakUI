#ifndef NAVIGATIONCONTROLLER_H
#define NAVIGATIONCONTROLLER_H

#include <QObject>
#include <KipTrak-Lib_global.h>

#include <assignment.h>

class KIPTRAKLIB_EXPORT NavigationController : public QObject
{
    Q_OBJECT
public:
    explicit NavigationController(QObject* _parent = nullptr)
    : QObject(_parent)
    {}
    virtual ~NavigationController()
    {}

signals:
    void goCreateAccountView();
    void goLoginView();
    void goMainPageView();
    void goSearchView();
    void goCreateAssignmentView();
    void goViewAssignment(const QJsonObject& data);
};

#endif // NAVIGATIONCONTROLLER_H
