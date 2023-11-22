within ThermalIntegrationLib.FactoryBuildings.ThermalZones.Examples.Modelling;
model example_productionHall_heatPort
  extends Modelica.Icons.Example;
  ThermalZones.ProductionHall productionHall(
    useHeatPortAir=true,
    useHeatPortRad=true,
    nPeople=127,
    calcUseHeatDem=false,
    length=130,
    width=60,
    zoneHeight=10.72,
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
      each stateAtSurface_a=false)) annotation (Placement(transformation(extent={{32,-2},{78,44}})));
  Buildings.BoundaryConditions.WeatherData.ReaderTMY3 weaDat(filNam=ModelicaServices.ExternalReferences.loadResource("modelica://ThermalIntegrationLib/Resources/weatherdata/DEU_Frankfurt.am.Main.106370_IWEC.mos"))
                                                                                                                                                                                                        annotation (Placement(transformation(extent={{48,74},{62,88}})));
  Modelica.Blocks.Sources.Sine GroundTemperature(
    amplitude=10,
    freqHz=1/(8760*3600),
    phase=-1.7453292519943,
    offset=273.15 + 10) annotation (Placement(transformation(extent={{42,-36},{52,-26}})));
  Modelica.Blocks.Sources.RealExpression zero(y=0) annotation (Placement(transformation(extent={{0,6},{8,12}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow convHeaFlo annotation (Placement(transformation(extent={{-8,-98},{12,-78}})));
  InternalGains.Gain_th_per_area machineType1(shareRad=0.5, nominalPower=10000*100/(3.6*productionHall.roo.AFlo)) annotation (Placement(transformation(extent={{-54,-56},{-46,-48}})));
  InternalGains.Gain_th_per_area machineType3(shareRad=0.5, nominalPower=500*10/(3.6*productionHall.roo.AFlo)) annotation (Placement(transformation(extent={{-54,-84},{-46,-76}})));
  InternalGains.Gain_th_per_area machineType2(shareRad=0.5, nominalPower=10000*20/(3.6*productionHall.roo.AFlo)) annotation (Placement(transformation(extent={{-54,-70},{-46,-62}})));
  Modelica.Blocks.Math.MultiSum radGainMach(y(unit="W/m2"), nu=3) annotation (Placement(transformation(extent={{-36,-74},{-28,-66}})));
  Modelica.Blocks.Math.MultiSum convGainMach(y(unit="W/m2"), nu=3) annotation (Placement(transformation(extent={{-38,-48},{-30,-40}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow radHeaFlo annotation (Placement(transformation(extent={{-8,-46},{12,-26}})));
  Modelica.Blocks.Math.Gain gain(k=productionHall.roo.AFlo) annotation (Placement(transformation(extent={{-14,-74},{-6,-66}})));
  Modelica.Blocks.Math.Gain gain1(k=productionHall.roo.AFlo) annotation (Placement(transformation(extent={{-14,-56},{-6,-48}})));
  Modelica.Blocks.Sources.Constant const(k=273.15 + 20)
    annotation (Placement(transformation(extent={{-90,60},{-70,80}})));
  Modelica.Blocks.Continuous.LimPID PID(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=15e4,
    Ti=100,
    yMax=Modelica.Constants.inf,
    initType=Modelica.Blocks.Types.InitPID.InitialState)
    annotation (Placement(transformation(extent={{-56,40},{-36,60}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow
    annotation (Placement(transformation(extent={{-18,50},{2,70}})));
  parameter HeatTransfer.Data.OpaqueConstructions.SandwichWall outsideWalls_SN annotation (Placement(transformation(extent={{28,-78},{48,-58}})));
  parameter HeatTransfer.Data.OpaqueConstructions.CassetteWall120 outsideWalls_WE annotation (Placement(transformation(extent={{54,-78},{74,-58}})));
  HeatTransfer.Data.OpaqueConstructions.FlatRoof_PIR roof annotation (Placement(transformation(extent={{80,-78},{100,-58}})));
  parameter Buildings.HeatTransfer.Data.OpaqueConstructions.Concrete200 floor annotation (Placement(transformation(extent={{44,-100},{64,-80}})));
  parameter Buildings.HeatTransfer.Data.GlazingSystems.DoubleClearAir13Clear window annotation (Placement(transformation(extent={{70,-100},{90,-80}})));
  Utilities.DivideLoad divideLoad annotation (Placement(transformation(extent={{80,-50},{100,-30}})));
  Modelica.Blocks.Sources.CombiTimeTable schedTable(
    table=[0.0,0.0; 8,1; 17,0.0; 24,0],
    columns=2:size(schedTable.table, 2),
    smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments,
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
    timeScale(displayUnit="h") = 3600) "schedules for 1) occupancy and 2) lighting (weekdays), 3) occupancy and 4) lighting (weekend)" annotation (Placement(transformation(extent={{-86,-70},{-72,-56}})));
equation
  connect(productionHall.T_ground, GroundTemperature.y) annotation (Line(points={{52.47,-5.45},{52.47,-22},{56,-22},{56,-31},{52.5,-31}},
                                                                                                                              color={0,0,127}));
  connect(weaDat.weaBus, productionHall.weaBus) annotation (Line(
      points={{62,81},{66,81},{66,48},{55.46,48},{55.46,43.54}},
      color={255,204,51},
      thickness=0.5));
  connect(machineType1.Qth_conv,convGainMach. u[1]) annotation (Line(points={{-45.28,-53.2},{-28,-53.2},{-28,-32},{-20,-32},{-20,-42.1333},{-38,-42.1333}},
                                                                                                                              color={0,0,127}));
  connect(machineType1.Qth_rad,radGainMach. u[1]) annotation (Line(points={{-45.28,-54.8},{-40,-54.8},{-40,-68.1333},{-36,-68.1333}},         color={0,0,127}));
  connect(machineType3.Qth_conv,convGainMach. u[3]) annotation (Line(points={{-45.28,-81.2},{-28,-81.2},{-28,-45.8667},{-38,-45.8667}},
                                                                                                                        color={0,0,127}));
  connect(machineType3.Qth_rad,radGainMach. u[3]) annotation (Line(points={{-45.28,-82.8},{-36,-82.8},{-36,-78},{-40,-78},{-40,-71.8667},{-36,-71.8667}},
                                                                                                                                        color={0,0,127}));
  connect(machineType2.Qth_rad,radGainMach. u[2]) annotation (Line(points={{-45.28,-68.8},{-40,-68.8},{-40,-70},{-36,-70}},                   color={0,0,127}));
  connect(machineType2.Qth_conv,convGainMach. u[2]) annotation (Line(points={{-45.28,-67.2},{-28,-67.2},{-28,-38},{-28,-44},{-38,-44}},           color={0,0,127}));
  connect(convHeaFlo.port, productionHall.heatPortAir) annotation (Line(points={{12,-88},{18,-88},{18,-44},{16,-44},{16,48},{34.99,48},{34.99,44.23}},
                                                                                                         color={191,0,0}));
  connect(radHeaFlo.port, productionHall.heatPortRad) annotation (Line(points={{12,-36},{20,-36},{20,50},{44.19,50},{44.19,44.23}},
                                                                                                                         color={191,0,0}));
  connect(gain.y, convHeaFlo.Q_flow) annotation (Line(points={{-5.6,-70},{-2,-70},{-2,-80},{-14,-80},{-14,-88},{-8,-88}},
                                                                                    color={0,0,127}));
  connect(gain1.y, radHeaFlo.Q_flow) annotation (Line(points={{-5.6,-52},{-2,-52},{-2,-44},{-14,-44},{-14,-36},{-8,-36}},
                                                                                                      color={0,0,127}));
  connect(gain.u, convGainMach.y) annotation (Line(points={{-14.8,-70},{-18,-70},{-18,-44},{-29.32,-44}},                color={0,0,127}));
  connect(gain1.u, radGainMach.y) annotation (Line(points={{-14.8,-52},{-22,-52},{-22,-70},{-27.32,-70}},              color={0,0,127}));
  connect(zero.y, productionHall.Q_gainRad) annotation (Line(points={{8.4,9},{14,9},{14,8.81},{28.55,8.81}},                        color={0,0,127}));
  connect(zero.y, productionHall.Q_gainConv) annotation (Line(points={{8.4,9},{22,9},{22,-4},{28.55,-4},{28.55,1.91}}, color={0,0,127}));
  connect(const.y,PID. u_s) annotation (Line(points={{-69,70},{-64,70},{-64,68},{-60,68},{-60,50},{-58,50}},
                                                                                           color={0,0,127}));
  connect(productionHall.insideRoomTemperature,PID. u_m) annotation (Line(points={{80.76,35.72},{90,35.72},{90,44},{60,44},{60,48},{6,48},{6,38},{-46,38}},            color={0,0,127}));
  connect(PID.y,prescribedHeatFlow. Q_flow) annotation (Line(points={{-35,50},{-22,50},{-22,60},{-18,60}}, color={0,0,127}));
  connect(prescribedHeatFlow.port, productionHall.heatPortAir) annotation (Line(points={{2,60},{36,60},{36,44.23},{34.99,44.23}}, color={191,0,0}));
  connect(PID.y, divideLoad.totalLoad) annotation (Line(points={{-35,50},{-22,50},{-22,-2},{26,-2},{26,-40},{78.2,-40}}, color={0,0,127}));
  connect(schedTable.y[1], machineType1.schedule) annotation (Line(points={{-71.3,-63},{-58,-63},{-58,-52},{-54.8,-52}}, color={0,0,127}));
  connect(schedTable.y[1], machineType2.schedule) annotation (Line(points={{-71.3,-63},{-58,-63},{-58,-66},{-54.8,-66}}, color={0,0,127}));
  connect(machineType3.schedule, schedTable.y[1]) annotation (Line(points={{-54.8,-80},{-62,-80},{-62,-63},{-71.3,-63}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false), graphics={Rectangle(
          extent={{-98,96},{4,28}},
          lineColor={0,0,0},
          lineThickness=1), Text(
          extent={{-98,94},{-34,88}},
          lineColor={0,0,0},
          textString="Heating/cooling control"),
        Rectangle(extent={{-100,-30},{16,-100}}, lineColor={28,108,200}),
        Text(
          extent={{-96,-88},{0,-100}},
          lineColor={28,108,200},
          horizontalAlignment=TextAlignment.Left,
          fontSize=8,
          textString="Dummy for machine waste heat")}),                                                               experiment(
      StopTime=31536000,
      Interval=3600,
      __Dymola_Algorithm="CVODE"));
end example_productionHall_heatPort;
