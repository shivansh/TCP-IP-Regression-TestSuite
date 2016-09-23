# Tests for connection close

## Status
|                      Name                        | Result (FreeBSD)|
|:------------------------------------------------:|:---------------:|
[close-last-ack-lost](close-last-ack-lost.pkt)     |
[close-read-data-fin](close-read-data-fin.pkt)     | Passed
[close-write-data-ack](close-write-data-ack.pkt)   | Passed
[close-unread-data-ack](close-unread-data-ack.pkt) | Passed
[simultaneous-close](simultaneous-close.pkt)       | Passed

## Description

tcpdump trace for [close-last-ack-lost](close-last-ack-lost.pkt) -
```
tcpdump: verbose output suppressed, use -v or -vv for full protocol decode
listening on tun0, link-type NULL (BSD loopback), capture size 262144 bytes
00:00:00.000000 IP 192.0.2.1.22778 > 192.168.0.1.8080: Flags [S], seq 0, win 65535, options [mss 1460,sackOK,nop,nop,nop,wscale 7], length 0
00:00:00.000513 IP 192.168.0.1.8080 > 192.0.2.1.22778: Flags [S.], seq 4097435150, ack 1, win 65535, options [mss 1460,nop,wscale 6,sackOK,eol], length 0
00:00:00.000915 IP 192.0.2.1.22778 > 192.168.0.1.8080: Flags [.], ack 1, win 65535, length 0
00:00:00.002440 IP 192.0.2.1.22778 > 192.168.0.1.8080: Flags [F.], seq 1, ack 1, win 65535, length 0
00:00:00.000016 IP 192.168.0.1.8080 > 192.0.2.1.22778: Flags [.], ack 2, win 1026, length 0
00:00:00.000538 IP 192.168.0.1.8080 > 192.0.2.1.22778: Flags [F.], seq 1, ack 2, win 1026, length 0
00:00:00.000488 IP 192.0.2.1.22778 > 192.168.0.1.8080: Flags [R.], seq 2, ack 1, win 65535, length 0
```
