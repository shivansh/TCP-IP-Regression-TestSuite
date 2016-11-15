# TCP-IP-Regression-TestSuite

## Overview

Regression testing is one of the most critical elements of the test artifacts and proves to be one of the most preventive measures for testing a software. Currently, within FreeBSD, there is no such tool to perform regression testing of the TCP/IP network stack. The purpose of this project is to develop tests using a regression testing tool which can then be integrated with FreeBSD. Once integrated, the tool will also facilitate further development of such tests. The regression testing tool of choice here is _packetdrill_.

## Project description

_packetdrill_ currently supports testing multiple scenarios for TCP/IP protocol suite within Linux. This project aims to design and implement a wire level regression test suite for FreeBSD using packetdrill. The test suite will exercise various states in the TCP/IP protocol suite, with both **IPv4** and **IPv6** support. Besides Linux, the _packetdrill_ tool works on {**Free**, **Net**, **Open**} **BSD**.
The existing Linux test suite implemented within _packetdrill_ will provide a basis for understanding, and implementation of the FreeBSD test suite. For the current scope of the project, only a subset of the existing test scenarios will be implemented.

## Why Packetdrill?

While valuable for measuring overall performance, TCP regression testing with _netperf_, application load tests, or production workloads can fail to reveal significant functional bugs in congestion control, loss recovery, flow control, security, DoS hardening and protocol state machines. Such approaches suffer from noise due to variations in site/network conditions or content, and a lack of precision and isolation, thus bugs in these areas can go unnoticed. Since _netperf_ is supposed to be more for benchmarking purposes and what we are trying to do is measure correctness, _packetdrill_, which was built with the same mindset, seemed an apt choice for this project.

