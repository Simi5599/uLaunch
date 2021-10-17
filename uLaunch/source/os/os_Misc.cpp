#include <os/os_Misc.hpp>
#include <ctime>

namespace os {

    u32 GetBatteryLevel() {
        u32 lvl = 0;
        psmGetBatteryChargePercentage(&lvl);
        return lvl;
    }

    bool IsConsoleCharging() {
        auto charger_type = PsmChargerType_Unconnected;
        psmGetChargerType(&charger_type);
        return charger_type > PsmChargerType_Unconnected;
    }
    
    std::string GetCurrentTime() {
        auto time_val = time(nullptr);
        auto local_time = localtime(&time_val);
        auto h = local_time->tm_hour;
        auto min = local_time->tm_min;
        char str[0x10] = {};
        sprintf(str, "%02d:%02d", h, min);
        return str;
    }

}