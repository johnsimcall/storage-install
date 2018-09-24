// Script File Name : postCMOS.sce
// Created on 09/06/18 at 11:02:17    
// Copyright (c)2016 American Megatrends, Inc.
// AMISCE Utility. Ver 5.02.1097

HIICrc32= 40E57483

Setup Question	= PCH CRID
Map String	= PCH015
Token	=44	// Do NOT change this line
Offset	=EA
Width	=01
BIOS Default	=[00]Disabled
Options	=*[00]Disabled	// Move "*" to the desired Option
         [01]Enabled

Setup Question	= USB Precondition
Map String	= PCH016
Token	=45	// Do NOT change this line
Offset	=128
Width	=01
BIOS Default	=[00]Disabled
Options	=[01]Enabled	// Move "*" to the desired Option
         *[00]Disabled

Setup Question	= xHCI Mode
Map String	= PCH017
Token	=46	// Do NOT change this line
Offset	=10E
Width	=01
BIOS Default	=[02]Auto
Options	=[03]Smart Auto	// Move "*" to the desired Option
         *[02]Auto
         [01]Enabled
         [00]Disabled

Setup Question	= SATA Controller
Map String	= PCH15C
Token	=7C	// Do NOT change this line
Offset	=12B
Width	=01
BIOS Default	=[01]Enabled
Options	=[00]Disabled	// Move "*" to the desired Option
         *[01]Enabled

Setup Question	= Configure SATA as
Map String	= PCH04D
Token	=7D	// Do NOT change this line
Offset	=12C
Width	=01
BIOS Default	=[01]AHCI
Options	=[00]IDE	// Move "*" to the desired Option
         *[01]AHCI
         [02]RAID

Setup Question	=   Port 0
Map String	= PCH053
Token	=84	// Do NOT change this line
Offset	=12E
Width	=01
BIOS Default	=[01]Enabled
Options	=[00]Disabled	// Move "*" to the desired Option
         *[01]Enabled

Setup Question	=   Hot Plug
Map String	= PCH059
Token	=85	// Do NOT change this line
Offset	=134
Width	=01
BIOS Default	=[00]Disabled
Options	=*[00]Disabled	// Move "*" to the desired Option
         [01]Enabled

Setup Question	=   Spin Up Device
Map String	= PCH065
Token	=88	// Do NOT change this line
Offset	=140
Width	=01
BIOS Default	=[00]Disabled
Options	=*[00]Disabled	// Move "*" to the desired Option
         [01]Enabled

Setup Question	=   Port 1
Map String	= PCH054
Token	=8A	// Do NOT change this line
Offset	=12F
Width	=01
BIOS Default	=[01]Enabled
Options	=[00]Disabled	// Move "*" to the desired Option
         *[01]Enabled

Setup Question	=   Hot Plug
Map String	= PCH05A
Token	=8B	// Do NOT change this line
Offset	=135
Width	=01
BIOS Default	=[00]Disabled
Options	=*[00]Disabled	// Move "*" to the desired Option
         [01]Enabled

Setup Question	=   Spin Up Device
Map String	= PCH066
Token	=8E	// Do NOT change this line
Offset	=141
Width	=01
BIOS Default	=[00]Disabled
Options	=*[00]Disabled	// Move "*" to the desired Option
         [01]Enabled

Setup Question	=   Port 2
Map String	= PCH055
Token	=90	// Do NOT change this line
Offset	=130
Width	=01
BIOS Default	=[01]Enabled
Options	=[00]Disabled	// Move "*" to the desired Option
         *[01]Enabled

Setup Question	=   Hot Plug
Map String	= PCH05B
Token	=91	// Do NOT change this line
Offset	=136
Width	=01
BIOS Default	=[00]Disabled
Options	=*[00]Disabled	// Move "*" to the desired Option
         [01]Enabled

Setup Question	=   Spin Up Device
Map String	= PCH067
Token	=94	// Do NOT change this line
Offset	=142
Width	=01
BIOS Default	=[00]Disabled
Options	=*[00]Disabled	// Move "*" to the desired Option
         [01]Enabled

Setup Question	=   Port 3
Map String	= PCH056
Token	=96	// Do NOT change this line
Offset	=131
Width	=01
BIOS Default	=[01]Enabled
Options	=[00]Disabled	// Move "*" to the desired Option
         *[01]Enabled

Setup Question	=   Hot Plug
Map String	= PCH05C
Token	=97	// Do NOT change this line
Offset	=137
Width	=01
BIOS Default	=[00]Disabled
Options	=*[00]Disabled	// Move "*" to the desired Option
         [01]Enabled

