#ifndef IMAGEUPLOADER_H
#define IMAGEUPLOADER_H

#include <QObject>

class ImageUploader : public QObject
{
    Q_OBJECT
public:
    explicit ImageUploader(QObject *parent = nullptr);

signals:

};

#endif // IMAGEUPLOADER_H
