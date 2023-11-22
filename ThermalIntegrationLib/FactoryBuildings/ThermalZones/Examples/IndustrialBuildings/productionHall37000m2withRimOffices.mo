within ThermalIntegrationLib.FactoryBuildings.ThermalZones.Examples.IndustrialBuildings;
model productionHall37000m2withRimOffices "A production hall from 1991 with rim constructions for offices on north and south side"
  extends Modelica.Icons.Example;
  Buildings.BoundaryConditions.WeatherData.ReaderTMY3 weaDat(filNam=ModelicaServices.ExternalReferences.loadResource("modelica://ThermalIntegrationLib/Resources/weatherdata/DEU_Frankfurt.am.Main.106370_IWEC.mos"))
                                                             annotation (Placement(transformation(extent={{-96,78},{-78,96}})));
  Modelica.Blocks.Sources.Sine GroundTemperature(
    amplitude=10,
    freqHz=1/(8760*3600),
    phase=-1.7453292519943,
    offset=273.15 + 10) annotation (Placement(transformation(extent={{-94,-56},{-84,-46}})));
  ThermalZones.ProductionHall office1_EG(
    useHeatInputConv=false,
    useHeatInputRad=false,
    nPeople=25,
    pElLights=20,
    pElDevices=15,
    effDevices=0.75,
    acrVent=0.5,
    calcUseHeatDem=true,
    length=191.52,
    width=8.15,
    zoneHeight=3.75,
    nMinPplVent=1,
    nConExt=0,
    nConExtWin=3,
    nConBou=1,
    nSurBou=2,
    nGroundFloor=1,
    datConExtWin(
      name={"North","East","West"},
      layers={outerWall_office1_EG,outerWall_office1_EG,outerWall_office1_EG},
      til={Buildings.Types.Tilt.Wall,Buildings.Types.Tilt.Wall,Buildings.Types.Tilt.Wall},
      azi={Buildings.Types.Azimuth.N,Buildings.Types.Azimuth.E,Buildings.Types.Azimuth.W},
      A={office1_EG.length*office1_EG.zoneHeight,office1_EG.width*office1_EG.zoneHeight,office1_EG.width*office1_EG.zoneHeight},
      hWin={1.5,1.5,1.5},
      wWin={office1_EG.length,office1_EG.width,office1_EG.width},
      each ove(
        wL=0,
        wR=0,
        dep=0,
        gap=0),
      each sidFin(
        h=0,
        dep=0,
        gap=0),
      each glaSys=win_o1EG),
    datConBou(
      name={"Floor"},
      layers={floor_office1_EG},
      til={Buildings.Types.Tilt.Floor},
      each azi=0,
      each A=office1_EG.roo.AFlo,
      each stateAtSurface_a=false),
    surBou(til={Buildings.Types.Tilt.Wall,Buildings.Types.Tilt.Ceiling}, A={office1_EG.length*office1_EG.zoneHeight,office1_EG.roo.AFlo}),
    envelopeArea=2*office1_EG.length*office1_EG.zoneHeight + 2*office1_EG.width*office1_EG.zoneHeight,
    lastDayOfWorkWeek=Types.Weekday.Friday,
    schedules=[0,0,0.05,0,0.05; 6,0.1,0.1,0.05,0.05; 7,0.2,0.3,0.05,0.05; 8,0.95,0.3,0.05,0.05; 9,0.95,0.9,0.05,0.05; 13,0.95,0.5,0.05,0.05; 17,0.3,0.5,0.05,0.05; 18,0.1,0.3,0,0.05; 19,0.1,0.3,0,0.05; 20,0.1,0.2,0,0.05; 22,0,0.1,0,0.05; 23,0,0.05,0,0.05; 24,0,0.05,0,0.05]) annotation (Placement(transformation(extent={{-24,44},{6,74}})));
  ThermalZones.ProductionHall office1_OG(
    useHeatInputConv=false,
    useHeatInputRad=false,
    nPeople=25,
    pElLights=20,
    pElDevices=11,
    effDevices=0.8,
    acrVent=0.6,
    calcUseHeatDem=true,
    length=191.52,
    width=8.15,
    zoneHeight=3.65,
    nMinPplVent=1,
    nConExt=3,
    nConExtWin=1,
    nConBou=1,
    nSurBou=1,
    nGroundFloor=0,
    datConExt(
      name={"East","West","Ceiling"},
      layers={outerWall_office1_OG,outerWall_office1_OG,roof_office1},
      til={Buildings.Types.Tilt.Wall,Buildings.Types.Tilt.Wall,Buildings.Types.Tilt.Ceiling},
      azi={Buildings.Types.Azimuth.E,Buildings.Types.Azimuth.W,0},
      A={office1_OG.width*office1_OG.zoneHeight,office1_OG.width*office1_OG.zoneHeight,office1_OG.roo.AFlo}),
    datConExtWin(
      name={"North"},
      layers={outerWall_office1_OG},
      til={Buildings.Types.Tilt.Wall},
      azi={Buildings.Types.Azimuth.N},
      A={office1_OG.length*office1_OG.zoneHeight},
      hWin={1.5},
      wWin={office1_OG.length},
      each ove(
        wL=0,
        wR=0,
        dep=0,
        gap=0),
      each sidFin(
        h=0,
        dep=0,
        gap=0),
      each glaSys=win_o1OG),
    datConBou(
      name={"Floor"},
      layers={floor_office1_OG},
      til={Buildings.Types.Tilt.Floor},
      each azi=0,
      each A=office1_EG.roo.AFlo,
      each stateAtSurface_a=false),
    surBou(til={Buildings.Types.Tilt.Wall}, A={office1_OG.length*office1_OG.zoneHeight}),
    envelopeArea=2*office1_OG.length*office1_OG.zoneHeight + 2*office1_OG.width*office1_OG.zoneHeight,
    lastDayOfWorkWeek=Types.Weekday.Friday,
    schedules=[0,0,0.05,0,0.05; 6,0.1,0.1,0.05,0.05; 7,0.2,0.3,0.05,0.05; 8,0.95,0.3,0.05,0.05; 9,0.95,0.9,0.05,0.05; 13,0.95,0.5,0.05,0.05; 17,0.3,0.5,0.05,0.05; 18,0.1,0.3,0,0.05; 19,0.1,0.3,0,0.05; 20,0.1,0.2,0,0.05; 22,0,0.1,0,0.05; 23,0,0.05,0,0.05; 24,0,0.05,0,0.05]) "Office First floor" annotation (Placement(transformation(extent={{20,44},{50,74}})));
  ThermalZones.ProductionHall productionHall(
    useHeatPortAir=false,
    useHeatPortRad=false,
    useFluidPorts=false,
    nPeople=50,
    acrInf=0.35,
    calcUseHeatDem=true,
    length=218.53,
    width=138.7,
    zoneHeight=7.4,
    Tmin_occ=291.15,
    Tmax_occ=299.15,
    pMaxCool=0,
    nConExt=5,
    nConExtWin=4,
    nConBou=5,
    nSurBou=0,
    datConExtWin(
      name={"North","South","East","West"},
      layers={cassetteWall,cassetteWall,cassetteWall,cassetteWall},
      til={Buildings.Types.Tilt.Wall,Buildings.Types.Tilt.Wall,Buildings.Types.Tilt.Wall,Buildings.Types.Tilt.Wall},
      azi={Buildings.Types.Azimuth.N,Buildings.Types.Azimuth.S,Buildings.Types.Azimuth.E,Buildings.Types.Azimuth.W},
      A={27.01*3.75,68.53*3.75,productionHall.width*3.75,productionHall.width*3.75},
      hWin={1.5,1.5,1.5,1.5},
      wWin={27.01,68.53,productionHall.width,productionHall.width},
      each ove(
        wL=0,
        wR=0,
        dep=0,
        gap=0),
      each sidFin(
        h=0,
        dep=0,
        gap=0),
      each glaSys=win),
    datConExt(
      name={"Ceiling","West","East","South","North"},
      layers={roof_ph,cassetteWall,cassetteWall,cassetteWall,cassetteWall},
      til={Buildings.Types.Tilt.Ceiling,Buildings.Types.Tilt.Wall,Buildings.Types.Tilt.Wall,Buildings.Types.Tilt.Wall,Buildings.Types.Tilt.Wall},
      azi={0,Buildings.Types.Azimuth.W,Buildings.Types.Azimuth.E,Buildings.Types.Azimuth.S,Buildings.Types.Azimuth.N},
      A={productionHall.roo.AFlo,productionHall.width*3.65,productionHall.width*3.65,188.53*3.65,27.01*3.65}),
    datConBou(
      name={"Floor","NorthEG","NorthOG","SouthEG","SouthOG"},
      layers={floor_ph,interiourWall,interiourWall,interiourWall,interiourWall},
      til={Buildings.Types.Tilt.Floor,Buildings.Types.Tilt.Wall,Buildings.Types.Tilt.Wall,Buildings.Types.Tilt.Wall,Buildings.Types.Tilt.Wall},
      azi={0,Buildings.Types.Azimuth.N,Buildings.Types.Azimuth.N,Buildings.Types.Azimuth.S,Buildings.Types.Azimuth.S},
      A={productionHall.roo.AFlo,office1_EG.length*office1_EG.zoneHeight,office1_OG.length*office1_OG.zoneHeight,office2_EG.length*office2_EG.zoneHeight,office2_OG.length*office2_OG.zoneHeight},
      each stateAtSurface_a=false),
    k=productionHall.roo.V*1.2*1005,
    envelopeArea=2*productionHall.length*productionHall.zoneHeight + 2*productionHall.width*productionHall.zoneHeight,
    lastDayOfWorkWeek=Types.Weekday.Friday,
    schedules=[0,0,0.05,0,0.05; 6,0.1,0.1,0.05,0.05; 7,0.2,0.3,0.05,0.05; 8,0.95,0.3,0.05,0.05; 9,0.95,0.9,0.05,0.05; 13,0.95,0.5,0.05,0.05; 17,0.3,0.5,0.05,0.05; 18,0.1,0.3,0,0.05; 19,0.1,0.3,0,0.05; 20,0.1,0.2,0,0.05; 22,0,0.1,0,0.05; 23,0,0.05,0,0.05; 24,0,0.05,0,0.05]) annotation (Placement(transformation(extent={{-20,-14},{12,18}})));
  ThermalZones.ProductionHall office2_EG(
    useHeatInputConv=false,
    useHeatInputRad=false,
    nPeople=10,
    pElLights=20,
    pElDevices=12,
    effDevices=0.75,
    acrVent=0.5,
    calcUseHeatDem=true,
    length=150,
    width=8.5,
    zoneHeight=3.75,
    nMinPplVent=1,
    nConExt=1,
    nConExtWin=3,
    nConBou=1,
    nSurBou=2,
    nGroundFloor=1,
    datConExt(
      name={"Ceiling"},
      layers={ceiling_office2},
      til={Buildings.Types.Tilt.Ceiling},
      azi={0},
      A={office2_EG.roo.AFlo - office2_OG.roo.AFlo}),
    datConExtWin(
      name={"South","East","West"},
      layers={outerWall_office2_EG,outerWall_office2_EG,outerWall_office2_EG},
      til={Buildings.Types.Tilt.Wall,Buildings.Types.Tilt.Wall,Buildings.Types.Tilt.Wall},
      azi={Buildings.Types.Azimuth.S,Buildings.Types.Azimuth.E,Buildings.Types.Azimuth.W},
      A={office2_EG.length*office2_EG.zoneHeight,office2_EG.width*office2_EG.zoneHeight,office2_EG.width*office2_EG.zoneHeight},
      hWin={1.5,1.5,1.5},
      wWin={office2_EG.length,office2_EG.width,office2_EG.width},
      each ove(
        wL=0,
        wR=0,
        dep=0,
        gap=0),
      each sidFin(
        h=0,
        dep=0,
        gap=0),
      each glaSys=win_o2EG),
    datConBou(
      name={"Floor"},
      layers={floor_office2_EG},
      til={Buildings.Types.Tilt.Floor},
      each azi=0,
      A={office2_EG.roo.AFlo},
      each stateAtSurface_a=false),
    surBou(til={Buildings.Types.Tilt.Wall,Buildings.Types.Tilt.Ceiling}, A={office2_EG.length*office2_EG.zoneHeight,office2_OG.roo.AFlo}),
    envelopeArea=2*office2_EG.length*office2_EG.zoneHeight + 2*office2_EG.width*office2_EG.zoneHeight,
    lastDayOfWorkWeek=Types.Weekday.Friday,
    schedules=[0,0,0.05,0,0.05; 6,0.1,0.1,0.05,0.05; 7,0.2,0.3,0.05,0.05; 8,0.95,0.3,0.05,0.05; 9,0.95,0.9,0.05,0.05; 13,0.95,0.5,0.05,0.05; 17,0.3,0.5,0.05,0.05; 18,0.1,0.3,0,0.05; 19,0.1,0.3,0,0.05; 20,0.1,0.2,0,0.05; 22,0,0.1,0,0.05; 23,0,0.05,0,0.05; 24,0,0.05,0,0.05]) annotation (Placement(transformation(extent={{-28,-74},{2,-44}})));
  ThermalZones.ProductionHall office2_OG(
    useHeatInputConv=false,
    useHeatInputRad=false,
    nPeople=10,
    pElLights=20,
    pElDevices=12,
    effDevices=0.8,
    acrVent=0.5,
    nMinPplVent=1,
    calcUseHeatDem=true,
    length=30,
    width=8.5,
    zoneHeight=3.65,
    nConExt=4,
    nConExtWin=0,
    nConBou=1,
    nSurBou=1,
    nGroundFloor=0,
    datConExt(
      name={"East","West","Ceiling","South"},
      layers={outerWall_office2_OG,outerWall_office2_OG,outerWall_office2_OG,outerWall_office2_OG},
      til={Buildings.Types.Tilt.Wall,Buildings.Types.Tilt.Wall,Buildings.Types.Tilt.Ceiling,Buildings.Types.Tilt.Wall},
      azi={Buildings.Types.Azimuth.E,Buildings.Types.Azimuth.W,0,Buildings.Types.Azimuth.S},
      A={office2_OG.width*office2_OG.zoneHeight,office2_OG.width*office2_OG.zoneHeight,office2_OG.roo.AFlo,office2_OG.length*office2_OG.zoneHeight}),
    datConBou(
      name={"Floor"},
      layers={floor_office2_OG},
      til={Buildings.Types.Tilt.Floor},
      each azi=0,
      A={office2_OG.roo.AFlo},
      each stateAtSurface_a=false),
    surBou(til={Buildings.Types.Tilt.Wall}, A={office2_OG.length*office2_OG.zoneHeight})) annotation (Placement(transformation(extent={{20,-74},{50,-44}})));
  parameter HeatTransfer.Data.OpaqueConstructions.Concrete_Insulated outerWall_office1_OG annotation (Placement(transformation(extent={{74,48},{86,60}})));
  parameter HeatTransfer.Data.OpaqueConstructions.Floor_Insulated_3cm floor_office1_OG annotation (Placement(transformation(extent={{88,48},{100,60}})));
  parameter HeatTransfer.Data.OpaqueConstructions.Concrete_Insulated outerWall_office2_EG annotation (Placement(transformation(extent={{86,-58},{98,-46}})));
  parameter HeatTransfer.Data.OpaqueConstructions.Concrete_Insulated outerWall_office2_OG annotation (Placement(transformation(extent={{86,-72},{98,-60}})));
  parameter HeatTransfer.Data.OpaqueConstructions.Floor_Insulated_3cm floor_office2_OG annotation (Placement(transformation(extent={{72,-72},{84,-60}})));
  parameter HeatTransfer.Data.GlazingSystems.DoubleClearAir23Clear win_o1OG annotation (Placement(transformation(extent={{74,88},{86,100}})));
  parameter HeatTransfer.Data.GlazingSystems.DoubleClearAir23Clear win_o2EG annotation (Placement(transformation(extent={{88,88},{100,100}})));
  parameter HeatTransfer.Data.OpaqueConstructions.FlatRoof_InsulatedConcrete roof_office1 annotation (Placement(transformation(extent={{60,48},{72,60}})));
  parameter HeatTransfer.Data.OpaqueConstructions.Floor_Insulated_3cm floor_office1_EG annotation (Placement(transformation(extent={{86,64},{98,76}})));
  parameter HeatTransfer.Data.GlazingSystems.DoubleClearAir23Clear win annotation (Placement(transformation(extent={{42,88},{54,100}})));
  parameter HeatTransfer.Data.GlazingSystems.DoubleClearAir23Clear win_o1EG annotation (Placement(transformation(extent={{58,88},{70,100}})));
  parameter HeatTransfer.Data.OpaqueConstructions.Concrete_Insulated outerWall_office1_EG annotation (Placement(transformation(extent={{72,64},{84,76}})));
  parameter HeatTransfer.Data.OpaqueConstructions.CassetteWall120 cassetteWall annotation (Placement(transformation(extent={{72,10},{84,22}})));
  parameter HeatTransfer.Data.OpaqueConstructions.Concrete400 floor_ph annotation (Placement(transformation(extent={{72,-4},{84,8}})));
  parameter HeatTransfer.Data.OpaqueConstructions.Floor_Insulated_3cm floor_office2_EG annotation (Placement(transformation(extent={{72,-58},{84,-46}})));
  parameter HeatTransfer.Data.OpaqueConstructions.FlatRoof_InsulatedConcrete ceiling_office2 annotation (Placement(transformation(extent={{58,-58},{70,-46}})));
  parameter HeatTransfer.Data.OpaqueConstructions.SandwichWall_Ducon roof_ph annotation (Placement(transformation(extent={{86,-4},{98,8}})));
  parameter HeatTransfer.Data.OpaqueConstructions.InteriourWall_ETA interiourWall annotation (Placement(transformation(extent={{86,10},{98,22}})));
  InternalGains.Gain_th_per_area machineDummy(shareRad=0.3, nominalPower=(10*20000 + 61*10000)/productionHall.roo.AFlo)
                                                                                                  annotation (Placement(transformation(extent={{-68,-8},{-60,0}})));
  Modelica.Blocks.Sources.CombiTimeTable schedTable(
    table=[0.0,0.0; 8,1; 17,0.0; 24,0],
    columns=2:size(schedTable.table, 2),
    smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments,
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
    timeScale(displayUnit="h") = 3600) "schedules for 1) occupancy and 2) lighting (weekdays), 3) occupancy and 4) lighting (weekend)" annotation (Placement(transformation(extent={{-92,-10},{-78,4}})));
