---
date: 2021-05-30 00:00
title: Network debugging on macOS
description: There are several tools on macOS which help you debug your network connection. Let's have a look at them.
shouldSkip: false
tags: hacking, network, macos
---

The last time someone asked *My internet is broken, can you help me?* I thought a blogpost might be a good way to share some tools macOS contains that can help to debug your network (future me ✋).

In this post I want to show some tips and tricks on how to find common networking problems.

When I approach a networking problem, I try to get some structure in my debugging workingflow by using the [OSI model](https://en.wikipedia.org/wiki/OSI_model).
We will have a look at each layer and try to isolate the problem layer by layer.

## OSI layers
In the following section we will have a look at each layer and try to find some tips and tricks for debugging.
It is intended to be a short checklist and therefore does not include more in-depth details on each step.

### **1-2** Physical, Data Link
* Ethernet cable plugged in?
* LEDs on ethernet port flashing?
* WLAN signal quality:
  * Open `Wireless Diagnostics.app` > Menu Bar open `Window` > `Info` & `Performance`
  * The `Info` window gives you some clues on your current network (Channel, Channel Band, Active PHY Mode etc.)
  * `Performance`: Are there variations in e.g. the noise and the resulting Received Signal Strength Indication (RSSI)?

### **3** Network
* Is the cloudflare namesever reachable: `ping 1.1` (aka. `ping 1.0.0.1`)
* Do I have the right `IP address`?
  * `169.254.0.0/16` are link local addresses ([RFC5735](https://datatracker.ietf.org/doc/html/rfc5735)) that might be self assigned by your machine -> DHCP servier not reachable.
  * IP address of guest network?

### **4-7** Transport, Session, Presentation, Application
* Is the DNS resolution working properly?
  * Get DNS record `$ dig A juliankahnert.de`
  * Ask a specific namesever: `$ dig A juliankahnert.de @1.1`
* Response correct (HTTP status code etc.) `$ curl -I http://juliankahnert.de`
* Validate the [certifcate](https://serverfault.com/a/749381):
`$ curl --insecure -vvI https://juliankahnert.de/ 2>&1 | awk 'BEGIN { cert=0 } /^\* SSL connection/ { cert=1 } /^\*/ { if (cert) print }'`

## Other Use Cases

### Where runs the server of ...?

Tools like [ipinfo](https://ipinfo.io) help you to find the [ASN](https://en.wikipedia.org/wiki/Autonomous_system_(Internet)) and its name.
This can reveal the hoster (e.g. *Hetzner* or *Uberspace*).

### Where can I change the DNS records?
You might have more than one registrar and want to find to namesever responsible for a (sub)domain.
```
$ dig NS juliankahnert.de
```
More information: [35c3: Domain Name System](https://media.ccc.de/v/35c3-9674-domain_name_system)


### DNS: Clear Cache
If you have changed DNS records and you can clear the cache of some nameservers:
* [Cloudflare](https://1.1.1.1/purge-cache/)
* [Google](https://developers.google.com/speed/public-dns/cache)

You can use a [DNS Checker](https://dnschecker.org) to valide DNS changes.

Tip: Set a short DNS record TTL some time before you make changes. This will speed up the DNS propagation and your testing afterwards.

## Conclusion
There are several ways to approach a networking problem.
The tools described in the article can give you some first insight.

If you think there are some tips, tricks or tools missing just leave me some [feedback](mailto:feedback@juliankahnert.de).
I love to add them to this post! 🤓