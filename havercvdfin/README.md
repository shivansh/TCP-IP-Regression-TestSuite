# Test for checking FIN acceptance from specific states

## Status
|           Name               | Result (FreeBSD)|
|:----------------------------:|:---------------:|
[CLOSE-WAIT](close_wait.pkt)   | Passed
[CLOSING](closing.pkt)         | Passed
[LAST-ACK](last_ack.pkt)       | Verification Required

## Description
* tcpdump capture for [CLOSE-WAIT](close_wait.pkt) -
```
listening on tun0, link-type NULL (BSD loopback), capture size 262144 bytes
14:18:46.509462 IP 192.0.2.1.36655 > 192.168.0.1.8080: Flags [S], seq 0, win 65535, options [mss 1460,sackOK,nop,nop,nop,wscale 7], length 0
14:18:46.509547 IP 192.168.0.1.8080 > 192.0.2.1.36655: Flags [S.], seq 2990540616, ack 1, win 65535, options [mss 1460,nop,wscale 6,sackOK,eol], length 0
14:18:46.510647 IP 192.0.2.1.36655 > 192.168.0.1.8080: Flags [.], ack 1, win 65535, length 0
14:18:46.512825 IP 192.0.2.1.36655 > 192.168.0.1.8080: Flags [F.], seq 1, ack 1, win 65535, length 0
14:18:46.512846 IP 192.168.0.1.8080 > 192.0.2.1.36655: Flags [.], ack 2, win 1026, length 0
14:18:46.522211 IP 192.0.2.1.36655 > 192.168.0.1.8080: Flags [F.], seq 2, ack 2, win 65535, length 0
14:18:46.522495 IP 192.168.0.1.8080 > 192.0.2.1.36655: Flags [.], ack 2, win 1026, length 0
```

* tcpdump capture for [CLOSING](closing.pkt) -
```
listening on tun0, link-type NULL (BSD loopback), capture size 262144 bytes
14:24:52.875903 IP6 :: > ff02::1:ffa0:b9e2: ICMP6, neighbor solicitation, who has fe80::a00:27ff:fea0:b9e2, length 32
14:24:52.880914 IP6 :: > ff02::16: HBH ICMP6, multicast listener report v2, 1 group record(s), length 28
14:24:52.982447 IP 192.0.2.1.45927 > 192.168.0.1.8080: Flags [S], seq 0, win 65535, options [mss 1460,sackOK,nop,nop,nop,wscale 7], length 0
14:24:52.982473 IP 192.168.0.1.8080 > 192.0.2.1.45927: Flags [S.], seq 631514591, ack 1, win 65535, options [mss 1460,nop,wscale 6,sackOK,eol], length 0
14:24:52.983334 IP 192.0.2.1.45927 > 192.168.0.1.8080: Flags [.], ack 1, win 65535, length 0
14:24:52.985377 IP 192.168.0.1.8080 > 192.0.2.1.45927: Flags [F.], seq 1, ack 1, win 1026, length 0
14:24:52.995628 IP 192.0.2.1.45927 > 192.168.0.1.8080: Flags [.], ack 1, win 65535, length 0
14:24:52.995973 IP 192.0.2.1.45927 > 192.168.0.1.8080: Flags [F.], seq 1, ack 2, win 65535, length 0
14:24:52.995994 IP 192.168.0.1.8080 > 192.0.2.1.45927: Flags [.], ack 2, win 1026, length 0
14:24:53.006202 IP 192.0.2.1.45927 > 192.168.0.1.8080: Flags [F.], seq 2, ack 2, win 65535, length 0
14:24:53.006217 IP 192.168.0.1.8080 > 192.0.2.1.45927: Flags [.], ack 2, win 1026, length 0
```

* After transitioning to the **LAST-ACK** state, when the TCP stack receives a **FIN**, we don't get any response.<br>
tcpdump capture for [LAST-ACK](last_ack.pkt) -
```
listening on tun0, link-type NULL (BSD loopback), capture size 262144 bytes
14:37:14.708050 IP 192.0.2.1.35554 > 192.168.0.1.8080: Flags [S], seq 0, win 65535, options [mss 1460,sackOK,nop,nop,nop,wscale 7], length 0
14:37:14.708073 IP 192.168.0.1.8080 > 192.0.2.1.35554: Flags [S.], seq 2250761341, ack 1, win 65535, options [mss 1460,nop,wscale 6,sackOK,eol], length 0
14:37:14.709161 IP 192.0.2.1.35554 > 192.168.0.1.8080: Flags [.], ack 1, win 65535, length 0
14:37:14.712016 IP 192.0.2.1.35554 > 192.168.0.1.8080: Flags [F.], seq 1, ack 1, win 65535, length 0
14:37:14.712033 IP 192.168.0.1.8080 > 192.0.2.1.35554: Flags [.], ack 2, win 1026, length 0
14:37:14.720883 IP 192.168.0.1.8080 > 192.0.2.1.35554: Flags [F.], seq 1, ack 2, win 1026, length 0
14:37:14.731757 IP 192.0.2.1.35554 > 192.168.0.1.8080: Flags [F.], seq 2, ack 0, win 65535, length 0
```
