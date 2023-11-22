within ThermalIntegrationLib.FactoryBuildings.ThermalZones.Examples.Modelling;
model twoZones "model of two adjacent thermal zones"
  import ModelicaServices;
  extends Modelica.Icons.Example;
  ThermalZones.ProductionHall productionHall(
    useFluidPorts=false,
    nPeople=127,
    calcUseHeatDem=true,
    length=130,
    width=60,
    zoneHeight=10.72,
    nConExt=3,
    nConExtWin=1,
    nConBou=2,
    datConExt(
      name={"North","East","West"},
      layers={casWall,casWall,casWall},
      til={Buildings.Types.Tilt.Wall,Buildings.Types.Tilt.Wall,Buildings.Types.Tilt.Wall},
      azi={Buildings.Types.Azimuth.N,Buildings.Types.Azimuth.E,Buildings.Types.Azimuth.W},
      A={productionHall.length*productionHall.zoneHeight,productionHall.width*productionHall.zoneHeight,productionHall.width*productionHall.zoneHeight}),
    datConExtWin(
      name={"Ceiling"},
      layers={roof1},
      til={Buildings.Types.Tilt.Ceiling},
      azi={0},
      A={productionHall.roo.AFlo},
      hWin={10},
      wWin={89},
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
    datConBou(
      name={"South","Floor"},
      layers={casWall,floor},
      til={Buildings.Types.Tilt.Wall,Buildings.Types.Tilt.Floor},
      azi={Buildings.Types.Azimuth.S,0},
      A={productionHall.length*productionHall.zoneHeight,productionHall.roo.AFlo},
      each stateAtSurface_a=false),
    latitude=0.87266462599716)
                 annotation (Placement(transformation(extent={{34,-6},{80,40}})));
  Buildings.BoundaryConditions.WeatherData.ReaderTMY3 weaDat(filNam=ModelicaServices.ExternalReferences.loadResource("modelica://ThermalIntegrationLib/Resources/weatherdata/DEU_Frankfurt.am.Main.106370_IWEC.mos"))
                                                                                                                                                                                                        annotation (Placement(transformation(extent={{-78,44},{-64,58}})));
  Modelica.Blocks.Sources.Sine GroundTemperature(
    amplitude=10,
    freqHz=1/(8760*3600),
    phase=-1.7453292519943,
    offset=273.15 + 10) annotation (Placement(transformation(extent={{-78,-84},{-68,-74}})));
  parameter HeatTransfer.Data.OpaqueConstructions.CassetteWall120 casWall annotation (Placement(transformation(extent={{-86,80},{-66,100}})));
  parameter HeatTransfer.Data.GlazingSystems.DoubleClearAir23Clear win annotation (Placement(transformation(extent={{-58,80},{-38,100}})));
  parameter Buildings.HeatTransfer.Data.OpaqueConstructions.Concrete200 floor annotation (Placement(transformation(extent={{-32,80},{-12,100}})));
  ThermalZones.ProductionHall office(
    useHeatInputConv=false,
    useHeatInputRad=false,
    pElDevices=10,
    acrVent=0.5,
    length=130,
    width=60,
    zoneHeight=10.72,
    nConExt=2,
    nSurBou=1,
    datConExt(
      name={"East","West"},
      layers={sandwichWall,sandwichWall},
      til={Buildings.Types.Tilt.Wall,Buildings.Types.Tilt.Wall},
      azi={Buildings.Types.Azimuth.E,Buildings.Types.Azimuth.W},
      A={office.width*office.zoneHeight,office.width*office.zoneHeight}),
    datConExtWin(
      name={"South","Ceiling"},
      layers={sandwichWall,roof1},
      til={Buildings.Types.Tilt.Wall,Buildings.Types.Tilt.Ceiling},
      azi={Buildings.Types.Azimuth.S,0},
      A={office.length*office.zoneHeight,office.roo.AFlo},
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
      each glaSys=win),
    datConBou(
      each name="Floor",
      layers={floor1},
      each til=Buildings.Types.Tilt.Floor,
      each azi=0,
      each A=office.roo.AFlo,
      each stateAtSurface_a=false),
    surBou(each A=office.length*office.zoneHeight, each til=Buildings.Types.Tilt.Wall)) annotation (Placement(transformation(extent={{44,-78},{86,-36}})));
  parameter HeatTransfer.Data.OpaqueConstructions.Concrete100 floor1 annotation (Placement(transformation(extent={{20,80},{40,100}})));
  InternalGains.Gain_th_per_area machineType1(shareRad=0.3, nominalPower=20*5000/productionHall.roo.AFlo) annotation (Placement(transformation(extent={{-64,14},{-56,22}})));
  InternalGains.Gain_th_per_area machineType3(shareRad=0.1, nominalPower=20*10000/productionHall.roo.AFlo) annotation (Placement(transformation(extent={{-64,-20},{-56,-12}})));
  InternalGains.Gain_th_per_area machineType2(shareRad=0.2, nominalPower=20*20000/productionHall.roo.AFlo) annotation (Placement(transformation(extent={{-64,-6},{-56,2}})));
  Modelica.Blocks.Math.MultiSum radGainMach(y(unit="W/m2"), nu=3) annotation (Placement(transformation(extent={{-40,-18},{-32,-10}})));
  Modelica.Blocks.Math.MultiSum convGainMach(y(unit="W/m2"), nu=5) annotation (Placement(transformation(extent={{-40,10},{-32,18}})));
  parameter HeatTransfer.Data.OpaqueConstructions.SandwichWall sandwichWall annotation (Placement(transformation(extent={{-6,80},{14,100}})));
  HeatTransfer.Data.OpaqueConstructions.FlatRoof_PIR roof1 annotation (Placement(transformation(extent={{46,80},{66,100}})));
  Modelica.Blocks.Sources.CombiTimeTable schedTable(
    table=[0.0,0.0; 8,1; 17,0.0; 24,0],
    columns=2:size(schedTable.table, 2),
    smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments,
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
    timeScale(displayUnit="h") = 3600) "schedules for 1) occupancy and 2) lighting (weekdays), 3) occupancy and 4) lighting (weekend)" annotation (Placement(transformation(extent={{-90,-8},{-76,6}})));
equation
  connect(weaDat.weaBus, productionHall.weaBus) annotation (Line(
      points={{-64,51},{16,51},{16,40},{30,40},{30,42},{48,42},{48,44},{57.46,44},{57.46,39.54}},
      color={255,204,51},
      thickness=0.5));
  connect(productionHall.T_ground, GroundTemperature.y) annotation (Line(points={{54.47,-9.45},{54.47,-79},{-67.5,-79}},      color={0,0,127}));
  connect(GroundTemperature.y, office.T_ground) annotation (Line(points={{-67.5,-79},{-62,-79},{-62,-90},{62.69,-90},{62.69,-81.15}}, color={0,0,127}));
  connect(office.surf_surBou[1], productionHall.surf_conBou[1]) annotation (Line(points={{72.14,-80.1},{86,-80.1},{86,-90},{92,-90},{92,-92},{96,-92},{96,-8.3},{75.86,-8.3}},  color={191,0,0}));
  connect(weaDat.weaBus, office.weaBus) annotation (Line(
      points={{-64,51},{16,51},{16,40},{22,40},{22,6},{20,6},{20,-16},{64,-16},{64,-32},{65.42,-32},{65.42,-36.42}},
      color={255,204,51},
      thickness=0.5));
  connect(machineType1.Qth_conv,convGainMach. u[1]) annotation (Line(points={{-55.28,16.8},{-55.28,16.24},{-40,16.24}},       color={0,0,127}));
  connect(machineType1.Qth_rad,radGainMach. u[1]) annotation (Line(points={{-55.28,15.2},{-52,15.2},{-52,-12.1333},{-40,-12.1333}},           color={0,0,127}));
  connect(machineType3.Qth_conv,convGainMach. u[3]) annotation (Line(points={{-55.28,-17.2},{-48,-17.2},{-48,14},{-40,14}},
                                                                                                                        color={0,0,127}));
  connect(machineType3.Qth_rad,radGainMach. u[3]) annotation (Line(points={{-55.28,-18.8},{-46,-18.8},{-46,-15.8667},{-40,-15.8667}},   color={0,0,127}));
  connect(machineType2.Qth_rad,radGainMach. u[2]) annotation (Line(points={{-55.28,-4.8},{-44,-4.8},{-44,-14},{-40,-14}},                     color={0,0,127}));
  connect(machineType2.Qth_conv,convGainMach. u[2]) annotation (Line(points={{-55.28,-3.2},{-46,-3.2},{-46,15.12},{-40,15.12}},                   color={0,0,127}));
  connect(convGainMach.y, productionHall.Q_gainConv) annotation (Line(points={{-31.32,14},{-30,14},{-30,18},{24,18},{24,2},{22,2},{22,-8},{30.55,-8},{30.55,-2.09}},
                                                                                                                                                  color={0,0,127}));
  connect(radGainMach.y, productionHall.Q_gainRad) annotation (Line(points={{-31.32,-14},{-30,-14},{-30,-18},{18,-18},{18,4.81},{30.55,4.81}},
                                                                                                                      color={0,0,127}));
  connect(machineType1.Qth_rad,convGainMach. u[4]) annotation (Line(points={{-55.28,15.2},{-52,15.2},{-52,12.88},{-40,12.88}},        color={0,0,127}));
  connect(machineType1.Qth_rad, convGainMach.u[5]) annotation (Line(points={{-55.28,15.2},{-47.64,15.2},{-47.64,11.76},{-40,11.76}}, color={0,0,127}));
  connect(schedTable.y[1], machineType1.schedule) annotation (Line(points={{-75.3,-1},{-70,-1},{-70,18},{-64.8,18}}, color={0,0,127}));
  connect(schedTable.y[1], machineType2.schedule) annotation (Line(points={{-75.3,-1},{-75.3,-2},{-64.8,-2}}, color={0,0,127}));
  connect(machineType3.schedule, schedTable.y[1]) annotation (Line(points={{-64.8,-16},{-70,-16},{-70,-1},{-75.3,-1}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(extent={{-98,26},{-18,-36}}, lineColor={28,108,200}),
        Text(
          extent={{-96,-24},{0,-36}},
          lineColor={28,108,200},
          horizontalAlignment=TextAlignment.Left,
          fontSize=8,
          textString="Dummy for machine waste heat")}),                                                               experiment(
      StopTime=31536000,
      Interval=3600,
      __Dymola_Algorithm="CVODE"));
end twoZones;
