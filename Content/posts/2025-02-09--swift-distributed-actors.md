---
date: 2025-05-09 00:00
title: Swift Distributed Actors
description: Hands on example with macOS catalyst App and a local Vapor server.
shouldSkip: false
tags: opensource, swift
---

tl;dr: The distributed actor system is a cool way to connect different environments/nodes/systems without "leaving" the Swift language.
I created a proof of concept with the basic concepts and documented my learnings in this blog post and [this repo](https://github.com/JulianKahnert/DistributedHomeAutomation/).

## Introduction

The Swift programming language includes the [Actor](https://developer.apple.com/documentation/swift/actor) language feature, which is a reference type that protects its mutable state by ensuring that its properties and methods are accessed only from a single thread at a time. This prevents data races in concurrent code.
The [Distributed](https://developer.apple.com/documentation/Distributed) framework enables the creation of distributed actors that can communicate across process or network boundaries, allowing for scalable and secure distributed systems.
In this blog post, I don’t want to simply copy the [documentation](https://swiftpackageindex.com/apple/swift-distributed-actors/main/documentation/distributedcluster), but instead provide a hands-on example.

Let’s assume we have a macOS Catalyst app and a Vapor server that need to communicate with each other.
Each component should push information (e.g., events and commands) to the other.
We will break down the following sequence of events and clarify each step:

[//]: #```mermaid
[//]: #sequenceDiagram
[//]: #    autonumber
[//]: #    participant Node1 as Server
[//]: #    participant Node2 as App
[//]: #
[//]: #    Node1->>+Node1: await ClusterSystem("0.0.0.0:8888")
[//]: #    Node1->>+Node1: receptionist.checkIn()
[//]: #    Node2->>+Node2: await ClusterSystem("0.0.0.0:7777")
[//]: #    Node2->>+Node2: receptionist.checkIn()
[//]: #    Node2->>+Node2: cluster.join(endpoint: "0.0.0.0:8888")
[//]: #    Node2->>+Node2: receptionist.lookUp(serverActor)
[//]: #    Node2->>Node1: serverActor.handle(event:)
[//]: #    Node1->>+Node1: receptionist.lookUp(appActor)
[//]: #    Node1->>Node2: appActor.send
[//]: #```

<p align="center">
<img src="/img/swift-distributed-actors-sequence-diagram.png" width="90%"/>
</p>

On each side, we will create a [`ClusterSystem`](https://swiftpackageindex.com/apple/swift-distributed-actors/main/documentation/distributedcluster/clustersystem) that provides an endpoint the other node can connect to.

**Learning:** Before we continue, we should add some (debug) logging for events to observe what happens in the cluster:
```swift
Task {
    for await event in system.cluster.events {
        print("******** event \(event)")
    }
}
```

## Connection

There are two ways to [form a cluster](https://swiftpackageindex.com/apple/swift-distributed-actors/main/documentation/distributedcluster/clustering#Forming-clusters) and establish a connection between different components.

### Join manually

You can manually join the cluster by calling the `actorSystem.cluster.join(host: "0.0.0.0", port: 8888)` [method](https://swiftpackageindex.com/apple/swift-distributed-actors/main/documentation/distributedcluster/clustercontrol/join(host:port:)).
This method does not wait for the connection to be established.
Alternatively, you can use one of the `joined(...)` [methods](https://swiftpackageindex.com/apple/swift-distributed-actors/main/documentation/distributedcluster/clustercontrol/joined(endpoint:within:)).

### Discovery

I personally prefer the discovery approach.
You can initialize the `ClusterSystem` and provide `ServiceDiscoverySettings` with a `ServiceDiscovery` implementation.
This allows the system to automatically discover other nodes in the network.

The `ServiceDiscoverySettings(static:)` provides a simple way to define a list of static nodes if you know them upfront.

```swift
var settings = ClusterSystemSettings(name: "HomeAutomation-App", host: "0.0.0.0", port: 7777)
settings.discovery = ServiceDiscoverySettings(static: [.init(host: "0.0.0.0", port: 7777), .init(host: "0.0.0.0", port: 8888)])
actorSystem = await ClusterSystem("HomeAutomation-App", settings: settings)
```

## Advertise & Resolve Actors

Now that we have a connection between the two nodes, we can advertise and resolve actors.
The `Receptionist` is a distributed actor that provides a way to advertise and resolve actors by their key (see [documentation](https://swiftpackageindex.com/apple/swift-distributed-actors/main/documentation/distributedcluster/receptionist) for more info).

Here’s an example of how to define an actor:
```swift
typealias DefaultDistributedActorSystem = ClusterSystem

public extension DistributedReception.Key {
    static var homeCommandHandler: DistributedReception.Key<HomeCommandHandler> {
        "homeCommandHandler"
    }
}

public distributed actor HomeCommandHandler {
    public distributed func handle(command: String) {
        print("******** Handling command: \(command)")
    }
}
```

Afterwards, you can advertise and resolve the actor:
```swift
// Advertise HomeCommandHandler on actor 1
let actor = HomeCommandHandler(actorSystem: actorSystem)
await actorSystem.receptionist.checkIn(actor, with: .homeCommandHandler)

// Resolve HomeCommandHandler on actor 2
let actor = await actorSystem.receptionist.lookup(.homeCommandHandler)
```

**Learning:** You must always hold a reference to the actor to keep it alive - otherwise, you will get a `DeadLetter` error.

## Summary

In this blog post, we have learned how to create a distributed actor system with Swift.
We walked through the basic concepts and the sequence of events required to establish a connection between two nodes.
In [this example repo](https://github.com/JulianKahnert/DistributedHomeAutomation/), you can find the full implementation of the sequence diagram above.

Thank you for reading! I’m looking forward to your feedback.

## Useful Links
*	The different repositories of [Jaleel on GitHub](https://github.com/akbashev)
*	[GitHub Repo with Spike](https://github.com/younata/DistributedClusterSpike/) from Rachel
*	Basic Concepts: [DistributedCluster Documentation](https://swiftpackageindex.com/apple/swift-distributed-actors/main/documentation/distributedcluster)