Setup Question	=   Spin Up Device
Map String	= PCH068
Token	=9A	// Do NOT change this line
Offset	=143
Width	=01
BIOS Default	=[00]Disabled
Options	=*[00]Disabled	// Move "*" to the desired Option
         [01]Enabled

Setup Question	=   Port 4
Map String	= PCH057
Token	=9C	// Do NOT change this line
Offset	=132
Width	=01
BIOS Default	=[01]Enabled
Options	=[00]Disabled	// Move "*" to the desired Option
         *[01]Enabled

Setup Question	=   Hot Plug
Map String	= PCH05D
Token	=9D	// Do NOT change this line
Offset	=138
Width	=01
BIOS Default	=[00]Disabled
Options	=*[00]Disabled	// Move "*" to the desired Option
         [01]Enabled

Setup Question	=   Spin Up Device
Map String	= PCH069
Token	=A0	// Do NOT change this line
Offset	=144
Width	=01
BIOS Default	=[00]Disabled
Options	=*[00]Disabled	// Move "*" to the desired Option
         [01]Enabled

Setup Question	=   Hot Plug
Map String	= PCH05E
Token	=A3	// Do NOT change this line
Offset	=139
Width	=01
BIOS Default	=[00]Disabled
Options	=*[00]Disabled	// Move "*" to the desired Option
         [01]Enabled

Setup Question	=   Spin Up Device
Map String	= PCH06A
Token	=A6	// Do NOT change this line
Offset	=145
Width	=01
BIOS Default	=[00]Disabled
Options	=*[00]Disabled	// Move "*" to the desired Option
         [01]Enabled

Setup Question	= sSATA Controller
Map String	= PCH075
Token	=B3	// Do NOT change this line
Offset	=169
Width	=01
BIOS Default	=[01]Enabled
Options	=*[01]Enabled	// Move "*" to the desired Option
         [00]Disabled

Setup Question	= Configure sSATA as
Map String	= PCH076
Token	=B4	// Do NOT change this line
Offset	=16A
Width	=01
BIOS Default	=[01]AHCI
Options	=[00]IDE	// Move "*" to the desired Option
         *[01]AHCI
         [02]RAID

Setup Question	=   Port 0
Map String	= PCH07B
Token	=BB	// Do NOT change this line
Offset	=16C
Width	=01
BIOS Default	=[01]Enabled
Options	=[00]Disabled	// Move "*" to the desired Option
         *[01]Enabled

Setup Question	=   Hot Plug
Map String	= PCH083
Token	=BC	// Do NOT change this line
Offset	=172
Width	=01
BIOS Default	=[00]Disabled
Options	=*[00]Disabled	// Move "*" to the desired Option
         [01]Enabled

Setup Question	=   Spin Up Device
Map String	= PCH08D
Token	=BF	// Do NOT change this line
Offset	=17B
Width	=01
BIOS Default	=[00]Disabled
Options	=*[00]Disabled	// Move "*" to the desired Option
         [01]Enabled

Setup Question	=   Port 1
Map String	= PCH080
Token	=C1	// Do NOT change this line
Offset	=16D
Width	=01
BIOS Default	=[01]Enabled
Options	=[00]Disabled	// Move "*" to the desired Option
         *[01]Enabled

Setup Question	=   Hot Plug
Map String	= PCH084
Token	=C2	// Do NOT change this line
Offset	=173
Width	=01
BIOS Default	=[00]Disabled
Options	=*[00]Disabled	// Move "*" to the desired Option
         [01]Enabled

Setup Question	=   Spin Up Device
Map String	= PCH08E
Token	=C5	// Do NOT change this line
Offset	=17C
Width	=01
BIOS Default	=[00]Disabled
Options	=*[00]Disabled	// Move "*" to the desired Option
         [01]Enabled

Setup Question	=   Port 2
Map String	= PCH081
Token	=C7	// Do NOT change this line
Offset	=16E
Width	=01
BIOS Default	=[01]Enabled
Options	=[00]Disabled	// Move "*" to the desired Option
         *[01]Enabled

Setup Question	=   Hot Plug
Map String	= PCH085
Token	=C8	// Do NOT change this line
Offset	=174
Width	=01
BIOS Default	=[00]Disabled
Options	=*[00]Disabled	// Move "*" to the desired Option
         [01]Enabled

Setup Question	=   Spin Up Device
Map String	= PCH08F
Token	=CB	// Do NOT change this line
Offset	=17D
Width	=01
BIOS Default	=[00]Disabled
Options	=*[00]Disabled	// Move "*" to the desired Option
         [01]Enabled

Setup Question	=   Port 3
Map String	= PCH082
Token	=CD	// Do NOT change this line
Offset	=16F
Width	=01
BIOS Default	=[01]Enabled
Options	=[00]Disabled	// Move "*" to the desired Option
         *[01]Enabled

