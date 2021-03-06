#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QSettings>
#include <QQuickStyle>
#include <QDebug>
#include <QTranslator>

int main(int argc, char *argv[])
{

    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);
    app.setOrganizationName("ttbn.lduboeuf");
    //app.setOrganizationDomain("ttbn.lduboeuf");
    app.setApplicationName("ttbn.lduboeuf");
    app.setApplicationVersion("0.7.3");

//load translation file
    QTranslator myappTranslator;
    qDebug()<< myappTranslator.load(QLocale(), QLatin1String("ttb"), QLatin1String("_"), QLatin1String(":/languages"));
    app.installTranslator(&myappTranslator);



    //qmlRegisterSingletonType(QUrl("qrc:/qml/TTBApplication.qml"), "TTBApplication", 1, 0, "TTBApplication");

    QSettings settings;
        QString style = QQuickStyle::name();
        QString platform = QGuiApplication::platformName();
//        if (platform=="android"){
//            settings.setValue("style", "Material");
//            QQuickStyle::setStyle("Material");
//        }else if (settings.contains("style")) {

//            QQuickStyle::setStyle(settings.value("style").toString());
//        }
//        else {
//            settings.setValue("style", "Suru");
//            QQuickStyle::setStyle("Suru");
//        }




    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("availableStyles", QQuickStyle::availableStyles());
    //engine.addImportPath("qrc:qml");
    engine.load(QUrl(QStringLiteral("qrc:qml/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;
    qDebug()<< "Default path >> "+engine.offlineStoragePath();

    return app.exec();
}
