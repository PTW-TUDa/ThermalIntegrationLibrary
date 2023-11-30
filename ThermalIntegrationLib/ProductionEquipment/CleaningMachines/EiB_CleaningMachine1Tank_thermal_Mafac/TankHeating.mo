within ThermalIntegrationLib.ProductionEquipment.CleaningMachines.EiB_CleaningMachine1Tank_thermal_Mafac;
package TankHeating

  model heatController
    extends ThermalIntegrationLib.ProductionEquipment.CleaningMachines.EiB_CleaningMachine1Tank_thermal_Mafac.TechnicalConfiguration.TechnicalConfiguration_a;
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

  model thermSwitch
    Modelica.SIunits.HeatFlowRate Q_flow;
   Modelica.SIunits.TemperatureDifference dT;
    Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_in_1 annotation (Placement(transformation(extent={{-110,70},{-90,90}}),
          iconTransformation(extent={{-110,70},{-90,90}})));
    Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_in_2 annotation (Placement(transformation(extent={{-112,-90},{-92,-70}}),
          iconTransformation(extent={{-112,-90},{-92,-70}})));
    Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b port_out annotation (Placement(transformation(extent={{90,-10},{110,10}})));
    Modelica.Blocks.Interfaces.BooleanInput u
      annotation (Placement(transformation(extent={{-120,-10},{-100,10}}), iconTransformation(extent={{-120,-10},{-100,10}})));
  equation
    if u then
      dT = port_in_1.T - port_out.T;
      port_in_1.Q_flow = Q_flow;
      port_in_2.Q_flow = 0;
    else
      dT = port_in_2.T - port_out.T;
      port_in_2.Q_flow = Q_flow;
      port_in_1.Q_flow = 0;
    end if;
    port_out.Q_flow = -Q_flow;
    Q_flow = 999999999 * dT;

  //   port_out = if u then port_in_1 else port_in_2;
  //
  //   if u then
  //     port_in_2.Q_flow = 0;
  //   else
  //     port_in_1.Q_flow = 0;
  //   end if;
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
  end thermSwitch;

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

  model thermTankHeating1
    parameter Modelica.SIunits.Mass m_t1 "Mass of cleaning fluid tank 1";
    parameter Modelica.SIunits.Area A_t1 "Surface area of tank 1";
    parameter Modelica.SIunits.SpecificHeatCapacity c_fluid "Heat capacity of cleaning fluid";
    parameter Modelica.SIunits.Length d_ins "Thickness insulation";
    parameter Modelica.SIunits.ThermalConductivity lambda_ins "Thermal conductivity insulation";
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
      annotation (Placement(transformation(extent={{-120,-10},{-100,10}}), iconTransformation(extent={{-120,-10},{-100,10}})));
    Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_batch
      annotation (Placement(transformation(extent={{-10,-110},{10,-90}})));
    Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_hall
      annotation (Placement(transformation(extent={{90,-10},{110,10}})));
    washingController washingController1(wState1=5, wState2=7)
                                         annotation (Placement(transformation(
          extent={{-10,-8},{10,8}},
          rotation=90,
          origin={34,-66})));
    heatController heatController1(st1=5, st2=7)
                                   annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
    Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_heating annotation (Placement(transformation(extent={{-10,90},{10,110}})));
    Modelica.Thermal.HeatTransfer.Components.ThermalConductor thermalConductor(G=A_t1/(1/350 + 2*0.002/20 + d_ins/lambda_ins + 1/8))
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
  equation
    connect(MT.port, temperatureSensor.port) annotation (Line(points={{-26,-40},{-40,-40}},color={191,0,0}));
    connect(temperatureSensor.T, heatController1.temp) annotation (Line(points={{-52,-40},{-70,-40},{-70,19}}, color={0,0,127}));
    connect(heatController1.state, state) annotation (Line(points={{-81,30},{-94,30},{-94,0},{-110,0}}, color={255,127,0}));
    connect(washingController1.state, state) annotation (Line(points={{34,-78},{34,-84},{-94,-84},{-94,0},{-110,0}}, color={255,127,0}));
    connect(thermalConductor.port_a, port_hall)
      annotation (Line(points={{72,-1.72085e-15},{100,0}}, color={191,0,0}));
    connect(port_heating, thermalConductor1.port_a)
      annotation (Line(points={{0,100},{1.77636e-15,86}}, color={191,0,0}));
    connect(thermOnOff1.port_out, MT.port) annotation (Line(points={{-26,20},{-26,-40}}, color={191,0,0}));
    connect(thermalConductor1.port_b, thermOnOff1.port_in) annotation (Line(points={{0,66},{0,58},{
            -26,58},{-26,40}},                                                                                        color={191,0,0}));
    connect(heatController1.heating, thermOnOff1.u)
      annotation (Line(points={{-59,30},{-38,30}}, color={255,0,255}));
    connect(T, heatController1.temp) annotation (Line(points={{-110,60},{-92,60},{-92,12},{-70,12},{-70,19}}, color={0,0,127}));
    connect(MT.port, thermSwitch1.port_out)
      annotation (Line(points={{-26,-40},{-14,-40},{-14,-20},{0,-20}}, color={191,0,0}));
    connect(thermalConductor.port_b, thermSwitch1.port_in_2) annotation (Line(points={{52,7.21645e-16},{26,7.21645e-16},{26,-12},{20.2,
            -12}},                                 color={191,0,0}));
    connect(thermSwitch1.port_in_1, port_batch)
      annotation (Line(points={{20,-28},{48,-28},{48,-86},{0,-86},{0,-100}}, color={191,0,0}));
    connect(thermSwitch1.u, washingController1.out)
      annotation (Line(points={{21,-20},{30,-20},{30,-48},{34,-48},{34,-54}}, color={255,0,255}));
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

  model thermOnOff
    Modelica.SIunits.HeatFlowRate Q_flow;
    Modelica.SIunits.TemperatureDifference dT;
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
end TankHeating;
