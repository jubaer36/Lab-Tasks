

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
    address.SetBase("192.6.26.0", "255.255.255.0");
    interfaces[0] = address.Assign(devices[0]);
    address.SetBase("192.6.27.0", "255.255.255.0");
    interfaces[1] = address.Assign(devices[1]);
    address.SetBase("192.6.28.0", "255.255.255.0");
    interfaces[2] = address.Assign(devices[2]);

    UdpEchoServerHelper echoServer(9);

    for (int serverNode = 0; serverNode <= 3; serverNode++)
    {
        ApplicationContainer serverApps = echoServer.Install(nodes.Get(serverNode));
        serverApps.Start(Seconds(1.0));
        serverApps.Stop(Seconds(40.0));

        if (serverNode == 0)
        {
            for (int clientNode = 1; clientNode <= 3; clientNode++)
            {
                UdpEchoClientHelper echoClient(interfaces[clientNode - 1].GetAddress(0), 9);
                echoClient.SetAttribute("MaxPackets", UintegerValue(1));
                echoClient.SetAttribute("Interval", TimeValue(Seconds(1.0)));
                echoClient.SetAttribute("PacketSize", UintegerValue(1024));

                ApplicationContainer clientApps = echoClient.Install(nodes.Get(clientNode));
                clientApps.Start(Seconds(2.0 + (clientNode - 1) * 2));
                clientApps.Stop(Seconds(20.0));
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
            clientApps1.Stop(Seconds(20.0));

            UdpEchoClientHelper echoClient2(interfaces[1].GetAddress(0), 9);
            echoClient2.SetAttribute("MaxPackets", UintegerValue(3));
            echoClient2.SetAttribute("Interval", TimeValue(Seconds(1.0)));
            echoClient2.SetAttribute("PacketSize", UintegerValue(1024));

            ApplicationContainer clientApps2 = echoClient2.Install(nodes.Get(2));
            clientApps2.Start(Seconds(10.0));
            clientApps2.Stop(Seconds(20.0));

            UdpEchoClientHelper echoClient3(interfaces[2].GetAddress(0), 9);
            echoClient3.SetAttribute("MaxPackets", UintegerValue(3));
            echoClient3.SetAttribute("Interval", TimeValue(Seconds(1.0)));
            echoClient3.SetAttribute("PacketSize", UintegerValue(1024));

            ApplicationContainer clientApps3 = echoClient3.Install(nodes.Get(3));
            clientApps3.Start(Seconds(12.0));
            clientApps3.Stop(Seconds(20.0));
        }
        else if (serverNode == 2)
        {
            UdpEchoClientHelper echoClient1(interfaces[1].GetAddress(1), 9);
            echoClient1.SetAttribute("MaxPackets", UintegerValue(3));
            echoClient1.SetAttribute("Interval", TimeValue(Seconds(1.0)));
            echoClient1.SetAttribute("PacketSize", UintegerValue(1024));
            ApplicationContainer clientApps1 = echoClient1.Install(nodes.Get(0));
            clientApps1.Start(Seconds(10.0));
            clientApps1.Stop(Seconds(40.0));

            UdpEchoClientHelper echoClient2(interfaces[0].GetAddress(0), 9);
            echoClient2.SetAttribute("MaxPackets", UintegerValue(3));
            echoClient2.SetAttribute("Interval", TimeValue(Seconds(1.0)));
            echoClient2.SetAttribute("PacketSize", UintegerValue(1024));
            ApplicationContainer clientApps2 = echoClient2.Install(nodes.Get(1));
            clientApps2.Start(Seconds(12.0));
            clientApps2.Stop(Seconds(40.0));

            UdpEchoClientHelper echoClient3(interfaces[2].GetAddress(0), 9);
            echoClient3.SetAttribute("MaxPackets", UintegerValue(3));
            echoClient3.SetAttribute("Interval", TimeValue(Seconds(1.0)));
            echoClient3.SetAttribute("PacketSize", UintegerValue(1024));

            ApplicationContainer clientApps3 = echoClient3.Install(nodes.Get(3));
            clientApps3.Start(Seconds(14.0));
            clientApps3.Stop(Seconds(40.0));
        }
        else if (serverNode == 3)
        {
            UdpEchoClientHelper echoClient1(interfaces[2].GetAddress(1), 9);
            echoClient1.SetAttribute("MaxPackets", UintegerValue(1));
            echoClient1.SetAttribute("Interval", TimeValue(Seconds(1.0)));
            echoClient1.SetAttribute("PacketSize", UintegerValue(1024));
            ApplicationContainer clientApps1 = echoClient1.Install(nodes.Get(0));
            clientApps1.Start(Seconds(16.0));
            clientApps1.Stop(Seconds(40.0));

            UdpEchoClientHelper echoClient2(interfaces[0].GetAddress(0), 9);
            echoClient2.SetAttribute("MaxPackets", UintegerValue(3));
            echoClient2.SetAttribute("Interval", TimeValue(Seconds(1.0)));
            echoClient2.SetAttribute("PacketSize", UintegerValue(1024));
            ApplicationContainer clientApps2 = echoClient2.Install(nodes.Get(1));
            clientApps2.Start(Seconds(18.0));
            clientApps2.Stop(Seconds(40.0));

            UdpEchoClientHelper echoClient3(interfaces[1].GetAddress(0), 9);
            echoClient3.SetAttribute("MaxPackets", UintegerValue(3));
            echoClient3.SetAttribute("Interval", TimeValue(Seconds(1.0)));
            echoClient3.SetAttribute("PacketSize", UintegerValue(1024));

            ApplicationContainer clientApps3 = echoClient3.Install(nodes.Get(2));
            clientApps3.Start(Seconds(20.0));
            clientApps3.Stop(Seconds(40.0));
        }
    }

    AnimationInterface anim("Topology1.xml");
    Simulator::Run();
    Simulator::Destroy();
    return 0;
}
