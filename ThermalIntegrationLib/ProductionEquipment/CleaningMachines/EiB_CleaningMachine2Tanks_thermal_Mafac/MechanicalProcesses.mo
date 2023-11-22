within ThermalIntegrationLib.ProductionEquipment.CleaningMachines.EiB_CleaningMachine2Tanks_thermal_Mafac;
package MechanicalProcesses

  model mech_processes
    Modelica.Blocks.Interfaces.RealOutput P_el
      annotation (Placement(transformation(extent={{100,-10},{120,10}})));
    Modelica.Blocks.Interfaces.IntegerInput state
      annotation (Placement(transformation(extent={{-120,-10},{-100,10}}), iconTransformation(extent={{-120,-10},{-100,10}})));
  equation
    if state == 1 then // system off
      P_el = 0;
    elseif state == 5 or state == 6 then // spraying MT1
      P_el = 7.5;
    elseif state == 7 then // ultrasonic cleaning MT1
      P_el = 1.5;
    elseif state == 8 then // spraying MT2
      P_el = 1.85;
    elseif state == 11 or state == 13 then // draining/suction
      P_el = 0.5;
    elseif state == 12 then // impulse blowing
      P_el = 0.1;
    elseif state == 15 then // vaccum drying
      P_el = 7.5;
    else // other processes
      P_el = 0;
    end if;

    annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Rectangle(
            extent={{-100,100},{100,-100}},
            lineColor={0,0,0},
            lineThickness=0.5),
          Rectangle(
            extent={{-70,50},{-10,-10}},
            lineColor={0,0,0},
            lineThickness=0.5,
            fillColor={0,0,0},
            fillPattern=FillPattern.None),
          Ellipse(
            extent={{-70,-30},{-10,-90}},
            lineColor={0,0,0},
            lineThickness=0.5,
            fillColor={0,0,0},
            fillPattern=FillPattern.None),
          Polygon(
            points={{10,-10},{40,50},{70,-10},{10,-10}},
            lineColor={0,0,0},
            lineThickness=0.5,
            fillColor={0,0,0},
            fillPattern=FillPattern.None),
          Polygon(
            points={{58,-90},{22,-90},{10,-60},{40,-30},{70,-60},{58,-90}},
            lineColor={0,0,0},
            lineThickness=0.5,
            fillColor={0,0,0},
            fillPattern=FillPattern.None),
          Text(
            extent={{-80,100},{80,60}},
            lineColor={0,0,0},
            textString="mech proc")}),
                                   Diagram(coordinateSystem(preserveAspectRatio=false)));
  end mech_processes;

  model oil_separator
    parameter Real pct;
    Modelica.Blocks.Interfaces.RealOutput P_el annotation (Placement(transformation(extent={{100,-10},{120,10}})));
    Modelica.Blocks.Interfaces.RealInput processTime
      annotation (Placement(transformation(extent={{-120,-60},{-100,-40}}), iconTransformation(extent={{-120,-60},{-100,-40}})));
    Modelica.Blocks.Interfaces.IntegerInput state
      annotation (Placement(transformation(extent={{-120,40},{-100,60}}),   iconTransformation(extent={{-120,40},{-100,60}})));
  protected
    Modelica.SIunits.Time timer;
  initial equation
    pre(timer) = 0;
  equation
    when state > 7 and pre(state) <= 7 then //
      timer = time + processTime*pct + 30;
    end when;
    if (state < 5 or state > 7) and timer >= time then // oil separator active
      P_el = 0.2;
    else // other processes
      P_el = 0;
    end if;
    annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Text(
            extent={{-80,100},{80,0}},
            lineColor={0,0,0},
            textString="oil sep"),
          Rectangle(
            extent={{-100,100},{100,-100}},
            lineColor={0,0,0},
            lineThickness=0.5),
          Line(
            points={{-80,-38},{-40,-8},{0,-34},{40,-62},{80,-42}},
            color={0,0,0},
            thickness=0.5,
            smooth=Smooth.Bezier),
          Line(
            points={{-80,-38},{-40,-18},{0,-44},{40,-72},{80,-42}},
            color={0,0,0},
            thickness=0.5,
            smooth=Smooth.Bezier)}),                               Diagram(coordinateSystem(preserveAspectRatio=false)));
  end oil_separator;

  model ah
    Modelica.Blocks.Interfaces.RealOutput P_el
      annotation (Placement(transformation(extent={{100,-10},{120,10}})));
    Modelica.Blocks.Interfaces.IntegerInput state
      annotation (Placement(transformation(extent={{-120,-10},{-100,10}}), iconTransformation(extent={{-120,-10},{-100,10}})));
  equation
    if state == 13 or state == 14 then // hot blowing / impulse hot blowing
      P_el = 3;
    else // other processes
      P_el = 0;
    end if;

    annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Rectangle(
            extent={{-100,100},{100,-100}},
            lineColor={0,0,0},
            lineThickness=0.5),
          Text(
            extent={{-80,100},{80,40}},
            lineColor={0,0,0},
            textString="air heater"),
          Ellipse(
            extent={{-24,-34},{24,-80}},
            lineColor={0,0,0},
            lineThickness=1,
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{-12,26},{12,-40}},
            lineColor={0,0,0},
            lineThickness=1,
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{-12,38},{12,14}},
            lineColor={0,0,0},
            lineThickness=1,
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{-14,-44},{14,-72}},
            lineColor={255,255,255},
            lineThickness=1,
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{-4,4},{4,-46}},
            lineColor={255,255,255},
            lineThickness=1,
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{-4,8},{4,0}},
            lineColor={255,255,255},
            lineThickness=1,
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Line(
            points={{-2,-32},{2,-32}},
            color={255,255,255},
            thickness=1)}),        Diagram(coordinateSystem(preserveAspectRatio=false)));
  end ah;

  model scc
    Modelica.Blocks.Interfaces.RealOutput P_el
      annotation (Placement(transformation(extent={{100,-10},{120,10}})));
    Modelica.Blocks.Interfaces.IntegerInput state
      annotation (Placement(transformation(extent={{-120,-10},{-100,10}}), iconTransformation(extent={{-120,-10},{-100,10}})));
  equation
    if state == 13 then // side channel compressor active (hot blowing)
      P_el = 5.5;
    elseif state == 14 then // side channel compressor active (impulse hot blowing)
      P_el = 6.1;
    else // other processes
      P_el = 0;
    end if;

    annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Rectangle(
            extent={{-100,100},{100,-100}},
            lineColor={0,0,0},
            lineThickness=0.5),
          Ellipse(
            extent={{-70,50},{70,-90}},
            lineColor={0,0,0},
            lineThickness=0.5),
          Line(
            points={{68,-2},{-54,24}},
            color={0,0,0},
            thickness=0.5),
          Line(
            points={{68,-38},{-54,-64}},
            color={0,0,0},
            thickness=0.5),
          Text(
            extent={{-60,100},{60,60}},
            lineColor={0,0,0},
            textString="scc")}),   Diagram(coordinateSystem(preserveAspectRatio=false)));
  end scc;

  model units_waste_heat
    parameter Real Q_wasteheat;
    Modelica.Blocks.Interfaces.IntegerInput state
      annotation (Placement(transformation(extent={{-120,-10},{-100,10}}), iconTransformation(extent={{-120,-10},{-100,10}})));
    Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b port_hall annotation (Placement(transformation(extent={{90,-10},{110,10}})));
    Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow fixedHeatFlow(
      Q_flow=Q_wasteheat,
      T_ref=298.15,
      alpha=1)                                                        annotation (Placement(transformation(extent={{-20,-10},{0,10}})));
    TankHeating.thermOnOff thermOnOff annotation (Placement(transformation(extent={{20,-10},{40,10}})));
    wasteheatController wasteheatController1 annotation (Placement(transformation(extent={{-10,-50},{10,-30}})));
  equation
    connect(thermOnOff.port_out, port_hall) annotation (Line(points={{40,0},{100,0}}, color={191,0,0}));
    connect(fixedHeatFlow.port, thermOnOff.port_in) annotation (Line(points={{0,0},{20,0}}, color={191,0,0}));
    connect(state, wasteheatController1.state) annotation (Line(points={{-110,0},{-60,0},{-60,-40},{-11.2,-40}}, color={255,127,0}));
    connect(wasteheatController1.y, thermOnOff.u) annotation (Line(points={{11,-40},{30,-40},{30,-12}}, color={255,0,255}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Rectangle(
            extent={{-100,100},{100,-100}},
            lineColor={0,0,0},
            lineThickness=0.5),
          Text(
            extent={{-80,100},{80,40}},
            lineColor={0,0,0},
            textString="units waste heat"),
          Line(
            points={{-40,40},{-60,0},{-20,-40},{-40,-80}},
            color={0,0,0},
            smooth=Smooth.Bezier,
            thickness=1,
            arrow={Arrow.Filled,Arrow.None}),
          Line(
            points={{-60,-88},{60,-88}},
            color={0,0,0},
            thickness=1,
            smooth=Smooth.Bezier),
          Line(
            points={{0,40},{-20,0},{20,-40},{0,-80}},
            color={0,0,0},
            smooth=Smooth.Bezier,
            thickness=1,
            arrow={Arrow.Filled,Arrow.None}),
          Line(
            points={{40,40},{20,0},{60,-40},{40,-80}},
            color={0,0,0},
            smooth=Smooth.Bezier,
            thickness=1,
            arrow={Arrow.Filled,Arrow.None})}), Diagram(coordinateSystem(preserveAspectRatio=false)));
  end units_waste_heat;

  model wasteheatController
    Modelica.Blocks.Interfaces.IntegerInput state
      annotation (Placement(transformation(extent={{-124,-12},{-100,12}}), iconTransformation(extent={{-124,-12},{-100,12}})));
    Modelica.Blocks.Interfaces.BooleanOutput y annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  equation
    y = state > 4;
    annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
                                Text(
            extent={{-80,100},{80,-100}},
            lineColor={0,0,0},
            textString="waste heat
controller"),                                                               Rectangle(
            extent={{-100,100},{100,-100}},
            lineColor={0,0,0},
            lineThickness=0.5)}), Diagram(coordinateSystem(preserveAspectRatio=false)));
  end wasteheatController;
end MechanicalProcesses;
