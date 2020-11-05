import QtQuick 2.12
import QtQuick.Controls 2.12 as Controls
import org.kde.kirigami 2.12 as Kirigami

import DeltaChat 1.0


Kirigami.ApplicationWindow {
    id: root

    property DcAccountsEventEmitter eventEmitter

    title: qsTr("Delta Chat")

    pageStack.initialPage: AccountsPage {}

    globalDrawer: Kirigami.GlobalDrawer {
        header: Controls.Switch {
            text: "Start IO"
            onCheckedChanged: {
                if (checked) {
                    dcAccounts.startIo()
                } else {
                    dcAccouts.stopIo()
                }
            }
        }

        actions: [
            Kirigami.Action {
                text: "Maybe network"
                iconName: "view-refresh"
                onTriggered: dcAccounts.maybeNetwork()
            }
        ]
    }

    contextDrawer: Kirigami.ContextDrawer {
        id: contextDrawer
    }

    DcAccounts {
        id: dcAccounts
    }

    Component.onCompleted: {
        console.log('starting')
        eventEmitter = dcAccounts.getEventEmitter()
        eventEmitter.start();
    }

    onClosing: {
        // Cancel all tasks that may block the termination of event loop.
        dcAccounts.stopIo()
    }
}
