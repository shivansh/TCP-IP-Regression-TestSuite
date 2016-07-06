# Test for Path MTU Discovery

## Status

|            Name            | Result (FreeBSD) |
|:--------------------------:|:----------------:|
|[pmtu-10pkt](pmtu-10pkt.pkt)|     Failed       |

## Description
After writing 10 data segments, the receiver should send an ICMP message saying fragmentation is required.
```
0.250 < [1:1461(1460)] icmp unreachable frag_needed mtu 1500>
```
From the **MTU** specified in the ICMP message, sender should retransmit `cwnd` packets.<br>
However, everything runs smooth except that receiver never sends an ICMP message.

## Todo

* FreeBSD TUN device does not support TSO, check this test on separate machines using remote mode in packetdrill.
