# Test for fast recovery

## Status
|              Name               |  Result (FreeBSD)  |
|:-------------------------------:|:------------------:|
[Fast-Recovery](fast-recovery.pkt)| Failed

## Description
**NOTE :** The test is still incomplete.
After multiple segments are lost (non-continuous), the sender is supposed to retransmit as a result of 3 **dupacks**.
```
0.330 > . 1:1001(1000) ack 1
0.330 > . 3001:4001(1000) ack 1
```
However, we cannot simultaneously retransmit multiple lost segments, as in the case of [Linux](https://github.com/google/packetdrill/blob/master/gtests/net/packetdrill/tests/linux/fast_recovery/prr-ss-ack-below-snd_una-reno.pkt#L29). After retransmitting the first segment, the sender waits for an **ACK** from the client and eventually retransmits again after the retransmission timeout.
