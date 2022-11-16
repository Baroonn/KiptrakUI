#ifndef ENTITY_H
#define ENTITY_H

#include <map>
#include <QObject>
#include <QScopedPointer>
#include <KipTrak-Lib_global.h>
#include <datadecorator.h>
#include <entitycollection.h>
#include <QJsonArray>
class KIPTRAKLIB_EXPORT Entity : public QObject
{
    Q_OBJECT
public:
    Entity(QObject* parent = nullptr, const QString& key = "SomeEntityKey");
    Entity(QObject* parent, const QString& key, const QJsonObject& jsonObject);
    virtual ~Entity();
public:
    const QString& key() const;
    Q_INVOKABLE void update(const QJsonObject& jsonObject);
    Q_INVOKABLE QJsonObject toJson() const;
signals:
    void childEntitiesChanged();
    void dataDecoratorsChanged();
    void childCollectionsChanged(const QString& collectionKey);
protected:
    Entity* addChild(Entity* entity, const QString& key);
    DataDecorator* addDataItem(DataDecorator* dataDecorator);
    EntityCollectionBase* addChildCollection(EntityCollectionBase* entityCollection);

protected:
    class Implementation;
    QScopedPointer<Implementation> implementation;
};

#endif // ENTITY_H
