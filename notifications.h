#pragma once
#include <QObject>

class DcNotifications: public QObject {
    Q_OBJECT
public:
    explicit DcNotifications(QObject *parent = nullptr);
    //explicit DcEvent(dc_event_t *event);

    //~DcNotifications();

    Q_INVOKABLE void send(QString event, QString pfpPath, QString title, QString message);
};
