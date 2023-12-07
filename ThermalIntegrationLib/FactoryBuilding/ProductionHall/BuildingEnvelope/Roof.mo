within ThermalIntegrationLib.FactoryBuilding.ProductionHall.BuildingEnvelope;
model Roof
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a Outside annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a Inside annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor thermalConductor(G=deviceData.G)
                                                                             annotation (Placement(transformation(extent={{40,-10},{60,10}})));
  replaceable parameter ThermalIntegrationLib.FactoryBuilding.ProductionHall.BuildingEnvelope.Records.RoofProperties deviceData constrainedby ThermalIntegrationLib.FactoryBuilding.ProductionHall.BuildingEnvelope.Records.RoofProperties annotation (__Dymola_choicesAllMatching=true);
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor thermalConductor1(G=deviceData.G)
                                                                             annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heatCapacitor(C=deviceData.C) annotation (Placement(transformation(extent={{-10,0},{10,22}})));
equation
  connect(thermalConductor.port_b, Inside) annotation (Line(points={{60,0},{100,0}}, color={191,0,0}));
  connect(thermalConductor1.port_a, Outside) annotation (Line(points={{-60,0},{-100,0}}, color={191,0,0}));
  connect(thermalConductor1.port_b, heatCapacitor.port) annotation (Line(points={{-40,0},{0,0}}, color={191,0,0}));
  connect(heatCapacitor.port, thermalConductor.port_a) annotation (Line(points={{0,0},{40,0}}, color={191,0,0}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p align=\"justify\"><b><span style=\"font-size: 20pt;\">Description of the Wall Modeling Approach</span></b></p>
<p align=\"justify\"><span style=\"font-size: 14pt;\">In general wall structures comprise different layers, which can be represented as thermal resistors.</span></p>
<p align=\"justify\"><br><span style=\"font-size: 14pt;\">In the case of the ETA-Research Factory the walls oriented to the west and east consist of 4 layers:</span></p>
<ul>
<li align=\"justify\"><span style=\"font-size: 14pt;\">Inner concrete layer (load-bearing structure)</span></li>
<li align=\"justify\"><span style=\"font-size: 14pt;\">Concrete foam layer (insulation)</span></li>
<li align=\"justify\"><span style=\"font-size: 14pt;\">Air layer </span></li>
<li align=\"justify\"><span style=\"font-size: 14pt;\">Outer concrete layer (facade)</span></li>
</ul>
<p align=\"justify\"><br><span style=\"font-size: 14pt;\">The Air layer and the outer concrete layer is not modelled because the air layer is not isolated and therefore T_Air_layer = T_ambient.</span></p>
<p align=\"justify\"><br><span style=\"font-size: 14pt;\">The glas facade to the south and north consists of two types of glas with a 50&percnt; share each:</span></p>
<ul>
<li align=\"justify\"><span style=\"font-size: 14pt;\">2 layerd glas elements with fleece layer</span></li>
<li align=\"justify\"><span style=\"font-size: 14pt;\">2 layerd glas elements without fleece layer</span></li>
</ul>
<p align=\"justify\"><br><b><span style=\"font-size: 20pt;\">Description of the Thermal Resistance Parametrization</span></b></p>
<p align=\"justify\"><span style=\"font-size: 14pt;\">For the mentioned layers different literature and experimentally validated parametrization approaches exist. In the case of the ETA Research Factory intensive experiments were conducted to validate the thermal resistance parameters. If there is no experiment conducted literature values were used.</span></p>
<p align=\"justify\"><span style=\"font-size: 14pt;\">In the following table the used parameters are presented:</span></p>
<table cellspacing=\"0\" cellpadding=\"0\" border=\"1\"><tr>
<td valign=\"top\"><p><b><span style=\"font-size: 14pt;\">Layer </span></b></p></td>
<td valign=\"top\"><p><b><span style=\"font-size: 14pt;\">Heat Transition Coefficient in W/m^2*K </span></b></p></td>
<td valign=\"top\"><p><b><span style=\"font-size: 14pt;\">Source </span></b></p></td>
</tr>
<tr>
<td valign=\"top\"><p><span style=\"font-size: 14pt;\">Concrete wall </span></p></td>
<td valign=\"top\"><p><span style=\"font-size: 14pt;\">0.24 </span></p></td>
<td valign=\"top\"><p><span style=\"font-size: 14pt;\">[ETA19] </span></p></td>
</tr>
<tr>
<td valign=\"top\"><p><span style=\"font-size: 14pt;\">Glas with fleece </span></p></td>
<td valign=\"top\"><p><span style=\"font-size: 14pt;\">0.23 </span></p></td>
<td valign=\"top\"><p><span style=\"font-size: 14pt;\">[ETA19] </span></p></td>
</tr>
<tr>
<td valign=\"top\"><p><span style=\"font-size: 14pt;\">Glas without fleece </span></p></td>
<td valign=\"top\"><p><span style=\"font-size: 14pt;\">1.1 </span></p></td>
<td valign=\"top\"><p><span style=\"font-size: 14pt;\">[ETA19] </span></p></td>
</tr>
</table>
<p><br><br><br><br><b><span style=\"font-size: 20pt;\">Dimensions of the ETA-Research Factory Walls</span></b></p>
<p><span style=\"font-size: 14pt;\">The following table comprises the geometrical data of the ETA-Research Factory:</span></p>
<table cellspacing=\"0\" cellpadding=\"0\" border=\"1\"><tr>
<td valign=\"top\"><p><b><span style=\"font-size: 14pt;\">Dimension</span></b></p></td>
<td valign=\"top\"><p><b><span style=\"font-size: 14pt;\">Value </span></b></p></td>
</tr>
<tr>
<td valign=\"top\"><p><span style=\"font-size: 14pt;\">Length </span></p></td>
<td valign=\"top\"><p><span style=\"font-size: 14pt;\">40m </span></p></td>
</tr>
<tr>
<td valign=\"top\"><p><span style=\"font-size: 14pt;\">Width </span></p></td>
<td valign=\"top\"><p><span style=\"font-size: 14pt;\">20m </span></p></td>
</tr>
<tr>
<td valign=\"top\"><p><span style=\"font-size: 14pt;\">Height </span></p></td>
<td valign=\"top\"><p><span style=\"font-size: 14pt;\">11m </span></p></td>
</tr>
</table>
</html>"));
end Roof;