Setup Question	=   Hot Plug
Map String	= PCH086
Token	=CE	// Do NOT change this line
Offset	=175
Width	=01
BIOS Default	=[00]Disabled
Options	=*[00]Disabled	// Move "*" to the desired Option
         [01]Enabled

Setup Question	=   Spin Up Device
Map String	= PCH090
Token	=D0	// Do NOT change this line
Offset	=17E
Width	=01
BIOS Default	=[00]Disabled
Options	=*[00]Disabled	// Move "*" to the desired Option
         [01]Enabled

Setup Question	= Isoc Mode
Map String	= CMRF006
Token	=19F	// Do NOT change this line
Offset	=F7C
Width	=01
BIOS Default	=[00]Disable
Options	=*[00]Disable	// Move "*" to the desired Option
         [01]Enable
         [02]Auto

Setup Question	= Numa
Map String	= CMRF008
Token	=1A1	// Do NOT change this line
Offset	=F7E
Width	=01
BIOS Default	=[01]Enable
Options	=[00]Disable	// Move "*" to the desired Option
         *[01]Enable

Setup Question	= Link Frequency Select
Map String	= QPI01B
Token	=1A7	// Do NOT change this line
Offset	=1014
Width	=01
BIOS Default	=[05]9.6GB/s
Options	=[01]6.4GB/s	// Move "*" to the desired Option
         [03]8.0GB/s
         *[05]9.6GB/s
         [06]Auto
         [07]Auto Limited

Setup Question	= Home Dir Snoop with IVT- Style OSB Enable
Map String	= QPI0F5
Token	=1B5	// Do NOT change this line
Offset	=1648
Width	=01
BIOS Default	=[02]Auto
Options	=[00]Disable	// Move "*" to the desired Option
         [01]Enable
         *[02]Auto

Setup Question	= EV DFX Features
Map String	= IIO007
Token	=216	// Do NOT change this line
Offset	=C1E
Width	=01
BIOS Default	=[00]Disable
Options	=*[00]Disable	// Move "*" to the desired Option
         [01]Enable

Setup Question	= Intel VT for Directed I/O (VT-d)
Map String	= IIO152
Token	=29B	// Do NOT change this line
Offset	=2E8
Width	=01
BIOS Default	=[00]Disable
Options	=[01]Enable	// Move "*" to the desired Option
         *[00]Disable

Setup Question	= Enable IOAT
Map String	= IIO15C
Token	=2AC	// Do NOT change this line
Offset	=B66
Width	=01
BIOS Default	=[00]Disable
Options	=*[00]Disable	// Move "*" to the desired Option
         [01]Enable

Setup Question	= No Snoop
Map String	= IIO15D
Token	=2AD	// Do NOT change this line
Offset	=B67
Width	=01
BIOS Default	=[00]Disable
Options	=*[00]Disable	// Move "*" to the desired Option
         [01]Enable

Setup Question	= System Errors
Map String	= EVLG010
Token	=AFB	// Do NOT change this line
Offset	=2A1
Width	=01
BIOS Default	=[01]Enable
Options	=[00]Disable	// Move "*" to the desired Option
         *[01]Enable

Setup Question	= S/W Error Injection Support 
Map String	= EVLG027
Token	=AFD	// Do NOT change this line
Offset	=2BA
Width	=01
BIOS Default	=[00]Disable
Options	=*[00]Disable	// Move "*" to the desired Option
         [01]Enable

Setup Question	= PCI-Ex Error Enable
Map String	= EVLG01F
Token	=1680	// Do NOT change this line
Offset	=2CE
Width	=01
BIOS Default	=[00]no
Options	=*[00]no	// Move "*" to the desired Option
         [01]yes

Setup Question	= WHEA Support
Map String	= EVLG011
Token	=B24	// Do NOT change this line
Offset	=2AB
Width	=01
BIOS Default	=[01]Enable
Options	=[00]Disable	// Move "*" to the desired Option
         *[01]Enable

Setup Question	= Uncorrected Error disable Memory
Map String	= EVLG160
Token	=B2A	// Do NOT change this line
Offset	=2BB
Width	=01
BIOS Default	=[00]Disable
Options	=*[00]Disable	// Move "*" to the desired Option
         [01]Enable

Setup Question	= Memory corrected Error enbaling
Map String	= EVLG024
Token	=B2B	// Do NOT change this line
Offset	=2B6
Width	=01
BIOS Default	=[00]Disable
Options	=*[00]Disable	// Move "*" to the desired Option
         [01]Enable

Setup Question	= Enforce POR
Map String	= MEM000
Token	=B2E	// Do NOT change this line
Offset	=1133
Width	=01
BIOS Default	=[02]Disabled
Options	=[00]Enforce POR	// Move "*" to the desired Option
         *[02]Disabled

