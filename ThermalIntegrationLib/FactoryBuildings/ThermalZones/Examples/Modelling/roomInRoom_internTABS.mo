within ThermalIntegrationLib.FactoryBuildings.ThermalZones.Examples.Modelling;
model roomInRoom_internTABS
  extends Modelica.Icons.Example;
  ThermalZones.ProductionHall productionHall(
    useHeatPortAir=false,
    useHeatPortRad=false,
    useFluidPorts=true,
    useHeatInputConv=false,
    useHeatInputRad=false,
    nPeople=127,
    length=130,
    width=60,
    zoneHeight=10.72,
    hasEnclosure=true,
    enclosureVolume=enclosure.length*enclosure.width*enclosure.zoneHeight,
    nSurBou=5,
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
      each A=productionHall.roo.AFlo - enclosure.length*enclosure.width,
      each stateAtSurface_a=false),
    surBou(A={enclosure.length*enclosure.zoneHeight,enclosure.length*enclosure.zoneHeight,enclosure.width*enclosure.zoneHeight,enclosure.width*enclosure.zoneHeight,enclosure.length*enclosure.width}, til={Buildings.Types.Tilt.Wall,Buildings.Types.Tilt.Wall,Buildings.Types.Tilt.Wall,Buildings.Types.Tilt.Wall,Buildings.Types.Tilt.Ceiling}),
    nFPorts=3) annotation (Placement(transformation(extent={{-82,8},{-48,42}})));
  Buildings.BoundaryConditions.WeatherData.ReaderTMY3 weaDat(filNam=ModelicaServices.ExternalReferences.loadResource("modelica://ThermalIntegrationLib/Resources/weatherdata/DEU_Frankfurt.am.Main.106370_IWEC.mos"))
                                                                                                                                                                                                        annotation (Placement(transformation(extent={{82,74},{68,88}})));
  Modelica.Blocks.Sources.Sine GroundTemperature(
    amplitude=10,
    freqHz=1/(8760*3600),
    phase=-1.7453292519943,
    offset=273.15 + 10) annotation (Placement(transformation(extent={{96,-72},{86,-62}})));
  InternalGains.Gain_th_per_area machineType1(shareRad=0.3, nominalPower=5000/enclosure.roo.AFlo) annotation (Placement(transformation(extent={{-56,-86},{-48,-78}})));
  ThermalZones.Enclosure enclosure(
    useFluidPorts=true,
    acrInf=0.1,
    acrVent=0.5,
    calcUseHeatDem=false,
    qThermalBridge=0.05,
    disPipTABS=0.02,
    each pipeTABS=datPip,
    nCirTABS=75,
    iLayPipTABS=layTABS.nLay - 1,
    lengthTABS=6.6,
    nConBou=5,
    nSurBou=1,
    nGroundFloor=1,
    nConTABS=1,
    datConBou(
      name={"Floor","North","South","East","West"},
      layers={floor,enclosureWalls,enclosureWalls,enclosureWalls,enclosureWalls},
      til={Buildings.Types.Tilt.Floor,Buildings.Types.Tilt.Wall,Buildings.Types.Tilt.Wall,Buildings.Types.Tilt.Wall,Buildings.Types.Tilt.Wall},
      azi={0,Buildings.Types.Azimuth.N,Buildings.Types.Azimuth.S,Buildings.Types.Azimuth.E,Buildings.Types.Azimuth.W},
      A={enclosure.length*enclosure.width,enclosure.length*enclosure.zoneHeight,enclosure.length*enclosure.zoneHeight,enclosure.width*enclosure.zoneHeight,enclosure.width*enclosure.zoneHeight},
      each stateAtSurface_a=false),
    surBou(
      each A=enclosure.length*enclosure.width,
      each absIR=0.9,
      each absSol=0.9,
      each til=Buildings.Types.Tilt.Ceiling),
    layersTABS=layTABS,
    nFPorts=3) "Room model" annotation (Placement(transformation(extent={{24,8},{54,38}})));
  parameter HeatTransfer.Data.OpaqueConstructions.Concrete100 enclosureWalls annotation (Placement(transformation(extent={{82,-98},{96,-84}})));
  parameter HeatTransfer.Data.OpaqueConstructions.CassetteWall120 outsideWalls_WE annotation (Placement(transformation(extent={{-70,80},{-50,100}})));
  parameter HeatTransfer.Data.OpaqueConstructions.SandwichWall outsideWalls_SN annotation (Placement(transformation(extent={{-98,80},{-78,100}})));
  parameter HeatTransfer.Data.OpaqueConstructions.FlatRoof_PIR roof annotation (Placement(transformation(extent={{-44,80},{-24,100}})));
  parameter Buildings.HeatTransfer.Data.GlazingSystems.DoubleClearAir13Clear window annotation (Placement(transformation(extent={{8,80},{28,100}})));
  parameter Buildings.HeatTransfer.Data.OpaqueConstructions.Concrete200 floor annotation (Placement(transformation(extent={{-18,80},{2,100}})));
  Modelica.Blocks.Sources.CombiTimeTable schedTable(
    table=[0.0,0.0; 8,1; 17,0.0; 24,0],
    columns=2:size(schedTable.table, 2),
    smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments,
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
    timeScale(displayUnit="h") = 3600) "schedules for 1) occupancy and 2) lighting (weekdays), 3) occupancy and 4) lighting (weekend)" annotation (Placement(transformation(extent={{-80,-90},{-66,-76}})));
  Buildings.Airflow.Multizone.DoorOperable Door(
    show_T=false,
    redeclare package Medium = Buildings.Media.Air,
    wOpe=2.5,
    hOpe=2.5,
    CDOpe=0.65,
    mOpe=0.5,
    LClo=2000*1E-4,
    dpCloRat=4,
    CDCloRat=1) annotation (Placement(transformation(extent={{-18,48},{-2,64}})));
  Modelica.Blocks.Sources.CombiTimeTable doorOperation(
    table=[0,0; 8,0.1; 9,0; 12,0.1; 13,0; 14,0.5; 15,0.1; 18,0; 24,0],
    columns=2:size(schedTable.table, 2),
    smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments,
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
    timeScale(displayUnit="h") = 3600) "schedules for the door between production hall and enclosure" annotation (Placement(transformation(extent={{-80,58},{-66,72}})));
  parameter HeatTransfer.Data.Pipes.PEX_DN_3dot35                                                  datPip annotation (Placement(transformation(extent={{66,-98},{78,-86}})));
  Buildings.Fluid.Sources.MassFlowSource_T boundary(
    redeclare package Medium = Buildings.Media.Water,
    m_flow=1,
    T=283.15,
    nPorts=1) annotation (Placement(transformation(extent={{-62,-48},{-46,-32}})));
  Buildings.Fluid.Sources.Boundary_pT bou(redeclare package Medium = Buildings.Media.Water, nPorts=1) annotation (Placement(transformation(extent={{24,-52},{14,-42}})));
  parameter HeatTransfer.Data.OpaqueConstructions.Ducon_VacuumInsulated layTABS annotation (Placement(transformation(extent={{50,-98},{64,-84}})));
