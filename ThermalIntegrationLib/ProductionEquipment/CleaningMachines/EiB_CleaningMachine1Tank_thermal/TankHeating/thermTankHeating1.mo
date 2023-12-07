within ThermalIntegrationLib.ProductionEquipment.CleaningMachines.EiB_CleaningMachine1Tank_thermal.TankHeating;
model thermTankHeating1
  parameter Modelica.Units.SI.Mass m_t1 "Mass of cleaning fluid tank 1";
  parameter Modelica.Units.SI.Area A_t1 "Surface area of tank 1";
  parameter Modelica.Units.SI.SpecificHeatCapacity c_fluid "Heat capacity of cleaning fluid";
  parameter Modelica.Units.SI.Length d_ins "Thickness insulation";
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
  washingController washingController1(washingTable=tableWashing)
                                       annotation (Placement(transformation(
        extent={{-10,-8},{10,8}},
        rotation=90,
        origin={34,-66})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_heating annotation (Placement(transformation(extent={{-10,90},{10,110}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor thermalConductor(G=A_t1/(1/350 + 0.002/20 + d_ins/lambda_ins + 1/8))
                                                                                            annotation (
     Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={62,0})));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor thermalConductor1(G=211.115)
                                                                                    annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,76})));
  thermOnOff thermOnOff1
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-26,30})));
  Modelica.Blocks.Interfaces.RealOutput T
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-110,60})));
  thermSwitch thermSwitch1 annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={10,-20})));
  heatController heatController1(
    T_req=T_req,
    T_lim=T_lim,
    washingTable=tableWashing) annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
equation
  connect(MT.port, temperatureSensor.port) annotation (Line(points={{-26,-40},{-40,-40}},color={191,0,0}));
  connect(washingController1.state, state) annotation (Line(points={{34,-78},{34,-84},{-88,-84},{-88,0},
          {-120,0}},                                                                                               color={255,127,0}));
  connect(thermalConductor.port_a, port_hall)
    annotation (Line(points={{72,-1.72085e-15},{100,0}}, color={191,0,0}));
  connect(port_heating, thermalConductor1.port_a)
    annotation (Line(points={{0,100},{1.77636e-15,86}}, color={191,0,0}));
  connect(thermOnOff1.port_out, MT.port) annotation (Line(points={{-26,20},{-26,-40}}, color={191,0,0}));
  connect(thermalConductor1.port_b, thermOnOff1.port_in) annotation (Line(points={{0,66},{0,58},{
          -26,58},{-26,40}},                                                                                        color={191,0,0}));
  connect(MT.port, thermSwitch1.port_out)
    annotation (Line(points={{-26,-40},{-14,-40},{-14,-20},{0,-20}}, color={191,0,0}));
  connect(thermalConductor.port_b, thermSwitch1.port_in_2) annotation (Line(points={{52,7.21645e-16},{26,7.21645e-16},{26,-12},{20.2,
          -12}},                                 color={191,0,0}));
  connect(thermSwitch1.port_in_1, port_batch)
    annotation (Line(points={{20,-28},{48,-28},{48,-86},{0,-86},{0,-100}}, color={191,0,0}));
  connect(thermSwitch1.u, washingController1.out)
    annotation (Line(points={{21,-20},{30,-20},{30,-48},{34,-48},{34,-54}}, color={255,0,255}));
  connect(thermOnOff1.u, heatController1.heating) annotation (Line(points={{-38,30},{-59,30}}, color={255,0,255}));
  connect(heatController1.state, state) annotation (Line(points={{-81,30},{-88,30},{-88,0},{-120,0}}, color={255,127,0}));
  connect(temperatureSensor.T, heatController1.temp) annotation (Line(points={{-52,-40},{-70,-40},{-70,19}}, color={0,0,127}));
  connect(temperatureSensor.T, T) annotation (Line(points={{-52,-40},{-70,-40},{-70,12},{-94,12},{-94,60},{-110,60}}, color={0,0,127}));
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
