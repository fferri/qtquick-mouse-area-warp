#include "mousecursorhelper.h"

#include <QCursor>
#include <QDebug>

MouseCursorHelper::MouseCursorHelper(QObject *parent) : QObject(parent)
{
}

QQuickItem * MouseCursorHelper::autoFindTarget()
{
    QObject *tmp = parent();
    while(tmp)
    {
        if(auto x = dynamic_cast<QQuickItem*>(tmp)) return x;
        tmp = tmp->parent();
    }
    return nullptr;
}

QPointF MouseCursorHelper::cursorPosition()
{
    return QCursor::pos();
}

QPointF MouseCursorHelper::localCursorPosition()
{
    if(!target_) setTarget(autoFindTarget());
    if(!target_) return {};
    return target_->mapFromGlobal(cursorPosition());
}

QQuickItem * MouseCursorHelper::target()
{
    return target_;
}

void MouseCursorHelper::setCursorPosition(QPointF position)
{
    QCursor::setPos(position.x(), position.y());
}

void MouseCursorHelper::setLocalCursorPosition(QPointF position)
{
    if(!target_) setTarget(autoFindTarget());
    if(!target_) return;
    setCursorPosition(target_->mapToGlobal(position));
}

void MouseCursorHelper::setTarget(QQuickItem *target)
{
    if(!target) return;
    auto old = target_;
    target_ = target;
    if(old != target) emit targetChanged(target);
}
