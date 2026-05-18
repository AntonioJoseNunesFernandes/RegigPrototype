#ifndef COLOREDSVGIMAGEPROVIDER_H
#define COLOREDSVGIMAGEPROVIDER_H

#include <QQuickImageProvider>
#include <QFile>
#include <QRegularExpression>
#include <QPainter>
#include <QSvgRenderer>

class ColoredSVGImageProvider : public QQuickImageProvider
{
public:
    explicit ColoredSVGImageProvider();
    ~ColoredSVGImageProvider() override;

    QPixmap requestPixmap(const QString &id, QSize *size, const QSize &requestedSize) override
    {
        auto parts = id.split("?color=");
        QString path = ":/" + parts[0];
        QString color = parts.size() > 1 ? "#" + parts[1] : "#000000";

        QFile file(path);
        //qDebug() << file.exists();
        if (!file.open(QIODevice::ReadOnly | QIODevice::Text)){
            return QPixmap();
        }
        QString svg = file.readAll();

        svg.replace(QRegularExpression(R"(fill="[^"]*")"), QString("fill=\"%1\"").arg(color));

        QSvgRenderer renderer(svg.toUtf8());
        QPixmap pixmap(requestedSize.isValid() ? requestedSize : QSize(64, 64));
        pixmap.fill(Qt::transparent);
        QPainter painter(&pixmap);
        renderer.render(&painter);
        return pixmap;
    }
};

#endif // COLOREDSVGIMAGEPROVIDER_H