Setup Question	= Memory Frequency
Map String	= MEM001
Token	=B31	// Do NOT change this line
Offset	=10E7
Width	=01
BIOS Default	=[00]Auto
Options	=*[00]Auto	// Move "*" to the desired Option
         [05]1333
         [07]1600
         [09]1867
         [0B]2133
         [0D]2400

Setup Question	= ECC Support
Map String	= MEM007
Token	=B38	// Do NOT change this line
Offset	=109E
Width	=01
BIOS Default	=[02]Auto
Options	=*[02]Auto	// Move "*" to the desired Option
         [00]Disable
         [01]Enable

Setup Question	= Rank Margin Tool
Map String	= MEM014
Token	=B4A	// Do NOT change this line
Offset	=1127
Width	=01
BIOS Default	=[02]Auto
Options	=*[02]Auto	// Move "*" to the desired Option
         [00]Disabled
         [01]Enabled

Setup Question	= RMT Pattern Length
Map String	= MEM015
Token	=B4B	// Do NOT change this line
Offset	=10ED
Width	=04
BIOS Default	=7FFF
Value	=7FFF

Setup Question	= Enable ADR
Map String	= MEM021
Token	=B63	// Do NOT change this line
Offset	=1125
Width	=01
BIOS Default	=[00]Disabled
Options	=*[00]Disabled	// Move "*" to the desired Option
         [01]Hardware Triggered ADR

Setup Question	= Set Throttling Mode
Map String	= MEM059
Token	=BA2	// Do NOT change this line
Offset	=10C7
Width	=01
BIOS Default	=[02]CLTT
Options	=[00]Disabled	// Move "*" to the desired Option
         *[02]CLTT

Setup Question	= MEMHOT Throttling Mode
Map String	= MEM060
Token	=BA9	// Do NOT change this line
Offset	=1124
Width	=01
BIOS Default	=[02]Input-only
Options	=[00]Disabled	// Move "*" to the desired Option
         [01]Output-only
         *[02]Input-only

Setup Question	= Socket Interleave Below 4GB
Map String	= MEM076
Token	=BC0	// Do NOT change this line
Offset	=109F
Width	=01
BIOS Default	=[00]Disable
Options	=*[00]Disable	// Move "*" to the desired Option
         [01]Enable

Setup Question	= Channel Interleaving
Map String	= MEM077
Token	=BC1	// Do NOT change this line
Offset	=10A0
Width	=01
BIOS Default	=[00]Auto
Options	=*[00]Auto	// Move "*" to the desired Option
         [01]1-way Interleave
         [02]2-way Interleave
         [03]3-way Interleave
         [04]4-way Interleave

Setup Question	= Rank Interleaving
Map String	= MEM079
Token	=BC2	// Do NOT change this line
Offset	=10A1
Width	=01
BIOS Default	=[00]Auto
Options	=*[00]Auto	// Move "*" to the desired Option
         [01]1-way Interleave
         [02]2-way Interleave
         [04]4-way Interleave
         [08]8-way Interleave

Setup Question	= RAS Mode
Map String	= MEM07C
Token	=BC5	// Do NOT change this line
Offset	=11CE
Width	=01
BIOS Default	=[00]Disable
Options	=*[00]Disable	// Move "*" to the desired Option
         [01]Mirror
         [02]Lockstep Mode

Setup Question	= Lockstep x4 DIMMs
Map String	= MEM07E
Token	=BC6	// Do NOT change this line
Offset	=112F
Width	=01
BIOS Default	=[02]Auto
Options	=*[02]Auto	// Move "*" to the desired Option
         [00]Disabled
         [01]Enabled

Setup Question	= Memory Rank Sparing
Map String	= MEM07F
Token	=BC7	// Do NOT change this line
Offset	=1129
Width	=01
BIOS Default	=[00]Disabled
Options	=*[00]Disabled	// Move "*" to the desired Option
         [01]Enabled

Setup Question	= Correctable Error Threshold
Map String	= MEM081
Token	=BC9	// Do NOT change this line
Offset	=1067
Width	=02
BIOS Default	=1
Value	=1

Setup Question	= Execute Disable Bit
Map String	= PRC0F2
Token	=BE7	// Do NOT change this line
Offset	=61
Width	=01
BIOS Default	=[01]Enable
Options	=[00]Disable	// Move "*" to the desired Option
         *[01]Enable

Setup Question	= Enable Intel TXT Support
Map String	= PRC0EB
Token	=BE8	// Do NOT change this line
Offset	=71
Width	=01
BIOS Default	=[00]Disable
Options	=*[00]Disable	// Move "*" to the desired Option
         [01]Enable

