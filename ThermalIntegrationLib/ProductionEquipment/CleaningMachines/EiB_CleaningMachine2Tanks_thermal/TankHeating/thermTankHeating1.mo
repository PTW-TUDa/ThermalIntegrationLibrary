within ThermalIntegrationLib.ProductionEquipment.CleaningMachines.EiB_CleaningMachine2Tanks_thermal.TankHeating;
model thermTankHeating1
  parameter Modelica.Units.SI.Mass m_t1 "Mass of cleaning fluid tank 1";
  parameter Modelica.Units.SI.Area A_t1 "Surface area of tank 1";
  parameter Modelica.Units.SI.SpecificHeatCapacity c_fluid "Heat capacity of cleaning fluid";
  parameter Modelica.Units.SI.Length d_ins "Thickness insulation (for no insulation set to 0)";
  parameter Modelica.Units.SI.ThermalConductivity lambda_ins "Thermal conductivity insulation";
  parameter Modelica.Units.SI.Temperature T_req "Working temperature of cleaning fluid";
  parameter Modelica.Units.SI.Temperature T_lim "Minimum temperature of cleaning fluid";
  parameter Integer tableWashing[:,1] "States when washing is active";
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor MT(C=c_fluid*m_t1, T(fixed=true, start=298.15))
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-26,-50})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor temperatureSensor
    annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=180,
        origin={-46,-40})));
  Modelica.Blocks.Interfaces.IntegerInput state
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_batch
    annotation (Placement(transformation(extent={{-10,-110},{10,-90}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_hall
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_tank
    annotation (Placement(transformation(extent={{90,-70},{110,-50}})));
  TankHeating.washingController washingController1(washingTable=tableWashing)
    annotation (Placement(transformation(
        extent={{-10,-8},{10,8}},
        rotation=90,
        origin={50,-50})));
  TankHeating.heatController heatController1(
    T_req=T_req,
    T_lim=T_lim,
    washingTable=tableWashing)                             annotation (Placement(transformation(extent={{-80,30},{-60,50}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_heating annotation (Placement(transformation(extent={{-10,90},{10,110}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor thermalConductor_hall(G=A_t1/(1/350 + 0.002/20 + d_ins/lambda_ins + 1/8))
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={74,0})));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor thermalConductor_heating(G=2111.15)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,76})));
  TankHeating.thermOnOff thermOnOff1
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-26,40})));
  Modelica.Blocks.Interfaces.RealOutput T
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-110,60})));
  TankHeating.thermSwitch_multi thermSwitch_multi1
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={10,-20})));
equation
  connect(MT.port, temperatureSensor.port) annotation (Line(points={{-26,-40},{-40,-40}},color={191,0,0}));
  connect(temperatureSensor.T, heatController1.temp) annotation (Line(points={{-52,-40},{-70,-40},{-70,29}}, color={0,0,127}));
  connect(heatController1.state, state) annotation (Line(points={{-81,40},{-92,40},{-92,0},{-120,0}}, color={255,127,0}));
  connect(washingController1.state, state) annotation (Line(points={{50,-62},{50,-68},{-92,-68},{-92,0},{-120,0}}, color={255,127,0}));
  connect(thermalConductor_hall.port_a, port_hall) annotation (Line(points={{84,-1.72085e-15},{100,0}}, color={191,0,0}));
  connect(port_heating, thermalConductor_heating.port_a) annotation (Line(points={{0,100},{1.77636e-15,86}}, color={191,0,0}));
  connect(thermOnOff1.port_out, MT.port) annotation (Line(points={{-26,30},{-26,-40}}, color={191,0,0}));
  connect(temperatureSensor.T, T)
    annotation (Line(points={{-52,-40},{-70,-40},{-70,22},{-96,22},{-96,60},{-110,60}}, color={0,0,127}));
  connect(MT.port, thermSwitch_multi1.port_out) annotation (Line(points={{-26,-40},{-14,-40},{-14,-20},{0,-20}}, color={191,0,0}));
  connect(thermSwitch_multi1.port_in_1, port_batch)
    annotation (Line(points={{20,-28},{24,-28},{24,-80},{0,-80},{0,-100}}, color={191,0,0}));
  connect(washingController1.out, thermSwitch_multi1.u) annotation (Line(points={{50,-38},{50,-20},{21,-20}}, color={255,0,255}));
  connect(thermSwitch_multi1.port_in_2[1], thermalConductor_hall.port_b)
    annotation (Line(points={{20.2,-12},{58,-12},{58,7.21645e-16},{64,7.21645e-16}}, color={191,0,0}));
  connect(thermSwitch_multi1.port_in_2[2], port_tank)
    annotation (Line(points={{20.2,-12},{86,-12},{86,-60},{100,-60}}, color={191,0,0}));
  connect(thermalConductor_heating.port_b, thermOnOff1.port_in)
    annotation (Line(points={{-1.77636e-15,66},{-1.77636e-15,56},{-26,56},{-26,50}}, color={191,0,0}));
  connect(thermOnOff1.u, heatController1.heating) annotation (Line(points={{-38,40},{-59,40}}, color={255,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          lineThickness=0.5),
        Text(
          extent={{-40,94},{40,54}},
          lineColor={0,0,0},
          textString="T1"),
        Ellipse(
          extent={{-70,60},{72,-80}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.None,
          lineThickness=0.5),
        Line(
          points={{60,34},{-40,34},{24,-10},{-40,-54},{60,-54}},
          color={0,0,0},
          thickness=0.5)}),                                      Diagram(coordinateSystem(preserveAspectRatio=false)));
end thermTankHeating1;
