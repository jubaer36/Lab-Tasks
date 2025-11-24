/*
 * SPDX-License-Identifier: GPL-2.0-only
 */

#include "ns3/applications-module.h"
#include "ns3/core-module.h"
#include "ns3/internet-module.h"
#include "ns3/netanim-module.h"
#include "ns3/network-module.h"
#include "ns3/point-to-point-module.h"

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

    NetDeviceContainer devices[3];
    devices[0] = pointToPoint.Install(nodes.Get(0), nodes.Get(1));
    devices[1] = pointToPoint.Install(nodes.Get(0), nodes.Get(2));
    devices[2] = pointToPoint.Install(nodes.Get(0), nodes.Get(3));

    InternetStackHelper stack;
    stack.Install(nodes);

    Ipv4AddressHelper address;
    Ipv4InterfaceContainer interfaces[3];

    address.SetBase("192.0.10.0", "255.255.255.0");
    interfaces[0] = address.Assign(devices[0]);

    address.SetBase("192.0.20.0", "255.255.255.0");
    interfaces[1] = address.Assign(devices[1]);

    address.SetBase("192.0.30.0", "255.255.255.0");
    interfaces[2] = address.Assign(devices[2]);

    UdpEchoServerHelper echoServer(9);

    for (int i = 0; i <= 3; i++)
    {
        ApplicationContainer serverApps = echoServer.Install(nodes.Get(i));
        serverApps.Start(Seconds(1.0));
        serverApps.Stop(Seconds(20.0));

        if (i == 0)
        {
            for (int k = 1; k <= 3; k++)
            {
                UdpEchoClientHelper echoClient(interfaces[k - 1].GetAddress(0), 9);
                echoClient.SetAttribute("MaxPackets", UintegerValue(1));
                echoClient.SetAttribute("Interval", TimeValue(Seconds(1.0)));
                echoClient.SetAttribute("PacketSize", UintegerValue(1024));

                ApplicationContainer clientApps = echoClient.Install(nodes.Get(k));
                clientApps.Start(Seconds(2.0 + (k - 1) * 2));
                clientApps.Stop(Seconds(20.0));
            }
        }
        else if (i == 1)
        {
            UdpEchoClientHelper echoClient(interfaces[0].GetAddress(1), 9);
            echoClient.SetAttribute("MaxPackets", UintegerValue(1));
            echoClient.SetAttribute("Interval", TimeValue(Seconds(1.0)));
            echoClient.SetAttribute("PacketSize", UintegerValue(1024));

            ApplicationContainer clientApps = echoClient.Install(nodes.Get(0));
            clientApps.Start(Seconds(8.0));
            clientApps.Stop(Seconds(20.0));
        }
        else if (i == 2)
        {
            UdpEchoClientHelper echoClient(interfaces[1].GetAddress(1), 9);
            echoClient.SetAttribute("MaxPackets", UintegerValue(1));
            echoClient.SetAttribute("Interval", TimeValue(Seconds(1.0)));
            echoClient.SetAttribute("PacketSize", UintegerValue(1024));

            ApplicationContainer clientApps = echoClient.Install(nodes.Get(0));
            clientApps.Start(Seconds(10.0));
            clientApps.Stop(Seconds(20.0));
        }
        else if (i == 3)
        {
            UdpEchoClientHelper echoClient(interfaces[2].GetAddress(1), 9);
            echoClient.SetAttribute("MaxPackets", UintegerValue(1));
            echoClient.SetAttribute("Interval", TimeValue(Seconds(1.0)));
            echoClient.SetAttribute("PacketSize", UintegerValue(1024));

            ApplicationContainer clientApps = echoClient.Install(nodes.Get(0));
            clientApps.Start(Seconds(12.0));
            clientApps.Stop(Seconds(20.0));
        }
    }

    AnimationInterface anim("star.xml");
    anim.SetConstantPosition(nodes.Get(0), 20.0, 20.0);
    anim.SetConstantPosition(nodes.Get(1), 10.0, 10.0);
    anim.SetConstantPosition(nodes.Get(2), 20.0, 10.0);
    anim.SetConstantPosition(nodes.Get(3), 30.0, 10.0);

    Simulator::Run();
    Simulator::Destroy();
    return 0;
}