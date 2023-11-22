within ThermalIntegrationLib.FactoryBuildings.BuildingModels;
model FactoryBuilding_ETA "ETA factory"
  extends ThermalIntegrationLib.BaseClasses.BaseFactoryBuilding(
    outsideTemperature=ETAfactory_productionHall.outsideTemperature,
    insideTemperature=ETAfactory_productionHall.insideRoomTemperature,
    heatDemands=1,
    coolDemands=1,
    electricDemands=1);

  ThermalZones.ProductionHall ETAfactory_productionHall(
    useHeatPortAir=true,
    useHeatPortRad=true,
    useFluidPorts=false,
    nPeople=2,
    pElLights=24,
    effLights=0.42,
    calcUseHeatDem=false,
    length=18.02,
    width=29.14,
    zoneHeight=10.54,
    nConExt=0,
    nConExtWin=4,
    nConBou=2,
    datConExtWin(
      name={"South","Ceiling","East","West"},
      layers={floor,roof,outsideWalls,outsideWalls},
      til={Buildings.Types.Tilt.Wall,Buildings.Types.Tilt.Ceiling,Buildings.Types.Tilt.Wall,Buildings.Types.Tilt.Wall},
      azi={Buildings.Types.Azimuth.S,0,Buildings.Types.Azimuth.E,Buildings.Types.Azimuth.W},
      A={ETAfactory_productionHall.length*ETAfactory_productionHall.zoneHeight,ETAfactory_productionHall.roo.AFlo,ETAfactory_productionHall.width*ETAfactory_productionHall.zoneHeight,ETAfactory_productionHall.width*ETAfactory_productionHall.zoneHeight},
      hWin={10,25,5.1,5.1},
      wWin={14.67,1.4,10,10},
      each ove(
        wL=0,
        wR=0,
        dep=0,
        gap=0),
      each sidFin(
        h=0,
        dep=0,
        gap=0),
      each glaSys=datGlaSys),
    datConBou(
      name={"North","Floor"},
      layers={intWall,floor},
      til={Buildings.Types.Tilt.Wall,Buildings.Types.Tilt.Floor},
      azi={Buildings.Types.Azimuth.N,0},
      A={ETAfactory_productionHall.length*ETAfactory_productionHall.zoneHeight,ETAfactory_productionHall.roo.AFlo},
      each stateAtSurface_a=false),
    latitude=0.87039569796957) annotation (Placement(transformation(extent={{36,-6},{82,40}})));
  Buildings.BoundaryConditions.WeatherData.ReaderTMY3 weaDat(filNam=ModelicaServices.ExternalReferences.loadResource("modelica://ThermalIntegrationLib/Resources/weatherdata/DEU_Frankfurt.am.Main.106370_IWEC.mos"))
                                                                                                                                                                                                        annotation (Placement(transformation(extent={{20,76},{34,90}})));
  Modelica.Blocks.Sources.Sine GroundTemperature(
    amplitude=10,
    freqHz=1/(8760*3600),
    phase=-1.7453292519943,
    offset=273.15 + 10) annotation (Placement(transformation(extent={{26,-38},{36,-28}})));
  Modelica.Blocks.Sources.RealExpression zero(y=0) annotation (Placement(transformation(extent={{4,-8},{20,4}})));
  Modelica.Blocks.Continuous.LimPID PID(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=15e4,
    Ti=3000,
    yMax=Modelica.Constants.inf,
    initType=Modelica.Blocks.Types.InitPID.InitialState)
    annotation (Placement(transformation(extent={{-70,-18},{-50,2}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlowConv(alpha=0.00000001) annotation (Placement(transformation(extent={{-22,4},{-2,24}})));
  Modelica.Blocks.Sources.Pulse isSpaceOccupied(
    amplitude=2,
    width=33.33,
    period(displayUnit="h") = 86400,
    offset=292.15,
    startTime(displayUnit="h") = 28800) annotation (Placement(transformation(extent={{-96,-16},{-80,0}})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature adjacentOfficeTemperature(T=293.15) "Room temperature of the adjacent office" annotation (Placement(transformation(extent={{48,-48},{68,-28}})));
  Modelica.Blocks.Sources.RealExpression heat_demand(y=if (prescribedHeatFlowConv.Q_flow + prescribedHeatFlowRad.Q_flow) > 0 then (prescribedHeatFlowConv.Q_flow + prescribedHeatFlowConv.Q_flow) else 0) annotation (Placement(transformation(extent={{-32,-72},{78,-60}})));
  Modelica.Blocks.Sources.RealExpression cool_demand(y=if (prescribedHeatFlowConv.Q_flow + prescribedHeatFlowConv.Q_flow) < 0 then (prescribedHeatFlowConv.Q_flow + prescribedHeatFlowConv.Q_flow) else 0) annotation (Placement(transformation(extent={{-32,-92},{76,-80}})));
  Modelica.Blocks.Interfaces.RealOutput Q_flow_heat "Heat demand of building" annotation (Placement(transformation(extent={{100,-76},{120,-56}})));
  Modelica.Blocks.Interfaces.RealOutput Q_flow_cool "Cooling demand of building" annotation (Placement(transformation(extent={{100,-96},{120,-76}})));
  Modelica.Blocks.Math.Gain shareRad(k=0.63) "radiative fraction of KaRoMa" annotation (Placement(transformation(extent={{-40,-26},{-30,-16}})));
  Modelica.Blocks.Math.Gain shareConv(k=0.37) "convective fraction of KaRoMa" annotation (Placement(transformation(extent={{-42,6},{-32,16}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlowRad(alpha=0.00000001) annotation (Placement(transformation(extent={{-22,-14},{-2,6}})));

protected
  parameter HeatTransfer.Data.GlazingSystems.DoubleClearAir23Clear datGlaSys annotation (Placement(transformation(extent={{-90,76},{-70,96}})));
  parameter HeatTransfer.Data.OpaqueConstructions.Slab_ETA floor annotation (Placement(transformation(extent={{-58,78},{-38,98}})));
  parameter HeatTransfer.Data.OpaqueConstructions.FlatRoof_ETA roof annotation (Placement(transformation(extent={{-32,78},{-12,98}})));
  parameter HeatTransfer.Data.OpaqueConstructions.Facade_WE_ETA outsideWalls annotation (Placement(transformation(extent={{-90,52},{-70,72}})));
  parameter HeatTransfer.Data.OpaqueConstructions.InteriourWall_ETA intWall annotation (Placement(transformation(extent={{-62,52},{-42,72}})));

equation

  coolDemand[1].Q_flow[1] =abs(Q_flow_cool);
  coolDemand[1].T_in[1] =ETAfactory_productionHall.insideRoomTemperature - 10;
                                                                    //Kühlung Vorlauf
  coolDemand[1].T_out[1] =ETAfactory_productionHall.insideRoomTemperature - 5;
                                                                    //Kühlung Rücklauf

  heatDemand[1].Q_flow[1] =Q_flow_heat;
  heatDemand[1].T_in[1] =ETAfactory_productionHall.insideRoomTemperature + 30;
                                                                    //Heizung Vorlauf
  heatDemand[1].T_out[1] =ETAfactory_productionHall.insideRoomTemperature + 20;
                                                                     //Heizung Rücklauf

  electricDemand[1].Power[1] =ETAfactory_productionHall.P_el;

  connect(weaDat.weaBus, ETAfactory_productionHall.weaBus) annotation (Line(
      points={{34,83},{34,58},{60,58},{60,39.54},{59.46,39.54}},
      color={255,204,51},
      thickness=0.5));
  connect(ETAfactory_productionHall.T_ground, GroundTemperature.y) annotation (Line(points={{56.47,-9.45},{56.47,-22},{36.5,-22},{36.5,-33}},
                                                                                                                                   color={0,0,127}));
  connect(zero.y, ETAfactory_productionHall.Q_gainRad) annotation (Line(points={{20.8,-2},{10,-2},{10,-16},{24,-16},{24,4.81},{32.55,4.81}},
                                                                                                                                     color={0,0,127}));
  connect(zero.y, ETAfactory_productionHall.Q_gainConv) annotation (Line(points={{20.8,-2},{10,-2},{10,-16},{24,-16},{24,-8},{32.55,-8},{32.55,-2.09}},
                                                                                                                                         color={0,0,127}));
  connect(isSpaceOccupied.y, PID.u_s) annotation (Line(points={{-79.2,-8},{-72,-8}},                       color={0,0,127}));
  connect(adjacentOfficeTemperature.port, ETAfactory_productionHall.surf_conBou[1]) annotation (Line(points={{68,-38},{72,-38},{72,-14},{77.86,-14},{77.86,-8.3}},
                                                                                                                                                color={191,0,0}));
  connect(prescribedHeatFlowConv.port, ETAfactory_productionHall.heatPortAir) annotation (Line(points={{-2,14},{12,14},{12,42},{32,42},{32,40.23},{38.99,40.23}}, color={191,0,0}));
  connect(heat_demand.y, Q_flow_heat) annotation (Line(points={{83.5,-66},{82,-66},{82,-70},{94,-70},{94,-66},{110,-66}}, color={0,0,127}));
  connect(cool_demand.y, Q_flow_cool) annotation (Line(points={{81.4,-86},{80,-86},{80,-90},{96,-90},{96,-86},{110,-86}}, color={0,0,127}));
  connect(shareConv.y, prescribedHeatFlowConv.Q_flow) annotation (Line(points={{-31.5,11},{-30,11},{-30,14},{-22,14}}, color={0,0,127}));
  connect(shareConv.u, PID.y) annotation (Line(points={{-43,11},{-48,11},{-48,6},{-46,6},{-46,-2},{-44,-2},{-44,-8},{-49,-8}}, color={0,0,127}));
  connect(PID.y, shareRad.u) annotation (Line(points={{-49,-8},{-44,-8},{-44,-16},{-46,-16},{-46,-21},{-41,-21}}, color={0,0,127}));
  connect(shareRad.y, prescribedHeatFlowRad.Q_flow) annotation (Line(points={{-29.5,-21},{-24,-21},{-24,-16},{-26,-16},{-26,-10},{-28,-10},{-28,-4},{-22,-4}}, color={0,0,127}));
  connect(ETAfactory_productionHall.operativeRoomTemperature, PID.u_m) annotation (Line(points={{84.76,26.2},{90,26.2},{90,-54},{-60,-54},{-60,-20}}, color={0,0,127}));
  connect(prescribedHeatFlowRad.port, ETAfactory_productionHall.heatPortRad) annotation (Line(points={{-2,-4},{2,-4},{2,8},{16,8},{16,48},{48.19,48},{48.19,40.23}}, color={191,0,0}));
 annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(
          preserveAspectRatio=false), graphics={
        Text(
          extent={{54,92},{146,54}},
          lineColor={28,108,200},
          horizontalAlignment=TextAlignment.Left,
          textString="TODO: Anja wg. Baustoffeigenschaften (Verglasung) fragen"),                                               Rectangle(
          extent={{-100,28},{2,-40}},
          lineColor={0,0,0},
          lineThickness=1), Text(
          extent={{-100,26},{-36,20}},
          lineColor={0,0,0},
          textString="Heating/cooling control")}),
    Documentation(info="<html>
</html>"));
end FactoryBuilding_ETA;
