/*
 * SPDX-License-Identifier: GPL-2.0-only
 */

 #include "ns3/applications-module.h"
 #include "ns3/core-module.h"
 #include "ns3/csma-module.h"
 #include "ns3/internet-module.h"
 #include "ns3/ipv4-global-routing-helper.h"
 #include "ns3/netanim-module.h"
 #include "ns3/network-module.h"
 #include "ns3/point-to-point-module.h"
 #include "ns3/internet-apps-module.h"
#include "ns3/ipv4-routing-table-entry.h"
#include "ns3/ipv4-static-routing-helper.h"

#include <fstream>
 using namespace ns3;
 
 NS_LOG_COMPONENT_DEFINE("SecondScriptExample");
 
 void
TearDownLink(Ptr<Node> nodeA, Ptr<Node> nodeB, uint32_t interfaceA, uint32_t interfaceB)
{
    nodeA->GetObject<Ipv4>()->SetDown(interfaceA);
    nodeB->GetObject<Ipv4>()->SetDown(interfaceB);
}



 int
 main(int argc, char* argv[])
 {
    bool verbose = false;
    bool printRoutingTables = false;
    bool showPings = false;
    std::string SplitHorizon("PoisonReverse");

    CommandLine cmd(__FILE__);
    cmd.AddValue("verbose", "turn on log components", verbose);
    cmd.AddValue("printRoutingTables",
                 "Print routing tables at 30, 60 and 90 seconds",
                 printRoutingTables);
    cmd.AddValue("showPings", "Show Ping reception", showPings);
    cmd.AddValue("splitHorizonStrategy",
                 "Split Horizon strategy to use (NoSplitHorizon, SplitHorizon, PoisonReverse)",
                 SplitHorizon);
    cmd.Parse(argc, argv);

    if (verbose)
    {
        LogComponentEnableAll(LogLevel(LOG_PREFIX_TIME | LOG_PREFIX_NODE));
        LogComponentEnable("RipSimpleRouting", LOG_LEVEL_INFO);
        LogComponentEnable("Rip", LOG_LEVEL_ALL);
        LogComponentEnable("Ipv4Interface", LOG_LEVEL_ALL);
        LogComponentEnable("Icmpv4L4Protocol", LOG_LEVEL_ALL);
        LogComponentEnable("Ipv4L3Protocol", LOG_LEVEL_ALL);
        LogComponentEnable("ArpCache", LOG_LEVEL_ALL);
        LogComponentEnable("Ping", LOG_LEVEL_ALL);
    }

    if (SplitHorizon == "NoSplitHorizon")
    {
        Config::SetDefault("ns3::Rip::SplitHorizon", EnumValue(Rip::NO_SPLIT_HORIZON));
    }
    else if (SplitHorizon == "SplitHorizon")
    {
        Config::SetDefault("ns3::Rip::SplitHorizon", EnumValue(Rip::SPLIT_HORIZON));
    }
    else
    {
        Config::SetDefault("ns3::Rip::SplitHorizon", EnumValue(Rip::POISON_REVERSE));
    }

    NS_LOG_INFO("Create nodes.");
    Ptr<Node> cse1 = CreateObject<Node>();
    Ptr<Node> cse2 = CreateObject<Node>();
    Ptr<Node> eee1 = CreateObject<Node>();
    Ptr<Node> eee2 = CreateObject<Node>();
    Ptr<Node> mpe1 = CreateObject<Node>();
    Ptr<Node> mpe2 = CreateObject<Node>();
    Ptr<Node> ictCentre1 = CreateObject<Node>();
    Ptr<Node> ictCentre2 = CreateObject<Node>();
    Ptr<Node> admin1 = CreateObject<Node>();
    Ptr<Node> admin2 = CreateObject<Node>();
    Ptr<Node> registrar1 = CreateObject<Node>();
    Ptr<Node> registrar2 = CreateObject<Node>();
    Ptr<Node> mpe2 = CreateObject<Node>();
    Ptr<Node> cseRouter = CreateObject<Node>();
    Ptr<Node> eeeRouter = CreateObject<Node>();
    Ptr<Node> mpeRouter = CreateObject<Node>();
    
    Ptr<Node> ab4Router = CreateObject<Node>();

    NodeContainer cseNet(cseRouter , cse1, cse2 );
    NodeContainer eeeNet(eeeRouter , eee2, eee2 );
    NodeContainer mpeNet(mpeRouter , mpe1, mpe2 );
    NodeContainer routerNet(cseRouter , eeeRouter , mpeRouter , ab4Router);
    
    
    NodeContainer ab4Net(ab4Router , admin1 , admin2 , ictCentre1 , ictCentre2 ,registrar1 , registrar2)
    


    
 
    CsmaHelper csma;
    csma.SetChannelAttribute("DataRate", DataRateValue(5000000));
    csma.SetChannelAttribute("Delay", TimeValue(MilliSeconds(2)));
    NetDeviceContainer cseNDC1 = csma.Install(cseNet1);
    NetDeviceContainer cseNDC2 = csma.Install(cseNet2);
    NetDeviceContainer eeeNDC1 = csma.Install(eeeNet1);
    NetDeviceContainer eeeNDC2 = csma.Install(eeeNet2);
    NetDeviceContainer mpeNDC1 = csma.Install(mpeNet1);
    NetDeviceContainer mpeNDC2 = csma.Install(mpeNet2);

    NetDeviceContainer adminNDC1 = csma.Install(adminNet1);
    NetDeviceContainer adminNDC2 = csma.Install(adminNet2);
    NetDeviceContainer ictNDC1 = csma.Install(ictNet1);
    NetDeviceContainer ictNDC2 = csma.Install(ictNet2);
    NetDeviceContainer registrarNDC1 = csma.Install(registrarNet1);
    NetDeviceContainer registrarNDC2 = csma.Install(registrarNet2);
 
     // Step 1: Create Nodes
 
     NodeContainer csmaAB1Nodes, csmaAB4Nodes;
     csmaAB1Nodes.Create(7);
     csmaAB4Nodes.Create(7);
 
     // Step 2: Connect AB1 and AB4 via P2P
     NodeContainer p2pNodes;
     p2pNodes.Add(csmaAB1Nodes.Get(0));
     p2pNodes.Add(csmaAB4Nodes.Get(0));
 
     // Step 3: Configure CSMA for Departments
     NetDeviceContainer p2pDevices;
     p2pDevices = pointToPoint.Install(p2pNodes);
     NodeContainer csmaCSENodes;
     csmaCSENodes.Add(csmaAB1Nodes.Get(0));
     csmaCSENodes.Add(csmaAB1Nodes.Get(1));
     csmaCSENodes.Add(csmaAB1Nodes.Get(2));
     NetDeviceContainer csmaCSEDevices;
     csmaCSEDevices = csma.Install(csmaCSENodes);
 
     NodeContainer csmaEEENodes;
     csmaEEENodes.Add(csmaAB1Nodes.Get(0));
     csmaEEENodes.Add(csmaAB1Nodes.Get(3));
     csmaEEENodes.Add(csmaAB1Nodes.Get(4));
     NetDeviceContainer csmaEEEDevices;
     csmaEEEDevices = csma.Install(csmaEEENodes);
 
     NodeContainer csmaMPENodes;
     csmaMPENodes.Add(csmaAB1Nodes.Get(0));
     csmaMPENodes.Add(csmaAB1Nodes.Get(5));
     csmaMPENodes.Add(csmaAB1Nodes.Get(6));
     NetDeviceContainer csmaMPEDevices;
     csmaMPEDevices = csma.Install(csmaMPENodes);
 
     NodeContainer csmaICTCentreNodes;
     csmaICTCentreNodes.Add(csmaAB4Nodes.Get(0));
     csmaICTCentreNodes.Add(csmaAB4Nodes.Get(1));
     csmaICTCentreNodes.Add(csmaAB4Nodes.Get(2));
     NetDeviceContainer csmaICTCentreDevices;
     csmaICTCentreDevices = csma.Install(csmaICTCentreNodes);
 
     NodeContainer csmaAdminNodes;
     csmaAdminNodes.Add(csmaAB4Nodes.Get(0));
     csmaAdminNodes.Add(csmaAB4Nodes.Get(3));
     csmaAdminNodes.Add(csmaAB4Nodes.Get(4));
     NetDeviceContainer csmaAdminDevices;
     csmaAdminDevices = csma.Install(csmaAdminNodes);
 
     NodeContainer csmaRegistrarNodes;
 
     csmaRegistrarNodes.Add(csmaAB4Nodes.Get(0));
     csmaRegistrarNodes.Add(csmaAB4Nodes.Get(5));
     csmaRegistrarNodes.Add(csmaAB4Nodes.Get(6));
     NetDeviceContainer csmaRegistrarDevices;
     csmaRegistrarDevices = csma.Install(csmaRegistrarNodes);
 
     InternetStackHelper stack;
     //  stack.Install(p2pNodes);
     stack.Install(csmaAB1Nodes);
     stack.Install(csmaAB4Nodes);
 
     // Step 4: Assign IP Addresses
     Ipv4AddressHelper address;
     address.SetBase("192.168.240.0", "255.255.255.252");
     Ipv4InterfaceContainer p2pInterfaces;
     p2pInterfaces = address.Assign(p2pDevices);
 
     address.SetBase("192.168.26.0", "255.255.255.192");
     Ipv4InterfaceContainer csmaCSEInterfaces;
     csmaCSEInterfaces = address.Assign(csmaCSEDevices);
 
     address.SetBase("192.168.26.64", "255.255.255.192");
     Ipv4InterfaceContainer csmaEEEInterfaces;
     csmaEEEInterfaces = address.Assign(csmaEEEDevices);
     address.SetBase("192.168.26.128", "255.255.255.192");
     Ipv4InterfaceContainer csmaMPEInterfaces;
     csmaMPEInterfaces = address.Assign(csmaMPEDevices);
 
     address.SetBase("192.168.26.192", "255.255.255.240");
     Ipv4InterfaceContainer csmaICTCentreInterfaces;
     csmaICTCentreInterfaces = address.Assign(csmaICTCentreDevices);
 
     address.SetBase("192.168.26.208", "255.255.255.240");
     Ipv4InterfaceContainer csmaAdminInterfaces;
     csmaAdminInterfaces = address.Assign(csmaAdminDevices);
 
     address.SetBase("192.168.26.224", "255.255.255.240");
     Ipv4InterfaceContainer csmaRegistrarInterfaces;
     csmaRegistrarInterfaces = address.Assign(csmaRegistrarDevices);
 
     UdpEchoServerHelper echoServer(9);
 
     // Step 5: Install UDP Echo Applications
 
     ApplicationContainer serverApps = echoServer.Install(p2pNodes.Get(0));
     serverApps.Start(Seconds(1.0));
     serverApps.Stop(Seconds(20.0));
 
     UdpEchoClientHelper echoClient(p2pInterfaces.GetAddress(0), 9);
     echoClient.SetAttribute("MaxPackets", UintegerValue(1));
     echoClient.SetAttribute("Interval", TimeValue(Seconds(1.0)));
     echoClient.SetAttribute("PacketSize", UintegerValue(1024));
 
     UdpEchoClientHelper echoCSEClient(csmaCSEInterfaces.GetAddress(0), 9);
     echoCSEClient.SetAttribute("MaxPackets", UintegerValue(1));
     echoCSEClient.SetAttribute("Interval", TimeValue(Seconds(1.0)));
     echoCSEClient.SetAttribute("PacketSize", UintegerValue(1024));
 
     UdpEchoClientHelper echoEEEClient(csmaEEEInterfaces.GetAddress(0), 9);
     echoEEEClient.SetAttribute("MaxPackets", UintegerValue(1));
     echoEEEClient.SetAttribute("Interval", TimeValue(Seconds(1.0)));
     echoEEEClient.SetAttribute("PacketSize", UintegerValue(1024));
 
     UdpEchoClientHelper echoMPEClient(csmaMPEInterfaces.GetAddress(0), 9);
     echoMPEClient.SetAttribute("MaxPackets", UintegerValue(1));
     echoMPEClient.SetAttribute("Interval", TimeValue(Seconds(1.0)));
     echoMPEClient.SetAttribute("PacketSize", UintegerValue(1024));
 
     UdpEchoClientHelper echoICTCentreClient(csmaICTCentreInterfaces.GetAddress(0), 9);
     echoICTCentreClient.SetAttribute("MaxPackets", UintegerValue(1));
     echoICTCentreClient.SetAttribute("Interval", TimeValue(Seconds(1.0)));
     echoICTCentreClient.SetAttribute("PacketSize", UintegerValue(1024));
 
     UdpEchoClientHelper echoAdminClient(csmaAdminInterfaces.GetAddress(0), 9);
     echoAdminClient.SetAttribute("MaxPackets", UintegerValue(1));
     echoAdminClient.SetAttribute("Interval", TimeValue(Seconds(1.0)));
     echoAdminClient.SetAttribute("PacketSize", UintegerValue(1024));
 
     UdpEchoClientHelper echoRegistrarClient(csmaRegistrarInterfaces.GetAddress(0), 9);
     echoRegistrarClient.SetAttribute("MaxPackets", UintegerValue(1));
     echoRegistrarClient.SetAttribute("Interval", TimeValue(Seconds(1.0)));
     echoRegistrarClient.SetAttribute("PacketSize", UintegerValue(1024));
 
     ApplicationContainer clientApps = echoClient.Install(p2pNodes.Get(1));
     clientApps.Start(Seconds(1.0));
     clientApps.Stop(Seconds(10.0));
 
     ApplicationContainer clientCSEApps = echoCSEClient.Install(csmaCSENodes.Get(1));
     clientCSEApps.Start(Seconds(1.0));
     clientCSEApps.Stop(Seconds(10.0));
     ApplicationContainer clientEEEApps = echoEEEClient.Install(csmaEEENodes.Get(1));
     clientEEEApps.Start(Seconds(1.0));
     clientEEEApps.Stop(Seconds(10.0));
     ApplicationContainer clientMPEApps = echoEEEClient.Install(csmaMPENodes.Get(1));
     clientMPEApps.Start(Seconds(1.0));
     clientMPEApps.Stop(Seconds(10.0));
 
     ApplicationContainer clientAdminApps = echoAdminClient.Install(csmaAdminNodes.Get(1));
     clientAdminApps.Start(Seconds(1.0));
     clientAdminApps.Stop(Seconds(10.0));
 
     ApplicationContainer clientRegistrarApps = echoRegistrarClient.Install(csmaAdminNodes.Get(1));
     clientRegistrarApps.Start(Seconds(1.0));
     clientRegistrarApps.Stop(Seconds(10.0));
 
     // Step 6: Enable Routing
     Ipv4GlobalRoutingHelper::PopulateRoutingTables();
 
     Simulator::Run();
     Simulator::Destroy();
     return 0;
 }
 