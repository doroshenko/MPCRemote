//
//  Command.swift
//  MPCRemote
//
//  Created by doroshenko on 06.03.20.
//  Copyright © 2020 doroshenko. All rights reserved.
//

import Foundation

enum Command {

    struct File {
        static let openMedia =             800
        static let openDVDBD =             801
        static let openDevice =            802
        static let closeMedia =            803
        static let closeAndRestore =       804
        static let saveCopy =              805
        static let saveImage =             806
        static let saveImageAuto =         807
        static let saveThumbnails =        808
        static let subtitlesLoad =         809
        static let subtitlesSave =         810
        static let subtitlesUpload =       811
        static let subtitlesDownload =     812
        static let properties =            814
    }

//    #define ID_VIEW_OPTIONS                 815
//    #define ID_FILE_EXIT                    816
//    #define ID_VIEW_CAPTIONMENU             817
//    #define ID_VIEW_SEEKER                  818
//    #define ID_VIEW_CONTROLS                819
//    #define ID_VIEW_INFORMATION             820
//    #define ID_VIEW_STATISTICS              821
//    #define ID_VIEW_STATUS                  822
//    #define ID_VIEW_SUBRESYNC               823
//    #define ID_VIEW_PLAYLIST                824
//    #define ID_VIEW_CAPTURE                 825
//    #define ID_VIEW_DEBUGSHADERS            826
//    #define ID_VIEW_PRESETS_MINIMAL         827
//    #define ID_VIEW_PRESETS_COMPACT         828
//    #define ID_VIEW_PRESETS_NORMAL          829
//    #define ID_VIEW_FULLSCREEN              830
//    #define ID_VIEW_FULLSCREEN_SECONDARY    831
//    #define ID_VIEW_ZOOM_50                 832
//    #define ID_VIEW_ZOOM_100                833
//    #define ID_VIEW_ZOOM_200                834
//    #define ID_VIEW_VF_HALF                 835
//    #define ID_VIEW_VF_NORMAL               836
//    #define ID_VIEW_VF_DOUBLE               837
//    #define ID_VIEW_VF_STRETCH              838
//    #define ID_VIEW_VF_FROMINSIDE           839
//    #define ID_VIEW_VF_FROMOUTSIDE          840
//    #define ID_VIEW_VF_ZOOM1                841
//    #define ID_VIEW_VF_ZOOM2                842
//    #define ID_VIEW_VF_SWITCHZOOM           843
//    #define ID_VIEW_VF_COMPMONDESKARDIFF    845
//    #define ID_VIEW_EDITLISTEDITOR          846
//    #define ID_EDL_IN                       847
//    #define ID_EDL_OUT                      848
//    #define ID_EDL_NEWCLIP                  849
//    #define ID_ASPECTRATIO_START            850
//    #define ID_ASPECTRATIO_DAR              850
//    #define ID_ASPECTRATIO_4_3              851
//    #define ID_ASPECTRATIO_5_4              852
//    #define ID_ASPECTRATIO_16_9             853
//    #define ID_ASPECTRATIO_235_100          854
//    #define ID_ASPECTRATIO_185_100          855
//    #define ID_ASPECTRATIO_SAR              856
//    #define ID_ASPECTRATIO_END              856
//    #define ID_ASPECTRATIO_NEXT             859
//    #define ID_EDL_SAVE                     860
//    #define ID_VIEW_RESET                   861
//    #define ID_VIEW_INCSIZE                 862
//    #define ID_VIEW_DECSIZE                 863
//    #define ID_VIEW_INCWIDTH                864
//    #define ID_VIEW_DECWIDTH                865
//    #define ID_VIEW_INCHEIGHT               866
//    #define ID_VIEW_DECHEIGHT               867
//    #define ID_PANSCAN_MOVELEFT             868
//    #define ID_PANSCAN_MOVERIGHT            869
//    #define ID_PANSCAN_MOVEUP               870
//    #define ID_PANSCAN_MOVEDOWN             871
//    #define ID_PANSCAN_MOVEUPLEFT           872
//    #define ID_PANSCAN_MOVEUPRIGHT          873
//    #define ID_PANSCAN_MOVEDOWNLEFT         874
//    #define ID_PANSCAN_MOVEDOWNRIGHT        875
//    #define ID_PANSCAN_CENTER               876
//    #define ID_PANSCAN_ROTATEXP             877
//    #define ID_PANSCAN_ROTATEXM             878
//    #define ID_PANSCAN_ROTATEYP             879
//    #define ID_PANSCAN_ROTATEYM             880
//    #define ID_PANSCAN_ROTATEZP             881
//    #define ID_PANSCAN_ROTATEZM             882
//    #define ID_ONTOP_DEFAULT                883
//    #define ID_ONTOP_ALWAYS                 884
//    #define ID_ONTOP_WHILEPLAYING           885
//    #define ID_ONTOP_WHILEPLAYINGVIDEO      886
//    #define ID_PLAY_PLAY                    887
//    #define ID_PLAY_PAUSE                   888
//    #define ID_PLAY_PLAYPAUSE               889
//    #define IDS_AG_OPEN_FILE_LOCATION       889
//    #define ID_PLAY_STOP                    890
//    #define ID_PLAY_FRAMESTEP               891
//    #define ID_PLAY_FRAMESTEPCANCEL         892
//    #define ID_NAVIGATE_GOTO                893
//    #define ID_PLAY_DECRATE                 894
//    #define ID_PLAY_INCRATE                 895
//    #define ID_PLAY_RESETRATE               896
//    #define ID_PLAY_SEEKKEYBACKWARD         897
//    #define ID_PLAY_SEEKKEYFORWARD          898
//    #define ID_PLAY_SEEKBACKWARDSMALL       899
//    #define ID_PLAY_SEEKFORWARDSMALL        900
//    #define ID_PLAY_SEEKBACKWARDMED         901
//    #define ID_PLAY_SEEKFORWARDMED          902
//    #define ID_PLAY_SEEKBACKWARDLARGE       903
//    #define ID_PLAY_SEEKFORWARDLARGE        904
//    #define ID_PLAY_INCAUDDELAY             905
//    #define ID_PLAY_DECAUDDELAY             906
//    #define ID_VOLUME_UP                    907
//    #define ID_VOLUME_DOWN                  908
//    #define ID_VOLUME_MUTE                  909
//    #define ID_VOLUME_MUTE_OFF              910
//    #define ID_VOLUME_MUTE_DISABLED         911
//    #define ID_AFTERPLAYBACK_EXIT           912
//    #define ID_AFTERPLAYBACK_STANDBY        913
//    #define ID_AFTERPLAYBACK_HIBERNATE      914
//    #define ID_AFTERPLAYBACK_SHUTDOWN       915
//    #define ID_AFTERPLAYBACK_LOGOFF         916
//    #define ID_AFTERPLAYBACK_LOCK           917
//    #define ID_AFTERPLAYBACK_MONITOROFF     918
//    #define ID_NAVIGATE_SKIPBACKFILE        919
//    #define ID_NAVIGATE_SKIPFORWARDFILE     920
//    #define ID_NAVIGATE_SKIPBACK            921
//    #define ID_NAVIGATE_SKIPFORWARD         922
//    #define ID_NAVIGATE_TITLEMENU           923
//    #define ID_NAVIGATE_ROOTMENU            924
//    #define ID_NAVIGATE_SUBPICTUREMENU      925
//    #define ID_NAVIGATE_AUDIOMENU           926
//    #define ID_NAVIGATE_ANGLEMENU           927
//    #define ID_NAVIGATE_CHAPTERMENU         928
//    #define ID_NAVIGATE_MENU_LEFT           929
//    #define ID_NAVIGATE_MENU_RIGHT          930
//    #define ID_NAVIGATE_MENU_UP             931
//    #define ID_NAVIGATE_MENU_DOWN           932
//    #define ID_NAVIGATE_MENU_ACTIVATE       933
//    #define ID_NAVIGATE_MENU_BACK           934
//    #define ID_NAVIGATE_MENU_LEAVE          935
//    #define ID_FAVORITES                    936
//    #define ID_FAVORITES_ORGANIZE           937
//    #define ID_FAVORITES_ADD                938
//    #define ID_HELP_HOMEPAGE                939
//    #define ID_HELP_DONATE                  940
//    #define ID_HELP_SHOWCOMMANDLINESWITCHES 941
//    #define ID_HELP_TOOLBARIMAGES           942
//    #define ID_HELP_ABOUT                   943
//    #define ID_BOSS                         944
//    #define ID_DUMMYSEPARATOR               945
//    #define ID_BUTTONSEP                    946
//    #define ID_AFTERPLAYBACK_PLAYNEXT       947
//    #define ID_AFTERPLAYBACK_DONOTHING      948
//    #define ID_MENU_PLAYER_SHORT            949
//    #define ID_MENU_PLAYER_LONG             950
//    #define ID_MENU_FILTERS                 951
//    #define ID_STREAM_AUDIO_NEXT            952
//    #define ID_STREAM_AUDIO_PREV            953
//    #define ID_STREAM_SUB_NEXT              954
//    #define ID_STREAM_SUB_PREV              955
//    #define ID_STREAM_SUB_ONOFF             956
//    #define ID_DVD_ANGLE_NEXT               961
//    #define ID_DVD_ANGLE_PREV               962
//    #define ID_DVD_AUDIO_NEXT               963
//    #define ID_DVD_AUDIO_PREV               964
//    #define ID_DVD_SUB_NEXT                 965
//    #define ID_DVD_SUB_PREV                 966
//    #define ID_DVD_SUB_ONOFF                967
//    #define ID_VIEW_ZOOM_AUTOFIT            968
//    #define ID_FILE_OPENQUICK               969
//    #define ID_VOLUME_BOOST_INC             970
//    #define ID_VOLUME_BOOST_DEC             971
//    #define ID_VOLUME_BOOST_MIN             972
//    #define ID_VOLUME_BOOST_MAX             973
//    #define ID_NAVIGATE_TUNERSCAN           974
//    #define ID_FAVORITES_QUICKADDFAVORITE   975
//    #define ID_FILE_REOPEN                  976
//    #define ID_FILTERS                      977
//    #define ID_AUDIOS                       978
//    #define ID_SUBTITLES                    979
//    #define ID_VIDEO_STREAMS                980
//    #define ID_COLOR_BRIGHTNESS_INC         984
//    #define ID_COLOR_BRIGHTNESS_DEC         985
//    #define ID_COLOR_CONTRAST_INC           986
//    #define ID_COLOR_CONTRAST_DEC           987
//    #define ID_COLOR_HUE_INC                988
//    #define ID_COLOR_HUE_DEC                989
//    #define ID_COLOR_SATURATION_INC         990
//    #define ID_COLOR_SATURATION_DEC         991
//    #define ID_COLOR_RESET                  992
//    #define ID_CUSTOM_CHANNEL_MAPPING       993
//    #define ID_NORMALIZE                    994
//    #define ID_REGAIN_VOLUME                995
//    #define ID_PLAY_SEEKSET                 996
//    #define ID_PANSCAN_ROTATEZ270           997
//    #define ID_FILTERS_COPY_TO_CLIPBOARD    1999
//    #define ID_FILTERS_SUBITEM_START        2000
//    #define ID_FILTERS_SUBITEM_END          2099
//    #define ID_FILTERSTREAMS_SUBITEM_START  2100
//    #define ID_FILTERSTREAMS_SUBITEM_END    2199
//    #define ID_AUDIO_SUBITEM_START          2200
//    #define ID_AUDIO_SUBITEM_END            2299
//    #define ID_SUBTITLES_SUBITEM_START      2300
//    #define ID_SUBTITLES_SUBITEM_END        2399
//    #define ID_VIDEO_STREAMS_SUBITEM_START  2400
//    #define ID_VIDEO_STREAMS_SUBITEM_END    2499
//    #define ID_FAVORITES_FILE_START         2800
//    #define ID_FAVORITES_FILE_END           3799
//    #define ID_FAVORITES_DVD_START          3800
//    #define ID_FAVORITES_DVD_END            3899
//    #define ID_FAVORITES_DEVICE_START       3900
//    #define ID_FAVORITES_DEVICE_END         3999
//    #define ID_FILE_OPEN_OPTICAL_DISK_START 4000
//    #define ID_FILE_OPEN_OPTICAL_DISK_END   4099
//    #define ID_PANNSCAN_PRESETS_START       4100
//    #define ID_PANNSCAN_PRESETS_END         4199
//    #define ID_SHADERS_SELECT               4200
//    #define ID_SHADERS_PRESETS_START        4201
//    #define ID_SHADERS_PRESETS_END          4299
//    #define ID_NAVIGATE_JUMPTO_SUBITEM_START 4300
//    #define ID_NAVIGATE_JUMPTO_SUBITEM_END  4899
//    #define ID_VIEW_ZOOM_AUTOFIT_LARGER     4900
}