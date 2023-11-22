within ThermalIntegrationLib.FactoryBuildings.BuildingModels;
model FactoryBuilding_productionHall1994_eff "FactoryBuilding_productionHall1994 with efficiency measures"
  extends ThermalIntegrationLib.BaseClasses.BaseFactoryBuilding(
    outsideTemperature=productionHall.outsideTemperature,
    insideTemperature=productionHall.insideRoomTemperature,
    heatDemands=1,
    coolDemands=1,
    electricDemands=1);

  ThermalZones.ProductionHall productionHall(
    latitude=0.87266462599716,
    useHeatPortAir=false,
    useFluidPorts=true,
    nPeople=127,
    pElLights=2,
    effLights=0.4,
    acrVent=0,
    calcUseHeatDem=true,
    length=130,
    width=60,
    zoneHeight=10.72,
    nMinPplVent=5,
    Tmin_occ=292.15,
    Tmin_nocc=289.15,
    pMaxHeat=1000000,
    pMaxCool=1000000,
    nConExt=3,
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
    nFPorts=1)                 "Metal processing industry, built 1994, approx. 9000 m2, sandwich/cassete construction" annotation (Placement(transformation(extent={{36,-6},{82,40}})));
  Buildings.BoundaryConditions.WeatherData.ReaderTMY3 weaDat(filNam=ModelicaServices.ExternalReferences.loadResource("modelica://ThermalIntegrationLib/Resources/weatherdata/DEU_Frankfurt.am.Main.106370_IWEC.mos"))
                                                                                                                                                                                                        annotation (Placement(transformation(extent={{66,76},{80,90}})));
  Modelica.Blocks.Sources.Sine GroundTemperature(
    amplitude=10,
    freqHz=1/(8760*3600),
    phase=-1.7453292519943,
    offset=273.15 + 10) annotation (Placement(transformation(extent={{12,-94},{22,-84}})));

  Modelica.Blocks.Sources.CombiTimeTable schedTable(
    table=[0.0,0.0; 8,1; 17,0.0; 24,0],
    columns=2:size(schedTable.table, 2),
    smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments,
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
    timeScale(displayUnit="h") = 3600) "Machine waste heat"                                                                            annotation (Placement(transformation(extent={{-20,-32},{-6,-18}})));
  InternalGains.Gain_th_per_area machineDummy(shareRad=0.3, nominalPower=50*10000/productionHall.roo.AFlo)
                                                                                                  annotation (Placement(transformation(extent={{4,-30},{12,-22}})));
  parameter HeatTransfer.Data.OpaqueConstructions.Generic floor(nLay=3, material={Buildings.HeatTransfer.Data.Solids.Concrete(x=0.2),HeatTransfer.Data.Solids.Polystyrene(x=0.1),HeatTransfer.Data.Solids.Screed(x=0.02)}) annotation (Placement(transformation(extent={{-16,80},{4,100}})));

  Buildings.Fluid.Sources.MassFlowSource_WeatherData ventilation(
    redeclare package Medium = Buildings.Media.Air,              use_m_flow_in=true, nPorts=1) annotation (Placement(transformation(extent={{-10,22},{4,36}})));
  Buildings.Fluid.Sensors.DensityTwoPort senDen(redeclare package Medium = Buildings.Media.Air, m_flow_nominal=1.5/3600*1.25*productionHall.roo.V)
                                                annotation (Placement(transformation(extent={{10,26},{18,34}})));
  IncreasedVentilation increasedVentilation(aCRtoMassFlow(volume=productionHall.roo.V), greaterThreshold(threshold=productionHall.Tmax_occ - 1)) annotation (Placement(transformation(rotation=0, extent={{-76,30},{-56,50}})));
  Buildings.Electrical.AC.ThreePhasesBalanced.Sources.Grid
                                      gri(
    f=50,
    V=230,
    phiSou=0) "Grid model that provides power to the system"
    annotation (Placement(transformation(extent={{-96,-80},{-76,-60}})));
  Buildings.Electrical.AC.ThreePhasesBalanced.Lines.Line
                                    line4(
    mode=Buildings.Electrical.Types.CableMode.automatic,
    l=50,
    V_nominal=230,
    P_nominal=5620 + 200*pv.A)       "Electrical line"
             annotation (Placement(transformation(extent={{-72,-96},{-52,-76}})));
  Buildings.Electrical.AC.ThreePhasesBalanced.Sources.PVSimpleOriented pv(
    eta_DCAC=0.89,
    A=500,
    fAct=0.9,
    eta=0.19,
    linearized=false,
    V_nominal=230,
    pf=0.9,
    lat=weaDat.lat,
    azi=Buildings.Types.Azimuth.S,
    til=0.5235987755983) "PV" annotation (Placement(transformation(extent={{-70,-78},{-50,-58}})));
  Buildings.Electrical.AC.ThreePhasesBalanced.Loads.Capacitive
                                         loa4(
    mode=Buildings.Electrical.Types.Load.VariableZ_P_input,
    linearized=false,
    use_pf_in=false,
    pf=0.88)                 "Electrical load"
    annotation (Placement(transformation(extent={{-36,-96},{-16,-76}})));
