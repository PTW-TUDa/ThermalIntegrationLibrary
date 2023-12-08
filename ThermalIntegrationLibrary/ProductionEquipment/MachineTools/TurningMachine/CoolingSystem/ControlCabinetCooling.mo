within ThermalIntegrationLibrary.ProductionEquipment.MachineTools.TurningMachine.CoolingSystem;
model ControlCabinetCooling
  parameter Boolean IsUsed "True if used. False if unused";
  parameter Modelica.Units.SI.ThermodynamicTemperature T_flow=288.15;
  parameter Modelica.Units.SI.Power P_el_nom_vent "Nominal electric power of the vent";
  parameter Modelica.Units.SI.MassFlowRate m_flow_nom_vent "Nominal mass flow rate of the vent";
  parameter Modelica.Units.SI.SpecificHeatCapacity cp_air=1000 "Specific heat capacity of air";
  Modelica.Units.SI.Power P_th_cool "Cooling power of control cabinet cooling";
  Modelica.Units.SI.MassFlowRate m_flow_vent "Mass flow of the vent";

  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a hall annotation (Placement(transformation(extent={{-10,90},{10,110}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a controlCabinet annotation (Placement(transformation(extent={{-10,-110},{10,-90}}), iconTransformation(extent={{-10,-110},{10,-90}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow1
                                                                              annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,50})));
  Modelica.Blocks.Sources.RealExpression realExpression1(y=P_th_cool + P_el)
                                                        annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-20,30})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor T_hall annotation (Placement(transformation(extent={{20,70},{40,90}})));
  Modelica.Thermal.HeatTransfer.Sensors.HeatFlowSensor heatFlowSensor annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,-70})));
  Modelica.Blocks.Logical.Switch switch2 annotation (Placement(transformation(extent={{40,-50},{20,-30}})));
  Modelica.Blocks.Sources.BooleanExpression booleanExpression(y=IsUsed)           annotation (Placement(transformation(extent={{90,-50},{70,-30}})));
  Modelica.Blocks.Sources.Constant const(k=1e3)
                                         annotation (Placement(transformation(extent={{90,-30},{70,-10}})));
  Modelica.Blocks.Interfaces.RealOutput P_el annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature prescribedTemperature annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,0})));
  Modelica.Thermal.HeatTransfer.Components.Convection convection annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=270,
        origin={0,-40})));
  Modelica.Blocks.Sources.Constant const1(k=0)
                                         annotation (Placement(transformation(extent={{90,-70},{70,-50}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor T_controlCabinet annotation (Placement(transformation(extent={{20,-90},{40,-70}})));
equation
  // Calculate air flow of vent in passive cooling type
  m_flow_vent = P_th_cool / (cp_air * (max(0.1, T_controlCabinet.T - T_hall.T)));

  // Calculate thermal cooling power
  P_th_cool = heatFlowSensor.Q_flow;

  // Calculate electric power demand depending on cooling type
  P_el = if IsUsed then 0 else min(P_el_nom_vent, P_el_nom_vent * (m_flow_vent/m_flow_nom_vent)^3);
  connect(realExpression1.y,prescribedHeatFlow1. Q_flow) annotation (Line(points={{-9,30},{0,30},{0,40}},
                                                                                                      color={0,0,127}));
  connect(hall, prescribedHeatFlow1.port) annotation (Line(points={{0,100},{0,64},{4.44089e-16,64},{4.44089e-16,60}},
                                                                                              color={191,0,0}));
  connect(heatFlowSensor.port_a, controlCabinet) annotation (Line(points={{-5.55112e-16,-80},{0,-100}}, color={191,0,0}));
  connect(const.y, switch2.u1) annotation (Line(points={{69,-20},{60,-20},{60,-32},{42,-32}},
                                                                                        color={0,0,127}));
  connect(T_hall.port, hall) annotation (Line(points={{20,80},{0,80},{0,100}}, color={191,0,0}));
  connect(T_hall.T, prescribedTemperature.T) annotation (Line(points={{40,80},{60,80},{60,20},{2.22045e-15,20},{2.22045e-15,12}}, color={0,0,127}));
  connect(convection.solid, heatFlowSensor.port_b) annotation (Line(points={{-1.83187e-15,-50},{5.55112e-16,-60}}, color={191,0,0}));
  connect(convection.fluid, prescribedTemperature.port) annotation (Line(points={{1.83187e-15,-30},{-1.77636e-15,-10}}, color={191,0,0}));
  connect(const1.y, switch2.u3) annotation (Line(points={{69,-60},{60,-60},{60,-48},{42,-48}}, color={0,0,127}));
  connect(booleanExpression.y, switch2.u2) annotation (Line(points={{69,-40},{42,-40}}, color={255,0,255}));
  connect(convection.Gc, switch2.y) annotation (Line(points={{10,-40},{19,-40}}, color={0,0,127}));
  connect(T_controlCabinet.port, heatFlowSensor.port_a) annotation (Line(points={{20,-80},{20,-100},{-8.88178e-16,-100},{-8.88178e-16,-80}}, color={191,0,0}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          lineThickness=0.5),
        Rectangle(
          extent={{-70,40},{50,-40}},
          lineColor={0,0,0},
          lineThickness=0.5),
        Line(
          points={{-70,40},{-50,60},{70,60},{70,-20},{50,-40},{50,40},{70,60}},
          color={0,0,0},
          thickness=0.5),
        Rectangle(
          extent={{-60,20},{40,-20}},
          lineColor={0,0,0},
          lineThickness=0.5),
        Line(
          points={{-60,12},{40,12}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{-60,4},{40,4}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{-60,-12},{40,-12}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{-60,-4},{40,-4}},
          color={0,0,0},
          thickness=0.5)}),                                      Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>Passive cooling module for the control cabinet.</p>
</html>"));
end ControlCabinetCooling;
