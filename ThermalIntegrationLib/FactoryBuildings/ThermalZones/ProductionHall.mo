within ThermalIntegrationLib.FactoryBuildings.ThermalZones;
model ProductionHall
   extends ThermalZones.PartialBuildingModel(
    nConBou=1,
    nSurBou=0,
    electricalPower(k=fill(roo.AFlo, electricalPower.nu)),
    nPeople=127,
    pElLights=15,
    effLights=0.12,
    pElDevices=0,
    effDevices=0.7,
    acrInf=0.15,
    acrVent=1.5,
    length=130,
    width=60,
    zoneHeight=10.72,
    nIntFPorts=3,
    roo(
    nConExt =   nConExt,
    nConExtWin =   nConExtWin,datConExt=datConExt,datConExtWin=datConExtWin));
  import Buildings;

  // --- Connectors ---
  Buildings.BoundaryConditions.WeatherData.Bus weaBus annotation (Placement(transformation(extent={{-22,80},{18,120}}), iconTransformation(extent={{-8,88},{12,108}})));
  Modelica.Blocks.Interfaces.RealInput cs_shading[nConExtWin](min=0,max=1) if useShading "Control signal for shading (0: Opened shade, 1: Closed shade)" annotation (Placement(transformation(extent={{30,92},{60,122}}),      iconTransformation(extent={{-15,-15},{15,15}},
        rotation=-90,
        origin={61,105})));

  // --- Parameters ---
  parameter Boolean useShading=false "Set to true to use shading control" annotation(Dialog(group="General",tab="Energy Efficiency Measures"));

  // Constructions
  parameter Integer nConExt(min=0)=3 "Number of exterior constructions" annotation(Dialog(group="Components",tab="Constructions"));
  parameter Integer nConExtWin(min=0)=2 "Number of constructions with window" annotation(Dialog(group="Components",tab="Constructions"));
  parameter Buildings.ThermalZones.Detailed.BaseClasses.ParameterConstruction datConExt[max(1,nConExt)](
    each A=0,
    each layers = roo.dummyCon,
    each til=0,
    each azi=0) "Data for exterior construction"
    annotation (HideResult=true,Dialog(enable=nConExt>0,group="Components",tab="Constructions"));
  parameter Buildings.ThermalZones.Detailed.BaseClasses.ParameterConstructionWithWindow
    datConExtWin[max(1,nConExtWin)](
    each A=0,
    each layers = roo.dummyCon,
    each til=0,
    each azi=0,
    each hWin=0,
    each wWin=0,
    each glaSys=roo.dummyGlaSys) "Data for exterior construction with window"
    annotation (HideResult=true,Dialog(enable=nConExtWin>0,group="Components",tab="Constructions"));
  // Thermal zones

  // Boundary Conditions

  // Heating and cooling

  // Outputs Kästchenlib
  Modelica.Blocks.Interfaces.RealOutput outsideTemperature(unit="K", displayUnit="degC")
                                                                                        "Try bulb temperature" annotation (Placement(transformation(extent={{100,80},{124,104}}),
                       iconTransformation(extent={{100,76},{124,100}})));
  // Internal gains

  // Infiltration and ventilation
  Buildings.Fluid.Sources.MassFlowSource_WeatherData ventilation(
    redeclare package Medium = MediumAir,
    use_m_flow_in=true,
    nPorts=1) annotation (Placement(transformation(extent={{44,26},{54,36}})));
  Buildings.Fluid.Sources.Outside outside(redeclare package Medium = MediumAir, nPorts=1) "Boundary condition" annotation (Placement(transformation(extent={{28,84},{36,92}})));
  Buildings.Fluid.Sources.MassFlowSource_WeatherData
                     infiltration(
    redeclare package Medium = MediumAir,
    use_m_flow_in=true,
    nPorts=1) annotation (Placement(transformation(extent={{56,38},{66,48}})));
  Utilities.ACRtoMassFlow acrToMassFlow(acr_fixed=acrInf, volume=roo.V) annotation (Placement(transformation(extent={{36,50},{42,56}})));
  Utilities.ACRtoMassFlow acrToMassFlow1(acr_fixed=acrVent, volume=roo.V)
                                                                         annotation (Placement(transformation(extent={{2,44},{8,50}})));
  Modelica.Blocks.Math.Product occ_dep_vent "occupancy dependant ventilation" annotation (Placement(transformation(extent={{16,40},{20,44}})));
  Modelica.Blocks.Math.BooleanToReal occDependentVentMassFlow(
    realTrue=1,
    realFalse=0,
    y(unit="kg/s")) annotation (Placement(transformation(extent={{-64,-76},{-58,-70}})));
  Modelica.Blocks.Logical.GreaterEqualThreshold
                                           greaterEqualThreshold1(threshold=nMinPplVent)
    annotation (Placement(transformation(extent={{-78,-80},{-72,-74}})));
  Modelica.Blocks.Math.Gain nPpl(k=nPeople) annotation (Placement(transformation(extent={{-88,-78},{-84,-74}})));
