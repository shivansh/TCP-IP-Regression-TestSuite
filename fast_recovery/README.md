# Test for fast recovery

## Status
|              Name               |  Result (FreeBSD)  |
|:-------------------------------:|:------------------:|
[Fast-Recovery](fast-recovery.pkt)| Failed

## Description
```
0.330 > . 1:1001(1000) ack 1
0.330 > . 3001:4001(1000) ack 1
```
We cannot simultaneously retransmit multiple lost segments. After retransmitting the first segment, the sender waits for an ACK from the client and eventually retransmits again after the retransmission timeout.
