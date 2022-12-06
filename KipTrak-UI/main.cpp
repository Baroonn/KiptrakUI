#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <mastercontroller.h>
#include <QQmlContext>
#include <QSslSocket>
#include <QDebug>
#include <QFontDatabase>
#include <fileupload.h>
#include <downloader.h>
#include <stringdecorator.h>
#include <enumeratordecorator.h>
#include <datetimedecorator.h>
#include <intdecorator.h>
#include <assignment.h>
#include <navigationcontroller.h>
#include <webrequest.h>
int main(int argc, char *argv[])
{
    qDebug() << QSslSocket::sslLibraryBuildVersionString();
    qDebug() << QSslSocket::supportsSsl();
    qDebug() << QSslSocket::sslLibraryVersionString();
    QGuiApplication app(argc, argv);
    QFontDatabase::addApplicationFont("Lato.ttf");
    QFont fon("Lato");
    app.setFont(fon);

    qmlRegisterType<MasterController>("KipTrak", 1, 0, "MasterController");
    qmlRegisterType<NavigationController>("KipTrak", 1, 0,"NavigationController");
    qmlRegisterType<FileUpload>("com.company.fileupload",1,0,"FileUpload");
    qmlRegisterType<Downloader>("DownloadManager",1,0,"Downloader");
    qmlRegisterType<WebRequest>("KipTrak", 1, 0, "WebRequest");
    qmlRegisterType<DateTimeDecorator>("KipTrak", 1, 0,"DateTimeDecorator");
    qmlRegisterType<EnumeratorDecorator>("KipTrak", 1, 0,"EnumeratorDecorator");
    qmlRegisterType<IntDecorator>("KipTrak", 1, 0, "IntDecorator");
    qmlRegisterType<StringDecorator>("KipTrak", 1, 0, "StringDecorator");
    qmlRegisterType<Assignment>("KipTrak", 1, 0, "Assignment");
    FileUpload fileupload;
    MasterController masterController;
    Downloader downloader;
    QQmlApplicationEngine engine;
    //WebRequest request;

    engine.rootContext()->setContextProperty("masterController", &masterController);
    engine.rootContext()->setContextProperty("fileupload", &fileupload);
    engine.rootContext()->setContextProperty("downloader", &downloader);
    //engine.rootContext()->setContextProperty("request", &request);
    const QUrl url(u"qrc:/KipTrak-UI/main.qml"_qs);
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
