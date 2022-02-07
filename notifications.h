#pragma once
#include <QObject>

class DcNotifications: public QObject {
    Q_OBJECT
public:
    explicit DcNotifications(QObject *parent = nullptr);
    Q_INVOKABLE void send(QString event, QString pfpPath, QString title, QString message);
};
