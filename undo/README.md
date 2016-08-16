# Test for fast recovery and undo

## Status
|                      Name                        | Result (FreeBSD)|
|:------------------------------------------------:|:---------------:|
[undo-fr-acks-dropped-then-dsack](undo-fr-acks-dropped-then-dsack.pkt) | Verification required

## Description
* The value of **tcpi_unacked** is always 0. However, this can be attributed to the incomplete implementation in `tcp_info()`.
* The value of **tcpi_snd_cwnd** is always a constant 1000.
