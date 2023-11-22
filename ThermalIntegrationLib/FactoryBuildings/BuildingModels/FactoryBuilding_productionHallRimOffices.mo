within ThermalIntegrationLib.FactoryBuildings.BuildingModels;
model FactoryBuilding_productionHallRimOffices "A production hall with rim offices"
  extends ThermalIntegrationLib.BaseClasses.BaseFactoryBuilding(
    outsideTemperature=productionHall.outsideTemperature,
    insideTemperature=productionHall.insideRoomTemperature,
    heatDemands=5,
    coolDemands=5,
    electricDemands=5);

  Buildings.BoundaryConditions.WeatherData.ReaderTMY3 weaDat(filNam=ModelicaServices.ExternalReferences.loadResource("modelica://ThermalIntegrationLib/Resources/weatherdata/DEU_Frankfurt.am.Main.106370_IWEC.mos"))
                                                             annotation (Placement(transformation(extent={{-98,68},{-80,86}})));
  Modelica.Blocks.Sources.Sine GroundTemperature(
    amplitude=10,
    freqHz=1/(8760*3600),
    phase=-1.7453292519943,
    offset=273.15 + 10) annotation (Placement(transformation(extent={{-96,-66},{-86,-56}})));
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
    schedules=[0,0,0.05,0,0.05; 6,0.1,0.1,0.05,0.05; 7,0.2,0.3,0.05,0.05; 8,0.95,0.3,0.05,0.05; 9,0.95,0.9,0.05,0.05; 13,0.95,0.5,0.05,0.05; 17,0.3,0.5,0.05,0.05; 18,0.1,0.3,0,0.05; 19,0.1,0.3,0,0.05; 20,0.1,0.2,0,0.05; 22,0,0.1,0,0.05; 23,0,0.05,0,0.05; 24,0,0.05,0,0.05]) annotation (Placement(transformation(extent={{-26,34},{4,64}})));
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
    schedules=[0,0,0.05,0,0.05; 6,0.1,0.1,0.05,0.05; 7,0.2,0.3,0.05,0.05; 8,0.95,0.3,0.05,0.05; 9,0.95,0.9,0.05,0.05; 13,0.95,0.5,0.05,0.05; 17,0.3,0.5,0.05,0.05; 18,0.1,0.3,0,0.05; 19,0.1,0.3,0,0.05; 20,0.1,0.2,0,0.05; 22,0,0.1,0,0.05; 23,0,0.05,0,0.05; 24,0,0.05,0,0.05]) "Office First floor" annotation (Placement(transformation(extent={{18,34},{48,64}})));
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
    schedules=[0,0,0.05,0,0.05; 6,0.1,0.1,0.05,0.05; 7,0.2,0.3,0.05,0.05; 8,0.95,0.3,0.05,0.05; 9,0.95,0.9,0.05,0.05; 13,0.95,0.5,0.05,0.05; 17,0.3,0.5,0.05,0.05; 18,0.1,0.3,0,0.05; 19,0.1,0.3,0,0.05; 20,0.1,0.2,0,0.05; 22,0,0.1,0,0.05; 23,0,0.05,0,0.05; 24,0,0.05,0,0.05]) annotation (Placement(transformation(extent={{-22,-24},{10,8}})));
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
    schedules=[0,0,0.05,0,0.05; 6,0.1,0.1,0.05,0.05; 7,0.2,0.3,0.05,0.05; 8,0.95,0.3,0.05,0.05; 9,0.95,0.9,0.05,0.05; 13,0.95,0.5,0.05,0.05; 17,0.3,0.5,0.05,0.05; 18,0.1,0.3,0,0.05; 19,0.1,0.3,0,0.05; 20,0.1,0.2,0,0.05; 22,0,0.1,0,0.05; 23,0,0.05,0,0.05; 24,0,0.05,0,0.05]) annotation (Placement(transformation(extent={{-30,-84},{0,-54}})));
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
    surBou(til={Buildings.Types.Tilt.Wall}, A={office2_OG.length*office2_OG.zoneHeight})) annotation (Placement(transformation(extent={{18,-84},{48,-54}})));
  parameter HeatTransfer.Data.OpaqueConstructions.Concrete_Insulated outerWall_office1_OG annotation (Placement(transformation(extent={{72,38},{84,50}})));
  parameter HeatTransfer.Data.OpaqueConstructions.Floor_Insulated_3cm floor_office1_OG annotation (Placement(transformation(extent={{86,38},{98,50}})));
  parameter HeatTransfer.Data.OpaqueConstructions.Concrete_Insulated outerWall_office2_EG annotation (Placement(transformation(extent={{84,-68},{96,-56}})));
  parameter HeatTransfer.Data.OpaqueConstructions.Concrete_Insulated outerWall_office2_OG annotation (Placement(transformation(extent={{84,-82},{96,-70}})));
  parameter HeatTransfer.Data.OpaqueConstructions.Floor_Insulated_3cm floor_office2_OG annotation (Placement(transformation(extent={{70,-82},{82,-70}})));
  parameter HeatTransfer.Data.GlazingSystems.DoubleClearAir23Clear win_o1OG annotation (Placement(transformation(extent={{72,78},{84,90}})));
  parameter HeatTransfer.Data.GlazingSystems.DoubleClearAir23Clear win_o2EG annotation (Placement(transformation(extent={{86,78},{98,90}})));
  parameter HeatTransfer.Data.OpaqueConstructions.FlatRoof_InsulatedConcrete roof_office1 annotation (Placement(transformation(extent={{58,38},{70,50}})));
  parameter HeatTransfer.Data.OpaqueConstructions.Floor_Insulated_3cm floor_office1_EG annotation (Placement(transformation(extent={{84,54},{96,66}})));
  parameter HeatTransfer.Data.GlazingSystems.DoubleClearAir23Clear win annotation (Placement(transformation(extent={{40,78},{52,90}})));
  parameter HeatTransfer.Data.GlazingSystems.DoubleClearAir23Clear win_o1EG annotation (Placement(transformation(extent={{56,78},{68,90}})));
  parameter HeatTransfer.Data.OpaqueConstructions.Concrete_Insulated outerWall_office1_EG annotation (Placement(transformation(extent={{70,54},{82,66}})));
  parameter HeatTransfer.Data.OpaqueConstructions.CassetteWall120 cassetteWall annotation (Placement(transformation(extent={{70,0},{82,12}})));
  parameter HeatTransfer.Data.OpaqueConstructions.Concrete400 floor_ph annotation (Placement(transformation(extent={{70,-14},{82,-2}})));
  parameter HeatTransfer.Data.OpaqueConstructions.Floor_Insulated_3cm floor_office2_EG annotation (Placement(transformation(extent={{70,-68},{82,-56}})));
  parameter HeatTransfer.Data.OpaqueConstructions.FlatRoof_InsulatedConcrete ceiling_office2 annotation (Placement(transformation(extent={{56,-68},{68,-56}})));
  parameter HeatTransfer.Data.OpaqueConstructions.SandwichWall_Ducon roof_ph annotation (Placement(transformation(extent={{84,-14},{96,-2}})));
  parameter HeatTransfer.Data.OpaqueConstructions.InteriourWall_ETA interiourWall annotation (Placement(transformation(extent={{84,0},{96,12}})));
  InternalGains.Gain_th_per_area machineDummy(shareRad=0.3, nominalPower=(10*20000 + 61*10000)/productionHall.roo.AFlo)
                                                                                                  annotation (Placement(transformation(extent={{-70,-18},{-62,-10}})));
  Modelica.Blocks.Sources.CombiTimeTable schedTable(
    table=[0.0,0.0; 8,1; 17,0.0; 24,0],
    columns=2:size(schedTable.table, 2),
    smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments,
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
    timeScale(displayUnit="h") = 3600) "schedules for 1) occupancy and 2) lighting (weekdays), 3) occupancy and 4) lighting (weekend)" annotation (Placement(transformation(extent={{-94,-20},{-80,-6}})));
