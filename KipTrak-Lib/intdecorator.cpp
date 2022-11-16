#include "intdecorator.h"

#include <QVariant>

class IntDecorator::Implementation
{
public:
    Implementation(IntDecorator* _intDecorator, int _value)
    : intDecorator(_intDecorator)
    , value(_value)
    {
    }
    IntDecorator* intDecorator{nullptr};
    int value;
};

IntDecorator::IntDecorator(Entity* parentEntity, const QString& key, const QString& label, int value)
    : DataDecorator(parentEntity, key, label)
{
    implementation.reset(new Implementation(this, value));
}

IntDecorator::~IntDecorator()
{
}

int IntDecorator::value()
{
    return implementation->value;
}

IntDecorator& IntDecorator::setValue(int value)
{
    if(value != implementation->value) {
        // ...Validation here if required...
        implementation->value = value;
        emit valueChanged();
    }
    return *this;
}

QJsonValue IntDecorator::jsonValue() const
{
    return QJsonValue::fromVariant(QVariant(implementation->value));
}

void IntDecorator::update(const QJsonObject& _jsonObject)
{
    if (_jsonObject.contains(key())) {
        setValue(_jsonObject.value(key()).toInt());
    } else {
        setValue(0);
    }
}
