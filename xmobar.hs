Config { font = "xft:Helvetica-14"
       , bgColor = "black"
       , fgColor = "grey"
       , position = TopW L 95
       , commands = [ Run Weather "EGPF" ["-t"," <tempC>C","-L","64","-H","77","--normal","green","--high","red","--low","lightblue"] 36000
                    , Run Cpu ["-L","3","-H","50","--normal","green","--high","red"] 10
                    , Run Memory ["-t","Mem: <usedratio>%"] 10
                    , Run Swap [] 10
                    , Run Date "%a %b %_d %l:%M" "date" 10
                    , Run StdinReader
                    ]
       , sepChar = "%"
       , alignSep = "}{"
       , template = "%StdinReader% }{ %cpu% | %memory% * %swap%    <fc=#ee9a00>%date%</fc> | %EGPF%"
       }
