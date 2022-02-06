#include <KNotification>
#include "notifications.h"

DcNotifications::DcNotifications(QObject *parent)
    : QObject{parent}
{
}

void
DcNotifications::send(QString event, QString pfpPath, QString title, QString message) {
   
   KNotification *newMess = new KNotification(event);
   newMess->setPixmap(QPixmap(pfpPath));
   newMess->setIconName("chat.delta.KDeltaChat");
   newMess->setComponentName("kdeltachat");
   newMess->setTitle(title);
   newMess->setText(message);
   newMess->sendEvent();

}
//newMess->setPixmap(QPixmap(":/res/chat.delta.KDeltaChat.png"));
