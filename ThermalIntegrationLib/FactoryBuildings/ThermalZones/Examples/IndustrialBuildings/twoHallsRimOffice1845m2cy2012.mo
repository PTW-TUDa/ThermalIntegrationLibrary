within ThermalIntegrationLib.FactoryBuildings.ThermalZones.Examples.IndustrialBuildings;
model twoHallsRimOffice1845m2cy2012 "A production building with two halls, build in 2012, 1845 m², office in the southwest part of the southern hall, with concrete walls in the north and acoustics cassette/sandwich walls in the eastern and western part of northern hall, southern hall with 'thermowalls'"
  extends Modelica.Icons.Example;
    ProductionHall hall4(
    hasRectBaseArea=false,
    baseArea=hall4.length*hall4.width,
    useHeatPortAir=false,
    useHeatPortRad=false,
    useFluidPorts=false,
    useHeatInputConv=false,
    useHeatInputRad=false,
    nPeople=40,
    pElLights=3.72,
    pElDevices=6.702,
    acrVent=3,
    calcUseHeatDem=true,
    length=90.79,
    width=20.72,
    zoneHeight=9.25,
    Tmin_occ=290.15,
    Tmin_nocc=288.15,
    nConBou=2,
    nConExt=5,
    nGroundFloor=1,
    datConExt(
      name={"North","East1","East2","West1","West2"},
      layers={ConcreteWall,ConcreteWall,AcousticsWall,AcousticsWall,ConcreteWall},
      til={Buildings.Types.Tilt.Wall,Buildings.Types.Tilt.Wall,Buildings.Types.Tilt.Wall,Buildings.Types.Tilt.Wall,Buildings.Types.Tilt.Wall},
      azi={Buildings.Types.Azimuth.N,Buildings.Types.Azimuth.E,Buildings.Types.Azimuth.E,Buildings.Types.Azimuth.W,Buildings.Types.Azimuth.W},
      A={hall4.width*hall4.zoneHeight,5*hall4.zoneHeight,15.52*hall4.zoneHeight,15.52*hall4.zoneHeight,5*hall4.zoneHeight}),
    datConExtWin(
      name={"South1","Ceiling"},
      layers={AcousticsWall,roof},
      til={Buildings.Types.Tilt.Wall,Buildings.Types.Tilt.Ceiling},
      azi={Buildings.Types.Azimuth.S,0},
      A={(hall4.length - hall5.length)*hall4.zoneHeight,hall4.roo.AFlo},
      hWin={2,2.4},
      wWin={18,72},
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
      name={"South2","Floor"},
      layers={ThermoWall,floor},
      til={Buildings.Types.Tilt.Wall,Buildings.Types.Tilt.Floor},
      azi={Buildings.Types.Azimuth.S,0},
      A={hall4.zoneHeight*hall5.width,hall4.roo.AFlo},
      each stateAtSurface_a=false),
    nFPorts=1,
    latitude=0.87266462599716) annotation (Placement(transformation(extent={{60,-2},{106,44}})));
  ProductionHall hall5(
    hasRectBaseArea=false,
    baseArea=hall5.length*hall5.width - office.length*office.width,
    useHeatPortAir=false,
    useHeatPortRad=false,
    useFluidPorts=false,
    useHeatInputConv=false,
    useHeatInputRad=false,
    nPeople=30,
    pElLights=3.72,
    pElDevices=6.702,
    acrVent=2.5,
    calcUseHeatDem=true,
    length=48.74,
    width=19.56,
    zoneHeight=9.25,
    Tmin_occ=290.15,
    Tmin_nocc=288.15,
    nConBou=1,
    nSurBou=3,
    surBou(til={Buildings.Types.Tilt.Wall,Buildings.Types.Tilt.Wall,Buildings.Types.Tilt.Wall}, A={office.length*office.zoneHeight,office.width*office.zoneHeight,hall4.zoneHeight*hall5.width}),
    nConExt=3,
    nGroundFloor=1,
    nConExtWin=1,
    datConExt(
      name={"East","South1","West2"},
      layers={ThermoWall,ThermoWall,ThermoWall},
      til={Buildings.Types.Tilt.Wall,Buildings.Types.Tilt.Wall,Buildings.Types.Tilt.Wall},
      azi={Buildings.Types.Azimuth.E,Buildings.Types.Azimuth.S,Buildings.Types.Azimuth.W},
      A={hall4.width*hall4.zoneHeight,(hall4.length - office.length)*hall4.zoneHeight,(hall4.width - office.length)*hall4.zoneHeight}),
    datConExtWin(
      name={"Ceiling"},
      layers={roof},
      til={Buildings.Types.Tilt.Ceiling},
      azi={0},
      A={hall4.roo.AFlo},
      hWin={2.4},
      wWin={24},
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
      each A=hall4.roo.AFlo,
      each stateAtSurface_a=false),
    nFPorts=1,
    latitude=0.87266462599716) annotation (Placement(transformation(extent={{60,-82},{106,-36}})));
  ProductionHall office(
    hasRectBaseArea=false,
    baseArea=office.length*office.width,
    useHeatPortAir=false,
    useHeatPortRad=false,
    useFluidPorts=false,
    useHeatInputConv=false,
    useHeatInputRad=false,
    nPeople=10,
    pElLights=3.72,
    pElDevices=6.702,
    calcUseHeatDem=true,
    length=9.565,
    width=4.13,
    zoneHeight=9.25,
    nConBou=3,
    nConExt=1,
    nGroundFloor=1,
    nConExtWin=2,
    datConExt(
      name={"Ceiling"},
      layers={roof},
      til={Buildings.Types.Tilt.Ceiling},
      azi={0},
      A={office.roo.AFlo}),
    datConExtWin(
      name={"South","West"},
      layers={InteriorWallOffice,InteriorWallOffice},
      til={Buildings.Types.Tilt.Wall,Buildings.Types.Tilt.Wall},
      azi={Buildings.Types.Azimuth.S,Buildings.Types.Azimuth.W},
      A={office.length*office.zoneHeight,office.width*office.zoneHeight},
      hWin={3.5,2.25},
      wWin={1.5,1.5},
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
      name={"North","East","Floor"},
      layers={InteriorWallOffice,InteriorWallOffice,floor},
      til={Buildings.Types.Tilt.Wall,Buildings.Types.Tilt.Wall,Buildings.Types.Tilt.Floor},
      azi={Buildings.Types.Azimuth.N,Buildings.Types.Azimuth.E,0},
      A={office.length*office.zoneHeight,office.width*office.zoneHeight,hall4.roo.AFlo},
      each stateAtSurface_a=false),
    nFPorts=1,
    latitude=0.87266462599716) annotation (Placement(transformation(extent={{-20,-82},{26,-36}})));
  parameter HeatTransfer.Data.OpaqueConstructions.Generic     ConcreteWall(nLay=1, material={Buildings.HeatTransfer.Data.Solids.Concrete(x=0.2)})
                                                                           "North wall and northern part of west and east wall (East1 and West2) in hall 4" annotation (Placement(transformation(extent={{-112,56},{-92,76}})));
  parameter HeatTransfer.Data.OpaqueConstructions.CassetteWall140 AcousticsWall "In Hall4 - East2, South1, West1" annotation (Placement(transformation(extent={{-88,56},{-68,76}})));
  parameter HeatTransfer.Data.OpaqueConstructions.ThermoWall ThermoWall "Hall4 - South2; Hall5 - East, South1, West2" annotation (Placement(transformation(extent={{-64,56},{-44,76}})));
  parameter HeatTransfer.Data.OpaqueConstructions.InteriourWall_GypsumBoard InteriorWallOffice "Walls from Office Building" annotation (Placement(transformation(extent={{-40,56},{-20,76}})));
  parameter HeatTransfer.Data.OpaqueConstructions.Floor_Insulated_5cm floor annotation (Placement(transformation(extent={{-112,34},{-92,54}})));
  parameter HeatTransfer.Data.OpaqueConstructions.Ceiling_Insulated roof annotation (Placement(transformation(extent={{-88,34},{-68,54}})));
  Buildings.BoundaryConditions.WeatherData.ReaderTMY3 weaDat(filNam=ModelicaServices.ExternalReferences.loadResource("modelica://ThermalIntegrationLib/Resources/weatherdata/DEU_Frankfurt.am.Main.106370_IWEC.mos"))
                                                                                                                                                                                                        annotation (Placement(transformation(extent={{-66,84},{-52,98}})));
  Modelica.Blocks.Sources.Sine GroundTemperature(
    amplitude=10,
    freqHz=1/(8760*3600),
    phase=-1.7453292519943,
    offset=273.15 + 10) annotation (Placement(transformation(extent={{-130,-120},{-120,-110}})));
  parameter HeatTransfer.Data.GlazingSystems.DoubleClearAir13Clear window annotation (Placement(transformation(extent={{-64,34},{-44,54}})));
