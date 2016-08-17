# Test for establishing TIME-WAIT configuration

## Status
|              Name               |  Result (FreeBSD)  |
|:-------------------------------:|:------------------:|
[TIME-WAIT](time-wait.pkt)        | Passed

## Description
* ~~It takes ~ **3 seconds** for transitioning from **FIN_WAIT_2** to **TIME_WAIT**.~~ **Fixed** as of [this commit](https://github.com/shivrai/TCP-IP-Regression-TestSuite/commit/f6c5d3ad6b94427d37bd99802599bfa18ceed67c).
* While transitioning to **TIME-WAIT**, after recieving a **FIN ACK**, we are supposed to send out an **ACK**. However the actual intercepted packet is a **FIN ACK**.