protected
  parameter HeatTransfer.Data.OpaqueConstructions.SandwichWall outsideWalls_SN annotation (Placement(transformation(extent={{-96,80},{-76,100}})));
protected
  parameter HeatTransfer.Data.OpaqueConstructions.CassetteWall120 outsideWalls_WE annotation (Placement(transformation(extent={{-70,80},{-50,100}})));
  parameter HeatTransfer.Data.OpaqueConstructions.FlatRoof_PIR roof(material={HeatTransfer.Data.Solids.PIR_023(x=0.2)})
                                                                    annotation (Placement(transformation(extent={{-44,80},{-24,100}})));
  parameter Buildings.HeatTransfer.Data.GlazingSystems.DoubleClearAir13Clear window annotation (Placement(transformation(extent={{12,80},{32,100}})));
equation

  coolDemand[1].Q_flow[1] = productionHall.Q_flow_cool_ideal;
  coolDemand[1].T_in[1] = productionHall.insideRoomTemperature -10; //Kühlung Vorlauf
  coolDemand[1].T_out[1] = productionHall.insideRoomTemperature -5; //Kühlung Rücklauf

  heatDemand[1].Q_flow[1] = productionHall.Q_flow_heat_ideal;
  heatDemand[1].T_in[1] = productionHall.insideRoomTemperature +30; //Heizung Vorlauf
  heatDemand[1].T_out[1] = productionHall.insideRoomTemperature +20; //Heizung Rücklauf

  electricDemand[1].Power[1] = productionHall.P_el-pv.P;

  connect(weaDat.weaBus,productionHall. weaBus) annotation (Line(
      points={{80,83},{84,83},{84,44},{59.46,44},{59.46,39.54}},
      color={255,204,51},
      thickness=0.5));
  connect(productionHall.T_ground,GroundTemperature. y) annotation (Line(points={{56.47,-9.45},{56.47,-89},{22.5,-89}},       color={0,0,127}));
  connect(schedTable.y[1],machineDummy. schedule) annotation (Line(points={{-5.3,-25},{-4,-25},{-4,-22},{3.2,-22},{3.2,-26}},
                                                                                                                 color={0,0,127}));
  connect(machineDummy.Qth_conv, productionHall.Q_gainConv) annotation (Line(points={{12.72,-27.2},{32.55,-27.2},{32.55,-2.09}},               color={0,0,127}));
  connect(machineDummy.Qth_rad, productionHall.Q_gainRad) annotation (Line(points={{12.72,-28.8},{30,-28.8},{30,-8},{24,-8},{24,4.81},{32.55,4.81}},
                                                                                                                                                   color={0,0,127}));
  connect(weaDat.weaBus, ventilation.weaBus) annotation (Line(
      points={{80,83},{84,83},{84,52},{-18,52},{-18,29.14},{-10,29.14}},
      color={255,204,51},
      thickness=0.5));
  connect(ventilation.ports[1], senDen.port_a) annotation (Line(points={{4,29},{10,30}}, color={0,127,255}));
  connect(senDen.port_b, productionHall.fPorts[1]) annotation (Line(points={{18,30},{18,40},{32,40},{32,32},{33.7,32},{33.7,28.5}}, color={0,127,255}));
  connect(senDen.d,increasedVentilation.mediumDensity)
                                                 annotation (Line(points={{14,34.4},{14,48},{-56,48}},                   color={0,0,127}));
  connect(productionHall.insideRoomTemperature,increasedVentilation.u1)
                                                            annotation (Line(points={{84.76,31.72},{90,31.72},{90,46},{16,46},{16,54},{-76,54},{-76,50}},            color={0,0,127}));
  connect(productionHall.outsideTemperature,increasedVentilation.u2)
                                                         annotation (Line(points={{84.76,37.24},{88,37.24},{88,44},{-20,44},{-20,26},{-80,26},{-80,46},{-76,46}},     color={0,0,127}));
  connect(increasedVentilation.y,
                           ventilation.m_flow_in) annotation (Line(points={{-56,44},{-16,44},{-16,34.6},{-10,34.6}},   color={0,0,127}));
