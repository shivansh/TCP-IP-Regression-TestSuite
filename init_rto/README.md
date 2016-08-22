# Test for init_rto

## Status
|         Name          | Result(FreeBSD) |
|:---------------------:|:---------------:|
[init_rto](init_rto.pkt)| Passed

## Description
Log for the test run -
```
script packet:  1.100000 S. 0:0(0) ack 1 win 65535
actual packet:  3.124121 S. 0:0(0) ack 1 win 65535 <mss 1460,nop,wscale 6,sackOK,eol,eol>
```
**TODO** Check the value of `TCP_SYNQ_INTERVAL` [here](http://fxr.watson.org/fxr/source/include/net/tcp.h?v=linux-2.4.22#L356).
The value of `HZ` is supposedly 1000 and `TCP_SYNQ_INTERVAL` is 200ms (**HZ/5**).

## Result
The retransmission timeout value for **SYN-ACK** is 3 seconds.