equation
  connect(office1_OG.surf_conBou[1],office1_EG. surf_surBou[2]) annotation (Line(points={{47.3,42.5},{47.3,16},{-30,16},{-30,43.25},{-3.9,43.25}},    color={191,0,0}));
  connect(GroundTemperature.y,office1_EG. T_ground) annotation (Line(points={{-83.5,-51},{-58,-51},{-58,14},{-10.65,14},{-10.65,41.75}}, color={0,0,127}));
  connect(office2_OG.surf_conBou[1],office2_EG. surf_surBou[2]) annotation (Line(points={{47.3,-75.5},{47.3,-80},{-7.9,-80},{-7.9,-74.75}},        color={191,0,0}));
  connect(office1_EG.weaBus, weaDat.weaBus) annotation (Line(
      points={{-8.7,73.7},{-82,73.7},{-82,87},{-78,87}},
      color={255,204,51},
      thickness=0.5));
  connect(weaDat.weaBus,office1_OG. weaBus) annotation (Line(
      points={{-78,87},{-82,87},{-82,54},{-58,54},{-58,60},{35.3,60},{35.3,73.7}},
      color={255,204,51},
      thickness=0.5));
  connect(office1_EG.surf_surBou[1], productionHall.surf_conBou[1]) annotation (Line(points={{-3.9,41.75},{9.12,41.75},{9.12,-15.6}},                 color={191,0,0}));
  connect(productionHall.surf_conBou[2],office1_OG. surf_surBou[1]) annotation (Line(points={{9.12,-15.6},{9.12,36},{40.1,36},{40.1,42.5}},                 color={191,0,0}));
  connect(productionHall.surf_conBou[3],office2_EG. surf_surBou[1]) annotation (Line(points={{9.12,-15.6},{9.12,-20},{6,-20},{6,-40},{8,-40},{8,-80},{-7.9,-80},{-7.9,-76.25}},
                                                                                                                                                                color={191,0,0}));
  connect(productionHall.surf_conBou[4],office2_OG. surf_surBou[1]) annotation (Line(points={{9.12,-15.6},{9.12,-20},{6,-20},{6,-40},{8,-40},{8,-82},{40.1,-82},{40.1,-75.5}},
                                                                                                                                                                 color={191,0,0}));
  connect(GroundTemperature.y, productionHall.T_ground) annotation (Line(points={{-83.5,-51},{-78,-51},{-78,-20},{-5.76,-20},{-5.76,-16.4}},   color={0,0,127}));
  connect(GroundTemperature.y, office2_EG.T_ground) annotation (Line(points={{-83.5,-51},{-78,-51},{-78,-20},{-34,-20},{-34,-82},{-14.65,-82},{-14.65,-76.25}},
                                                                                                                                                            color={0,0,127}));
  connect(weaDat.weaBus, productionHall.weaBus) annotation (Line(
      points={{-78,87},{-82,87},{-82,72},{-84,72},{-84,28},{-38,28},{-38,22},{-3.68,22},{-3.68,17.68}},
      color={255,204,51},
      thickness=0.5));
  connect(weaDat.weaBus, office2_EG.weaBus) annotation (Line(
      points={{-78,87},{-82,87},{-82,72},{-84,72},{-84,28},{-38,28},{-38,22},{18,22},{18,-32},{-12.7,-32},{-12.7,-44.3}},
      color={255,204,51},
      thickness=0.5));
  connect(weaDat.weaBus, office2_OG.weaBus) annotation (Line(
      points={{-78,87},{-82,87},{-82,72},{-84,72},{-84,28},{-38,28},{-38,22},{18,22},{18,-36},{34,-36},{34,-40},{35.3,-40},{35.3,-44.3}},
      color={255,204,51},
      thickness=0.5));
  connect(schedTable.y[1],machineDummy. schedule) annotation (Line(points={{-77.3,-3},{-68.8,-4}},                       color={0,0,127}));
  connect(machineDummy.Qth_rad, productionHall.Q_gainRad) annotation (Line(points={{-59.28,-6.8},{-28,-6.8},{-28,-6.48},{-22.4,-6.48}}, color={0,0,127}));
  connect(machineDummy.Qth_conv, productionHall.Q_gainConv) annotation (Line(points={{-59.28,-5.2},{-41.64,-5.2},{-41.64,-11.28},{-22.4,-11.28}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)), experiment(
      StopTime=31536000, Interval=3600, __Dymola_Algorithm="CVODE"));
end productionHall37000m2withRimOffices;
