within ThermalIntegrationLib.FactoryBuildings.ThermalZones;
model Enclosure "Model of a thermal zone that encloses the machines"
  import ThermalIntegrationLib;
  extends ThermalIntegrationLib.FactoryBuildings.ThermalZones.PartialBuildingModel(
      nConBou=1,
      nSurBou=5,
      nIntFPorts=2,
      nPeople=0,
      pElLights=0,
      effLights=0,
      pElDevices=0,
      effDevices=0,
      acrInf=0.1,
      acrVent=0,
      length=3.16,
      width=3.16,
      zoneHeight=3.16,
      calcUseHeatDem=false,
      roo(nConExt=0,nConExtWin=0));

  // Parameters

  // Internal gains

  // Infiltration and ventilation
  Buildings.Fluid.Sources.MassFlowSource_T ventilation(
    redeclare package Medium = MediumAir,
    use_m_flow_in=true,
    nPorts=1,
    use_T_in=true)
              annotation (Placement(transformation(extent={{10,54},{24,68}})));
  Modelica.Blocks.Interfaces.RealInput ventilationTemperature "Inlet temperature for ventilation" annotation (Placement(transformation(
        extent={{-16,-16},{16,16}},
        rotation=270,
        origin={0,116}), iconTransformation(
        extent={{-16,-16},{16,16}},
        rotation=270,
        origin={1.77636e-15,116})));
  Utilities.ACRtoMassFlow acrToMassFlow(acr_fixed=acrVent,volume=roo.V)  annotation (Placement(transformation(extent={{-22,70},{-14,78}})));
    Buildings.Fluid.Sources.MassFlowSource_T infiltration(
    redeclare package Medium = MediumAir,
    use_m_flow_in=true,
    nPorts=1,
    use_T_in=true)
              annotation (Placement(transformation(extent={{20,36},{34,50}})));
  Modelica.Blocks.Interfaces.RealInput infiltrationTemperature
                                                              "Inlet temperature for ventilation" annotation (Placement(transformation(
        extent={{-16,-16},{16,16}},
        rotation=270,
        origin={40,116}),iconTransformation(
        extent={{-16,-16},{16,16}},
        rotation=270,
        origin={40,116})));
  ThermalIntegrationLib.FactoryBuildings.Utilities.ACRtoMassFlow
                          acrToMassFlow1(acr_fixed=acrInf, volume=roo.V) annotation (Placement(transformation(extent={{-14,52},{-6,60}})));
equation
  connect(ventilation.ports[1], roo.ports[1]) annotation (Line(points={{24,61},{58,61},{58,18},{4,18},{4,-36},{32,-36},{32,-26},{41.25,-26}},                         color={0,127,255}));
  connect(infiltration.ports[1], roo.ports[2]) annotation (Line(points={{34,43},{58,43},{58,18},{4,18},{4,-36},{32,-36},{32,-26},{41.25,-26}},                         color={0,127,255}));
  connect(zero.y, roomArea.u) annotation (Line(points={{80.4,-83},{60,-83},{60,-66},{32,-66},{32,-62},{-6,-62},{-6,-26},{-16,-26},{-16,-5},{-12.6,-5}}, color={0,0,127}));
  connect(zero.y, roomArea1.u) annotation (Line(points={{80.4,-83},{50,-83},{50,-58},{22,-58},{22,-54},{-16,-54},{-16,-18},{-26,-18},{-26,-19},{-12.6,-19}}, color={0,0,127}));
  connect(zero.y, latGainTot.u[1]) annotation (Line(points={{80.4,-83},{60,-83},{60,-66},{50,-66},{50,-58},{22,-58},{22,-54},{-6,-54},{-6,-26},{6,-26},{6,-20},{12,-20}}, color={0,0,127}));
  connect(ventilationTemperature, ventilation.T_in) annotation (Line(points={{0,116},{0,63.8},{8.6,63.8}}, color={0,0,127}));
  connect(roo.airDensity, acrToMassFlow.mediumDensity) annotation (Line(points={{75.9,-25.6},{80,-25.6},{80,88},{-17.96,88},{-17.96,78.44}}, color={0,0,127}));
  connect(acrToMassFlow.m_flow, ventilation.m_flow_in) annotation (Line(points={{-13.2,74},{-2,74},{-2,66.6},{8.6,66.6}},color={0,0,127}));
  connect(roo.airDensity, acrToMassFlow1.mediumDensity) annotation (Line(points={{75.9,-25.6},{82,-25.6},{82,12},{74,12},{74,74},{-2,74},{-2,68},{-4,68},{-4,60.44},{-9.96,60.44}},  color={0,0,127}));
  connect(acrToMassFlow1.m_flow,infiltration. m_flow_in) annotation (Line(points={{-5.2,56},{6,56},{6,48.6},{18.6,48.6}}, color={0,0,127}));
  connect(infiltrationTemperature,infiltration. T_in) annotation (Line(points={{40,116},{40,32},{16,32},{16,40},{12,40},{12,45.8},{18.6,45.8}}, color={0,0,127}));
  connect(infiltrationTemperature, thermalBridge.Toutside) annotation (Line(points={{40,116},{40,32},{16,32},{16,40},{-30,40},{-30,66.04},{-35.64,66.04}}, color={0,0,127}));
  annotation (Icon(graphics={
        Polygon(points={{0,78},{66,40},{68,-38},{0,-76},{-68,-38},{-68,40},{0,78}},   lineColor={28,108,200},
          fillPattern=FillPattern.Solid,
          fillColor=DynamicSelect({170,213,255},
            min(1, max(0, (1-(roo.heaPorAir.T-295.15)/10)))*{28,108,200}+
            min(1, max(0, (roo.heaPorAir.T-295.15)/10))*{255,0,0})),
                             Bitmap(extent={{-96,-78},{96,80}}, fileName="modelica://ThermalIntegrationLib/Resources/icon_bld_enclosure.png")}), Documentation(info="<html>
<p>A thermal zone model usually connected to an outer thermal zone (see <a href=\"modelica://ThermalIntegrationLib/FactoryBuildings/ThermalZones/Examples/Modelling/package.mo\">Examples.Modelling</a>).</p>
<p>The constructions adjacent to the outer zone should have matching surfaces in the outer zone.</p>
<p>For example: An enclosure has 5 surfaces facing the outer zone and a ground floor. You may assign the constructions to the enclosure and define matching surfaces in the outer zone:</p>
<ul>
<li>enclosure: <b>nConBou</b>=6, <b>nGroundFloor</b>=1</li>
<li>outer zone additional constructions: <b>nSurBou</b>=5</li>
<li>The connector surf_conBou[2:6] of the enclosure is connected with surf_surBou[:] of the outer zone.</li>
</ul>
<p><br>The fluid volumes of the inner and outer zone should be somehow connected to allow for pressure equalization.</p>
</html>"));
end Enclosure;
