within ThermalIntegrationLibrary.FactoryBuilding.ProductionHall.BuildingEnvelope;
model Roof
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a Outside annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a Inside annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor thermalConductor(G=deviceData.G)
                                                                             annotation (Placement(transformation(extent={{40,-10},{60,10}})));
  replaceable parameter ThermalIntegrationLibrary.FactoryBuilding.ProductionHall.BuildingEnvelope.Records.RoofProperties deviceData constrainedby ThermalIntegrationLibrary.FactoryBuilding.ProductionHall.BuildingEnvelope.Records.RoofProperties annotation (__Dymola_choicesAllMatching=true);
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
</html>"));
end Roof;
