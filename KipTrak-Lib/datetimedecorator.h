#ifndef DATETIMEDECORATOR_H
#define DATETIMEDECORATOR_H

#include <QJsonObject>
#include <QJsonValue>
#include <QObject>
#include <QScopedPointer>
#include <QString>

#include <KipTrak-Lib_global.h>
#include <datadecorator.h>
class KIPTRAKLIB_EXPORT DateTimeDecorator : public DataDecorator
{
    Q_OBJECT
    Q_PROPERTY( QDateTime ui_value READ value WRITE setValue NOTIFY valueChanged )
    Q_PROPERTY( QString ui_iso8601String READ toIso8601String NOTIFY valueChanged )
    Q_PROPERTY( QString ui_prettyDateString READ toPrettyDateString NOTIFY valueChanged )
    Q_PROPERTY( QString ui_prettyTimeString READ toPrettyTimeString NOTIFY valueChanged )
    Q_PROPERTY( QString ui_prettyString READ toPrettyString NOTIFY valueChanged )
public:
    DateTimeDecorator(Entity* parentEntity = nullptr, const QString& key = "SomeItemKey", const QString& label = "", const QDateTime& value = QDateTime::currentDateTime());
    virtual ~DateTimeDecorator();
    DateTimeDecorator& setValue(const QDateTime& value);
    const QDateTime& value() const;
    QJsonValue jsonValue() const override;
    void update(const QJsonObject& jsonObject) override;
    QString toIso8601String() const;
    QString toPrettyString() const;
    QString toPrettyDateString() const;
    QString toPrettyTimeString() const;
signals:
    void valueChanged();
private:
    class Implementation;
    QScopedPointer<Implementation> implementation;

};

#endif // DATETIMEDECORATOR_H
