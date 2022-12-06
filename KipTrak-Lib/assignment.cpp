#include "assignment.h"

std::map<int, QString> Assignment::statusMapper = std::map<int, QString>
{
    { Status::New, "New" }
    , { Status::Pending, "Pending" }
    , { Status::Completed, "Completed" }
    , { Status::Expired, "Expired" }
};

Assignment::Assignment(QObject* parent)
    : Entity(parent, "assignment")
{
    id = static_cast<StringDecorator*>(addDataItem(new StringDecorator(this, "id", "Id")));
    title = static_cast<StringDecorator*>(addDataItem(new StringDecorator(this, "title", "Title*")));
    description = static_cast<StringDecorator*>(addDataItem(new StringDecorator(this, "description", "Description*")));
    notes = static_cast<StringDecorator*>(addDataItem(new StringDecorator(this, "notes", "Notes")));
    course = static_cast<StringDecorator*>(addDataItem(new StringDecorator(this, "course", "Course*")));
    teacherName = static_cast<StringDecorator*>(addDataItem(new StringDecorator(this, "teacherName", "Teacher*")));
    dateDue = static_cast<DateTimeDecorator*>(addDataItem(new DateTimeDecorator(this, "dateDue", "Date Due* ")));
    createdAt = static_cast<DateTimeDecorator*>(addDataItem(new DateTimeDecorator(this, "createdAt", "Created* ")));
    username = static_cast<StringDecorator*>(addDataItem(new StringDecorator(this, "username", "Created By")));
    status = static_cast<EnumeratorDecorator*>(addDataItem(new EnumeratorDecorator(this, "status", "Status", 0, statusMapper)));
}

Assignment::Assignment(const QJsonObject& json, QObject* parent)
    :Entity(parent, "assignment", json)
{
    id = static_cast<StringDecorator*>(addDataItem(new StringDecorator(this, "id", "Id")));
    title = static_cast<StringDecorator*>(addDataItem(new StringDecorator(this, "title", "Title*")));
    description = static_cast<StringDecorator*>(addDataItem(new StringDecorator(this, "description", "Description*")));
    notes = static_cast<StringDecorator*>(addDataItem(new StringDecorator(this, "notes", "Notes")));
    course = static_cast<StringDecorator*>(addDataItem(new StringDecorator(this, "course", "Course*")));
    teacherName = static_cast<StringDecorator*>(addDataItem(new StringDecorator(this, "teacherName", "Teacher*")));
    dateDue = static_cast<DateTimeDecorator*>(addDataItem(new DateTimeDecorator(this, "dateDue", "DateDue* ")));
    createdAt = static_cast<DateTimeDecorator*>(addDataItem(new DateTimeDecorator(this, "createdAt", "Created* ")));
    username = static_cast<StringDecorator*>(addDataItem(new StringDecorator(this, "username", "Created By")));
    status = static_cast<EnumeratorDecorator*>(addDataItem(new EnumeratorDecorator(this, "status", "Status", 0, statusMapper)));
}

Assignment::~Assignment()
{}
