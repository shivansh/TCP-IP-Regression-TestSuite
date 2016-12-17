# Test for verifying slow read attack

## Status
|                  Name                |  Result (FreeBSD)  |
|:------------------------------------:|:------------------:|
[slow-read](slow-read.pkt)             | Passed

## Description
* Quoting from RFC6429 -
> As stated in [RFC1122], a TCP implementation MUST NOT close a
  connection merely because it seems to be stuck in the ZWP or persist
  condition.  Though unstated in RFC 1122, but implicit for system
  robustness, a TCP implementation needs to allow connections in the
  ZWP or persist condition to be closed or aborted by their
  applications or other resource management routines in the operating
  system.

* **Note** If the client never updates it's advertized window, the server will keep sending the zero window probes indefinitely. The handling for this case is done by the application.

## References
* [RFC6429: TCP Sender Clarification for Persist Condition](https://tools.ietf.org/html/rfc6429#section-3)
