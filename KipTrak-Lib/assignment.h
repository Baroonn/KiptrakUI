#ifndef ASSIGNMENT_H
#define ASSIGNMENT_H

#include "KipTrak-Lib_global.h"
#include <QObject>
#include <entity.h>
#include <stringdecorator.h>
#include <datetimedecorator.h>
#include <enumeratordecorator.h>
#include <iwebrequest.h>

class KIPTRAKLIB_EXPORT Assignment : public Entity
{
    Q_OBJECT
    Q_PROPERTY(StringDecorator* ui_id MEMBER id CONSTANT)
    Q_PROPERTY(StringDecorator* ui_title MEMBER title CONSTANT)
    Q_PROPERTY(StringDecorator* ui_description MEMBER description CONSTANT)
    Q_PROPERTY(StringDecorator* ui_notes MEMBER notes CONSTANT)
    Q_PROPERTY(StringDecorator* ui_course MEMBER course CONSTANT)
    Q_PROPERTY(StringDecorator* ui_teacherName MEMBER teacherName CONSTANT)
    Q_PROPERTY(DateTimeDecorator* ui_dateDue MEMBER dateDue CONSTANT)
    Q_PROPERTY(DateTimeDecorator* ui_createdAt MEMBER createdAt CONSTANT)
    Q_PROPERTY(StringDecorator* ui_username MEMBER username CONSTANT)
    Q_PROPERTY(EnumeratorDecorator* ui_status MEMBER status CONSTANT)
public:
    explicit Assignment(QObject* parent = nullptr);
    Assignment( const QJsonObject& json, QObject* parent=nullptr);
    ~Assignment();
    StringDecorator* id{nullptr};
    StringDecorator* title{nullptr};
    StringDecorator* description{nullptr};
    StringDecorator* notes{nullptr};
    StringDecorator* course{nullptr};
    StringDecorator* teacherName{nullptr};
    DateTimeDecorator* dateDue{nullptr};
    DateTimeDecorator* createdAt{nullptr};
    StringDecorator* username{nullptr};
    EnumeratorDecorator* status{nullptr};

    static std::map<int, QString> statusMapper;
};

enum Status{
    New = 0,
    Pending,
    Completed,
    Expired
};

#endif // ASSIGNMENT_H
