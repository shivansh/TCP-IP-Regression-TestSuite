# Test for Retransmission Timeout

## Status
|                       Name                        |  Result (FreeBSD)  |
|:-------------------------------------------------:|:------------------:|
[Retransmission Timeout](retransmission_timeout.pkt)|  Failed

## Description
* After the receiver sacks one out of five data segments, the sender should retransmit the segment starting from the next acknowledged segment number (in this case 1001:2001) after **RTO**. However, the sender again retransmits the previously retransmitted segment.<br>
```
script packet:  0.650000 . 1001:2001(1000) ack 1
actual packet:  0.632029 . 2001:3001(1000) ack 1 win 1031
```
