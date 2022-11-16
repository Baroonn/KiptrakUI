#include "enumeratordecorator.h"

#include <QVariant>

class EnumeratorDecorator::Implementation
{
public:
    Implementation(EnumeratorDecorator* _enumDecorator, int _value, const std::map<int, QString>& _descriptionMapper)
    : enumDecorator(_enumDecorator)
    , descriptionMapper(_descriptionMapper)
    , value(_value)
    {
    }
    EnumeratorDecorator* enumDecorator{nullptr};
    std::map<int, QString> descriptionMapper;
    int value;
};

EnumeratorDecorator::EnumeratorDecorator(Entity* parentEntity,
                                         const QString& key,
                                         const QString& label,
                                         int value,
                                         const std::map<int, QString>& descriptionMapper
                                         )
    : DataDecorator(parentEntity, key, label)
{
    implementation.reset(new Implementation(this, value, descriptionMapper));
}

EnumeratorDecorator::~EnumeratorDecorator()
{
}

int EnumeratorDecorator::value() const
{
    return implementation->value;
}

EnumeratorDecorator& EnumeratorDecorator::setValue(int value)
{
    if(value != implementation->value) {
        // ...Validation here if required...
        implementation->value = value;
        emit valueChanged();
    }
    return *this;
}

QJsonValue EnumeratorDecorator::jsonValue() const
{
    return QJsonValue::fromVariant(QVariant(implementation->value));
}

void EnumeratorDecorator::update(const QJsonObject& _jsonObject)
{
    if (_jsonObject.contains(key())) {
        setValue(_jsonObject.value(key()).toInt());
    } else {
        setValue(0);
    }
}

QString EnumeratorDecorator::valueDescription() const
{
    if (implementation->descriptionMapper.find(implementation->value)
            != implementation->descriptionMapper.end()) {
        return implementation->descriptionMapper.at(implementation->value);
    } else {
        return {};
    }
}
