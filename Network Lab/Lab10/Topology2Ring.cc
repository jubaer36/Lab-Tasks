/*
 * SPDX-License-Identifier: GPL-2.0-only
 */

#include "ns3/applications-module.h"
#include "ns3/core-module.h"
#include "ns3/internet-module.h"
#include "ns3/netanim-module.h"
#include "ns3/network-module.h"
#include "ns3/point-to-point-module.h"

// Default Network Topology
//
//       10.1.1.0
// n0 -------------- n1
//    point-to-point
//

using namespace ns3;

NS_LOG_COMPONENT_DEFINE("FirstScriptExample");

int
main(int argc, char* argv[])
{
    CommandLine cmd(__FILE__);
    cmd.Parse(argc, argv);

    Time::SetResolution(Time::NS);
    LogComponentEnable("UdpEchoClientApplication", LOG_LEVEL_INFO);
    LogComponentEnable("UdpEchoServerApplication", LOG_LEVEL_INFO);

    NodeContainer nodes;
    nodes.Create(4);
    PointToPointHelper pointToPoint;
    pointToPoint.SetDeviceAttribute("DataRate", StringValue("5Mbps"));
    pointToPoint.SetChannelAttribute("Delay", StringValue("2ms"));

    NetDeviceContainer devices[4];
    devices[0] = pointToPoint.Install(nodes.Get(0), nodes.Get(1));
    devices[1] = pointToPoint.Install(nodes.Get(1), nodes.Get(2));
    devices[2] = pointToPoint.Install(nodes.Get(2), nodes.Get(3));
    devices[3] = pointToPoint.Install(nodes.Get(3), nodes.Get(0));

    InternetStackHelper stack;
    stack.Install(nodes);

    Ipv4AddressHelper address;

    Ipv4InterfaceContainer interfaces[4];
    address.SetBase("192.6.26.0", "255.255.255.0");
    interfaces[0] = address.Assign(devices[0]);
    address.SetBase("192.6.36.0", "255.255.255.0");
    interfaces[1] = address.Assign(devices[1]);
    address.SetBase("192.6.46.0", "255.255.255.0");
    interfaces[2] = address.Assign(devices[2]);
    address.SetBase("192.6.56.0", "255.255.255.0");
    interfaces[3] = address.Assign(devices[3]);
    UdpEchoServerHelper echoServer(9);

    for (int serverNode = 0; serverNode <= 3; serverNode++)
    {
        ApplicationContainer serverApps = echoServer.Install(nodes.Get(serverNode));
        serverApps.Start(Seconds(1.0));
        serverApps.Stop(Seconds(40.0));

        if (serverNode == 0)
        {
            for (int clientNode = 0; clientNode < 3; clientNode++)
            {
                UdpEchoClientHelper echoClient(interfaces[clientNode + 1].GetAddress(1), 9);
                echoClient.SetAttribute("MaxPackets", UintegerValue(3));
                echoClient.SetAttribute("Interval", TimeValue(Seconds(1.0)));
                echoClient.SetAttribute("PacketSize", UintegerValue(1024));

                ApplicationContainer clientApps = echoClient.Install(nodes.Get(clientNode + 1));
                clientApps.Start(Seconds(2.0 + (clientNode) * 2));
                clientApps.Stop(Seconds(2.0 + (clientNode) * 2 + 1));
            }
        }
        else if (serverNode == 1)
        {
            UdpEchoClientHelper echoClient1(interfaces[0].GetAddress(1), 9);
            echoClient1.SetAttribute("MaxPackets", UintegerValue(3));
            echoClient1.SetAttribute("Interval", TimeValue(Seconds(1.0)));
            echoClient1.SetAttribute("PacketSize", UintegerValue(1024));

            ApplicationContainer clientApps1 = echoClient1.Install(nodes.Get(0));
            clientApps1.Start(Seconds(8.0));
            clientApps1.Stop(Seconds(8.5));

            UdpEchoClientHelper echoClient2(interfaces[2].GetAddress(1), 9);
            echoClient2.SetAttribute("MaxPackets", UintegerValue(3));
            echoClient2.SetAttribute("Interval", TimeValue(Seconds(1.0)));
            echoClient2.SetAttribute("PacketSize", UintegerValue(1024));

            ApplicationContainer clientApps2 = echoClient2.Install(nodes.Get(2));
            clientApps2.Start(Seconds(9.0));
            clientApps2.Stop(Seconds(9.5));

            UdpEchoClientHelper echoClient3(interfaces[3].GetAddress(1), 9);
            echoClient3.SetAttribute("MaxPackets", UintegerValue(3));
            echoClient3.SetAttribute("Interval", TimeValue(Seconds(1.0)));
            echoClient3.SetAttribute("PacketSize", UintegerValue(1024));

            ApplicationContainer clientApps3 = echoClient3.Install(nodes.Get(3));
            clientApps3.Start(Seconds(10.0));
            clientApps3.Stop(Seconds(10.5));
        }
        else if (serverNode == 2)
        {
            UdpEchoClientHelper echoClient1(interfaces[1].GetAddress(1), 9);
            echoClient1.SetAttribute("MaxPackets", UintegerValue(3));
            echoClient1.SetAttribute("Interval", TimeValue(Seconds(1.0)));
            echoClient1.SetAttribute("PacketSize", UintegerValue(1024));
            ApplicationContainer clientApps1 = echoClient1.Install(nodes.Get(1));
            clientApps1.Start(Seconds(11.0));
            clientApps1.Stop(Seconds(11.5));

            UdpEchoClientHelper echoClient2(interfaces[0].GetAddress(1), 9);
            echoClient2.SetAttribute("MaxPackets", UintegerValue(3));
            echoClient2.SetAttribute("Interval", TimeValue(Seconds(1.0)));
            echoClient2.SetAttribute("PacketSize", UintegerValue(1024));
            ApplicationContainer clientApps2 = echoClient2.Install(nodes.Get(0));
            clientApps2.Start(Seconds(12.0));
            clientApps2.Stop(Seconds(12.5));

            UdpEchoClientHelper echoClient3(interfaces[3].GetAddress(1), 9);
            echoClient3.SetAttribute("MaxPackets", UintegerValue(3));
            echoClient3.SetAttribute("Interval", TimeValue(Seconds(1.0)));
            echoClient3.SetAttribute("PacketSize", UintegerValue(1024));

            ApplicationContainer clientApps3 = echoClient3.Install(nodes.Get(3));
            clientApps3.Start(Seconds(13.0));
            clientApps3.Stop(Seconds(13.5));
        }
        else if (serverNode == 3)
        {
            UdpEchoClientHelper echoClient1(interfaces[2].GetAddress(1), 9);
            echoClient1.SetAttribute("MaxPackets", UintegerValue(3));
            echoClient1.SetAttribute("Interval", TimeValue(Seconds(1.0)));
            echoClient1.SetAttribute("PacketSize", UintegerValue(1024));
            ApplicationContainer clientApps1 = echoClient1.Install(nodes.Get(2));
            clientApps1.Start(Seconds(14.0));
            clientApps1.Stop(Seconds(14.5));

            UdpEchoClientHelper echoClient2(interfaces[0].GetAddress(1), 9);
            echoClient2.SetAttribute("MaxPackets", UintegerValue(3));
            echoClient2.SetAttribute("Interval", TimeValue(Seconds(1.0)));
            echoClient2.SetAttribute("PacketSize", UintegerValue(1024));
            ApplicationContainer clientApps2 = echoClient2.Install(nodes.Get(0));
            clientApps2.Start(Seconds(15.0));
            clientApps2.Stop(Seconds(15.5));

            UdpEchoClientHelper echoClient3(interfaces[1].GetAddress(1), 9);
            echoClient3.SetAttribute("MaxPackets", UintegerValue(3));
            echoClient3.SetAttribute("Interval", TimeValue(Seconds(1.0)));
            echoClient3.SetAttribute("PacketSize", UintegerValue(1024));

            ApplicationContainer clientApps3 = echoClient3.Install(nodes.Get(1));
            clientApps3.Start(Seconds(16.0));
            clientApps3.Stop(Seconds(16.5));
        }
    }

    AnimationInterface anim("Topology2Ring.xml");
    Simulator::Run();
    Simulator::Destroy();
    return 0;
}
