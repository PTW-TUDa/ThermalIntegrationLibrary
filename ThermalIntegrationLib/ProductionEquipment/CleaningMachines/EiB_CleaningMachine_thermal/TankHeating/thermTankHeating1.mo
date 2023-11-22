within ThermalIntegrationLib.ProductionEquipment.CleaningMachines.EiB_CleaningMachine_thermal.TankHeating;
model thermTankHeating1
  extends
    ThermalIntegrationLib.ProductionEquipment.CleaningMachines.EiB_CleaningMachine_thermal.TechnicalConfiguration.TechnicalConfiguration_a;
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor MT(C=c_fluid*m_t1, T(fixed=true, start=T_req))
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-26,-50})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor temperatureSensor
    annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=180,
        origin={-46,-40})));
  Modelica.Thermal.HeatTransfer.Components.ThermalCollector thermalCollector(m=2)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={44,-22})));
  thermSwitch thermSwitch1 annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-2,-30})));
  Modelica.Blocks.Interfaces.IntegerInput state
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_batch
    annotation (Placement(transformation(extent={{-10,-110},{10,-90}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_hall
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_tank
    annotation (Placement(transformation(extent={{90,-70},{110,-50}})));
  washingController washingController1(wState1=5, wState2=7)
                                       annotation (Placement(transformation(
        extent={{-10,-8},{10,8}},
        rotation=90,
        origin={34,-66})));
  heatController heatController1(st1=5, st2=7)
                                 annotation (Placement(transformation(extent={{-80,30},{-60,50}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_heating annotation (Placement(transformation(extent={{-10,90},{10,110}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor thermalConductor(G=3.815533726) annotation (
     Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={74,0})));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor thermalConductor1(G=10) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,76})));
  thermOnOff thermOnOff1
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-26,40})));
equation
  connect(MT.port, temperatureSensor.port) annotation (Line(points={{-26,-40},{-40,-40}},color={191,0,0}));
  connect(thermSwitch1.port_in_2, thermalCollector.port_b)
    annotation (Line(points={{8.2,-22},{34,-22}},  color={191,0,0}));
  connect(port_batch, thermSwitch1.port_in_1)
    annotation (Line(points={{0,-100},{0,-80},{14,-80},{14,-38},{8,-38}},  color={191,0,0}));
  connect(thermSwitch1.port_out, MT.port)
    annotation (Line(points={{-12,-30},{-26,-30},{-26,-40}},                color={191,0,0}));
  connect(thermSwitch1.u, washingController1.out)
    annotation (Line(points={{9,-30},{34,-30},{34,-54}},  color={255,0,255}));
  connect(temperatureSensor.T, heatController1.temp) annotation (Line(points={{-52,-40},{-70,-40},{-70,
          29}},                                                                                              color={0,0,127}));
  connect(heatController1.state, state) annotation (Line(points={{-81,40},{-92,40},{-92,0},{-120,0}}, color={255,127,0}));
  connect(washingController1.state, state) annotation (Line(points={{34,-78},{34,-84},{-88,-84},{-88,0},
          {-120,0}},                                                                                               color={255,127,0}));
  connect(thermalConductor.port_a, port_hall)
    annotation (Line(points={{84,-1.72085e-15},{100,0}}, color={191,0,0}));
  connect(thermalCollector.port_a[2], port_tank)
    annotation (Line(points={{53.5,-22},{60,-22},{60,-60},{100,-60}}, color={191,0,0}));
  connect(thermalConductor.port_b, thermalCollector.port_a[1])
    annotation (Line(points={{64,7.21645e-16},{60,7.21645e-16},{60,-22},{54.5,-22}}, color={191,0,0}));
  connect(port_heating, thermalConductor1.port_a)
    annotation (Line(points={{0,100},{1.77636e-15,86}}, color={191,0,0}));
  connect(heatController1.heating, thermOnOff1.u) annotation (Line(points={{-59,40},{-38,40}}, color={255,0,255}));
  connect(thermOnOff1.port_out, MT.port) annotation (Line(points={{-26,30},{-26,-40}}, color={191,0,0}));
  connect(thermalConductor1.port_b, thermOnOff1.port_in) annotation (Line(points={{0,66},{0,58},{-26,58},{-26,50}}, color={191,0,0}));
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