equation
  connect(productionHall.T_ground, GroundTemperature.y) annotation (Line(points={{-66.87,5.45},{-80,5.45},{-80,-10},{28,-10},{28,-68},{72,-68},{72,-67},{85.5,-67}},
                                                                                                                              color={0,0,127}));
  connect(weaDat.weaBus, productionHall.weaBus) annotation (Line(
      points={{68,81},{32,81},{32,46},{-64.66,46},{-64.66,41.66}},
      color={255,204,51},
      thickness=0.5));

  connect(productionHall.insideRoomTemperature, enclosure.ventilationTemperature) annotation (Line(points={{-45.96,35.88},{-14,35.88},{-14,40.4},{39,40.4}},                     color={0,0,127}));
  connect(GroundTemperature.y, enclosure.T_ground) annotation (Line(points={{85.5,-67},{72,-67},{72,-82},{36,-82},{36,-68},{37.35,-68},{37.35,5.75}},
                                                                                                                                                   color={0,0,127}));
  connect(machineType1.Qth_conv, enclosure.Q_gainConv) annotation (Line(points={{-47.28,-83.2},{-19.64,-83.2},{-19.64,10.55},{21.75,10.55}},
                                                                                                                                          color={0,0,127}));
  connect(machineType1.Qth_rad, enclosure.Q_gainRad) annotation (Line(points={{-47.28,-84.8},{-6,-84.8},{-6,8},{8,8},{8,16},{21.75,16},{21.75,15.05}},
                                                                                                                                color={0,0,127}));
  connect(schedTable.y[1], machineType1.schedule) annotation (Line(points={{-65.3,-83},{-56.8,-82}}, color={0,0,127}));
  connect(productionHall.fPorts[1], Door.port_a1) annotation (Line(points={{-83.7,28.9667},{-88,28.9667},{-88,60.8},{-18,60.8}}, color={0,127,255}));
  connect(productionHall.fPorts[2], Door.port_b2) annotation (Line(points={{-83.7,33.5},{-88,33.5},{-88,60},{-24,60},{-24,51.2},{-18,51.2}}, color={0,127,255}));
  connect(Door.port_b1, enclosure.fPorts[1]) annotation (Line(points={{-2,60.8},{4,60.8},{4,26.5},{22.5,26.5}}, color={0,127,255}));
  connect(Door.port_a2, enclosure.fPorts[2]) annotation (Line(points={{-2,51.2},{12,51.2},{12,30.5},{22.5,30.5}}, color={0,127,255}));
  connect(productionHall.fPorts[3], enclosure.fPorts[3]) annotation (Line(points={{-83.7,38.0333},{-86,38.0333},{-86,50},{-26,50},{-26,36},{4,36},{4,26},{16,26},{16,34.5},{22.5,34.5}}, color={0,127,255}));
  connect(doorOperation.y[1], Door.y) annotation (Line(points={{-65.3,65},{-64,65},{-64,56},{-18.8,56}}, color={0,0,127}));
  connect(productionHall.insideRoomTemperature, enclosure.infiltrationTemperature) annotation (Line(points={{-45.96,35.88},{0.02,35.88},{0.02,40.4},{45,40.4}}, color={0,0,127}));
  connect(boundary.ports[1:1], enclosure.portTABS_a) annotation (Line(points={{-46,-40},{-4,-40},{-4,20.9},{22.5,20.9}}, color={0,127,255}));
  connect(bou.ports[1:1], enclosure.portTABS_b) annotation (Line(points={{14,-47},{12,-47},{12,2},{27.9,2},{27.9,6.5}}, color={0,127,255}));
  connect(enclosure.surf_conBou[1:4], productionHall.surf_surBou[1:4]) annotation (Line(points={{51.3,6.5},{50,6.5},{50,-4},{-58,-4},{-58,2},{-59.22,2},{-59.22,6.98}}, color={191,0,0}));
  connect(enclosure.surf_conTABS[1], productionHall.surf_surBou[5]) annotation (Line(points={{47.7,6.5},{46,6.5},{46,-4},{-58,-4},{-58,2},{-59.22,2},{-59.22,7.66}}, color={191,0,0}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(extent={{-100,-70},{-16,-100}},lineColor={28,108,200}),
        Text(
          extent={{-96,-88},{0,-100}},
          lineColor={28,108,200},
          horizontalAlignment=TextAlignment.Left,
          fontSize=8,
          textString="Dummy for machine waste heat")}),                                                                                                           experiment(
      StopTime=31536000,
      Interval=3600,
      __Dymola_Algorithm="CVODE"));
end roomInRoom_internTABS;
