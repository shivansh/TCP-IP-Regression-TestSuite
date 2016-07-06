# Tests for checking behavior of socket shutdown

## Status

| Name                               | Result (FreeBSD) |
|:----------------------------------:|:----------------:|
[shutdown-rd](shutdown-rd.pkt)       | Failed
[shutdown-wr](shutdown-wr.pkt)       | Failed
[shutdown-rd-wr](shutdown-rd-wr.pkt) | Failed

## Description

* After calling `shutdown(4, SHUT_RD)`, `read()` should not be able to run. However, we still get **0** as a return value instead of **-1**, though `read()` isn't getting called.
```
tests/bsd/tcp/shutdown/shutdown-rd.pkt:18: runtime error in read call: Expected result -1 but got 0
```
* After calling `shutdown(4, SHUT_RD)`, if client writes some data, the TCP stack should respond with a **RST**. However, FreeBSD responds with a delayed **ACK** in this case.
```
script packet:  0.360000 R 1:1(0)
actual packet:  0.367084 . 1:1(0) ack 1001 win 1008
```
