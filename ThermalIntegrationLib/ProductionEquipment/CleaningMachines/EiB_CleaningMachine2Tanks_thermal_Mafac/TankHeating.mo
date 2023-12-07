within ThermalIntegrationLib.ProductionEquipment.CleaningMachines.EiB_CleaningMachine2Tanks_thermal_Mafac;
package TankHeating

  model heatController
    extends ThermalIntegrationLib.ProductionEquipment.CleaningMachines.EiB_CleaningMachine2Tanks_thermal_Mafac.TechnicalConfiguration.TechnicalConfiguration_a;
      parameter Integer st1, st2;
    Modelica.Blocks.Interfaces.IntegerInput state
      annotation (Placement(transformation(extent={{-120,-10},{-100,10}}), iconTransformation(extent={{-120,-10},{-100,10}})));
    Modelica.Blocks.Interfaces.BooleanOutput heating annotation (Placement(transformation(extent={{-10,-10},{10,10}},
          rotation=0,
          origin={110,0})));
  public
    Modelica.Blocks.Interfaces.RealInput temp annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={0,-110}), iconTransformation(extent={{-10,-10},{10,10}},
          rotation=90,
          origin={0,-110})));
  initial equation
    pre(heating) = false;
  equation
    if state < st1 or state > st2 then
      heating = temp <= T_lim or pre(heating) and temp < T_req; // state tank heating on/off
    else
      heating = false;
    end if;
    annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={Rectangle(
            extent={{-100,100},{100,-100}},
            lineColor={0,0,0},
            lineThickness=0.5), Text(
            extent={{-80,100},{80,-100}},
            lineColor={0,0,0},
            textString="heating
controller")}),                                                    Diagram(coordinateSystem(preserveAspectRatio=false)));
  end heatController;

  model washingController
    parameter Integer wState1 = 5,
                      wState2 = 7;
    Modelica.Blocks.Interfaces.IntegerInput state
      annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
    Modelica.Blocks.Interfaces.BooleanOutput out annotation (Placement(transformation(extent={{100,-20},{140,
              20}}), iconTransformation(extent={{100,-20},{140,20}})));
  equation
    if state >= wState1 and state <= wState2 then
      out = true; // washing on
    else
      out = false; // washing off
    end if;
    annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={Rectangle(
            extent={{-100,100},{100,-100}},
            lineColor={0,0,0},
            lineThickness=0.5), Text(
            extent={{-80,100},{80,-100}},
            lineColor={0,0,0},
            textString="washing
controller")}),             Diagram(coordinateSystem(preserveAspectRatio=false)));
  end washingController;

  model thermOnOff
    Modelica.Units.SI.HeatFlowRate Q_flow;
    Modelica.Units.SI.TemperatureDifference dT;
    Real k;
    Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_in annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
    Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b port_out annotation (Placement(transformation(extent={{90,-10},{110,10}})));
    Modelica.Blocks.Interfaces.BooleanInput u annotation (Placement(transformation(extent={{-20,-20},{20,20}},
          rotation=90,
          origin={0,-120})));
  equation
     if u then
       k = 999999999;
     else
       k = 0.0000001;
     end if;
    dT = port_in.T - port_out.T;
    port_in.Q_flow = Q_flow;
    port_out.Q_flow = -Q_flow;
    Q_flow = k*dT;
    annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
                                           Rectangle(
            extent={{-100,100},{100,-100}},
            fillColor={210,210,210},
            fillPattern=FillPattern.Solid,
            borderPattern=BorderPattern.Raised),
          Line(points={{-90,0},{-40,0}}, color={238,46,47}),
          Line(points={{40,0},{90,0}}, color={238,46,47}),
          Ellipse(
            extent={{24,8},{40,-8}},
            lineColor={238,46,47},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Line(points={{24,-42},{-28,-4}}, color={238,46,47}),
          Line(points={{0,-100},{0,-24}}, color={217,67,180}),
          Ellipse(
            extent={{-40,8},{-24,-8}},
            lineColor={238,46,47},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Text(
            extent={{-80,100},{80,40}},
            lineColor={0,0,0},
            textString="%name")}),                                 Diagram(coordinateSystem(preserveAspectRatio=false)));
  end thermOnOff;

  model thermTankHeating2
    parameter Modelica.Units.SI.Mass m_t2 "Mass of cleaning fluid tank 2";
    parameter Modelica.Units.SI.Area A_t2 "Surface area of tank 2";
    parameter Modelica.Units.SI.SpecificHeatCapacity c_fluid "Heat capacity of cleaning fluid";
    parameter Modelica.Units.SI.Length d_ins "Thickness insulation (for no insulation set to 0)";
    parameter Modelica.Units.SI.ThermalConductivity lambda_ins "Thermal conductivity insulation";
    Modelica.Thermal.HeatTransfer.Components.HeatCapacitor MT(C=m_t2*c_fluid, T(fixed=true, start=298.15))
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=180,
          origin={-24,-50})));
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
    washingController washingController1(wState1=8, wState2=10)
                                         annotation (Placement(transformation(
          extent={{-10,-8},{10,8}},
          rotation=90,
          origin={36,-64})));
    Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_heating annotation (Placement(transformation(extent={{-10,90},{10,110}})));
    Modelica.Thermal.HeatTransfer.Components.ThermalConductor thermalConductor_hall(G=A_t2/(1/350 + 2*0.002/20 + d_ins/lambda_ins + 1/8))
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=180,
          origin={76,0})));
    Modelica.Thermal.HeatTransfer.Components.ThermalConductor thermalConductor_heating(G=1225.22)
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={0,76})));
    thermOnOff thermOnOff1
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-24,40})));
    heatController heatController1(st1=8, st2=10) annotation (Placement(transformation(extent={{-80,30},{-60,50}})));
    Modelica.Blocks.Interfaces.RealOutput T
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=180,
          origin={-110,60})));
    thermSwitch_multi thermSwitch_multi1
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=180,
          origin={10,-20})));
  equation
    connect(MT.port, temperatureSensor.port) annotation (Line(points={{-24,-40},{-40,-40}},color={191,0,0}));
    connect(thermalConductor_hall.port_a, port_hall) annotation (Line(points={{86,-1.72085e-15},{100,0}}, color={191,0,0}));
    connect(port_heating, thermalConductor_heating.port_a) annotation (Line(points={{0,100},{1.77636e-15,86}}, color={191,0,0}));
    connect(thermOnOff1.port_out, MT.port) annotation (Line(points={{-24,30},{-24,-40}}, color={191,0,0}));
    connect(thermOnOff1.u, heatController1.heating) annotation (Line(points={{-36,40},{-59,40}}, color={255,0,255}));
    connect(heatController1.state, state) annotation (Line(points={{-81,40},{-94,40},{-94,0},{-120,0}}, color={255,127,0}));
    connect(temperatureSensor.T, heatController1.temp) annotation (Line(points={{-52,-40},{-70,-40},{-70,29}}, color={0,0,127}));
    connect(washingController1.state, state) annotation (Line(points={{36,-76},{36,-80},{-92,-80},{-92,0},{-120,0}}, color={255,127,0}));
    connect(temperatureSensor.T, T)
      annotation (Line(points={{-52,-40},{-70,-40},{-70,22},{-96,22},{-96,60},{-110,60}}, color={0,0,127}));
    connect(MT.port, thermSwitch_multi1.port_out) annotation (Line(points={{-24,-40},{-12,-40},{-12,-20},{0,-20}}, color={191,0,0}));
    connect(thermSwitch_multi1.u, washingController1.out) annotation (Line(points={{21,-20},{36,-20},{36,-52}}, color={255,0,255}));
    connect(thermSwitch_multi1.port_in_1, port_batch)
      annotation (Line(points={{20,-28},{24,-28},{24,-86},{0,-86},{0,-100}}, color={191,0,0}));
    connect(thermSwitch_multi1.port_in_2[1], thermalConductor_hall.port_b)
      annotation (Line(points={{20.2,-12},{60,-12},{60,7.21645e-16},{66,7.21645e-16}}, color={191,0,0}));
    connect(port_tank, thermSwitch_multi1.port_in_2[2])
      annotation (Line(points={{100,-60},{54,-60},{54,-12},{20.2,-12}}, color={191,0,0}));
    connect(thermOnOff1.port_in, thermalConductor_heating.port_b)
      annotation (Line(points={{-24,50},{-24,60},{-1.77636e-15,60},{-1.77636e-15,66}}, color={191,0,0}));
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

  model thermSwitch_multi
    parameter Integer n(min=1)=2 "Number of collected heat flows port 2";
    Modelica.Units.SI.HeatFlowRate Q_flow[n];
    Modelica.Units.SI.TemperatureDifference dT[n];
    Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_in_1 annotation (Placement(transformation(extent={{-110,70},{-90,90}}),
          iconTransformation(extent={{-110,70},{-90,90}})));
    Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_in_2[n]
      annotation (Placement(transformation(extent={{-112,-90},{-92,-70}}), iconTransformation(extent={{-112,-90},{-92,-70}})));
    Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b port_out annotation (Placement(transformation(extent={{90,-10},{110,10}})));
    Modelica.Blocks.Interfaces.BooleanInput u
      annotation (Placement(transformation(extent={{-120,-10},{-100,10}}), iconTransformation(extent={{-120,-10},{-100,10}})));
  equation
    if u then
        dT[1] = port_in_1.T - port_out.T;
      for i in 2:n loop
        dT[i] = 0;
      end for;
      port_in_1.Q_flow = sum(Q_flow);
      port_in_2.Q_flow = fill(0, n);
    else
      for i in 1:n loop
        dT[i] = port_in_2[i].T - port_out.T;
        port_in_2[i].Q_flow = Q_flow[i];
      end for;
      port_in_1.Q_flow = 0;
    end if;
    port_out.Q_flow = -sum(Q_flow);
    Q_flow = 999999999*dT;

    annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
                                           Rectangle(
            extent={{-100,100},{100,-100}},
            fillColor={210,210,210},
            fillPattern=FillPattern.Solid,
            borderPattern=BorderPattern.Raised),
          Line(points={{12,0},{100,0}},
            color={238,46,47}),
          Line(points={{-100,0},{-40,0}},
            color={255,0,255}),
          Line(points={{-100,-80},{-40,-80},{-40,-80}},
            color={238,46,47}),
          Line(points={{-40,12},{-40,-12}},
            color={255,0,255}),
          Line(points={{-100,80},{-38,80}},
            color={238,46,47}),
          Line(points={{-38,80},{6,2}},
            color={238,46,47},
            thickness=1),
          Ellipse(lineColor={0,0,255},
            pattern=LinePattern.None,
            fillPattern=FillPattern.Solid,
            extent={{2,-8},{18,8}}),
          Text(
            extent={{-100,140},{100,100}},
            lineColor={0,0,0},
            textString="%name")}),                                 Diagram(coordinateSystem(preserveAspectRatio=false)));
  end thermSwitch_multi;

  model thermTankHeating1
    parameter Modelica.Units.SI.Mass m_t1 "Mass of cleaning fluid tank 1";
    parameter Modelica.Units.SI.Area A_t1 "Surface area of tank 1";
    parameter Modelica.Units.SI.SpecificHeatCapacity c_fluid "Heat capacity of cleaning fluid";
    parameter Modelica.Units.SI.Length d_ins "Thickness insulation (for no insulation set to 0)";
    parameter Modelica.Units.SI.ThermalConductivity lambda_ins "Thermal conductivity insulation";
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
    TankHeating.washingController washingController1(wState1=5, wState2=7)
      annotation (Placement(transformation(
          extent={{-10,-8},{10,8}},
          rotation=90,
          origin={34,-66})));
    TankHeating.heatController heatController1(st1=5, st2=7) annotation (Placement(transformation(extent={{-80,30},{-60,50}})));
    Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_heating annotation (Placement(transformation(extent={{-10,90},{10,110}})));
    Modelica.Thermal.HeatTransfer.Components.ThermalConductor thermalConductor_hall(G=A_t1/(1/350 + 2*0.002/20 + d_ins/lambda_ins + 1/8))
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
    connect(washingController1.state, state) annotation (Line(points={{34,-78},{34,-84},{-88,-84},{-88,0},
            {-120,0}},                                                                                               color={255,127,0}));
    connect(thermalConductor_hall.port_a, port_hall) annotation (Line(points={{84,-1.72085e-15},{100,0}}, color={191,0,0}));
    connect(port_heating, thermalConductor_heating.port_a) annotation (Line(points={{0,100},{1.77636e-15,86}}, color={191,0,0}));
    connect(thermOnOff1.port_out, MT.port) annotation (Line(points={{-26,30},{-26,-40}}, color={191,0,0}));
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

  model elTankHeating1
    extends ThermalIntegrationLib.ProductionEquipment.CleaningMachines.EiB_CleaningMachine2Tanks_thermal_Mafac.TechnicalConfiguration.TechnicalConfiguration_a;
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
    Modelica.Electrical.Analog.Basic.Resistor heatingResistor(
      R=10,
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
end TankHeating;
