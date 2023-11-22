within ThermalIntegrationLib.FactoryBuildings.BuildingModels;
model FactoryBuilding_productionHall1994
  extends ThermalIntegrationLib.BaseClasses.BaseFactoryBuilding(
    outsideTemperature=productionHall.outsideTemperature,
    insideTemperature=productionHall.insideRoomTemperature,
    heatDemands=1,
    coolDemands=1,
    electricDemands=1);

  ThermalZones.ProductionHall productionHall(
    useHeatPortAir=false,
    useFluidPorts=false,
    nPeople=127,
    acrVent=1.5,
    calcUseHeatDem=true,
    length=130,
    width=60,
    zoneHeight=10.72,
    nMinPplVent=5,
    Tmin_occ=292.15,
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
    latitude=0.87266462599716) "Metal processing industry, built 1994, approx. 9000 m2, sandwich/cassete construction" annotation (Placement(transformation(extent={{36,-4},{82,42}})));
  Buildings.BoundaryConditions.WeatherData.ReaderTMY3 weaDat(filNam=ModelicaServices.ExternalReferences.loadResource("modelica://ThermalIntegrationLib/Resources/weatherdata/DEU_Frankfurt.am.Main.106370_IWEC.mos"))
                                                                                                                                                                                                        annotation (Placement(transformation(extent={{-22,30},{-8,44}})));
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
    timeScale(displayUnit="h") = 3600) "Machine waste heat"                                                                            annotation (Placement(transformation(extent={{-42,-32},{-28,-18}})));
  InternalGains.Gain_th_per_area machineDummy(shareRad=0.3, nominalPower=50*10000/productionHall.roo.AFlo)
                                                                                                  annotation (Placement(transformation(extent={{-18,-30},{-10,-22}})));
protected
  parameter HeatTransfer.Data.OpaqueConstructions.CassetteWall120 outsideWalls_WE annotation (Placement(transformation(extent={{-70,80},{-50,100}})));
  parameter HeatTransfer.Data.OpaqueConstructions.SandwichWall outsideWalls_SN annotation (Placement(transformation(extent={{-96,80},{-76,100}})));
  parameter HeatTransfer.Data.OpaqueConstructions.FlatRoof_PIR roof(material={HeatTransfer.Data.Solids.PIR_023(x=0.2)})
                                                                    annotation (Placement(transformation(extent={{-44,80},{-24,100}})));
  parameter Buildings.HeatTransfer.Data.GlazingSystems.DoubleClearAir13Clear window annotation (Placement(transformation(extent={{8,80},{28,100}})));
  parameter Buildings.HeatTransfer.Data.OpaqueConstructions.Concrete200 floor(material={Buildings.HeatTransfer.Data.Solids.Concrete(x=0.2)})
                                                                              annotation (Placement(transformation(extent={{-18,80},{2,100}})));

equation

  coolDemand[1].Q_flow[1] = productionHall.Q_flow_cool_ideal;
  coolDemand[1].T_in[1] = productionHall.insideRoomTemperature -10; //Kühlung Vorlauf
  coolDemand[1].T_out[1] = productionHall.insideRoomTemperature -5; //Kühlung Rücklauf

  heatDemand[1].Q_flow[1] = productionHall.Q_flow_heat_ideal;
  heatDemand[1].T_in[1] = productionHall.insideRoomTemperature +30; //Heizung Vorlauf
  heatDemand[1].T_out[1] = productionHall.insideRoomTemperature +20; //Heizung Rücklauf

  electricDemand[1].Power[1] = productionHall.P_el;

  connect(weaDat.weaBus,productionHall. weaBus) annotation (Line(
      points={{-8,37},{26,37},{26,44},{59.46,44},{59.46,39.54}},
      color={255,204,51},
      thickness=0.5));
  connect(productionHall.T_ground,GroundTemperature. y) annotation (Line(points={{56.47,-7.45},{56.47,-89},{22.5,-89}},       color={0,0,127}));
  connect(schedTable.y[1],machineDummy. schedule) annotation (Line(points={{-27.3,-25},{-27.3,-26},{-18.8,-26}}, color={0,0,127}));
  connect(machineDummy.Qth_conv, productionHall.Q_gainConv) annotation (Line(points={{-9.28,-27.2},{11.36,-27.2},{11.36,-0.09},{32.55,-0.09}}, color={0,0,127}));
  connect(machineDummy.Qth_rad, productionHall.Q_gainRad) annotation (Line(points={{-9.28,-28.8},{14,-28.8},{14,2},{24,2},{24,6.81},{32.55,6.81}}, color={0,0,127}));
 annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(
          preserveAspectRatio=false), graphics={
        Rectangle(extent={{-100,100},{50,70}},lineColor={28,108,200}),
        Text(
          extent={{-98,78},{22,72}},
          lineColor={28,108,200},
          textString="Constructions used in the building model",
          horizontalAlignment=TextAlignment.Left)}),
    Documentation(info="<html>
</html>"));
end FactoryBuilding_productionHall1994;
