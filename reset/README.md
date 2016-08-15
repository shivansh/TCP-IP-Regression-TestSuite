# Handling reset from synchronized/non-synchronized state

## Status
| Name                                             | Result (FreeBSD) |
|:------------------------------------------------:|:----------------:|
[rst-non-sync](rst-non-synchronized.pkt) | Passed
[rst-sync-est](rst-synchronized-established.pkt) | Failed
[rst-sync-est-fin-wait-1](rst-sync-est-fin-wait-1.pkt) | Passed
[rst-sync-est-fin-wait-2](rst-sync-est-fin-wait-2.pkt) | Passed

## Description
~~The connection cannot be established. The accept system call never returns.~~ Fixed with [this commit](https://github.com/shivrai/TCP-IP-Regression-TestSuite/commit/7f258ea6847c34682e24b473376da234f71a9063).
