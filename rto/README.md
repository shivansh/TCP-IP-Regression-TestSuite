# Test for Retransmission Timeout

## Status
|                       Name                        |  Result (FreeBSD)  |
|:-------------------------------------------------:|:------------------:|
[Retransmission Timeout](retransmission_timeout.pkt)| Verification Required

## Description
~~After the receiver **SACK**s one out of five data segments, the sender should retransmit the segment starting from the next acknowledged segment number (in this case 1001:2001) after **RTO**. However, the sender again retransmits the previously retransmitted segment.<br>~~

_tcpdump_ capture for the test -
```
listening on tun0, link-type NULL (BSD loopback), capture size 262144 bytes
16:23:37.426970 IP 192.0.2.1.13684 > 192.168.0.1.8080: Flags [S], seq 0, win 65535, options [mss 1000,sackOK,nop,nop,nop,wscale 7], length 0
16:23:37.427000 IP 192.168.0.1.8080 > 192.0.2.1.13684: Flags [S.], seq 3868403933, ack 1, win 65535, options [mss 1000,nop,wscale 6,sackOK,eol], length 0
16:23:37.428322 IP 192.0.2.1.13684 > 192.168.0.1.8080: Flags [.], ack 1, win 65535, length 0
16:23:37.430217 IP 192.168.0.1.8080 > 192.0.2.1.13684: Flags [.], seq 1:1001, ack 1, win 1031, length 1000: HTTP
16:23:37.430228 IP 192.168.0.1.8080 > 192.0.2.1.13684: Flags [.], seq 1001:2001, ack 1, win 1031, length 1000: HTTP
16:23:37.430234 IP 192.168.0.1.8080 > 192.0.2.1.13684: Flags [.], seq 2001:3001, ack 1, win 1031, length 1000: HTTP
16:23:37.430240 IP 192.168.0.1.8080 > 192.0.2.1.13684: Flags [.], seq 3001:4001, ack 1, win 1031, length 1000: HTTP
16:23:37.430246 IP 192.168.0.1.8080 > 192.0.2.1.13684: Flags [P.], seq 4001:5001, ack 1, win 1031, length 1000: HTTP
16:23:37.885964 IP6 :: > ff02::16: HBH ICMP6, multicast listener report v2, 2 group record(s), length 48
16:23:38.098184 IP6 :: > ff02::16: HBH ICMP6, multicast listener report v2, 1 group record(s), length 28
16:23:38.139486 IP6 :: > ff02::1:ffa0:b9e2: ICMP6, neighbor solicitation, who has fe80::a00:27ff:fea0:b9e2, length 32
16:23:39.793962 IP6 fe80::a00:27ff:fea0:b9e2 > ff02::16: HBH ICMP6, multicast listener report v2, 1 group record(s), length 28
16:23:40.429966 IP 192.168.0.1.8080 > 192.0.2.1.13684: Flags [.], seq 1:1001, ack 1, win 1031, length 1000: HTTP
16:23:40.455602 IP 192.0.2.1.13684 > 192.168.0.1.8080: Flags [R.], seq 1, ack 1, win 65535, length 0
```

## Todo
Add support for following `tcp_info` options in FreeBSD -

| Line  |  Name  |
:------:|:------:|
[u_int32_t](http://fxr.watson.org/fxr/source/netinet/tcp.h#L215)| `__tcpi_unacked`
[u_int32_t](http://fxr.watson.org/fxr/source/netinet/tcp.h#L216)| `__tcpi_sacked`
[u_int32_t](http://fxr.watson.org/fxr/source/netinet/tcp.h#L217)| `__tcpi_lost`
[u_int32_t](http://fxr.watson.org/fxr/source/netinet/tcp.h#L218)| `__tcpi_retrans`