protected
  model IncreasedVentilation
    Utilities.ACRtoMassFlow aCRtoMassFlow(inputACR=true) annotation (Placement(transformation(extent={{-52,20},{-44,28}})));
    Modelica.Blocks.Logical.GreaterThreshold greaterThreshold annotation (Placement(transformation(extent={{-90,4},{-82,12}})));
    Modelica.Blocks.Logical.Greater greater annotation (Placement(transformation(extent={{-92,34},{-84,42}})));
    Utilities.BooleanToReal booleanToReal annotation (Placement(transformation(extent={{-66,18},{-58,26}})));
    Modelica.Blocks.Logical.And and1 annotation (Placement(transformation(extent={{-84,20},{-76,28}})));
    Modelica.Blocks.Sources.RealExpression realExpression annotation (Placement(transformation(extent={{-86,-18},{-74,-6}})));
    Modelica.Blocks.Sources.RealExpression increasedACR(y=1.5) annotation (Placement(transformation(extent={{-86,46},{-74,58}})));
    Modelica.Blocks.Continuous.LimIntegrator limIntegrator(outMax=1.5, outMin=0) annotation (Placement(transformation(extent={{-38,22},{-32,28}})));
    Modelica.Blocks.Sources.Clock clock annotation (Placement(transformation(extent={{-92,-40},{-80,-28}})));
    Modelica.Blocks.Logical.Greater greater1 annotation (Placement(transformation(extent={{-68,-40},{-60,-32}})));
    Modelica.Blocks.Sources.RealExpression realExpression1(y=7689600) annotation (Placement(transformation(extent={{-90,-64},{-78,-52}})));
    Modelica.Blocks.Logical.And and2 annotation (Placement(transformation(extent={{-58,-64},{-50,-56}})));
    Modelica.Blocks.Logical.Less less annotation (Placement(transformation(extent={{-72,-80},{-64,-72}})));
    Modelica.Blocks.Sources.RealExpression realExpression2(y=23500800) annotation (Placement(transformation(extent={{-94,-84},{-82,-72}})));
    Modelica.Blocks.Logical.And and3 annotation (Placement(transformation(extent={{-60,-4},{-52,4}})));
    Modelica.Blocks.Interfaces.RealInput mediumDensity(unit="kg/m3") annotation (Placement(transformation(rotation=0, extent={{90,70},{110,90}})));
    Modelica.Blocks.Interfaces.RealInput u1 annotation (Placement(transformation(rotation=0, extent={{-110,90},{-90,110}})));
    Modelica.Blocks.Interfaces.RealInput u2 annotation (Placement(transformation(rotation=0, extent={{-110,50},{-90,70}})));
    Modelica.Blocks.Interfaces.RealOutput y(start=limIntegrator.y_start) annotation (Placement(transformation(rotation=0, extent={{90,30},{110,50}})));
  equation
    connect(booleanToReal.y,aCRtoMassFlow. acr) annotation (Line(points={{-57.6,22},{-56,22},{-56,24},{-52.68,24},{-52.68,23.96}}, color={0,0,127}));
    connect(greater.y,and1. u1) annotation (Line(points={{-83.6,38},{-80,38},{-80,32},{-84,32},{-84,24},{-84.8,24}}, color={255,0,255}));
    connect(and1.u2,greaterThreshold. y) annotation (Line(points={{-84.8,20.8},{-84.8,16},{-78,16},{-78,8},{-81.6,8}}, color={255,0,255}));
    connect(booleanToReal.realFalse,realExpression. y) annotation (Line(points={{-66.8,19.6},{-66.8,-12},{-73.4,-12}}, color={0,0,127}));
    connect(increasedACR.y, booleanToReal.realTrue) annotation (Line(points={{-73.4,52},{-66.8,52},{-66.8,24.4}}, color={0,0,127}));
    connect(aCRtoMassFlow.m_flow,limIntegrator. u) annotation (Line(points={{-43.2,24},{-43.2,25},{-38.6,25}}, color={0,0,127}));
    connect(clock.y,greater1. u1) annotation (Line(points={{-79.4,-34},{-79.4,-36},{-68.8,-36}}, color={0,0,127}));
    connect(realExpression1.y,greater1. u2) annotation (Line(points={{-77.4,-58},{-68.8,-58},{-68.8,-39.2}}, color={0,0,127}));
    connect(greater1.y,and2. u1) annotation (Line(points={{-59.6,-36},{-54,-36},{-54,-52},{-62,-52},{-62,-60},{-58.8,-60}}, color={255,0,255}));
    connect(realExpression2.y,less. u2) annotation (Line(points={{-81.4,-78},{-81.4,-79.2},{-72.8,-79.2}}, color={0,0,127}));
    connect(less.y,and2. u2) annotation (Line(points={{-63.6,-76},{-58,-76},{-58,-68},{-62,-68},{-62,-63.2},{-58.8,-63.2}}, color={255,0,255}));
    connect(and1.y,and3. u1) annotation (Line(points={{-75.6,24},{-72,24},{-72,6},{-64,6},{-64,0},{-60.8,0}}, color={255,0,255}));
    connect(and3.u2,and2. y) annotation (Line(points={{-60.8,-3.2},{-60.8,-28},{-48,-28},{-48,-52},{-44,-52},{-44,-60},{-49.6,-60}}, color={255,0,255}));
    connect(and3.y,booleanToReal. u) annotation (Line(points={{-51.6,0},{-48,0},{-48,8},{-70,8},{-70,22},{-66.8,22}}, color={255,0,255}));
    connect(clock.y,less. u1) annotation (Line(points={{-79.4,-34},{-74,-34},{-74,-48},{-94,-48},{-94,-68},{-76,-68},{-76,-76},{-72.8,-76}}, color={0,0,127}));
    connect(mediumDensity, aCRtoMassFlow.mediumDensity) annotation (Line(points={{100,80},{-44,80},{-44,32},{-47.96,32},{-47.96,28.44}}, color={0,0,127}));
    connect(u1, greater.u1) annotation (Line(points={{-100,100},{-96,100},{-96,38},{-92.8,38}}, color={0,0,127}));
    connect(u2, greater.u2) annotation (Line(points={{-100,60},{-100,34.8},{-96,34.8},{-92.8,34.8}}, color={0,0,127}));
    connect(u1, greaterThreshold.u) annotation (Line(points={{-100,100},{-96,100},{-96,8},{-90.8,8}}, color={0,0,127}));
    connect(y, limIntegrator.y) annotation (Line(points={{100,40},{34,40},{34,25},{-31.7,25}}, color={0,0,127}));
  end IncreasedVentilation;
