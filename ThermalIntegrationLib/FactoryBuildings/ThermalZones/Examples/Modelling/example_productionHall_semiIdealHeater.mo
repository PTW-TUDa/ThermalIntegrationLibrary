within ThermalIntegrationLib.FactoryBuildings.ThermalZones.Examples.Modelling;
model example_productionHall_semiIdealHeater
  extends Modelica.Icons.Example;
  ThermalZones.ProductionHall productionHall(
    hasRectBaseArea=false,
    baseArea=130*60,
    useHeatPortAir=false,
    useFluidPorts=true,
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
    nFPorts=1,
    latitude=0.87266462599716) annotation (Placement(transformation(extent={{32,-12},{78,34}})));
  Buildings.BoundaryConditions.WeatherData.ReaderTMY3 weaDat(filNam=ModelicaServices.ExternalReferences.loadResource("modelica://ThermalIntegrationLib/Resources/weatherdata/DEU_Frankfurt.am.Main.106370_IWEC.mos"))
                                                                                                                                                                                                        annotation (Placement(transformation(extent={{12,50},{26,64}})));
  Modelica.Blocks.Sources.Sine groundTemperature(
    amplitude=10,
    freqHz=1/(8760*3600),
    phase=-1.7453292519943,
    offset=273.15 + 10) annotation (Placement(transformation(extent={{56,-68},{66,-58}})));
  InternalGains.Gain_th_per_area machineType1(shareRad=0.5, nominalPower=10000*100/(3.6*productionHall.roo.AFlo)) annotation (Placement(transformation(extent={{-48,-44},{-40,-36}})));
  InternalGains.Gain_th_per_area machineType3(shareRad=0, nominalPower=500*10/(3.6*productionHall.roo.AFlo)) annotation (Placement(transformation(extent={{-48,-78},{-40,-70}})));
  InternalGains.Gain_th_per_area machineType2(shareRad=0.5, nominalPower=10000*20/(3.6*productionHall.roo.AFlo)) annotation (Placement(transformation(extent={{-48,-64},{-40,-56}})));
  Modelica.Blocks.Math.MultiSum radGainMach(y(unit="W/m2"), nu=3) annotation (Placement(transformation(extent={{-2,-72},{6,-64}})));
  Modelica.Blocks.Math.MultiSum convGainMach(y(unit="W/m2"), nu=4) annotation (Placement(transformation(extent={{-2,-44},{6,-36}})));
  Buildings.Fluid.Sources.MassFlowSource_T ventilator(
    redeclare package Medium = Buildings.Media.Air,
    m_flow=0.01,
    T=293.15,
    nPorts=1) "source of air at 20 degC" annotation (Placement(transformation(extent={{-14,12},{6,32}})));
  parameter HeatTransfer.Data.OpaqueConstructions.CassetteWall120 outsideWalls_WE annotation (Placement(transformation(extent={{-68,80},{-48,100}})));
  parameter HeatTransfer.Data.OpaqueConstructions.SandwichWall outsideWalls_SN annotation (Placement(transformation(extent={{-96,80},{-76,100}})));
  parameter HeatTransfer.Data.OpaqueConstructions.FlatRoof_PIR roof annotation (Placement(transformation(extent={{-42,80},{-22,100}})));
  parameter Buildings.HeatTransfer.Data.GlazingSystems.DoubleClearAir13Clear window annotation (Placement(transformation(extent={{10,80},{30,100}})));
  parameter Buildings.HeatTransfer.Data.OpaqueConstructions.Concrete200 floor annotation (Placement(transformation(extent={{-16,80},{4,100}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature prescribedTemperature annotation (Placement(transformation(extent={{82,-72},{102,-52}})));
  Modelica.Blocks.Sources.CombiTimeTable schedTable(
    table=[0.0,0.0; 8,1; 17,0.0; 24,0],
    columns=2:size(schedTable.table, 2),
    smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments,
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
    timeScale(displayUnit="h") = 3600) "schedules for 1) occupancy and 2) lighting (weekdays), 3) occupancy and 4) lighting (weekend)" annotation (Placement(transformation(extent={{-82,-66},{-68,-52}})));
equation
  connect(weaDat.weaBus, productionHall.weaBus) annotation (Line(
      points={{26,57},{54,57},{54,38},{55.46,38},{55.46,33.54}},
      color={255,204,51},
      thickness=0.5));
  connect(machineType1.Qth_conv, convGainMach.u[1]) annotation (Line(points={{-39.28,-41.2},{8,-41.2},{8,-37.9},{-2,-37.9}},  color={0,0,127}));
  connect(machineType1.Qth_rad, radGainMach.u[1]) annotation (Line(points={{-39.28,-42.8},{14,-42.8},{14,-66.1333},{-2,-66.1333}},            color={0,0,127}));
  connect(machineType3.Qth_conv, convGainMach.u[3]) annotation (Line(points={{-39.28,-75.2},{12,-75.2},{12,-40.7},{-2,-40.7}},
                                                                                                                        color={0,0,127}));
  connect(machineType3.Qth_rad, radGainMach.u[3]) annotation (Line(points={{-39.28,-76.8},{-2,-76.8},{-2,-78},{14,-78},{14,-69.8667},{-2,-69.8667}},
                                                                                                                                        color={0,0,127}));
  connect(machineType2.Qth_rad, radGainMach.u[2]) annotation (Line(points={{-39.28,-62.8},{14,-62.8},{14,-68},{-2,-68}},                      color={0,0,127}));
  connect(machineType2.Qth_conv, convGainMach.u[2]) annotation (Line(points={{-39.28,-61.2},{-16,-61.2},{-16,-44},{8,-44},{8,-39.3},{-2,-39.3}},  color={0,0,127}));
  connect(convGainMach.y, productionHall.Q_gainConv) annotation (Line(points={{6.68,-40},{6.68,-30},{28.55,-30},{28.55,-8.09}},                   color={0,0,127}));
  connect(radGainMach.y, productionHall.Q_gainRad) annotation (Line(points={{6.68,-68},{20,-68},{20,-1.19},{28.55,-1.19}},
                                                                                                                      color={0,0,127}));
  connect(ventilator.ports[1], productionHall.fPorts[1]) annotation (Line(points={{6,22},{29.7,22.5}}, color={0,127,255}));
  connect(machineType1.Qth_rad, convGainMach.u[4]) annotation (Line(points={{-39.28,-42.8},{-20.64,-42.8},{-20.64,-42.1},{-2,-42.1}}, color={0,0,127}));
  connect(prescribedTemperature.T, groundTemperature.y) annotation (Line(points={{80,-62},{66.5,-63}}, color={0,0,127}));
  connect(prescribedTemperature.port, productionHall.surf_conBou[1]) annotation (Line(points={{102,-62},{106,-62},{106,-20},{73.86,-20},{73.86,-14.3}},
                                                                                                                                                      color={191,0,0}));
  connect(schedTable.y[1], machineType1.schedule) annotation (Line(points={{-67.3,-59},{-54,-59},{-54,-40},{-48.8,-40}}, color={0,0,127}));
  connect(schedTable.y[1], machineType2.schedule) annotation (Line(points={{-67.3,-59},{-67.3,-60},{-48.8,-60}}, color={0,0,127}));
  connect(machineType3.schedule, schedTable.y[1]) annotation (Line(points={{-48.8,-74},{-58,-74},{-58,-59},{-67.3,-59}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(extent={{-98,100},{52,70}}, lineColor={28,108,200}),
        Text(
          extent={{-96,78},{24,72}},
          lineColor={28,108,200},
          textString="Constructions used in the building model",
          horizontalAlignment=TextAlignment.Left),
        Rectangle(extent={{-96,-32},{20,-94}}, lineColor={28,108,200}),
        Text(
          extent={{-92,-82},{4,-94}},
          lineColor={28,108,200},
          horizontalAlignment=TextAlignment.Left,
          fontSize=8,
          textString="Dummy for machine waste heat")}),                                                               experiment(
      StopTime=31536000,
      Interval=3600,
      __Dymola_Algorithm="CVODE"));
end example_productionHall_semiIdealHeater;
