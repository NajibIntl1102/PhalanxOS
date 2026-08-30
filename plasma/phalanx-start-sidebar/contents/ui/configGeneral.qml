import QtQuick 2.15
import QtQuick.Controls 2.15 as QQC2
import QtQuick.Layouts 1.15
import org.kde.kirigami 2.20 as Kirigami

Kirigami.FormLayout {
    id: root

    property alias cfg_accentColor: accentColor.text
    property alias cfg_secondaryAccentColor: secondaryAccentColor.text
    property alias cfg_transparency: transparency.value
    property string cfg_panelPosition: "left"
    property alias cfg_animationIntensity: animationIntensity.value
    property var cfg_enabledModules: []

    readonly property var moduleIds: [
        "systemStatus", "aiAssistant", "securityTools", "networkStatus",
        "privacyTor", "syncStatus", "socialNotifications"
    ]

    function selectedModules() {
        if (Array.isArray(cfg_enabledModules)) {
            return cfg_enabledModules
        }
        if (!cfg_enabledModules) {
            return []
        }
        return String(cfg_enabledModules).split(",")
    }

    function syncModules() {
        var selected = []
        for (var i = 0; i < moduleRepeater.count; i++) {
            var item = moduleRepeater.itemAt(i)
            if (item && item.checked) {
                selected.push(item.moduleId)
            }
        }
        cfg_enabledModules = selected
    }

    onCfg_panelPositionChanged: panelPosition.currentIndex = Math.max(0, panelPosition.model.indexOf(cfg_panelPosition))

    QQC2.TextField {
        id: accentColor
        Kirigami.FormData.label: i18n("Accent color:")
        placeholderText: "#dc143c"
    }

    QQC2.TextField {
        id: secondaryAccentColor
        Kirigami.FormData.label: i18n("Glow color:")
        placeholderText: "#ff335f"
    }

    QQC2.Slider {
        id: transparency
        Kirigami.FormData.label: i18n("Transparency:")
        from: 0.35
        to: 1.0
        stepSize: 0.01
    }

    QQC2.ComboBox {
        id: panelPosition
        Kirigami.FormData.label: i18n("Panel position:")
        model: ["left", "right", "top", "bottom"]
        onActivated: root.cfg_panelPosition = currentText
    }

    QQC2.Slider {
        id: animationIntensity
        Kirigami.FormData.label: i18n("Animation intensity:")
        from: 0
        to: 3
        stepSize: 1
    }

    ColumnLayout {
        Kirigami.FormData.label: i18n("Enabled modules:")
        Repeater {
            id: moduleRepeater
            model: root.moduleIds
            QQC2.CheckBox {
                required property string modelData
                property string moduleId: modelData
                text: moduleId
                checked: root.selectedModules().indexOf(moduleId) !== -1
                onToggled: root.syncModules()
            }
        }
    }
}