equation
  connect(gri.terminal, line4.terminal_n) annotation (Line(points={{-86,-80},{-86,-86},{-72,-86}}, color={0,120,120}));
  connect(pv.terminal, line4.terminal_p) annotation (Line(points={{-70,-68},{-70,-54},{-44,-54},{-44,-70},{-42,-70},{-42,-86},{-52,-86}}, color={0,120,120}));
  connect(loa4.terminal, line4.terminal_p) annotation (Line(points={{-36,-86},{-52,-86}}, color={0,120,120}));
  connect(weaDat.weaBus, pv.weaBus) annotation (Line(
      points={{80,83},{84,83},{84,52},{-18,52},{-18,-14},{-60,-14},{-60,-59}},
      color={255,204,51},
      thickness=0.5));
  connect(productionHall.P_el, loa4.Pow) annotation (Line(points={{84.76,7.8},{90,7.8},{90,-100},{-2,-100},{-2,-86},{-16,-86}}, color={0,0,127}));
 annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(
          preserveAspectRatio=false), graphics={
        Rectangle(extent={{-100,100},{50,70}},lineColor={28,108,200}),
        Text(
          extent={{-98,78},{22,72}},
          lineColor={28,108,200},
          horizontalAlignment=TextAlignment.Left,
          textString="Refurbished constructions used in the building model")}),
    Documentation(info="<html>
</html>"));
end FactoryBuilding_productionHall1994_eff;
