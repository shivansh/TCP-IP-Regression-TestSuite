# Tests for connection close

## Status
|                      Name                        | Result (FreeBSD)|
|:------------------------------------------------:|:---------------:|
[close-read-data-fin](close-read-data-fin.pkt)     | Passed
[close-write-data-ack](close-write-data-ack.pkt)   | Passed
[close-unread-data-ack](close-unread-data-ack.pkt) | Passed
[simultaneous-close](simultaneous-close.pkt)       | Doubtful

## Description

* Simultaneous connection close can be visualised by -
![Simultaneous-Close](http://www.tcpipguide.com/free/diagrams/tcpclosesimul.png)<br>
However while testing, the server first has to acknowledge client's **FIN** before it can send out it's own **FIN**.
