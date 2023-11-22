within ThermalIntegrationLib.FactoryBuildings.ThermalZones.Examples.Modelling;
model example_productionHall_PID
  extends Modelica.Icons.Example;
  ThermalZones.ProductionHall productionHall(
    useHeatPortAir=false,
    useFluidPorts=true,
    useHeatInputConv=false,
    useHeatInputRad=false,
    nPeople=127,
    acrVent=3,
    calcUseHeatDem=false,
    length=130,
    width=60,
    zoneHeight=10.72,
    nConExt=3,
    nFPorts=1,
    latitude=0.87266462599716,
    datConExt(
      name={"North","East","West"},
      layers={outsideWalls_SN,outsideWalls_WE,outsideWalls_WE},
      til={Buildings.Types.Tilt.Wall,Buildings.Types.Tilt.Wall,Buildings.Types.Tilt.Wall},
      azi={Buildings.Types.Azimuth.N,Buildings.Types.Azimuth.E,Buildings.Types.Azimuth.W},
      A={productionHall.length*productionHall.zoneHeight,productionHall.width*productionHall.zoneHeight,productionHall.width*productionHall.zoneHeight}),
    datConExtWin(
      name={"South","Ceiling"},
      layers={outsideWalls_SN,roof},
      til={Buildings.Types.Tilt.Wall,Buildings.Types.Tilt.Ceiling},
      azi={Buildings.Types.Azimuth.S,0},
      A={productionHall.length*productionHall.zoneHeight,productionHall.roo.AFlo},
      hWin={2,10},
      wWin={40.7,89},
      each ove(
        wL=0,
        wR=0,
        dep=0,
        gap=0),
      each sidFin(
        h=0,
        dep=0,
        gap=0),
      each glaSys=window),
    datConBou(
      each name="Floor",
      layers={floor},
      each til=Buildings.Types.Tilt.Floor,
      each azi=0,
      each A=productionHall.roo.AFlo,
      each stateAtSurface_a=false)) annotation (Placement(transformation(extent={{32,-4},{78,42}})));
  Buildings.BoundaryConditions.WeatherData.ReaderTMY3 weaDat(filNam=ModelicaServices.ExternalReferences.loadResource("modelica://ThermalIntegrationLib/Resources/weatherdata/DEU_Frankfurt.am.Main.106370_IWEC.mos"))
                                                                                                                                                                                                        annotation (Placement(transformation(extent={{16,78},{30,92}})));
  Modelica.Blocks.Sources.Sine GroundTemperature(
    amplitude=10,
    freqHz=1/(8760*3600),
    phase=-1.7453292519943,
    offset=273.15 + 10) annotation (Placement(transformation(extent={{24,-48},{34,-38}})));
  Buildings.Fluid.Sources.MassFlowSource_T flowSource(
    redeclare package Medium = Buildings.Media.Air,
    use_m_flow_in=true,
    m_flow=0.01,
    use_T_in=false,
    T=293.15,
    nPorts=1) annotation (Placement(transformation(extent={{-62,-46},{-42,-26}})));
  Modelica.Blocks.Sources.Constant const(k=273.15 + 25)
    annotation (Placement(transformation(extent={{-92,52},{-72,72}})));
  Modelica.Blocks.Continuous.LimPID PID(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=15e4,
    Ti=3000,
    yMax=Modelica.Constants.inf,
    initType=Modelica.Blocks.Types.InitPID.InitialState)
    annotation (Placement(transformation(extent={{-58,32},{-38,52}})));
  parameter HeatTransfer.Data.OpaqueConstructions.CassetteWall120 outsideWalls_WE annotation (Placement(transformation(extent={{-66,-96},{-46,-76}})));
  parameter HeatTransfer.Data.OpaqueConstructions.SandwichWall outsideWalls_SN annotation (Placement(transformation(extent={{-94,-96},{-74,-76}})));
  HeatTransfer.Data.OpaqueConstructions.FlatRoof_PIR roof annotation (Placement(transformation(extent={{-40,-96},{-20,-76}})));
  parameter Buildings.HeatTransfer.Data.GlazingSystems.DoubleClearAir13Clear window annotation (Placement(transformation(extent={{10,-96},{30,-76}})));
  parameter Buildings.HeatTransfer.Data.OpaqueConstructions.Concrete200 floor annotation (Placement(transformation(extent={{-14,-96},{6,-76}})));
equation
  connect(weaDat.weaBus, productionHall.weaBus) annotation (Line(
      points={{30,85},{30,48},{6,48},{6,41.54},{55.46,41.54}},
      color={255,204,51},
      thickness=0.5));
  connect(productionHall.T_ground, GroundTemperature.y) annotation (Line(points={{52.47,-7.45},{52.47,-43},{34.5,-43}},       color={0,0,127}));
  connect(flowSource.ports[1], productionHall.fPorts[1]) annotation (Line(points={{-42,-36},{-20,-36},{-20,30.5},{29.7,30.5}},
                                                                                                                       color={0,127,255}));
  connect(productionHall.insideRoomTemperature, PID.u_m) annotation (Line(points={{80.76,33.72},{86,33.72},{86,46},{4,46},{4,36},{-32,36},{-32,24},{-48,24},{-48,30}}, color={0,0,127}));
  connect(const.y, PID.u_s) annotation (Line(points={{-71,62},{-66,62},{-66,42},{-60,42}}, color={0,0,127}));
  connect(flowSource.m_flow_in, PID.y) annotation (Line(points={{-64,-28},{-64,-26},{-80,-26},{-80,12},{-30,12},{-30,42},{-37,42}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false), graphics={Rectangle(
          extent={{-100,88},{2,20}},
          lineColor={0,0,0},
          lineThickness=1), Text(
          extent={{-100,86},{-36,80}},
          lineColor={0,0,0},
          textString="Heating/cooling control")}),                                                                    experiment(
      StopTime=31536000,
      Interval=3600,
      __Dymola_Algorithm="CVODE"));
end example_productionHall_PID;
