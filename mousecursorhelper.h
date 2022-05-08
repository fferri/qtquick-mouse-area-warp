#ifndef MOUSECURSORHELPER_H
#define MOUSECURSORHELPER_H

#include <QObject>
#include <QQuickItem>

class MouseCursorHelper : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QPointF cursorPosition READ cursorPosition WRITE setCursorPosition)
    Q_PROPERTY(QPointF localCursorPosition READ localCursorPosition WRITE setLocalCursorPosition)
    Q_PROPERTY(QQuickItem * target READ target WRITE setTarget)

public:
    explicit MouseCursorHelper(QObject *parent = nullptr);

protected:
    QQuickItem * autoFindTarget();

public:
    QPointF cursorPosition();
    QPointF localCursorPosition();
    QQuickItem * target();

signals:
    void targetChanged(QQuickItem *newTarget);

public slots:
    void setCursorPosition(QPointF position);
    void setLocalCursorPosition(QPointF position);
    void setTarget(QQuickItem *target);

private:
    QQuickItem *target_;
};

#endif // MOUSECURSORHELPER_H
