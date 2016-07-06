# Test for handling incoming ICMP packets

## Status

|  Num  |	Abbrev.	  |	Description
|:-----:|:-------:  |:---------------------:
     0	|echorep	 	|Echo reply
	   3	|unreach		|Destination unreachable
	   4	|squench		|Packet loss, slow down
	   5	|redir		  |Shorter	route exists
	   6	|althost		|Alternate host address
	   8	|echoreq		|Echo request
	   9	|routeradv	|Router advertisement
	   10	|routersol	|Router solicitation
	   11	|timex		  |Time exceeded
	   12	|paramprob	|Invalid	IP header
	   13	|timereq		|Timestamp request
	   14	|timerep		|Timestamp reply
	   15	|inforeq		|Information request
	   16	|inforep		|Information reply
	   17	|maskreq		|Address	mask request
	   18	|maskrep		|Address	mask reply
	   30	|trace		  |Traceroute
	   31	|dataconv	  |Data conversion	problem
	   32	|mobredir	  |Mobile host redirection
	   33	|ipv6-where |IPv6 where-are-you
	   34	|ipv6-here	|IPv6 i-am-here
	   35	|mobregreq	|Mobile registration request
	   36	|mobregrep	|Mobile registration reply
	   39	|skip		    |SKIP
	   40	|photuris	  |Photuris

|  Num | Abbrev.        |   Type        | Description
|:----:|:------------:  |:-------------:|:-----------------------------------:
     0	|net-unr		    |unreach	      |Network unreachable
	   1	|host-unr	      |unreach	      |Host unreachable
	   2	|proto-unr	    |unreach	      |Protocol unreachable
	   3	|port-unr	      |unreach	      |Port unreachable
	   4	|needfrag	      |unreach	      |Fragmentation needed but DF	bit set
	   5	|srcfail		    |unreach	      |Source routing failed
	   6	|net-unk		    |unreach	      |Network unknown
	   7	|host-unk	      |unreach	      |Host unknown
	   8	|isolate		    |unreach	      |Host isolated
	   9	|net-prohib     |unreach	      |Network administratively prohibited
	   10	|host-prohib	  |unreach	      |Host administratively prohibited
	   11	|net-tos		    |unreach	      |Invalid TOS	for network
	   12	|host-tos	      |unreach	      |Invalid TOS	for host
	   13	|filter-prohib	|unreach	      |Prohibited access
	   14	|host-preced	  |unreach	      |Precedence violation
	   15	|cutoff-preced	|unreach	      |Precedence cutoff
	   0	|redir-net	    |redir	        |Shorter route for network
	   1	|redir-host	    |redir	        |Shorter route for host
	   2	|redir-tos-net	|redir	        |Shorter route for TOS and network
	   3	|redir-tos-host |redir	        |Shorter route for TOS and host
	   0	|normal-adv	    |routeradv      |Normal advertisement
	   16	|common-adv	    |routeradv      |Selective advertisement
	   0	|transit		    |timex	        |Time exceeded in transit
	   1	|reassemb	      |timex	        |Time exceeded in reassembly
	   0	|badhead		    |paramprob      |Invalid option pointer
	   1	|optmiss		    |paramprob      |Missing option
	   2	|badlen		      |paramprob      |Invalid length
	   1	|unknown-ind	  |photuris       |Unknown security index
	   2	|auth-fail	    |photuris       |Authentication failed
	   3	|decrypt-fail	  |photuris       |Decryption failed

