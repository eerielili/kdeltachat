import DeltaChat 1.0
import QtQml.Models 2.1
import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import org.kde.kirigami 2.13 as Kirigami

Kirigami.AbstractListItem {
    id: root

    property DcContext context
    property int chatId
    property string chatName
    property string avatarSource
    property string username
    property int freshMsgCnt
    property int visibility
    property bool isContactRequest
    property bool isPinned
    property bool isMuted

    RowLayout {
        Kirigami.Avatar {
            source: root.avatarSource
            name: root.chatName
            color: root.context.getChat(root.chatId).getColor()

            MouseArea {
                anchors.fill: parent
                acceptedButtons: Qt.RightButton
                onClicked: {
                    if (mouse.button === Qt.RightButton)
                        contextMenu.popup();

                }

                Menu {
                    id: contextMenu
                    
                    Action {
                      text: !root.isMuted ? "Mute chat" : "Unmute chat"
                      onTriggered: {
                          if (!root.isMuted)
                            root.context.setChatMuteDuration(root.chatId, -1)
                          else
                            root.context.setChatMuteDuration(root.chatId, 0)
                      }
                    }

                    Action {
                        text: "Block chat"
                        onTriggered: {
                            root.context.blockChat(root.chatId)
                            updateChatlist()
                        }

                    }

                    Action {
                        icon.name: "pin"
                        text: !root.isPinned ? "Pin chat" : "Unpin chat"
                        onTriggered: !root.isPinned ? root.context.setChatVisibility(root.chatId, 2) : root.context.setChatVisibility(root.chatId, 0)
                    }

                    Action {
                        text: root.visibility != 1 ? "Archive chat" : "Unarchive chat"
                        onTriggered: root.visibility != 1 ? root.context.setChatVisibility(root.chatId, 1) : root.context.setChatVisibility(root.chatId, 0)
                    }

                    Action {
                        icon.name: "delete"
                        text: "Delete chat"
                        onTriggered: root.context.deleteChat(root.chatId)
                    }

                }

            }

        }

        ColumnLayout {
            Layout.fillWidth: true

            Label {
                text: root.context.getChat(root.chatId).getName()
                font.weight: Font.Bold
                Layout.fillWidth: true
            }

            Label {
                text: root.username
                font: Kirigami.Theme.smallFont
                Layout.fillWidth: true
            }

        }

        // Contact request / new messages count badge
        Label {
            text: root.isContactRequest ? "NEW" : root.freshMsgCnt
            visible: root.freshMsgCnt > 0 || root.isContactRequest
            // Align label in the center of a badge.
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            // Make sure badge is not too narrow.
            Layout.minimumWidth: height

            background: Rectangle {
                color: Kirigami.Theme.alternateBackgroundColor
                radius: 0.25 * height
            }

        }

        // Twemoji
        // Copyright 2020 Twitter, Inc and other contributors.
        // Muted chat badge
        Image {
            visible: root.isMuted
            source: "qrc:/res/muted_48x48.png"
            sourceSize.width: 24
            sourceSize.height: 24
            Layout.bottomMargin: 13
        }

        // Twemoji
        // Copyright 2020 Twitter, Inc and other contributors.
        // Pinned chat badge
        Image {
            visible: root.isPinned
            source: "qrc:/res/pin_48x48.png"
            sourceSize.width: 24
            sourceSize.height: 24
            Layout.bottomMargin: 13
        }

    }

}
