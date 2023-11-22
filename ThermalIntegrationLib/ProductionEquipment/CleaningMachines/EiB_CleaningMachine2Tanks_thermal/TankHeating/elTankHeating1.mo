within ThermalIntegrationLib.ProductionEquipment.CleaningMachines.EiB_CleaningMachine2Tanks_thermal.TankHeating;
model elTankHeating1
  extends
    ThermalIntegrationLib.ProductionEquipment.CleaningMachines.EiB_CleaningMachine2Tanks_thermal_Mafac.TechnicalConfiguration.TechnicalConfiguration_a;
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
  Modelica.Blocks.Interfaces.IntegerInput state
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_batch
    annotation (Placement(transformation(extent={{-10,-110},{10,-90}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_hall
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_tank
    annotation (Placement(transformation(extent={{90,-70},{110,-50}})));
  TankHeating.washingController washingController1(wState1=5, wState2=7)
    annotation (Placement(transformation(
        extent={{-10,-8},{10,8}},
        rotation=90,
        origin={34,-66})));
  TankHeating.heatController heatController1(st1=5, st2=7) annotation (Placement(transformation(extent={{-80,60},{-60,80}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor thermalConductor_hall(G=A_t1/(1/350 + 0.002/20 + d_ins/lambda_ins + 1/8))
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={74,0})));
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
  Modelica.Electrical.Analog.Basic.Ground ground
                              annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={58,84})));
  Modelica.Electrical.Analog.Sources.ConstantVoltage constantVoltage(V=230)
                                                        annotation (Placement(
        transformation(
        origin={30,42},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  Modelica.Electrical.Analog.Basic.HeatingResistor heatingResistor(
    R_ref=10,
    T_ref=293.15,
    alpha=1/255) annotation (Placement(transformation(
        origin={-16,42},
        extent={{-10,10},{10,-10}},
        rotation=90)));
  Modelica.Electrical.Analog.Ideal.IdealOpeningSwitch idealSwitch
        annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-16,70})));
  Modelica.Blocks.Logical.Not not1 annotation (Placement(transformation(extent={{-48,66},{-40,74}})));
equation
  connect(MT.port, temperatureSensor.port) annotation (Line(points={{-26,-40},{-40,-40}},color={191,0,0}));
  connect(temperatureSensor.T, heatController1.temp) annotation (Line(points={{-52,-40},{-70,-40},{-70,59}}, color={0,0,127}));
  connect(heatController1.state, state) annotation (Line(points={{-81,70},{-88,70},{-88,0},{-120,0}}, color={255,127,0}));
  connect(washingController1.state, state) annotation (Line(points={{34,-78},{34,-84},{-88,-84},{-88,0},
          {-120,0}},                                                                                               color={255,127,0}));
  connect(thermalConductor_hall.port_a, port_hall) annotation (Line(points={{84,-1.72085e-15},{100,0}}, color={191,0,0}));
  connect(temperatureSensor.T, T)
    annotation (Line(points={{-52,-40},{-70,-40},{-70,22},{-96,22},{-96,60},{-110,60}}, color={0,0,127}));
  connect(MT.port, thermSwitch_multi1.port_out) annotation (Line(points={{-26,-40},{-14,-40},{-14,-20},{0,-20}}, color={191,0,0}));
  connect(thermSwitch_multi1.port_in_1, port_batch)
    annotation (Line(points={{20,-28},{48,-28},{48,-86},{0,-86},{0,-100}}, color={191,0,0}));
  connect(washingController1.out, thermSwitch_multi1.u) annotation (Line(points={{34,-54},{34,-20},{21,-20}}, color={255,0,255}));
  connect(thermSwitch_multi1.port_in_2[1], thermalConductor_hall.port_b)
    annotation (Line(points={{20.2,-12},{58,-12},{58,7.21645e-16},{64,7.21645e-16}}, color={191,0,0}));
  connect(thermSwitch_multi1.port_in_2[2], port_tank)
    annotation (Line(points={{20.2,-12},{86,-12},{86,-60},{100,-60}}, color={191,0,0}));
  connect(idealSwitch.p, heatingResistor.n) annotation (Line(points={{-16,60},{-16,52}}, color={0,0,255}));
  connect(idealSwitch.n, constantVoltage.n) annotation (Line(points={{-16,80},{-16,84},{30,84},{30,52}}, color={0,0,255}));
  connect(heatingResistor.p, constantVoltage.p) annotation (Line(points={{-16,32},{-16,26},{30,26},{30,32}}, color={0,0,255}));
  connect(constantVoltage.n, ground.p) annotation (Line(points={{30,52},{30,84},{48,84}}, color={0,0,255}));
  connect(MT.port, heatingResistor.heatPort) annotation (Line(points={{-26,-40},{-26,42}}, color={191,0,0}));
  connect(heatController1.heating, not1.u) annotation (Line(points={{-59,70},{-48.8,70}}, color={255,0,255}));
  connect(not1.y, idealSwitch.control) annotation (Line(points={{-39.6,70},{-28,70}}, color={255,0,255}));
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
end elTankHeating1;