equation
  connect(weaDat.weaBus, hall4.weaBus) annotation (Line(
      points={{-52,91},{32,91},{32,48},{83.46,48},{83.46,43.54}},
      color={255,204,51},
      thickness=0.5));
  connect(weaDat.weaBus, office.weaBus) annotation (Line(
      points={{-52,91},{32,91},{32,48},{30,48},{30,-30},{10,-30},{10,-28},{2,-28},{2,-34},{4,-34},{4,-36.46},{3.46,-36.46}},
      color={255,204,51},
      thickness=0.5));
  connect(weaDat.weaBus, hall5.weaBus) annotation (Line(
      points={{-52,91},{32,91},{32,48},{30,48},{30,-32},{83.46,-32},{83.46,-36.46}},
      color={255,204,51},
      thickness=0.5));
  connect(GroundTemperature.y, hall4.T_ground) annotation (Line(points={{-119.5,-115},{118,-115},{118,-16},{80.47,-16},{80.47,-5.45}},
                                                                                                                              color={0,0,127}));
  connect(GroundTemperature.y, office.T_ground) annotation (Line(points={{-119.5,-115},{0,-115},{0,-114},{0.47,-114},{0.47,-85.45}},
                                                                                                                                color={0,0,127}));
  connect(GroundTemperature.y, hall5.T_ground) annotation (Line(points={{-119.5,-115},{78,-115},{78,-114},{80.47,-114},{80.47,-85.45}},
                                                                                                                                 color={0,0,127}));
  connect(office.surf_conBou[1], hall5.surf_surBou[1]) annotation (Line(points={{21.86,-84.3},{20,-84.3},{20,-96},{90.82,-96},{90.82,-85.8333}}, color={191,0,0}));
  connect(office.surf_conBou[2], hall5.surf_surBou[2]) annotation (Line(points={{21.86,-84.3},{20,-84.3},{20,-100},{90.82,-100},{90.82,-84.3}}, color={191,0,0}));
  connect(hall5.surf_surBou[3], hall4.surf_conBou[1]) annotation (Line(points={{90.82,-82.7667},{90.82,-92},{124,-92},{124,-12},{100,-12},{100,-8},{101.86,-8},{101.86,-4.3}}, color={191,0,0}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-140,-140},{140,100}}), graphics={Rectangle(
          extent={{-120,20},{0,80}},
          lineColor={0,0,0},
          lineThickness=1)}),
          experiment(
      StopTime=31536000, Interval=3600, __Dymola_Algorithm="CVODE"));
end twoHallsRimOffice1845m2cy2012;