Setup Question	= VMX
Map String	= PRC0EC
Token	=BE9	// Do NOT change this line
Offset	=72
Width	=01
BIOS Default	=[01]Enable
Options	=[00]Disable	// Move "*" to the desired Option
         *[01]Enable

Setup Question	= Enable SMX
Map String	= PRC0ED
Token	=BEA	// Do NOT change this line
Offset	=73
Width	=01
BIOS Default	=[00]Disable
Options	=*[00]Disable	// Move "*" to the desired Option
         [01]Enable

Setup Question	= Hardware Prefetcher
Map String	= PRC0F7
Token	=BEF	// Do NOT change this line
Offset	=81
Width	=01
BIOS Default	=[01]Enable
Options	=*[01]Enable	// Move "*" to the desired Option
         [00]Disable

Setup Question	= Adjacent Cache Prefetch
Map String	= PRC0F8
Token	=BF0	// Do NOT change this line
Offset	=82
Width	=01
BIOS Default	=[01]Enable
Options	=*[01]Enable	// Move "*" to the desired Option
         [00]Disable

Setup Question	= DCU Streamer Prefetcher
Map String	= PRC0F9
Token	=BF1	// Do NOT change this line
Offset	=83
Width	=01
BIOS Default	=[01]Enable
Options	=*[01]Enable	// Move "*" to the desired Option
         [00]Disable

Setup Question	= DCU IP Prefetcher
Map String	= PRC0FA
Token	=BF2	// Do NOT change this line
Offset	=84
Width	=01
BIOS Default	=[01]Enable
Options	=*[01]Enable	// Move "*" to the desired Option
         [00]Disable

Setup Question	= DCU Mode
Map String	= PRC101
Token	=BF3	// Do NOT change this line
Offset	=85
Width	=01
BIOS Default	=[00]32KB 8Way Without ECC
Options	=*[00]32KB 8Way Without ECC	// Move "*" to the desired Option
         [01]16KB 4Way With ECC

Setup Question	= Direct Cache Access (DCA)
Map String	= PRC0E8
Token	=BF7	// Do NOT change this line
Offset	=7F
Width	=01
BIOS Default	=[02]Auto
Options	=[00]Disable	// Move "*" to the desired Option
         [01]Enable
         *[02]Auto

Setup Question	= DCA Prefetch Delay
Map String	= PRC0E9
Token	=BF8	// Do NOT change this line
Offset	=80
Width	=01
BIOS Default	=[04]32
Options	=[00]Disable	// Move "*" to the desired Option
         [01]8
         [02]16
         [03]24
         *[04]32
         [05]40
         [06]48
         [07]56
         [08]64
         [09]72
         [0A]80
         [0B]88
         [0C]96
         [0D]104
         [0E]112

Setup Question	= X2APIC
Map String	= PRC0F4
Token	=BFA	// Do NOT change this line
Offset	=86
Width	=01
BIOS Default	=[00]Disable
Options	=*[00]Disable	// Move "*" to the desired Option
         [01]Enable

Setup Question	= AES-NI
Map String	= PRC0F5
Token	=BFC	// Do NOT change this line
Offset	=B0
Width	=01
BIOS Default	=[01]Enable
Options	=[00]Disable	// Move "*" to the desired Option
         *[01]Enable

Setup Question	= Cores Enabled
Map String	= PRC11B
Token	=2850	// Do NOT change this line
Offset	=9E
Width	=01
BIOS Default	=0
Value	=0

Setup Question	= Cores Enabled
Map String	= PRC11B
Token	=2851	// Do NOT change this line
Offset	=9F
Width	=01
BIOS Default	=0
Value	=0

Setup Question	= MCTP Bus Owner
Map String	= ME001
Token	=C11	// Do NOT change this line
Offset	=116A
Width	=02
BIOS Default	=0
Value	=0

Setup Question	= Power Technology
Map String	= PRC0003
Token	=2800	// Do NOT change this line
Offset	=11F4
Width	=01
BIOS Default	=[02]Custom
Options	=[00]Disable	// Move "*" to the desired Option
         [01]Energy Efficient
         *[02]Custom

Setup Question	= EIST (P-states)
Map String	= PRC000E
Token	=C63	// Do NOT change this line
Offset	=62
Width	=01
BIOS Default	=[00]Disable
Options	=*[00]Disable	// Move "*" to the desired Option
         [01]Enable

Setup Question	= CPU C State
Map String	= PRC02E
Token	=C87	// Do NOT change this line
Offset	=68
Width	=01
BIOS Default	=[01]Enable
Options	=[00]Disable	// Move "*" to the desired Option
         *[01]Enable

