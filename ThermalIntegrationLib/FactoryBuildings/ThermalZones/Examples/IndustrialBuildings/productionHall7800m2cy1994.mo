within ThermalIntegrationLib.FactoryBuildings.ThermalZones.Examples.IndustrialBuildings;
model productionHall7800m2cy1994 "production hall with 7800 m2, construction year 1994, south windows/roof light and cassette/sandwich walls"
  extends Modelica.Icons.Example;
  ThermalZones.ProductionHall productionHall(
    useHeatPortAir=false,
    useFluidPorts=false,
    nPeople=127,
    calcUseHeatDem=true,
    length=130,
    width=60,
    zoneHeight=10.72,
    nConExt=3,
    nGroundFloor=0,
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
      each stateAtSurface_a=false),
    latitude=0.87266462599716) annotation (Placement(transformation(extent={{32,-12},{78,34}})));
  Buildings.BoundaryConditions.WeatherData.ReaderTMY3 weaDat(filNam=ModelicaServices.ExternalReferences.loadResource("modelica://ThermalIntegrationLib/Resources/weatherdata/DEU_Frankfurt.am.Main.106370_IWEC.mos"))
                                                                                                                                                                                                        annotation (Placement(transformation(extent={{12,50},{26,64}})));
  Modelica.Blocks.Sources.Sine groundTemperature(
    amplitude=10,
    freqHz=1/(8760*3600),
    phase=-1.7453292519943,
    offset=273.15 + 10) annotation (Placement(transformation(extent={{46,-68},{56,-58}})));
  parameter HeatTransfer.Data.OpaqueConstructions.CassetteWall120 outsideWalls_WE annotation (Placement(transformation(extent={{-68,80},{-48,100}})));
  parameter HeatTransfer.Data.OpaqueConstructions.SandwichWall outsideWalls_SN annotation (Placement(transformation(extent={{-96,80},{-76,100}})));
  parameter HeatTransfer.Data.OpaqueConstructions.FlatRoof_PIR roof annotation (Placement(transformation(extent={{-42,80},{-22,100}})));
  parameter Buildings.HeatTransfer.Data.GlazingSystems.DoubleClearAir13Clear window annotation (Placement(transformation(extent={{10,80},{30,100}})));
  parameter Buildings.HeatTransfer.Data.OpaqueConstructions.Concrete200 floor annotation (Placement(transformation(extent={{-16,80},{4,100}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature prescribedTemperature annotation (Placement(transformation(extent={{72,-72},{92,-52}})));
  InternalGains.Gain_th_per_area machineDummy(shareRad=0.3, nominalPower=50*10000/productionHall.roo.AFlo)
                                                                                                  annotation (Placement(transformation(extent={{-20,16},{-12,24}})));
  Modelica.Blocks.Sources.CombiTimeTable schedTable(
    table=[0.0,0.0; 8,1; 17,0.0; 24,0],
    columns=2:size(schedTable.table, 2),
    smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments,
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
    timeScale(displayUnit="h") = 3600) "Machine waste heat"                                                                            annotation (Placement(transformation(extent={{-44,14},{-30,28}})));
equation
  connect(weaDat.weaBus, productionHall.weaBus) annotation (Line(
      points={{26,57},{54,57},{54,38},{55.46,38},{55.46,33.54}},
      color={255,204,51},
      thickness=0.5));
  connect(prescribedTemperature.T, groundTemperature.y) annotation (Line(points={{70,-62},{56.5,-63}}, color={0,0,127}));
  connect(prescribedTemperature.port, productionHall.surf_conBou[1]) annotation (Line(points={{92,-62},{98,-62},{98,-20},{73.86,-20},{73.86,-14.3}},  color={191,0,0}));
  connect(schedTable.y[1], machineDummy.schedule) annotation (Line(points={{-29.3,21},{-29.3,20},{-20.8,20}},    color={0,0,127}));
  connect(machineDummy.Qth_conv, productionHall.Q_gainConv) annotation (Line(points={{-11.28,18.8},{2,18.8},{2,-14},{28.55,-14},{28.55,-8.09}}, color={0,0,127}));
  connect(machineDummy.Qth_rad, productionHall.Q_gainRad) annotation (Line(points={{-11.28,17.2},{0,17.2},{0,8},{28.55,8},{28.55,-1.19}},   color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)),experiment(
      StopTime=31536000,
      Interval=3600,
      __Dymola_Algorithm="CVODE"));
end productionHall7800m2cy1994;
