within ThermalIntegrationLib.FactoryBuildings.ThermalZones.Examples.Modelling;
model example_productionHall_externalHeater
  extends Modelica.Icons.Example;
  Modelica.Blocks.Sources.Pulse isSpaceOccupied(
    amplitude=1,
    width=33.33,
    period(displayUnit="h") = 86400,
    startTime(displayUnit="h") = 28800) annotation (Placement(transformation(extent={{-94,78},{-80,92}})));
  ThermalZones.ProductionHall productionHall(
    useHeatPortAir=true,
    useHeatPortRad=false,
    nPeople=127,
    acrVent=3,
    calcUseHeatDem=false,
    length=130,
    width=60,
    zoneHeight=10.72,
    datConExt(
      name={"North","East","West"},
      layers={outsideWalls,outsideWalls,outsideWalls},
      til={Buildings.Types.Tilt.Wall,Buildings.Types.Tilt.Wall,Buildings.Types.Tilt.Wall},
      azi={Buildings.Types.Azimuth.N,Buildings.Types.Azimuth.E,Buildings.Types.Azimuth.W},
      A={productionHall.length*productionHall.zoneHeight,productionHall.width*productionHall.zoneHeight,productionHall.width*productionHall.zoneHeight}),
    datConExtWin(
      name={"South","Ceiling"},
      layers={outsideWalls,roof},
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
    offset=273.15 + 10) annotation (Placement(transformation(extent={{70,-46},{80,-36}})));
  Modelica.Blocks.Sources.RealExpression zero(y=0) annotation (Placement(transformation(extent={{-16,4},{-8,10}})));
  Controls.semi_idealHeater idealHeater_var(k=20000000) annotation (Placement(transformation(extent={{-16,14},{4,34}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=292.15) annotation (Placement(transformation(extent={{-94,-20},{-74,0}})));
  Modelica.Blocks.Sources.RealExpression realExpression1(y=298.15) annotation (Placement(transformation(extent={{-94,20},{-74,40}})));
  Modelica.Blocks.Logical.Switch T_room_max annotation (Placement(transformation(extent={{-50,20},{-38,32}})));
  Modelica.Blocks.Math.RealToBoolean realToBoolean annotation (Placement(transformation(extent={{-76,50},{-66,60}})));
  Modelica.Blocks.Sources.RealExpression realExpression2(y=303.15) annotation (Placement(transformation(extent={{-94,6},{-74,26}})));
  Modelica.Blocks.Logical.Switch T_room_min annotation (Placement(transformation(extent={{-50,-8},{-38,4}})));
  Modelica.Blocks.Sources.RealExpression realExpression3(y=290.15)
                                                                  annotation (Placement(transformation(extent={{-94,-34},{-74,-14}})));
  parameter HeatTransfer.Data.OpaqueConstructions.SandwichWall outsideWalls annotation (Placement(transformation(extent={{-92,-92},{-72,-72}})));
  parameter HeatTransfer.Data.GlazingSystems.DoubleClearAir23Clear window annotation (Placement(transformation(extent={{-62,-92},{-42,-72}})));
  parameter HeatTransfer.Data.OpaqueConstructions.Concrete400 floor annotation (Placement(transformation(extent={{-36,-92},{-16,-72}})));
  HeatTransfer.Data.OpaqueConstructions.FlatRoof_PIR roof annotation (Placement(transformation(extent={{-12,-92},{8,-72}})));
equation
  connect(productionHall.T_ground, GroundTemperature.y) annotation (Line(points={{52.47,-5.45},{42,-5.45},{42,-32},{84,-32},{84,-41},{80.5,-41}},
                                                                                                                              color={0,0,127}));
  connect(weaDat.weaBus, productionHall.weaBus) annotation (Line(
      points={{62,81},{66,81},{66,48},{55.46,48},{55.46,43.54}},
      color={255,204,51},
      thickness=0.5));
  connect(zero.y, productionHall.Q_gainRad) annotation (Line(points={{-7.6,7},{8,7},{8,8},{20,8},{20,18},{28.55,18},{28.55,8.81}},  color={0,0,127}));
  connect(zero.y, productionHall.Q_gainConv) annotation (Line(points={{-7.6,7},{18,7},{18,-4},{28.55,-4},{28.55,1.91}},color={0,0,127}));
  connect(productionHall.insideRoomTemperature, idealHeater_var.actTemperature) annotation (Line(points={{80.76,35.72},{86,35.72},{86,48},{64,48},{64,50},{-24,50},{-24,29.4},{-18,29.4}},
                                                                                                                                                                                       color={0,0,127}));
  connect(idealHeater_var.port_b, productionHall.heatPortAir) annotation (Line(points={{4.4,24},{26,24},{26,44.23},{34.99,44.23}},
                                                                                                                                 color={191,0,0}));
  connect(isSpaceOccupied.y, realToBoolean.u) annotation (Line(points={{-79.3,85},{-66,85},{-66,72},{-78,72},{-78,55},{-77,55}}, color={0,0,127}));
  connect(realToBoolean.y, T_room_max.u2) annotation (Line(points={{-65.5,55},{-52,55},{-52,36},{-54,36},{-54,26},{-51.2,26}}, color={255,0,255}));
  connect(T_room_max.u1, realExpression1.y) annotation (Line(points={{-51.2,30.8},{-51.2,30},{-73,30}}, color={0,0,127}));
  connect(realExpression2.y, T_room_max.u3) annotation (Line(points={{-73,16},{-52,16},{-52,21.2},{-51.2,21.2}}, color={0,0,127}));
  connect(T_room_max.y, idealHeater_var.T_max) annotation (Line(points={{-37.4,26},{-26,26},{-26,21.2},{-18,21.2}}, color={0,0,127}));
  connect(T_room_min.y, idealHeater_var.T_min) annotation (Line(points={{-37.4,-2},{-24,-2},{-24,16.8},{-18,16.8}}, color={0,0,127}));
  connect(realExpression3.y, T_room_min.u3) annotation (Line(points={{-73,-24},{-40,-24},{-40,-12},{-51.2,-12},{-51.2,-6.8}}, color={0,0,127}));
  connect(realToBoolean.y, T_room_min.u2) annotation (Line(points={{-65.5,55},{-52,55},{-52,36},{-54,36},{-54,-2},{-51.2,-2}}, color={255,0,255}));
  connect(realExpression.y, T_room_min.u1) annotation (Line(points={{-73,-10},{-52,-10},{-52,2.8},{-51.2,2.8}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(extent={{-100,100},{-24,-40}},
                                              lineColor={28,108,200}),
        Text(
          extent={{-96,-32},{24,-38}},
          lineColor={28,108,200},
          horizontalAlignment=TextAlignment.Left,
          textString="Definition of set temperatures")}),                                                             experiment(
      StopTime=31536000,
      Interval=3600,
      __Dymola_Algorithm="CVODE"));
end example_productionHall_externalHeater;
