# Handling reset from synchronized/non-synchronized state

## Status
| Name                                             | Result (FreeBSD) |
|:------------------------------------------------:|:----------------:|
[reset-non-synchronized](rst-non-synchronized.pkt) | Passed
[reset-synchronized-established](rst-synchronized-established.pkt) | Failed

## Description
~~The connection cannot be established. The accept system call never returns.~~ Fixed with [this commit](https://github.com/shivrai/TCP-IP-Regression-TestSuite/commit/7f258ea6847c34682e24b473376da234f71a9063).
