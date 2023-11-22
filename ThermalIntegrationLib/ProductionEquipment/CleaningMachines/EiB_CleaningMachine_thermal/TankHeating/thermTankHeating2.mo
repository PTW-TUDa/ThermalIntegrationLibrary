within ThermalIntegrationLib.ProductionEquipment.CleaningMachines.EiB_CleaningMachine_thermal.TankHeating;
model thermTankHeating2
   extends
    ThermalIntegrationLib.ProductionEquipment.CleaningMachines.EiB_CleaningMachine_thermal.TechnicalConfiguration.TechnicalConfiguration_a;
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor MT(C=m_t2*c_fluid, T(fixed=true, start=T_req))
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-24,-50})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor temperatureSensor
    annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=180,
        origin={-46,-40})));
  Modelica.Thermal.HeatTransfer.Components.ThermalCollector thermalCollector(m=2)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={46,-22})));
  thermSwitch thermSwitch1 annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={0,-30})));
  Modelica.Blocks.Interfaces.IntegerInput state
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_batch
    annotation (Placement(transformation(extent={{-10,-110},{10,-90}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_hall
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_tank
    annotation (Placement(transformation(extent={{90,-70},{110,-50}})));
  washingController washingController1(wState1=8, wState2=10)
                                       annotation (Placement(transformation(
        extent={{-10,-8},{10,8}},
        rotation=90,
        origin={36,-64})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_heating annotation (Placement(transformation(extent={{-10,90},{10,110}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor thermalConductor(G=2.671538276) annotation (
     Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={76,0})));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor thermalConductor1(G=10) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,78})));
  thermOnOff thermOnOff1
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-24,40})));
  heatController heatController1(st1=8, st2=10) annotation (Placement(transformation(extent={{-80,30},{-60,50}})));
equation
  connect(MT.port, temperatureSensor.port) annotation (Line(points={{-24,-40},{-40,-40}},color={191,0,0}));
  connect(thermSwitch1.port_in_2, thermalCollector.port_b)
    annotation (Line(points={{10.2,-22},{36,-22}}, color={191,0,0}));
  connect(port_batch, thermSwitch1.port_in_1)
    annotation (Line(points={{0,-100},{0,-60},{20,-60},{20,-38},{10,-38}}, color={191,0,0}));
  connect(thermSwitch1.port_out, MT.port)
    annotation (Line(points={{-10,-30},{-24,-30},{-24,-40}},                color={191,0,0}));
  connect(thermSwitch1.u, washingController1.out)
    annotation (Line(points={{11,-30},{36,-30},{36,-52}}, color={255,0,255}));
  connect(thermalConductor.port_a, port_hall)
    annotation (Line(points={{86,-1.72085e-15},{100,0}}, color={191,0,0}));
  connect(thermalCollector.port_a[2], port_tank)
    annotation (Line(points={{55.5,-22},{60,-22},{60,-60},{100,-60}}, color={191,0,0}));
  connect(thermalConductor.port_b, thermalCollector.port_a[1])
    annotation (Line(points={{66,7.21645e-16},{60,7.21645e-16},{60,-22},{56.5,-22}}, color={191,0,0}));
  connect(port_heating, thermalConductor1.port_a)
    annotation (Line(points={{0,100},{1.77636e-15,88}}, color={191,0,0}));
  connect(thermOnOff1.port_out, MT.port) annotation (Line(points={{-24,30},{-24,-40}}, color={191,0,0}));
  connect(thermalConductor1.port_b, thermOnOff1.port_in) annotation (Line(points={{0,68},{0,60},{-24,60},{-24,50}}, color={191,0,0}));
  connect(thermOnOff1.u, heatController1.heating) annotation (Line(points={{-36,40},{-59,40}}, color={255,0,255}));
  connect(heatController1.state, state) annotation (Line(points={{-81,40},{-94,40},{-94,0},{-120,0}}, color={255,127,0}));
  connect(temperatureSensor.T, heatController1.temp) annotation (Line(points={{-52,-40},{-70,-40},{-70,29}}, color={0,0,127}));
  connect(washingController1.state, state) annotation (Line(points={{36,-76},{36,-80},{-92,-80},{-92,0},{-120,0}}, color={255,127,0}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          lineThickness=0.5),
        Text(
          extent={{-40,94},{40,54}},
          lineColor={0,0,0},
          textString="T2"),
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
end thermTankHeating2;
