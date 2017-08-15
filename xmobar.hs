Config { font = "xft:Helvetica-14"
       , bgColor = "#262626"
       , fgColor = "grey"
       , position = TopW L 95
       , commands = [
        -- network activity monitor (dynamic interface resolution)
        Run DynNetwork     [ "--template" , "[<dev>] tx:<tx> rx:<rx>"
                             , "--Low"      , "1000"       -- units: kB/s
                             , "--High"     , "5000"       -- units: kB/s
                             , "--low"      , "darkgreen"
                             , "--normal"   , "darkorange"
                             , "--high"     , "darkred"
                             ] 10

        -- cpu activity monitor
        , Run MultiCpu       [ "--template" , "CPU: <total0>% : <total1>%"
                             , "--Low"      , "50"         -- units: %
                             , "--High"     , "85"         -- units: %
                             , "--low"      , "darkgreen"
                             , "--normal"   , "darkorange"
                             , "--high"     , "darkred"
                             ] 10

                    , Run Memory ["-t","Mem: <usedratio>%"] 10
                    , Run Swap [] 10
                    , Run Date "%a %b %_d %l:%M" "date" 10
                    , Run StdinReader
                    , Run Battery [ "--template" , "Batt: <acstatus>"
                                  , "--Low"      , "10"        -- units: %
                                  , "--High"     , "80"        -- units: %
                                  , "--low"      , "darkred"
                                  , "--normal"   , "darkorange"
                                  , "--high"     , "darkgreen"

                                  , "--" -- battery specific options
                                       -- discharging status
                                       , "-o"	, "<left>% (<timeleft>)"
                                       -- AC "on" status
                                       , "-O"	, "<fc=#dAA520>Charging</fc>"
                                       -- charged status
                                       , "-i"	, "<fc=#006000>Charged</fc>"
                                 ] 50
                    ]
       , sepChar = "%"
       , alignSep = "}{"
       , template = "%StdinReader% }{ %multicpu% %dynnetwork% | %memory% %swap%  <fc=#ee9a00>%date%</fc> | %battery%"
}
