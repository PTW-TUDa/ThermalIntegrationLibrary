within ThermalIntegrationLib.ProductionEquipment.MachineTools.TurningMachine.ControlCabinet;
model ControlCabinet
  parameter Modelica.SIunits.Mass m_controlCabinet "Mass of control cabinet";
  parameter Modelica.SIunits.SpecificHeatCapacity cp_controlCabinet "Specific heat capacity of control cabinet";
  parameter Real eta_controlCabinet "Efficiency of control cabinet";
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heatCapacitor(C=cp_controlCabinet*m_controlCabinet)
                                                                       annotation (Placement(transformation(extent={{-10,60},{10,80}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow annotation (Placement(transformation(extent={{-30,30},{-10,50}})));
  Modelica.Blocks.Math.Gain gain(k=1 - eta_controlCabinet) annotation (Placement(transformation(extent={{-72,30},{-52,50}})));
  Modelica.Blocks.Math.Gain gain1(k=eta_controlCabinet)     annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  Modelica.Blocks.Interfaces.RealInput u annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealOutput P_el annotation (Placement(transformation(extent={{100,-60},{120,-40}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a controlCabinetCooling annotation (Placement(transformation(extent={{-60,90},{-40,110}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalResistor thermalResistor(R=1e-5) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-50,80})));
  Modelica.Blocks.Interfaces.RealOutput T_controlCabinet annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={110,50})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor temperatureSensor annotation (Placement(transformation(extent={{60,40},{80,60}})));
equation
  connect(prescribedHeatFlow.port, heatCapacitor.port) annotation (Line(points={{-10,40},{0,40},{0,60}}, color={191,0,0}));
  connect(gain.y, prescribedHeatFlow.Q_flow) annotation (Line(points={{-51,40},{-30,40}}, color={0,0,127}));
  connect(u, gain1.u) annotation (Line(points={{-120,0},{-62,0}}, color={0,0,127}));
  connect(u, gain.u) annotation (Line(points={{-120,0},{-80,0},{-80,40},{-74,40}}, color={0,0,127}));
  connect(gain1.y, P_el) annotation (Line(points={{-39,0},{96,0},{96,-50},{110,-50}},
                                                                    color={0,0,127}));
  connect(controlCabinetCooling, thermalResistor.port_b) annotation (Line(points={{-50,100},{-50,90}}, color={191,0,0}));
  connect(thermalResistor.port_a, heatCapacitor.port) annotation (Line(points={{-50,70},{-50,60},{0,60}}, color={191,0,0}));
  connect(temperatureSensor.T, T_controlCabinet) annotation (Line(points={{80,50},{110,50}}, color={0,0,127}));
  connect(temperatureSensor.port, heatCapacitor.port) annotation (Line(points={{60,50},{0,50},{0,60}}, color={191,0,0}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          lineThickness=0.5),
        Rectangle(
          extent={{-40,60},{40,-60}},
          lineColor={0,0,0},
          lineThickness=0.5),
        Line(
          points={{0,60},{0,-60}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{-10,10},{-10,-10}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{10,10},{10,-10}},
          color={0,0,0},
          thickness=0.5)}),                                      Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>Generic control cabinet of the machine tool. The physical behavior is characterized by it&apos;s efficiency and therefore thermal losses.</p>
</html>"));
end ControlCabinet;
