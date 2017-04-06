# Tests for connection close

## Status
|                      Name                        | Result (FreeBSD)|
|:------------------------------------------------:|:---------------:|
[close-last-ack-lost](close-last-ack-lost.pkt)     | Passed
[close-read-data-fin](close-read-data-fin.pkt)     | Passed
[close-write-data-rst](close-write-data-rst.pkt)   | Passed
[close-unread-data-rst](close-unread-data-rst.pkt) | Failed(Note 1)
[simultaneous-close](simultaneous-close.pkt)       | Passed

## Notes
1. When server closes the connection without reading client's data, a **RST** is generated as confirmed in [RFC1122: Section 4.2.2.13](https://tools.ietf.org/html/rfc1122#page-87). However, FreeBSD generates a **FIN** in this case.