## Installation
The testsuite is available as a [freebsd port](https://www.freshports.org/net/tcptestsuite/) along with [tuexen/tcp-testsuite](https://github.com/tuexen/tcp-testsuite).
* If you already have packetdrill installed and configured - <br>
 ```
 pkg install tcptestsuite
 ```

* For installing the entire suite with packetdrill - <br>
 ```
 pkg install packetdrill
 ```
 Now proceed with the [steps for configuring packetdrill](https://github.com/google/packetdrill/blob/master/gtests/net/packetdrill/README).

## Test Plan

_packetdrill_ supports two modes of testing - local and remote.  A **TUN** virtual network device is used in the local testing and a physical **NIC** is used for the remote testing.
Local testing is relatively easier to use because there is less timing variation and the users need not coordinate access to multiple machines.
One thing to keep in mind is that we treat the network stack as server and the running instance of _packetdrill_ is a client which issues packets and matches the response from the server against the hard-coded behavior.

To avoid conflicts arising due to memory locking used in packetdrill, the following command must be run on a FreeBSD machine -
```
>> sudo sysctl -w vm.old_mlock = 1
```
Or following line should be placed in /etc/sysctl.conf -
```
vm.old_mlock = 1
```

The following tests were done in order to ensure proper functioning and behavior of the test scripts were as desired -

### Local mode testing

Local mode is the default mode, and hence the user need not specify any special command line flags.
```
>> ./packetdrill -v <test-script.pkt>
```
Executing the above command will give the information about the inbound injected and outbound sniffed packets which can be studied and checked whether in accordance with the expected behaviour. The TUN virtual network device will be used as a source and sink for packets in this case.

#### Using the script to automate
The script [run-tests.sh](https://github.com/shivrai/TCP-IP-Regression-TestSuite/blob/master/run-tests.sh) can be used to automate the tests. The value of the `packetdrill` variable should be replaced with the location of the **packetdrill** binary on your machine.
The following command should be used for executing all the tests -
```
sudo sh run-tests.sh
```

### Remote mode testing

On the system under test (i.e the “client” machine), a command line option to enable remote mode (acting as a client) and a second option to specify the IP address of the remote server machine to which the client packetdrill instance will connect must be specified.
```
client>> ./packetdrill --wire_client --wire_server_ip=<server_ip> <test-script.pkt>
```
On the remote machine, using the same layer 2 broadcast domain (same hub/switch), a packetdrill process acting as a “wire server” daemon to inject and sniff packets remotely on the wire will be started.
```
server>> ./packetdrill --wire_server
```
The client instance will connect to the server (using TCP), and will send command line options and contents of the script file. Then, the two packetdrill instances will work in coherence to execute the script and test the client machine’s network stack.

### IPv4 and IPv6 protocol testing

packetdrill supports IPv4, IPv6 and dual-stack modes. The modes can be specified by the user with --ip_version command line flag. To get FreeBSD to allow using ipv4-mapped-ipv6 mode, the kernel must be notified with the following command -
```
>> sysctl -w net.inet6.ip6.v6only = 0
```
For testing using AF_INET6 sockets with IPv4 traffic -
```
>> ./packetdrill --ip_version=ipv4-mapped-ipv6 <test-script.pkt>
```
For testing using AF_INET6 sockets with IPv6 traffic -
```
>> ./packetdrill --ip_version=ipv6 --mtu=1520 <test-script.pkt>
```
Since the IPv6 headers are 20 bytes larger than the IPv4 headers, the MTU has to be set to 1520 to address the extra 20 bytes, rather than the standard size of 1500 bytes.

## Scenarios covered

|**Scenario**|**Number of tests**|**Result**|
------------|:-------------------:|:----------:|
|ICMP|1|Passed|
|Blocking system calls|2|Passed|
|Fast Retransmit|1|Passed|
|Early Retransmit|1|[Failed](https://github.com/shivrai/TCP-IP-Regression-TestSuite/tree/master/early_retransmit#test-for-early-retranstmit)|
|Fast Recovery|1|Passed|
|init_rto|1|Passed|
|Initial window|1|Passed|
|PMTU discovery|1|Passed|
|Retransmission Timeout|2|Passed|
|Socket Shutdown|3|Passed|
|Undo|2|Passed|
|Connect|1|Passed|
|TCP options establishment|5|Passed|
|AIMD|1|Passed|
|TIME-WAIT configuration|1|Passed|
|Selective Acknowledgements|1|Passed|
|Connection Close|5|Passed|
|Simultaneous Close|1|Passed|
|RESET from synchronized and <br> non-synchronized states|7|Passed|
|MSS|8|6/8 Passed|
|Receiver RTT|2|Passed|
|TCP timestamps|*|Passed|

## Possible Scenarios
* ~~Test for half-open connection (last ack getting lost).~~ **Update -** [close-last-ack-lost](./close/close-last-ack-lost.pkt)

## Future Plans and Work
There is a huge scope for work yet to be done in this project, and I am not stopping anywhere in the near future. The final goal is to make this test suite exhaustive so that it can be easy for FreeBSD developers for checking the authenticity of the network stack in a rigorous manner, and that occurrence of any misbehavior can be found out and rectified easily. The number of scenarios that can be added are innumerable, and the existing implemented set will be kept expanding and perfected. <br>Some of the tasks which can be listed as of now are -
 * Once we are successful in adding support in **tcp_info()** for checking window size, scenarios such as sliding window protocol, ~~zero window handling and zero window probing~~ **Update:** [3d359c](https://github.com/shivrai/TCP-IP-Regression-TestSuite/commit/3d359cb60a2c682dfae28d640eedfe9d7e2ef361) can be successfully tested.
 * Adding support for urgent pointer in _packetdrill_.
 * _packetdrill_ currently supports testing only a single connection at a time. An attempt will be made to patch it to support multiple concurrent connections.
 * The current remote mode available in _packetdrill_ allows testing a remote host provided there is already an instance of _packetdrill_ running on it. There is not yet support for testing a remote host that does not have _packetdrill_ running. One such approach for enabling support for this can be that instead of getting command line arguments and the script over a TCP connection, the current instance can get it directly. Hence, the logic for handshake with the client will be removed, the packets will be injected and the client will wait for inbound packets.

**Keep in touch with the latest updates in the project via the [FreeBSD-wiki](https://wiki.freebsd.org/SummerOfCode2016/TCP-IP-RegressionTestSuite/).**

## Acknowledgements
I cannot thank my mentor **Hiren Panchasara** enough for all the help and support which he has given in the entire duration of the project. Working in his guidance was full of fun and challenging. I would be extremely grateful to receive his guidance in the future too while I continue to work on this project. <br>
I also thank **Michael Tuexen** for all his help and guidance during the project. <br>
I would also like to thank the FreeBSD community for accepting this project, which gave me a chance to gain a lot of knowledge about the community and open source in general.
