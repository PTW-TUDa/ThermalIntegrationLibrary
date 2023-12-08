within ThermalIntegrationLibrary.ProductionEquipment.MachineTools.TurningMachine.CoolingSystem;
model ColdWaterNetwork
  parameter Modelica.Units.SI.Mass m_coldWaterNetwork=20 "Total mass within cold water network";
  parameter Modelica.Units.SI.SpecificHeatCapacity cp_coldWaterNetwork=4185 "Specific heat capacity of cold water network";
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heatCapacitor(C=m_coldWaterNetwork*cp_coldWaterNetwork)
                                                                       annotation (Placement(transformation(extent={{-10,0},{10,20}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a consumption annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor temperatureSensor annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,50})));
  Modelica.Blocks.Interfaces.RealOutput T_coldWater annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,110})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a supply annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
equation
  connect(consumption, heatCapacitor.port) annotation (Line(points={{100,0},{0,0}}, color={191,0,0}));
  connect(temperatureSensor.port, heatCapacitor.port) annotation (Line(points={{-6.66134e-16,40},{-6.66134e-16,30},{-20,30},{-20,0},{0,0}},         color={191,0,0}));
  connect(temperatureSensor.T, T_coldWater) annotation (Line(points={{7.21645e-16,60},{0,110}}, color={0,0,127}));
  connect(heatCapacitor.port, supply) annotation (Line(points={{0,0},{-100,0}}, color={191,0,0}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          lineThickness=0.5),
        Line(
          points={{-60,60}},
          color={0,0,0},
          thickness=0.5),
        Rectangle(
          extent={{-60,60},{60,-60}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-10,70},{0,60}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{-10,50},{0,60}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{0,-60},{10,-50}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{0,-60},{10,-70}},
          color={0,0,0},
          thickness=0.5)}),                                      Diagram(coordinateSystem(preserveAspectRatio=false)));
end ColdWaterNetwork;
