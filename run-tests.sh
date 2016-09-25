#!/bin/sh

packetdrill=/usr/home/zeebsd/packetdrill/gtests/net/packetdrill/packetdrill

set blocking/blocking-accept \
  blocking/blocking-read \
  close/close-last-ack-lost \
  close/close-read-data-fin \
  close/close-unread-data-rst \
  close/close-write-data-rst \
  close/simultaneous-close \
  connect/http-get-nonblocking-ts \
  early_retransmit/early-retransmit \
  fast_recovery/fast-recovery \
  fast_retransmit/fr-4pkt-sack-bsd \
  ICMP/icmp-all-types \
  initial_window/iw10-base-case \
  initial_window/iw10-short-response \
  init_rto/init_rto_passive_open \
  listen/listen-incoming-ack \
  listen/listen-incoming-no-tcp-flags \
  listen/listen-incoming-rst \
  listen/listen-incoming-syn-ack \
  listen/listen-incoming-syn-rst \
  mss/mss-getsockopt-tcp_maxseg-client-ts \
  mss/mss-getsockopt-tcp_maxseg-client \
  mss/mss-getsockopt-tcp_maxseg-server-advmss-ipv4 \
  mss/mss-getsockopt-tcp_maxseg-server-advmss-ipv4 \
  mss/mss-getsockopt-tcp_maxseg-server-advmss-ts-ipv4 \
  mss/mss-setsockopt-tcp_maxseg-client \
  mss/mss-setsockopt-tcp_maxseg-server \
  pmtu_discovery/pmtu-10pkt \
  receiver_rtt/rcv-rtt-with-timestamps-new \
  receiver_rtt/rcv-rtt-without-timestamps-new \
  reset/rst-non-synchronized \
  reset/rst-syn-sent \
  reset/rst-sync-est-fin-wait-1 \
  reset/rst-sync-est-fin-wait-2 \
  reset/rst-sync-est-time-wait \
  reset/rst_sync_close_wait \
  rto/retransmission_timeout \
  shutdown/shutdown-rd \
  shutdown/shutdown-rdwr \
  shutdown/shutdown-wr \
  slow_start/slow-start \
  time_wait/time-wait \
  undo/undo-fr-acks-dropped-then-dsack

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
  #if [ -f ${test}.pkt ]
  #then
  $packetdrill ${test}.pkt > /dev/null 2>&1
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
  #else
  #printf "SKIPPED\n"
  #skipped=`expr $skipped + 1`
  #fi
done

printf "\nSummary\n"
printf "===========================\n"

printf "Number of tests run: %6d\n" $run
printf "Number of tests passed: %3d\n" $passed
printf "Number of tests failed: %3d\n" $failed
printf "Number of tests skipped: %2d\n" $skipped
