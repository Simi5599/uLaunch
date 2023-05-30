
#pragma once
#include <ul_Include.hpp>

namespace os {

    enum class GeneralChannelMessage : u32 {
        Invalid,
        HomeButton = 2,
        Sleep = 3,
        Shutdown = 5,
        Reboot = 6,
        OverlayBrightValueChanged = 13,
        OverlayAutoBrightnessChanged = 14,
        OverlayAirplaneModeChanged = 15,
        HomeButtonHold = 16,
        OverlayHidden = 17
    };

    struct SystemAppletMessage {
        static constexpr u32 Magic = 0x534D4153; // "SAMS" -> System applet message...?

        u32 magic;
        u32 unk;
        GeneralChannelMessage general_channel_message;
        u8 unk_reserved[0x3F4];

        static inline constexpr SystemAppletMessage Create(const GeneralChannelMessage msg) {
            return {
                .magic = Magic,
                .general_channel_message = msg
            };
        }
    };
    static_assert(sizeof(SystemAppletMessage) == 0x400);

    // TODO: actual names N uses?
    enum class AppletMessage : u32 {
        Invalid,
        Exit = 4,
        FocusStateChange = 15,
        HomeButton = 20,
        PowerButton = 22,
        BackFromSleep = 26,
        ChangeOperationMode = 30,
        ChangePerformanceMode = 31,
        SdCardOut = 33
    };

    Result PushSystemAppletMessage(const SystemAppletMessage msg);
    

}