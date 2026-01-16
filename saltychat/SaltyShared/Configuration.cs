using System;
using System.Collections.Generic;
using System.Text;
using Newtonsoft.Json;

namespace SaltyShared
{
    public class Configuration
    {
        public bool VoiceEnabled { get; set; } = true;
        public string ServerUniqueIdentifier { get; set; }
        public string MinimumPluginVersion { get; set; }
        public string SoundPack { get; set; }
        public ulong IngameChannelId { get; set; }
        public string IngameChannelPassword { get; set; }
        public ulong[] SwissChannelIds { get; set; } = new ulong[0];

        public float[] VoiceRanges { get; set; } = new float[] { 3f, 8f, 15f, 32f };
        public bool EnableVoiceRangeNotification { get; set; } = true;
        public string VoiceRangeNotification { get; set; } = "New voice range is {voicerange} metres.";
        public int RadioType { get; set; } = 4;
        public bool EnableRadioHardcoreMode { get; set; } = true;
        public float UltraShortRangeDistance { get; set; } = 1800f;
        public float ShortRangeDistance { get; set; } = 3000f;
        public float LongRangeDistance { get; set; } = 8000f;
        [JsonProperty("LongRangeDistace")]
        public float LongRangeDistace
        {
            get => this.LongRangeDistance;
            set => this.LongRangeDistance = value;
        }
        public float MegaphoneRange { get; set; } = 120f;
        public string NamePattern { get; set; } = "{guid}";
        public bool RequestTalkStates { get; set; } = true;
        public bool RequestRadioTrafficStates { get; set; } = false;

        public long ToggleRange { get; set; } = 4085452174;
        public string ToggleRangeKey { get; set; } = "J";
        public long TalkPrimary { get; set; } = 1271519931;
        public string TalkPrimaryKey { get; set; } = "N";
        public long TalkSecondary { get; set; } = 1287709438;
        public string TalkSecondaryKey { get; set; } = "B";
        public string TalkMegaphoneKey { get; set; } = "H";
    }
}