Setup Question	= Package C State limit
Map String	= PRC02F
Token	=C88	// Do NOT change this line
Offset	=6B
Width	=01
BIOS Default	=[00]C0/C1 state
Options	=*[00]C0/C1 state	// Move "*" to the desired Option
         [01]C2 state
         [02]C6(non Retention) state
         [03]C6(Retention) state

Setup Question	= CPU C3 report
Map String	= PRC030
Token	=C89	// Do NOT change this line
Offset	=6C
Width	=01
BIOS Default	=[00]Disable
Options	=*[00]Disable	// Move "*" to the desired Option
         [01]Enable

Setup Question	= CPU C6 report
Map String	= PRC031
Token	=C8A	// Do NOT change this line
Offset	=6D
Width	=01
BIOS Default	=[00]Disable
Options	=*[00]Disable	// Move "*" to the desired Option
         [01]Enable

Setup Question	= Enhanced Halt State (C1E)
Map String	= PRC032
Token	=C8B	// Do NOT change this line
Offset	=6F
Width	=01
BIOS Default	=[01]Enable
Options	=[00]Disable	// Move "*" to the desired Option
         *[01]Enable

Setup Question	= ACPI T-States
Map String	= PRC0C8
Token	=C8D	// Do NOT change this line
Offset	=AA
Width	=01
BIOS Default	=[01]Enable
Options	=[00]Disable	// Move "*" to the desired Option
         *[01]Enable

Setup Question	= Turbo Mode
Map String	= PRC00F
Token	=D23	// Do NOT change this line
Offset	=B3
Width	=01
BIOS Default	=[00]Disable
Options	=*[00]Disable	// Move "*" to the desired Option
         [01]Enable

Setup Question	= FRB-2 Timer
Map String	= IPMI100
Token	=03	// Do NOT change this line
Offset	=08
Width	=01
BIOS Default	=[00]Disabled
Options	=[01]Enabled	// Move "*" to the desired Option
         *[00]Disabled

Setup Question	= FRB-2 Timer timeout
Map String	= IPMI101
Token	=04	// Do NOT change this line
Offset	=09
Width	=02
BIOS Default	=[168]6 minutes
Options	=[B4]3 minutes	// Move "*" to the desired Option
         [F0]4 minutes
         [12C]5 minutes
         *[168]6 minutes

Setup Question	= FRB-2 Timer Policy
Map String	= IPMI102
Token	=05	// Do NOT change this line
Offset	=0B
Width	=01
BIOS Default	=[00]Do Nothing
Options	=*[00]Do Nothing	// Move "*" to the desired Option
         [01]Reset
         [02]Power Down
         [03]Power Cycle

Setup Question	= OS Watchdog Timer
Map String	= IPMI103
Token	=06	// Do NOT change this line
Offset	=0C
Width	=01
BIOS Default	=[00]Disabled
Options	=[01]Enabled	// Move "*" to the desired Option
         *[00]Disabled

Setup Question	= OS Wtd Timer Timeout
Map String	= IPMI104
Token	=07	// Do NOT change this line
Offset	=0D
Width	=02
BIOS Default	=[258]10 minutes
Options	=[12C]5 minutes	// Move "*" to the desired Option
         *[258]10 minutes
         [384]15 minutes
         [4B0]20 minutes

Setup Question	= OS Wtd Timer Policy
Map String	= IPMI105
Token	=08	// Do NOT change this line
Offset	=0F
Width	=01
BIOS Default	=[01]Reset
Options	=[00]Do Nothing	// Move "*" to the desired Option
         *[01]Reset
         [02]Power Down
         [03]Power Cycle

Setup Question	= SEL Components
Map String	= IPMI000
Token	=0A	// Do NOT change this line
Offset	=02
Width	=01
BIOS Default	=[01]Enabled
Options	=[00]Disabled	// Move "*" to the desired Option
         *[01]Enabled

Setup Question	= Erase SEL
Map String	= IPMI001
Token	=0B	// Do NOT change this line
Offset	=03
Width	=01
BIOS Default	=[00]No
Options	=*[00]No	// Move "*" to the desired Option
         [01]Yes, On next reset
         [02]Yes, On every reset

Setup Question	= When SEL is Full
Map String	= IPMI002
Token	=0C	// Do NOT change this line
Offset	=04
Width	=01
BIOS Default	=[00]Do Nothing
Options	=*[00]Do Nothing	// Move "*" to the desired Option
         [01]Erase Immediately

Setup Question	= Log EFI Status Codes
Map String	= IPMI003
Token	=0D	// Do NOT change this line
Offset	=05
Width	=01
BIOS Default	=[02]Error code
Options	=[00]Disabled	// Move "*" to the desired Option
         [01]Both
         *[02]Error code
         [03]Progress code