equation
  // Connectors
  connect(outside.weaBus, weaBus) annotation (Line(
      points={{28,88.08},{-2,88.08},{-2,100}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(roo.uSha, cs_shading) annotation (Line(points={{34.32,2},{-88,2},{-88,107},{45,107}}, color={0,0,127}));
  // Boundary Conditions
  connect(roo.weaBus, weaBus) annotation (Line(
      points={{75.795,1.9},{74,1.9},{74,54},{90,54},{90,62},{-2,62},{-2,100}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  // Heating and cooling
  connect(zero.y, roomArea1.u) annotation (Line(points={{80.4,-83},{8,-83},{8,-40},{-16,-40},{-16,-19},{-12.6,-19}}, color={0,0,127}));
  connect(zero.y, roomArea.u) annotation (Line(points={{80.4,-83},{-12.6,-83},{-12.6,-5}}, color={0,0,127}));
  connect(idealHeater_var.port_b, heatFlowSensor.port_a) annotation (Line(points={{-13.6,-44},{-4,-44},{-4,-42},{6,-42}},
                                                                                                        color={191,0,0}));
  connect(TRoomAir.T, idealHeater_var.actTemperature) annotation (Line(points={{94,20},{94,24},{96,24},{96,30},{76,30},{76,16},{-52,16},{-52,-38.6},{-36,-38.6}},
                                                                                                                                                              color={0,0,127}));
  connect(operativeTemperature.y, operativeRoomTemperature) annotation (Line(points={{100.4,8},{106,8},{106,36},{94,36},{94,52},{112,52}}, color={0,0,127}));
  // Outputs Kästchenlib
  connect(weaBus.TDryBul, outsideTemperature) annotation (Line(
      points={{-2,100},{92,100},{92,92},{112,92}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  // Internal gains
  connect(weaBus.TDryBul, thermalBridge.Toutside) annotation (Line(
      points={{-2,100},{-2,66.04},{-35.64,66.04}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  // Infiltration and ventilation
  connect(weaBus, ventilation.weaBus) annotation (Line(
      points={{-2,100},{-2,62},{28,62},{28,46},{36,46},{36,31.1},{44,31.1}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(ventilation.ports[1], roo.ports[1]) annotation (Line(points={{54,31},{58,31},{58,18},{4,18},{4,-36},{32,-36},{32,-26},{41.25,-26}},                         color={0,127,255}));
  connect(outside.ports[1], roo.ports[3]) annotation (Line(points={{36,88},{36,-26},{41.25,-26}},        color={0,127,255}));
  connect(weaBus, infiltration.weaBus) annotation (Line(
      points={{-2,100},{-2,62},{28,62},{28,43.1},{56,43.1}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(infiltration.ports[1], roo.ports[2]) annotation (Line(points={{66,43},{70,43},{70,18},{4,18},{4,-36},{32,-36},{32,-26},{41.25,-26}},
                                                                                                                            color={0,127,255}));
  connect(roo.airDensity, acrToMassFlow.mediumDensity) annotation (Line(points={{75.9,-25.6},{82,-25.6},{82,8},{76,8},{76,6},{72,6},{72,56},{58,56},{58,70},{39.03,70},{39.03,56.33}}, color={0,0,127}));
  connect(acrToMassFlow.m_flow, infiltration.m_flow_in) annotation (Line(points={{42.6,53},{50,53},{50,52},{44,52},{44,47},{56,47}}, color={0,0,127}));
  connect(roo.airDensity, acrToMassFlow1.mediumDensity) annotation (Line(points={{75.9,-25.6},{82,-25.6},{82,8},{76,8},{76,6},{72,6},{72,56},{58,56},{58,70},{38,70},{38,58},{5.03,58},{5.03,50.33}}, color={0,0,127}));
  connect(acrToMassFlow1.m_flow, occ_dep_vent.u1) annotation (Line(points={{8.6,47},{12,47},{12,43.2},{15.6,43.2}}, color={0,0,127}));
  connect(occ_dep_vent.y, ventilation.m_flow_in) annotation (Line(points={{20.2,42},{26,42},{26,40},{44,40},{44,35}}, color={0,0,127}));
  connect(occDependentVentMassFlow.y, occ_dep_vent.u2) annotation (Line(points={{-57.7,-73},{-58,-73},{-58,32},{14,32},{14,36},{15.6,36},{15.6,40.8}}, color={0,0,127}));
  connect(greaterEqualThreshold1.y, occDependentVentMassFlow.u) annotation (Line(points={{-71.7,-77},{-68,-77},{-68,-73},{-64.6,-73}}, color={255,0,255}));
  connect(nPpl.y, greaterEqualThreshold1.u) annotation (Line(points={{-83.8,-76},{-78.6,-77}}, color={0,0,127}));
  connect(nPpl.u, switchSchedPeople.y) annotation (Line(points={{-88.4,-76},{-92,-76},{-92,-68},{-84,-68},{-84,6},{-86,6},{-86,38},{-56,38},{-56,48},{-57.7,48},{-57.7,51}}, color={0,0,127}));
  annotation (experiment(
      StopTime=31536000,
      Interval=3600,
      __Dymola_Algorithm="Dassl"), Icon(graphics={
        Polygon(points={{0,80},{68,40},{70,-42},{0,-80},{-70,-42},{-70,38},{0,80}},   lineColor={28,108,200},
          fillPattern=FillPattern.Solid,
          fillColor=DynamicSelect({170,213,255},
            min(1, max(0, (1-(roo.heaPorAir.T-295.15)/10)))*{28,108,200}+
            min(1, max(0, (roo.heaPorAir.T-295.15)/10))*{255,0,0})),
                                                  Bitmap(extent={{-80,-82},{80,80}}, fileName="modelica://ThermalIntegrationLib/Resources/icon_bld_productionHall.png")}),
    Documentation(info="<html>
<p>A thermal zone model connected to the outside.</p>
</html>"));
end ProductionHall;
