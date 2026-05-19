#include "bottomsheet.h"
#include <QGraphicsDropShadowEffect>

BottomSheet::BottomSheet(QWidget *parent) : QWidget(parent) {
    // Frameless tool window keeps it on top of the QML surface without a taskbar icon
    setWindowFlags(Qt::FramelessWindowHint | Qt::Tool | Qt::WindowStaysOnTopHint);
    setAttribute(Qt::WA_TranslucentBackground);

    setupUI();

    animation = new QPropertyAnimation(this, "geometry");
    animation->setDuration(1000); //250
}

void BottomSheet::setupUI() {
    mainLayout = new QVBoxLayout(this);
    mainLayout->setContentsMargins(0, 0, 0, 0);

    contentWidget = new QWidget(this);
    contentWidget->setObjectName("sheetWidget");
    contentWidget->setStyleSheet(
        "#sheetWidget { "
        "background-color: #ffffff; "
        "border-top-left-radius: 16px; "
        "border-top-right-radius: 16px; "
        "}"
        );

    QGraphicsDropShadowEffect *shadow = new QGraphicsDropShadowEffect(this);
    shadow->setBlurRadius(15);
    shadow->setOffset(0, -2);
    shadow->setColor(QColor(0, 0, 0, 40));
    contentWidget->setGraphicsEffect(shadow);

    QVBoxLayout *sheetLayout = new QVBoxLayout(contentWidget);
    QPushButton *closeBtn = new QPushButton("Close Sheet", contentWidget);
    closeBtn->setStyleSheet("padding: 12px; font-weight: bold; background-color: #e0e0e0; border: none; border-radius: 8px;");

    connect(closeBtn, &QPushButton::clicked, this, &BottomSheet::animateClose);

    sheetLayout->addWidget(closeBtn);
    mainLayout->addWidget(contentWidget);
}

void BottomSheet::openSheet() {
    if (!parentWidget()) return;

    // Calculate size relative to the parent QML Window
    int parentW = parentWidget()->width();
    int parentH = parentWidget()->height();
    int sheetH = parentH / 2; // Sheet takes up half the screen height

    // Global position of the parent window
    QPoint parentPos = parentWidget()->mapToGlobal(QPoint(0, 0));

    // Animate from off-screen bottom to the bottom edge of the window
    animation->setStartValue(QRect(parentPos.x(), parentPos.y() + parentH, parentW, sheetH));
    animation->setEndValue(QRect(parentPos.x(), parentPos.y() + parentH - sheetH, parentW, sheetH));

    show();
    animation->start();
}

void BottomSheet::animateClose() {
    if (!parentWidget()) return;

    int parentH = parentWidget()->height();
    QPoint parentPos = parentWidget()->mapToGlobal(QPoint(0, 0));

    animation->setStartValue(geometry());
    animation->setEndValue(QRect(x(), parentPos.y() + parentH, width(), height()));

    connect(animation, &QPropertyAnimation::finished, this, &QWidget::hide);
    animation->start();
}

void BottomSheet::resizeEvent(QResizeEvent *event) {
    QWidget::resizeEvent(event);
}
