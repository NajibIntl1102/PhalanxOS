import QtQuick 2.15
import QtQuick.Controls 2.15 as QQC2
import QtQuick.Layouts 1.15
import org.kde.plasma.plasmoid 2.0
import org.kde.kirigami 2.20 as Kirigami

PlasmoidItem {
    id: root

    readonly property color baseBlack: "#050507"
    readonly property color gunmetal: "#20252b"
    readonly property color accent: plasmoid.configuration.accentColor || "#dc143c"
    readonly property color glowAccent: plasmoid.configuration.secondaryAccentColor || "#ff335f"
    readonly property real panelAlpha: plasmoid.configuration.transparency || 0.88
    readonly property int animationIntensity: plasmoid.configuration.animationIntensity || 2
    readonly property string panelPosition: plasmoid.configuration.panelPosition || "left"
    readonly property var enabledModules: normalizeModules(plasmoid.configuration.enabledModules)

    function normalizeModules(value) {
        if (!value) {
            return ["systemStatus", "aiAssistant", "securityTools", "networkStatus", "privacyTor", "syncStatus", "socialNotifications"]
        }
        if (Array.isArray(value)) {
            return value
        }
        return String(value).split(",")
    }

    compactRepresentation: QQC2.ToolButton {
        text: "Φ"
        font.pixelSize: Kirigami.Units.iconSizes.smallMedium
        onClicked: root.expanded = !root.expanded
        QQC2.ToolTip.text: i18n("Open PhalanxOS Start Sidebar")
        QQC2.ToolTip.visible: hovered
    }

    fullRepresentation: Item {
        implicitWidth: Kirigami.Units.gridUnit * 22
        implicitHeight: Kirigami.Units.gridUnit * 34

        Rectangle {
            id: shell
            anchors.fill: parent
            radius: Kirigami.Units.largeSpacing
            color: Qt.rgba(0.02, 0.02, 0.03, root.panelAlpha)
            border.color: root.accent
            border.width: 1

            Rectangle {
                anchors.fill: parent
                anchors.margins: 1
                radius: parent.radius - 1
                color: "transparent"
                border.color: Qt.rgba(root.glowAccent.r, root.glowAccent.g, root.glowAccent.b, 0.35)
                border.width: 1
            }

            Canvas {
                anchors.fill: parent
                opacity: 0.20
                onPaint: {
                    var ctx = getContext("2d")
                    ctx.clearRect(0, 0, width, height)
                    ctx.strokeStyle = root.accent
                    ctx.lineWidth = 0.5
                    var grid = Kirigami.Units.gridUnit
                    for (var x = 0; x < width; x += grid) {
                        ctx.beginPath(); ctx.moveTo(x, 0); ctx.lineTo(x, height); ctx.stroke()
                    }
                    for (var y = 0; y < height; y += grid) {
                        ctx.beginPath(); ctx.moveTo(0, y); ctx.lineTo(width, y); ctx.stroke()
                    }
                }
            }

            ColumnLayout {
                anchors.fill: parent
                anchors.margins: Kirigami.Units.largeSpacing
                spacing: Kirigami.Units.smallSpacing

                RowLayout {
                    Layout.fillWidth: true
                    Rectangle {
                        width: Kirigami.Units.iconSizes.medium
                        height: width
                        radius: width / 2
                        color: root.accent
                        QQC2.Label {
                            anchors.centerIn: parent
                            text: "Φ"
                            color: root.baseBlack
                            font.bold: true
                        }
                    }
                    ColumnLayout {
                        Layout.fillWidth: true
                        QQC2.Label { text: i18n("PhalanxOS"); color: "white"; font.bold: true; font.pixelSize: Kirigami.Units.gridUnit }
                        QQC2.Label { text: i18n("Secure desktop command surface"); color: "#aeb5bd"; font.pixelSize: Kirigami.Units.smallSpacing * 2 }
                    }
                }

                Rectangle { Layout.fillWidth: true; height: 1; color: root.accent; opacity: 0.55 }

                Repeater {
                    model: [
                        { id: "systemStatus", label: i18n("System Status"), icon: "computer", detail: i18n("CPU, memory, thermal, battery") },
                        { id: "aiAssistant", label: i18n("AI Assistant"), icon: "assistant", detail: i18n("Launch local or cloud copilot") },
                        { id: "securityTools", label: i18n("Security Tools"), icon: "security-high", detail: i18n("Hardening, firewall, scanner") },
                        { id: "networkStatus", label: i18n("Network Status"), icon: "network-connect", detail: i18n("Interfaces, VPN, throughput") },
                        { id: "privacyTor", label: i18n("Privacy / Tor"), icon: "view-private", detail: i18n("Circuit, proxy, anonymity mode") },
                        { id: "syncStatus", label: i18n("Nextcloud / rclone"), icon: "folder-sync", detail: i18n("Cloud and remote sync health") },
                        { id: "socialNotifications", label: i18n("Social Ecosystem"), icon: "notifications", detail: i18n("Federated and community updates") }
                    ].filter(function(module) { return root.enabledModules.indexOf(module.id) !== -1 })

                    delegate: ModuleButton {
                        Layout.fillWidth: true
                        moduleLabel: modelData.label
                        moduleIcon: modelData.icon
                        moduleDetail: modelData.detail
                        accentColor: root.accent
                        glowColor: root.glowAccent
                        animationIntensity: root.animationIntensity
                    }
                }

                Item { Layout.fillHeight: true }

                QQC2.Label {
                    Layout.fillWidth: true
                    text: i18n("Position: %1 • Theme: black / crimson / gunmetal", root.panelPosition)
                    color: "#7f8790"
                    wrapMode: Text.WordWrap
                    horizontalAlignment: Text.AlignHCenter
                }
            }
        }
    }
}
