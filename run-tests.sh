#!/bin/sh

packetdrill=/usr/home/zeebu/source-codes/regression-testing/regression-tester-google/gtests/net/packetdrill

set blocking/blocking-accept \
    blocking/blocking-read.pkt \
    close/close-last-ack-lost.pkt \
    close/close-read-data-fin.pkt \
    close/close-unread-data-rst.pkt \
    close/close-write-data-rst.pkt \
    close/simultaneous-close.pkt \
    connect/http-get-nonblocking-ts.pkt \
    early_retransmit/early-retransmit.pkt \
    fast_recovery/fast-recovery.pkt \
    fast_retransmit/fr-4pkt-sack-bsd.pkt \
    ICMP/icmp-all-types.pkt \
    initial_window/iw10-base-case.pkt \
    initial_window/iw10-short-response.pkt \
    init_rto/init_rto_passive_open.pkt \
    listen/listen-incoming-ack.pkt \
    listen/listen-incoming-no-tcp-flags.pkt \
    listen/listen-incoming-rst.pkt \
    listen/listen-incoming-syn-ack.pkt \
    listen/listen-incoming-syn-rst.pkt \
    mss/mss-getsockopt-tcp_maxseg-client-ts.pkt \
    mss/mss-getsockopt-tcp_maxseg-client.pkt \
    mss/mss-getsockopt-tcp_maxseg-server-advmss-ipv4.pkt \
    mss/mss-getsockopt-tcp_maxseg-server-advmss-ipv4.pkt \
    mss/mss-getsockopt-tcp_maxseg-server-advmss-ts-ipv4.pkt \
    mss/mss-setsockopt-tcp_maxseg-client.pkt \
    mss/mss-setsockopt-tcp_maxseg-server.pkt \
    pmtu_discovery/pmtu-10pkt.pkt \
    receiver_rtt/rcv-rtt-with-timestamps-new.pkt \
    receiver_rtt/rcv-rtt-without-timestamps-new.pkt \
    reset/rst-non-synchronized.pkt \
    reset/rst-syn-sent.pkt \
    reset/rst-sync-est-fin-wait-1.pkt \
    reset/rst-sync-est-fin-wait-2.pkt \
    reset/rst-sync-est-time-wait.pkt \
    reset/rst_sync_close_wait.pkt \
    rto/retransmission_timeout.pkt \
    shutdown/shutdown-rd.pkt \
    shutdown/shutdown-rdwr.pkt \
    shutdown/shutdown-wr.pkt \
    slow_start/slow-start.pkt \
    time_wait/time-wait.pkt \
    undo/undo-fr-acks-dropped-then-dsack.pkt

delay=0.2
passed=0
failed=0
run=0
skipped=0
found=0

printf "\nScript Name                                                  Result\n"
printf "====================================================================\n"
for test
do
  printf "%-60.60s " $test
  `sleep $delay`
  if [ -f ${test}.pkt ]
  then
    $packetdrill ${test}.pkt 2> /dev/null
    result="`echo $?`"
    found=1
    if [ $found = 1 ]
    then
      if [ $result = 1 ]
      then
        printf "FAILED\n"
        failed=`expr $failed + 1`
      else
        printf "PASSED\n"
        passed=`expr $passed + 1`
      fi
      run=`expr $run + 1`
    fi
  else
    printf "SKIPPED\n"
    skipped=`expr $skipped + 1`
  fi
done

printf "\nSummary\n"
printf "===========================\n"

printf "Number of tests run: %6d\n" $run
printf "Number of tests passed: %3d\n" $passed
printf "Number of tests failed: %3d\n" $failed
printf "Number of tests skipped: %2d\n" $skipped
