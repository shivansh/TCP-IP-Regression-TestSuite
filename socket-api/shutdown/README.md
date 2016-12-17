# Tests for checking behavior of socket shutdown

## Status

| Name                               | Result (FreeBSD) |
|:----------------------------------:|:----------------:|
[shutdown-rd](shutdown-rd.pkt)       | Passed
[shutdown-wr](shutdown-wr.pkt)       | Passed
[shutdown-rd-wr](shutdown-rd-wr.pkt) | Passed

## Description

* ~~After calling `shutdown(4, SHUT_RD)`, `read()` should not be able to run. However, we still get **0** as a return value instead of **-1**, though `read()` isn't getting called.~~
```
tests/bsd/tcp/shutdown/shutdown-rd.pkt:18: runtime error in read call: Expected result -1 but got 0
```
* ~~After calling `shutdown(4, SHUT_RD)`, if client writes some data, the TCP stack should respond with a **RST**. However, FreeBSD responds with a delayed **ACK** in this case.~~
```
script packet:  0.360000 R 1:1(0)
actual packet:  0.367084 . 1:1(0) ack 1001 win 1008
```
**FIXED** as of [this commit](https://github.com/shivrai/TCP-IP-Regression-TestSuite/commit/dbff9865f8fa31b1db181b7a1e3533780185628a).

* **Note:** After calling `shutdown(SHUT_RD)`, FreeBSD still accepts data (and ACKs) **but discards them**.
