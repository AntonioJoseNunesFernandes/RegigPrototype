#ifndef BOTTOMSHEET_H
#define BOTTOMSHEET_H

#include <QWidget>
#include <QPropertyAnimation>
#include <QVBoxLayout>
#include <QPushButton>
#include <QtQml/QQmlEngine> // Required for QML_ELEMENT

class BottomSheet : public QWidget {
    Q_OBJECT
    QML_ELEMENT // Automatically registers this class with QML
public:
    explicit BottomSheet(QWidget *parent = nullptr);

public slots:
    void openSheet();
    void animateClose();

protected:
    void resizeEvent(QResizeEvent *event) override;

private:
    QVBoxLayout *mainLayout;
    QWidget *contentWidget;
    QPropertyAnimation *animation;
    void setupUI();
signals:
};


#endif // BOTTOMSHEET_H
