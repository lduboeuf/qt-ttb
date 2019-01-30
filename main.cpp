#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QSettings>
#include <QQuickStyle>


int main(int argc, char *argv[])
{
    QGuiApplication::setApplicationName("ttbn.lduboeuf");
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);
    //qmlRegisterSingletonType(QUrl("qrc:/qml/TTBApplication.qml"), "TTBApplication", 1, 0, "TTBApplication");

    QSettings settings;
        QString style = QQuickStyle::name();
        QString platform = QGuiApplication::platformName();
        if (platform=="android"){
            settings.setValue("style", "material");
            QQuickStyle::setStyle("material");
        }else if (settings.contains("style")) {
            QQuickStyle::setStyle(settings.value("style").toString());
        }
        else {
            settings.setValue("style", "Suru");
            QQuickStyle::setStyle("Suru");
        }




    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("availableStyles", QQuickStyle::availableStyles());
    //engine.addImportPath("qrc:qml");
    engine.load(QUrl(QStringLiteral("qrc:qml/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
