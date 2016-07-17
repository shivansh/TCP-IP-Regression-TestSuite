# Test for Retransmission Timeout

## Status
|                       Name                        |  Result (FreeBSD)  |
|:-------------------------------------------------:|:------------------:|
[Retransmission Timeout](retransmission_timeout.pkt)|  Failed

## Description
After the receiver **SACK**s one out of five data segments, the sender should retransmit the segment starting from the next acknowledged segment number (in this case 1001:2001) after **RTO**. However, the sender again retransmits the previously retransmitted segment.<br>
```
script packet:  0.650000 . 1001:2001(1000) ack 1
actual packet:  0.632029 . 2001:3001(1000) ack 1 win 1031
```

## Todo
Add support for following `tcp_info` options in FreeBSD -

| Line  |  Name  |
:------:|:------:|
[u_int32_t](http://fxr.watson.org/fxr/source/netinet/tcp.h#L215)| `__tcpi_unacked`
[u_int32_t](http://fxr.watson.org/fxr/source/netinet/tcp.h#L216)| `__tcpi_sacked`
[u_int32_t](http://fxr.watson.org/fxr/source/netinet/tcp.h#L217)| `__tcpi_lost`
[u_int32_t](http://fxr.watson.org/fxr/source/netinet/tcp.h#L218)| `__tcpi_retrans`