equation
  coolDemand[1].Q_flow[1] = productionHall.Q_flow_cool_ideal;
  coolDemand[1].T_in[1] = productionHall.insideRoomTemperature -10; //Kühlung Vorlauf
  coolDemand[1].T_out[1] = productionHall.insideRoomTemperature -5; //Kühlung Rücklauf
  heatDemand[1].Q_flow[1] = productionHall.Q_flow_heat_ideal;
  heatDemand[1].T_in[1] = productionHall.insideRoomTemperature +30; //Heizung Vorlauf
  heatDemand[1].T_out[1] = productionHall.insideRoomTemperature +20; //Heizung Rücklauf
  electricDemand[1].Power[1] = productionHall.P_el;

  coolDemand[2].Q_flow[1] = office1_EG.Q_flow_cool_ideal;
  coolDemand[2].T_in[1] = office1_EG.insideRoomTemperature -10; //Kühlung Vorlauf
  coolDemand[2].T_out[1] = office1_EG.insideRoomTemperature -5; //Kühlung Rücklauf
  heatDemand[2].Q_flow[1] = office1_EG.Q_flow_heat_ideal;
  heatDemand[2].T_in[1] = office1_EG.insideRoomTemperature +30; //Heizung Vorlauf
  heatDemand[2].T_out[1] = office1_EG.insideRoomTemperature +20; //Heizung Rücklauf
  electricDemand[2].Power[1] = office1_EG.P_el;

  coolDemand[3].Q_flow[1] = office1_OG.Q_flow_cool_ideal;
  coolDemand[3].T_in[1] = office1_OG.insideRoomTemperature -10; //Kühlung Vorlauf
  coolDemand[3].T_out[1] = office1_OG.insideRoomTemperature -5; //Kühlung Rücklauf
  heatDemand[3].Q_flow[1] = office1_OG.Q_flow_heat_ideal;
  heatDemand[3].T_in[1] = office1_OG.insideRoomTemperature +30; //Heizung Vorlauf
  heatDemand[3].T_out[1] = office1_OG.insideRoomTemperature +20; //Heizung Rücklauf
  electricDemand[3].Power[1] = office1_OG.P_el;

  coolDemand[4].Q_flow[1] = office2_EG.Q_flow_cool_ideal;
  coolDemand[4].T_in[1] = office2_EG.insideRoomTemperature -10; //Kühlung Vorlauf
  coolDemand[4].T_out[1] = office2_EG.insideRoomTemperature -5; //Kühlung Rücklauf
  heatDemand[4].Q_flow[1] = office2_EG.Q_flow_heat_ideal;
  heatDemand[4].T_in[1] = office2_EG.insideRoomTemperature +30; //Heizung Vorlauf
  heatDemand[4].T_out[1] = office2_EG.insideRoomTemperature +20; //Heizung Rücklauf
  electricDemand[4].Power[1] = office2_EG.P_el;

  coolDemand[5].Q_flow[1] = office2_OG.Q_flow_cool_ideal;
  coolDemand[5].T_in[1] = office2_OG.insideRoomTemperature -10; //Kühlung Vorlauf
  coolDemand[5].T_out[1] = office2_OG.insideRoomTemperature -5; //Kühlung Rücklauf
  heatDemand[5].Q_flow[1] = office2_OG.Q_flow_heat_ideal;
  heatDemand[5].T_in[1] = office2_OG.insideRoomTemperature +30; //Heizung Vorlauf
  heatDemand[5].T_out[1] = office2_OG.insideRoomTemperature +20; //Heizung Rücklauf
  electricDemand[5].Power[1] = office2_OG.P_el;


  connect(office1_OG.surf_conBou[1],office1_EG. surf_surBou[2]) annotation (Line(points={{45.3,32.5},{45.3,6},{-32,6},{-32,33.25},{-5.9,33.25}},      color={191,0,0}));
  connect(GroundTemperature.y,office1_EG. T_ground) annotation (Line(points={{-85.5,-61},{-60,-61},{-60,4},{-12.65,4},{-12.65,31.75}},   color={0,0,127}));
  connect(office2_OG.surf_conBou[1],office2_EG. surf_surBou[2]) annotation (Line(points={{45.3,-85.5},{45.3,-90},{-9.9,-90},{-9.9,-84.75}},        color={191,0,0}));
  connect(office1_EG.weaBus,weaDat. weaBus) annotation (Line(
      points={{-10.7,63.7},{-84,63.7},{-84,77},{-80,77}},
      color={255,204,51},
      thickness=0.5));
  connect(weaDat.weaBus,office1_OG. weaBus) annotation (Line(
      points={{-80,77},{-84,77},{-84,44},{-60,44},{-60,50},{33.3,50},{33.3,63.7}},
      color={255,204,51},
      thickness=0.5));
  connect(office1_EG.surf_surBou[1],productionHall. surf_conBou[1]) annotation (Line(points={{-5.9,31.75},{7.12,31.75},{7.12,-25.6}},                 color={191,0,0}));
  connect(productionHall.surf_conBou[2],office1_OG. surf_surBou[1]) annotation (Line(points={{7.12,-25.6},{7.12,26},{38.1,26},{38.1,32.5}},                 color={191,0,0}));
  connect(productionHall.surf_conBou[3],office2_EG. surf_surBou[1]) annotation (Line(points={{7.12,-25.6},{7.12,-30},{4,-30},{4,-50},{6,-50},{6,-90},{-9.9,-90},{-9.9,-86.25}},
                                                                                                                                                                color={191,0,0}));
  connect(productionHall.surf_conBou[4],office2_OG. surf_surBou[1]) annotation (Line(points={{7.12,-25.6},{7.12,-30},{4,-30},{4,-50},{6,-50},{6,-92},{38.1,-92},{38.1,-85.5}},
                                                                                                                                                                 color={191,0,0}));
  connect(GroundTemperature.y,productionHall. T_ground) annotation (Line(points={{-85.5,-61},{-80,-61},{-80,-30},{-7.76,-30},{-7.76,-26.4}},   color={0,0,127}));
  connect(GroundTemperature.y,office2_EG. T_ground) annotation (Line(points={{-85.5,-61},{-80,-61},{-80,-30},{-36,-30},{-36,-92},{-16.65,-92},{-16.65,-86.25}},
                                                                                                                                                            color={0,0,127}));
  connect(weaDat.weaBus,productionHall. weaBus) annotation (Line(
      points={{-80,77},{-84,77},{-84,62},{-86,62},{-86,18},{-40,18},{-40,12},{-5.68,12},{-5.68,7.68}},
      color={255,204,51},
      thickness=0.5));
  connect(weaDat.weaBus,office2_EG. weaBus) annotation (Line(
      points={{-80,77},{-84,77},{-84,62},{-86,62},{-86,18},{-40,18},{-40,12},{16,12},{16,-42},{-14.7,-42},{-14.7,-54.3}},
      color={255,204,51},
      thickness=0.5));
  connect(weaDat.weaBus,office2_OG. weaBus) annotation (Line(
      points={{-80,77},{-84,77},{-84,62},{-86,62},{-86,18},{-40,18},{-40,12},{16,12},{16,-46},{32,-46},{32,-50},{33.3,-50},{33.3,-54.3}},
      color={255,204,51},
      thickness=0.5));
  connect(schedTable.y[1],machineDummy. schedule) annotation (Line(points={{-79.3,-13},{-70.8,-14}},                     color={0,0,127}));
  connect(machineDummy.Qth_rad,productionHall. Q_gainRad) annotation (Line(points={{-61.28,-16.8},{-30,-16.8},{-30,-16.48},{-24.4,-16.48}},
                                                                                                                                        color={0,0,127}));
  connect(machineDummy.Qth_conv,productionHall. Q_gainConv) annotation (Line(points={{-61.28,-15.2},{-43.64,-15.2},{-43.64,-21.28},{-24.4,-21.28}},
                                                                                                                                                  color={0,0,127}));
 annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(
          preserveAspectRatio=false)),
    Documentation(info="<html>
</html>"));
end FactoryBuilding_productionHallRimOffices;