Setup Question	= Configuration Address source
Map String	= IPMI500
Token	=0F	// Do NOT change this line
Offset	=12
Width	=01
BIOS Default	=[02]DynamicBmcDhcp
Options	=[00]Unspecified	// Move "*" to the desired Option
         [01]Static
         *[02]DynamicBmcDhcp

Setup Question	= Legacy Serial Redirection Port
Map String	= TER010
Token	=43	// Do NOT change this line
Offset	=3E
Width	=01
BIOS Default	=[00]COM1
Options	=*[00]COM1	// Move "*" to the desired Option
         [01]COM2/Serial Over LAN

Setup Question	= PCI Latency Timer
Map String	= PCIS001
Token	=6A	// Do NOT change this line
Offset	=41
Width	=01
BIOS Default	=[20]32 PCI Bus Clocks
Options	=*[20]32 PCI Bus Clocks	// Move "*" to the desired Option
         [40]64 PCI Bus Clocks
         [60]96 PCI Bus Clocks
         [80]128 PCI Bus Clocks
         [A0]160 PCI Bus Clocks
         [C0]192 PCI Bus Clocks
         [E0]224 PCI Bus Clocks
         [F8]248 PCI Bus Clocks

Setup Question	= VGA Palette Snoop
Map String	= PCIS003
Token	=6C	// Do NOT change this line
Offset	=42
Width	=01
BIOS Default	=[00]Disabled
Options	=*[00]Disabled	// Move "*" to the desired Option
         [01]Enabled

Setup Question	= Above 4G Decoding
Map String	= PCIS006
Token	=6F	// Do NOT change this line
Offset	=3F
Width	=01
BIOS Default	=[00]Disabled
Options	=*[00]Disabled	// Move "*" to the desired Option
         [01]Enabled

Setup Question	= SR-IOV Support
Map String	= PCIS007
Token	=70	// Do NOT change this line
Offset	=40
Width	=01
BIOS Default	=[00]Disabled
Options	=*[00]Disabled	// Move "*" to the desired Option
         [01]Enabled

Setup Question	= Relaxed Ordering
Map String	= PCIS008
Token	=74	// Do NOT change this line
Offset	=46
Width	=01
BIOS Default	=[00]Disabled
Options	=*[00]Disabled	// Move "*" to the desired Option
         [01]Enabled

Setup Question	= Extended Tag
Map String	= PCIS009
Token	=75	// Do NOT change this line
Offset	=47
Width	=01
BIOS Default	=[00]Disabled
Options	=*[00]Disabled	// Move "*" to the desired Option
         [01]Enabled

Setup Question	= No Snoop
Map String	= PCIS010
Token	=76	// Do NOT change this line
Offset	=48
Width	=01
BIOS Default	=[01]Enabled
Options	=[00]Disabled	// Move "*" to the desired Option
         *[01]Enabled

Setup Question	= Maximum Payload
Map String	= PCIS011
Token	=77	// Do NOT change this line
Offset	=49
Width	=01
BIOS Default	=[37]Auto
Options	=*[37]Auto	// Move "*" to the desired Option
         [00]128 Bytes
         [01]256 Bytes
         [02]512 Bytes
         [03]1024 Bytes
         [04]2048 Bytes
         [05]4096 Bytes

Setup Question	= Extended Synch
Map String	= PCIS014
Token	=7A	// Do NOT change this line
Offset	=4C
Width	=01
BIOS Default	=[00]Disabled
Options	=*[00]Disabled	// Move "*" to the desired Option
         [01]Enabled

Setup Question	= Link Training Retry
Map String	= PCIS015
Token	=7B	// Do NOT change this line
Offset	=4D
Width	=01
BIOS Default	=[05]5
Options	=[00]Disabled	// Move "*" to the desired Option
         [02]2
         [03]3
         *[05]5

Setup Question	= Link Training Timeout (uS)
Map String	= PCIS016
Token	=7C	// Do NOT change this line
Offset	=4E
Width	=02
BIOS Default	=3E8
Value	=3E8

Setup Question	= Network Stack
Map String	= NWSK000
Token	=92	// Do NOT change this line
Offset	=00
Width	=01
BIOS Default	=[00]Disabled
Options	=*[00]Disabled	// Move "*" to the desired Option
         [01]Enabled

Setup Question	= CSM Support
Map String	= CSM004
Token	=2737	// Do NOT change this line
Offset	=69
Width	=01
BIOS Default	=[01]Enabled
Options	=[00]Disabled	// Move "*" to the desired Option
         *[01]Enabled

Setup Question	= GateA20 Active
Map String	= CSM001
Token	=97	// Do NOT change this line
Offset	=6D
Width	=01
BIOS Default	=[00]Upon Request
Options	=*[00]Upon Request	// Move "*" to the desired Option
         [01]Always

Setup Question	= Option ROM Messages
Map String	= CSM000
Token	=98	// Do NOT change this line
Offset	=6A
Width	=01
BIOS Default	=[01]Force BIOS
Options	=*[01]Force BIOS	// Move "*" to the desired Option
         [00]Keep Current

Setup Question	= INT19 Endless Retry
Map String	= CSM100
Token	=99	// Do NOT change this line
Offset	=6B
Width	=01
BIOS Default	=[01]Enabled
Options	=*[01]Enabled	// Move "*" to the desired Option
         [00]Disabled

Setup Question	= Boot option filter
Map String	= CSM005
Token	=9A	// Do NOT change this line
Offset	=6E
Width	=01
BIOS Default	=[00]UEFI and Legacy
Options	=*[00]UEFI and Legacy	// Move "*" to the desired Option
         [01]Legacy only
         [02]UEFI only

Setup Question	= Network
Map String	= CSM006
Token	=9B	// Do NOT change this line
Offset	=6F
Width	=01
BIOS Default	=[02]Legacy
Options	=[00]Do not launch	// Move "*" to the desired Option
         [01]UEFI
         *[02]Legacy

Setup Question	= Storage
Map String	= CSM007
Token	=9C	// Do NOT change this line
Offset	=70
Width	=01
BIOS Default	=[02]Legacy
Options	=[00]Do not launch	// Move "*" to the desired Option
         [01]UEFI
         *[02]Legacy

Setup Question	= Video
Map String	= CSM008
Token	=9D	// Do NOT change this line
Offset	=71
Width	=01
BIOS Default	=[02]Legacy
Options	=[00]Do not launch	// Move "*" to the desired Option
         [01]UEFI
         *[02]Legacy

Setup Question	= Other PCI devices
Map String	= CSM009
Token	=9E	// Do NOT change this line
Offset	=72
Width	=01
BIOS Default	=[01]UEFI
Options	=[00]Do not launch	// Move "*" to the desired Option
         *[01]UEFI
         [02]Legacy

Setup Question	= XHCI Hand-off
Map String	= USB003
Token	=A8	// Do NOT change this line
Offset	=1B
Width	=01
BIOS Default	=[01]Enabled
Options	=*[01]Enabled	// Move "*" to the desired Option
         [00]Disabled

Setup Question	= EHCI Hand-off
Map String	= USB004
Token	=A9	// Do NOT change this line
Offset	=02
Width	=01
BIOS Default	=[00]Disabled
Options	=*[00]Disabled	// Move "*" to the desired Option
         [01]Enabled

Setup Question	= USB Mass Storage Driver Support
Map String	= USB00F
Token	=AA	// Do NOT change this line
Offset	=1F
Width	=01
BIOS Default	=[01]Enabled
Options	=[00]Disabled	// Move "*" to the desired Option
         *[01]Enabled

Setup Question	= Port 60/64 Emulation
Map String	= USB00D
Token	=AB	// Do NOT change this line
Offset	=07
Width	=01
BIOS Default	=[01]Enabled
Options	=[00]Disabled	// Move "*" to the desired Option
         *[01]Enabled

Setup Question	= Secure Boot
Map String	= SECB001
Token	=2742	// Do NOT change this line
Offset	=00
Width	=01
BIOS Default	=[00]Disabled
Options	=*[00]Disabled	// Move "*" to the desired Option
         [01]Enabled

Setup Question	= Secure Boot Mode
Map String	= SECB002
Token	=2743	// Do NOT change this line
Offset	=01
Width	=01
BIOS Default	=[01]Custom
Options	=[00]Standard	// Move "*" to the desired Option
         *[01]Custom

Setup Question	= Provision Factory Default keys
Map String	= SECB008
Token	=2746	// Do NOT change this line
Offset	=02
Width	=01
BIOS Default	=[00]Disabled
Options	=*[00]Disabled	// Move "*" to the desired Option
         [01]Enabled

Setup Question	= Setup Prompt Timeout
Map String	= SETUP003
Token	=D8	// Do NOT change this line
Offset	=00
Width	=02
BIOS Default	=1
Value	=1

Setup Question	= Bootup NumLock State
Map String	= SETUP004
Token	=D9	// Do NOT change this line
Offset	=00
Width	=01
BIOS Default	=[01]On
Options	=*[01]On	// Move "*" to the desired Option
         [00]Off

Setup Question	= Quiet Boot
Map String	= SETUP005
Token	=DB	// Do NOT change this line
Offset	=50
Width	=01
BIOS Default	=1
Value	=1	// Enabled = 1, Disabled = 0
