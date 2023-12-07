within ThermalIntegrationLib.ProductionEquipment;
package Ovens
  extends Modelica.Icons.VariantsPackage;


  package AnnealingOven
    extends ThermalIntegrationLib.BaseClasses.Icons.AnnealingOven;
    package Wall
      model Wall
        parameter Integer n = 3 "number of discrete wall segments";
        parameter Modelica.Units.SI.Density rho_wall "density of wall material";
        parameter Modelica.Units.SI.ThermalConductivity lambda_wall "thermal conductivity of wall material";
        parameter Modelica.Units.SI.SpecificHeatCapacity cp_wall "specific heat capacity of wall material";
        parameter Modelica.Units.SI.Length t_wall "thickness of wall material";
        parameter Modelica.Units.SI.Area A_wall "area of wall";
        parameter Modelica.Units.SI.ThermodynamicTemperature T_start_wall "start temperature of wall material";

        Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heatCapacitor[n](C=cp_wall*(rho_wall*A_wall*t_wall)/n,
                                                                                                    T(start=T_start_wall)) annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
        Modelica.Thermal.HeatTransfer.Components.ThermalConductor thermalConductor[n](G=lambda_wall*A_wall/(t_wall*n)) annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={50,0})));
        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_a annotation (Placement(transformation(extent={{-10,-110},{10,-90}})));
        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_a1 annotation (Placement(transformation(extent={{-10,90},{10,110}})));
      equation

        for i in 1:n loop //Connect each heat capacity with inlet of thermal conductor
          connect( heatCapacitor[i].port, thermalConductor[i].port_a);
        end for;

        for i in 1:(n-1) loop //Connect outlet of each thermal conductor (except n) to a heat capacity
          connect(thermalConductor[i].port_b, heatCapacitor[i+1].port);
        end for;

        connect(port_a, heatCapacitor[1].port);
        connect(thermalConductor[n].port_b, port_a1);
        annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)),
          Documentation(info="<html>
<p>Thermal model of a wall, consisting of n discrete elements (in row). Each element itself consists of a heat capacity as well as a thermal conductivity.</p>
</html>"));
      end Wall;

    end Wall;

    package ThermalSystem
      model ThermalSystem
        Wall.Wall wall_element(
          n=10,
          rho_wall=2000,
          lambda_wall=0.8,
          cp_wall=1000,
          t_wall=0.1,
          A_wall=10,
          T_start_wall=293.15) annotation (Placement(transformation(extent={{-10,160},{10,180}})));
        Modelica.Thermal.HeatTransfer.Components.HeatCapacitor retort(C=1000*500) annotation (Placement(transformation(extent={{-120,0},{-78,42}})));
        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a wall_loss "Thermal port of oven wall"
                                                                      annotation (Placement(transformation(extent={{-10,190},{10,210}})));
        Modelica.Thermal.HeatTransfer.Components.ConvectiveResistor convectiveResistor annotation (Placement(transformation(extent={{-10,110},{10,90}})));
        Modelica.Thermal.HeatTransfer.Components.HeatCapacitor workpiece(C=1000*200) annotation (Placement(transformation(extent={{30,100},{70,140}})));
        Modelica.Thermal.HeatTransfer.Components.HeatCapacitor workpiece_carrier(C=1000*200) annotation (Placement(transformation(extent={{90,100},{130,140}})));
        Modelica.Blocks.Sources.Constant high_resistance(k=1e6) annotation (Placement(transformation(extent={{-180,-160},{-160,-140}})));
        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a retort_port "Thermal port of retort" annotation (Placement(transformation(extent={{-210,-110},{-190,-90}})));
        Modelica.Thermal.HeatTransfer.Components.BodyRadiation bodyRadiation(Gr=1) annotation (Placement(transformation(extent={{160,-10},{180,10}})));
        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a radiation_loss "Thermal port for radiation loss if door is open"
                                                                           annotation (Placement(transformation(extent={{190,-10},{210,10}})));
        Modelica.Thermal.HeatTransfer.Components.ConvectiveResistor convectiveResistor1 annotation (Placement(transformation(extent={{-10,10},{10,-10}})));
        Modelica.Blocks.Logical.Switch switch1 annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=0,
              origin={-20,70})));
        Modelica.Blocks.Logical.Switch switch2 annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=0,
              origin={-20,-30})));
        Modelica.Blocks.Sources.Constant low_resitance(k=1e-6) annotation (Placement(transformation(extent={{-180,-110},{-160,-90}})));
        Modelica.Blocks.MathBoolean.FallingEdge closing annotation (Placement(transformation(extent={{16,-84},{24,-76}})));
        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a door_loss "Thermal port for door" annotation (Placement(transformation(extent={{190,90},{210,110}})));
        Wall.Wall door_element(
          n=10,
          rho_wall=2000,
          lambda_wall=0.8,
          cp_wall=1000,
          t_wall=0.1,
          A_wall=1,
          T_start_wall=293.15) annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=270,
              origin={170,100})));
        Modelica.Thermal.HeatTransfer.Components.Convection convection annotation (Placement(transformation(extent={{-130,90},{-150,110}})));
        Modelica.Blocks.Sources.Constant alpha(k=250*5) annotation (Placement(transformation(extent={{-180,-60},{-160,-40}})));
        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a air_port "Thermal port to air chamber" annotation (Placement(transformation(extent={{-210,90},{-190,110}})));
        Modelica.Thermal.HeatTransfer.Components.HeatCapacitor air(C=1000*500) annotation (Placement(transformation(extent={{-190,100},{-150,140}})));
        Modelica.Blocks.Examples.BusUsage_Utilities.Interfaces.ControlBus controlBus annotation (Placement(transformation(
              extent={{-20,-20},{20,20}},
              rotation=180,
              origin={0,-200}), iconTransformation(
              extent={{-10,-10},{10,10}},
              rotation=180,
              origin={0,-200})));
        Modelica.Blocks.Logical.GreaterThreshold greaterThreshold(threshold=0.5) annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={0,-150})));
        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a workpiece_temp annotation (Placement(transformation(extent={{190,-110},{210,-90}})));
      equation
        when closing.y then
          reinit(workpiece.T, 293.15);
          //reinit(workpiece_carrier.T, 293.15);
        end when;
        connect(wall_element.port_a1, wall_loss) annotation (Line(points={{0,180},{0,200}}, color={191,0,0}));
        connect(retort.port, convectiveResistor.solid) annotation (Line(points={{-99,0},{-54,0},{-54,100},{-10,100}},
                                                                                                   color={191,0,0}));
        connect(retort_port, retort.port) annotation (Line(points={{-200,-100},{-200,0},{-99,0}}, color={191,0,0}));
        connect(bodyRadiation.port_b, radiation_loss) annotation (Line(points={{180,0},{200,0}},     color={191,0,0}));
        connect(bodyRadiation.port_a, convectiveResistor1.fluid) annotation (Line(points={{160,0},{10,0}},     color={191,0,0}));
        connect(convectiveResistor.fluid, workpiece.port) annotation (Line(points={{10,100},{50,100}},
                                                                                                   color={191,0,0}));
        connect(workpiece.port, workpiece_carrier.port) annotation (Line(points={{50,100},{110,100}},
                                                                                                  color={191,0,0}));
        connect(convectiveResistor1.solid, retort.port) annotation (Line(points={{-10,0},{-99,0}},                      color={191,0,0}));
        connect(convectiveResistor1.Rc, switch2.y) annotation (Line(points={{0,-10},{0,-30},{-9,-30}},
                                                                                                     color={0,0,127}));
        connect(convectiveResistor.Rc, switch1.y) annotation (Line(points={{0,90},{0,70},{-9,70}},    color={0,0,127}));
        connect(door_element.port_a, workpiece_carrier.port) annotation (Line(points={{160,100},{110,100}}, color={191,0,0}));
        connect(door_element.port_a1, door_loss) annotation (Line(points={{180,100},{200,100}}, color={191,0,0}));
        connect(convection.solid, retort.port) annotation (Line(points={{-130,100},{-120,100},{-120,0},{-99,0}},
                                                                                                         color={191,0,0}));
        connect(alpha.y, convection.Gc) annotation (Line(
            points={{-159,-50},{-140,-50},{-140,110}},
            color={0,0,127},
            pattern=LinePattern.Dot));
        connect(air.port, air_port) annotation (Line(points={{-170,100},{-200,100}}, color={191,0,0}));
        connect(air.port, convection.fluid) annotation (Line(points={{-170,100},{-150,100}},                     color={191,0,0}));
        connect(wall_element.port_a, retort.port) annotation (Line(points={{0,160},{0,140},{-80,140},{-80,0},{-99,0}}, color={191,0,0}));
        connect(high_resistance.y, switch1.u1) annotation (Line(
            points={{-159,-150},{-50,-150},{-50,78},{-32,78}},
            color={0,0,127},
            pattern=LinePattern.Dot));
        connect(switch1.u3, low_resitance.y) annotation (Line(
            points={{-32,62},{-110,62},{-110,-100},{-159,-100}},
            color={0,0,127},
            pattern=LinePattern.Dot));
        connect(switch2.u1, low_resitance.y) annotation (Line(
            points={{-32,-22},{-120,-22},{-120,-100},{-159,-100}},
            color={0,0,127},
            pattern=LinePattern.Dot));
        connect(switch2.u3, high_resistance.y) annotation (Line(
            points={{-32,-38},{-100,-38},{-100,-150},{-159,-150}},
            color={0,0,127},
            pattern=LinePattern.Dot));
        connect(greaterThreshold.u, controlBus.DoorIsOpen) annotation (Line(points={{-6.66134e-16,-162},{0,-200}}, color={0,0,127}), Text(
            string="%second",
            index=1,
            extent={{-3,-6},{-3,-6}},
            horizontalAlignment=TextAlignment.Right));
        connect(greaterThreshold.y, closing.u) annotation (Line(points={{0,-139},{0,-80},{14.4,-80}}, color={255,0,255}));
        connect(greaterThreshold.y, switch1.u2) annotation (Line(points={{0,-139},{-40,-139},{-40,70},{-32,70}}, color={255,0,255}));
        connect(switch2.u2, switch1.u2) annotation (Line(points={{-32,-30},{-40,-30},{-40,70},{-32,70}}, color={255,0,255}));
        connect(workpiece_temp, workpiece.port) annotation (Line(points={{200,-100},{50,-100},{50,100}}, color={191,0,0}));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-200,-200},{200,200}}), graphics={
              Rectangle(
                extent={{-200,200},{200,-200}},
                lineColor={0,0,0},
                lineThickness=0.5,
                fillColor={0,0,0},
                fillPattern=FillPattern.None),
              Rectangle(
                extent={{-100,80},{100,-60}},
                lineThickness=0.5,
                fillColor={0,0,0},
                fillPattern=FillPattern.None,
                pattern=LinePattern.None),
              Rectangle(
                extent={{-90,148},{-22,82}},
                lineColor={255,255,255},
                pattern=LinePattern.None,
                lineThickness=0.5,
                fillColor={255,255,255},
                fillPattern=FillPattern.None),
              Rectangle(
                extent={{38,-2},{98,-32}},
                lineColor={0,0,0},
                lineThickness=0.5,
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid),
              Line(
                points={{-40,102}},
                color={0,0,0},
                thickness=0.5),
              Polygon(
                points={{98,-32},{118,-12},{118,18},{98,-2},{98,-32}},
                lineColor={0,0,0},
                lineThickness=0.5,
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid),
              Polygon(
                points={{38,-2},{98,-2},{118,18},{58,18},{38,-2}},
                lineColor={0,0,0},
                lineThickness=0.5,
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid),
              Ellipse(
                extent={{-140,70},{-60,-70}},
                lineColor={0,0,0},
                lineThickness=0.5,
                fillColor={0,0,0},
                fillPattern=FillPattern.None),
              Rectangle(
                extent={{-100,70},{62,-72}},
                lineColor={0,0,0},
                pattern=LinePattern.None,
                lineThickness=0.5,
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid),
              Ellipse(
                extent={{60,70},{140,-70}},
                lineColor={0,0,0},
                lineThickness=0.5,
                fillColor={0,0,0},
                fillPattern=FillPattern.None),
              Line(
                points={{-100,70},{100,70}},
                color={0,0,0},
                thickness=0.5),
              Line(
                points={{-100,-70},{100,-70}},
                color={0,0,0},
                thickness=0.5)}),                                                                      Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-200,-200},{200,200}})),
          Documentation(info="<html>
<p><span style=\"font-size: 14pt;\">The thermal system model of the annealing oven is based on the following assumptions:</span></p>
<ol>
<li><span style=\"font-size: 14pt;\">The main thermal losses of the annealing oven are due to wall-, door-, and radiation-losses (once the door is opened)</span></li>
<li><span style=\"font-size: 14pt;\">The thermal behavior within the chamber/retort is primarily influenced by the workpiece and workpiece carrier. The mass and heat capacity of the atmosphere within the chamber/retort is not taken into consideration</span></li>
<li><span style=\"font-size: 14pt;\">Thermal energy exchange between the retort and workpiece/workpiece carrier is not taken into consideration. Therefore the temperature of the retort and workpiece/workpiece carrier is more or less equal</span></li>
<li><span style=\"font-size: 14pt;\">Once the door is opened, the workpiece/workpiece carrier is extracted and therefore initialized with a new, lower temperature</span></li>
<li><span style=\"font-size: 14pt;\">Once the door is opened, the retort/chamber exchanges thermal energy with the environment via radiation. Here, black body radiation is assumed</span></li>
</ol>
</html>"));
      end ThermalSystem;

    end ThermalSystem;

    package HeatingSystem
      model HeaterUnit
        parameter Modelica.Units.SI.Power P_th_nom "Nominal power of heater unit";
        parameter Real eta_f "Firing efficiency of heater unit";
        Modelica.Blocks.Interfaces.RealInput u "Regulating variable of heater unit [0,1]"
                                               annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heating "Thermal port of heater unit"
                                                                    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a exhaust "Thermal port of heater unit losses (exhaust)"
                                                                    annotation (Placement(transformation(extent={{-10,90},{10,110}})));
        Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow annotation (Placement(transformation(extent={{60,-10},{80,10}})));
        Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow1 annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={0,70})));
        Modelica.Blocks.Math.Gain gain(k=P_th_nom)
                                       annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
        Modelica.Blocks.Math.Gain gain1(k=eta_f)
                                       annotation (Placement(transformation(extent={{20,-10},{40,10}})));
        Modelica.Blocks.Math.Gain gain2(k=1 - eta_f)
                                       annotation (Placement(transformation(extent={{-10,-10},{10,10}},
              rotation=90,
              origin={0,30})));
        Modelica.Blocks.Interfaces.RealOutput P_final(quantity="Power", unit="W") "Final power (electricity or gas) demand of heater unit" annotation (Placement(transformation(extent={{100,-60},{120,-40}})));
      equation
        connect(prescribedHeatFlow.port, heating) annotation (Line(points={{80,0},{100,0}}, color={191,0,0}));
        connect(prescribedHeatFlow1.port, exhaust) annotation (Line(points={{0,80},{0,100}}, color={191,0,0}));
        connect(gain.u, u) annotation (Line(points={{-82,0},{-120,0}}, color={0,0,127}));
        connect(gain.y, gain1.u) annotation (Line(points={{-59,0},{18,0}}, color={0,0,127}));
        connect(gain1.y, prescribedHeatFlow.Q_flow) annotation (Line(points={{41,0},{60,0}}, color={0,0,127}));
        connect(gain2.u, gain1.u) annotation (Line(points={{0,18},{0,0},{18,0}}, color={0,0,127}));
        connect(gain2.y, prescribedHeatFlow1.Q_flow) annotation (Line(points={{0,41},{0,60}}, color={0,0,127}));
        connect(P_final, gain.y) annotation (Line(points={{110,-50},{0,-50},{0,0},{-59,0}}, color={0,0,127}));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
              Rectangle(
                extent={{-100,100},{100,-100}},
                lineColor={0,0,0},
                lineThickness=0.5),
              Line(
                points={{-30,60},{-70,20},{-30,-20},{-70,-60},{-20,-20},{-60,20},{-30,60}},
                color={0,0,0},
                thickness=0.5,
                smooth=Smooth.Bezier),
              Line(
                points={{10,60},{-30,20},{10,-20},{-30,-60},{20,-20},{-20,20},{10,60}},
                color={0,0,0},
                thickness=0.5,
                smooth=Smooth.Bezier),
              Line(
                points={{50,60},{10,20},{50,-20},{10,-60},{60,-20},{20,20},{50,60}},
                color={0,0,0},
                thickness=0.5,
                smooth=Smooth.Bezier)}),                               Diagram(coordinateSystem(preserveAspectRatio=false)),
          Documentation(info="<html>
<p>Simple model of heater unit with constant efficiency. Once the firing efficiency is set equal to 1, the heater is can be regarded as a resistant heater. If the firing efficiency is below 1, losses are exported via the exhaust port.  The exhaust port itself can be connected to a waste heat recovery if needed.</p>
</html>"));
      end HeaterUnit;

      model HeaterUnit_Controller
        Modelica.Blocks.Interfaces.RealInput Temperature "Target temperatur which is predominate within the oven [K]"
                                                         annotation (Placement(transformation(extent={{-20,-20},{20,20}},
              rotation=90,
              origin={0,-120})));
        Modelica.Blocks.Interfaces.RealOutput y "Regulating variable of heater unit [0,1]"
                                                annotation (Placement(transformation(extent={{100,-10},{120,10}})));
        Modelica.Blocks.Logical.Switch switch1 annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
        Modelica.Blocks.Continuous.LimPID PID(
          controllerType=Modelica.Blocks.Types.SimpleController.P,
          k=0.1,
          yMax=1,
          yMin=0) annotation (Placement(transformation(extent={{40,-10},{60,10}})));
        Modelica.Blocks.Examples.BusUsage_Utilities.Interfaces.ControlBus controlBus annotation (Placement(transformation(
              extent={{-20,20},{20,-20}},
              rotation=270,
              origin={-100,0}), iconTransformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={-100,0})));
        Modelica.Blocks.Logical.GreaterThreshold greaterThreshold(threshold=0.0) annotation (Placement(transformation(extent={{-70,-10},{-50,10}})));
      equation
        connect(PID.y, y) annotation (Line(points={{61,0},{110,0}}, color={0,0,127}));
        connect(Temperature, PID.u_m) annotation (Line(points={{0,-120},{0,-50},{50,-50},{50,-12}},
                                                                                              color={0,0,127}));
        connect(switch1.y, PID.u_s) annotation (Line(points={{11,0},{38,0}}, color={0,0,127}));
        connect(switch1.u3, PID.u_m) annotation (Line(points={{-12,-8},{-20,-8},{-20,-50},{50,-50},{50,-12}},
                                                                                                     color={0,0,127}));
        connect(greaterThreshold.u, controlBus.Heating) annotation (Line(points={{-72,0},{-100,0}}, color={0,0,127}), Text(
            string="%second",
            index=1,
            extent={{-6,3},{-6,3}},
            horizontalAlignment=TextAlignment.Right));
        connect(greaterThreshold.y, switch1.u2) annotation (Line(points={{-49,0},{-12,0}}, color={255,0,255}));
        connect(switch1.u1, controlBus.TargetTemperature) annotation (Line(points={{-12,8},{-20,8},{-20,30},{-100,30},{-100,0}}, color={0,0,127}), Text(
            string="%second",
            index=1,
            extent={{-6,3},{-6,3}},
            horizontalAlignment=TextAlignment.Right));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
              Rectangle(
                extent={{-100,100},{100,-100}},
                lineColor={0,0,0},
                lineThickness=0.5),
              Rectangle(
                extent={{10,20},{50,-20}},
                lineColor={0,0,0},
                lineThickness=0.5),
              Ellipse(
                extent={{-80,10},{-60,-10}},
                lineColor={0,0,0},
                lineThickness=0.5),
              Ellipse(
                extent={{-30,10},{-10,-10}},
                lineColor={0,0,0},
                lineThickness=0.5),
              Line(
                points={{-100,0},{-80,0}},
                color={0,0,0},
                thickness=0.5),
              Line(
                points={{-70,-10},{-70,-80},{0,-80},{0,-108}},
                color={0,0,0},
                thickness=0.5),
              Line(
                points={{-60,0},{-30,0}},
                color={0,0,0},
                thickness=0.5),
              Line(
                points={{-10,0},{10,0}},
                color={0,0,0},
                thickness=0.5),
              Line(
                points={{50,0},{100,0}},
                color={0,0,0},
                thickness=0.5),
              Line(
                points={{80,0},{80,-40},{-20,-40},{-20,-10}},
                color={0,0,0},
                thickness=0.5),
              Text(
                extent={{-90,100},{90,20}},
                lineColor={0,0,0},
                textString="Controller")}),                            Diagram(coordinateSystem(preserveAspectRatio=false)),
          Documentation(info="<html>
<p>Model to control the heater unit to reach the target temperature</p>
</html>"));
      end HeaterUnit_Controller;
    end HeatingSystem;

    package QuenchingSystem
      model QuenchingUnit
        parameter Modelica.Units.SI.MassFlowRate m_nom "Nominal air mass flow of quenching system";
        parameter Modelica.Units.SI.SpecificHeatCapacity cp_air=1006 "Heat capacity of air";
        parameter Modelica.Units.SI.Power P_el_nom "Nominal electric power demand";
        Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow annotation (Placement(transformation(extent={{60,-10},{80,10}})));
        Modelica.Blocks.Math.Gain gain1(k=-1)
                                       annotation (Placement(transformation(extent={{20,-10},{40,10}})));
        Modelica.Blocks.Interfaces.RealInput u "Regulating variable of quenching unit [0,1]"
                                               annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a quenching "Thermal port of quenching unit"
                                                                      annotation (Placement(transformation(extent={{90,-10},{110,10}})));
        Modelica.Blocks.Interfaces.RealInput T_air "Air temperature within oven/retort"
                                                   annotation (Placement(transformation(
              extent={{-20,-20},{20,20}},
              rotation=90,
              origin={-50,-120})));
        Modelica.Blocks.Interfaces.RealInput T_hall "Air temperatur within the hall"
                                                    annotation (Placement(transformation(
              extent={{-20,-20},{20,20}},
              rotation=90,
              origin={50,-120})));
        Modelica.Blocks.Nonlinear.VariableLimiter variableLimiter annotation (Placement(transformation(extent={{-30,-10},{-10,10}})));
        Modelica.Blocks.Sources.Constant const(k=0) annotation (Placement(transformation(extent={{-10,-40},{-30,-20}})));
        Modelica.Blocks.Sources.RealExpression realExpression(y=max(1, m_nom*cp_air*(T_air - T_hall)))
                                                              annotation (Placement(transformation(extent={{-10,20},{-30,40}})));
        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a exhaust "Thermal port of exhaust" annotation (Placement(transformation(extent={{-10,90},{10,110}})));
        Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow1
                                                                                    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
              rotation=90,
              origin={0,70})));
        Modelica.Blocks.Interfaces.RealOutput P_el(quantity="Power", unit="W") "Electric power demand of quenching unit"
                                                                               annotation (Placement(transformation(extent={{100,-60},{120,-40}})));
        Modelica.Blocks.Sources.Constant nominal_massflow(k=m_nom) annotation (Placement(transformation(extent={{-100,-30},{-80,-10}})));
        Modelica.Blocks.Sources.Constant specific_heat_capacity_air(k=cp_air) annotation (Placement(transformation(extent={{-100,40},{-80,60}})));
        Modelica.Blocks.Sources.RealExpression dT(y=max(1, (T_air - T_hall))) annotation (Placement(transformation(extent={{-100,10},{-80,30}})));
        Modelica.Blocks.Math.MultiProduct multiProduct(nu=4) annotation (Placement(transformation(extent={{-66,6},{-54,-6}})));
        Modelica.Blocks.Sources.Constant nominal_electric_power(k=P_el_nom) annotation (Placement(transformation(extent={{-100,-60},{-80,-40}})));
        Modelica.Blocks.Sources.RealExpression massflow(y=u*nominal_massflow.y) annotation (Placement(transformation(extent={{-100,-90},{-80,-70}})));
        Modelica.Blocks.Sources.RealExpression electric_power_demand(y=nominal_electric_power.y*((massflow.y/nominal_massflow.y)^3)) annotation (Placement(transformation(extent={{0,-60},{80,-40}})));
      equation
        connect(prescribedHeatFlow.port, quenching) annotation (Line(points={{80,0},{100,0}}, color={191,0,0}));
        connect(gain1.y,prescribedHeatFlow. Q_flow) annotation (Line(points={{41,0},{60,0}}, color={0,0,127}));
        connect(variableLimiter.y, gain1.u) annotation (Line(points={{-9,0},{18,0}}, color={0,0,127}));
        connect(const.y, variableLimiter.limit2) annotation (Line(points={{-31,-30},{-50,-30},{-50,-8},{-32,-8}}, color={0,0,127}));
        connect(realExpression.y, variableLimiter.limit1) annotation (Line(points={{-31,30},{-50,30},{-50,8},{-32,8}}, color={0,0,127}));
        connect(prescribedHeatFlow1.port, exhaust) annotation (Line(points={{0,80},{0,100}}, color={191,0,0}));
        connect(prescribedHeatFlow1.Q_flow, variableLimiter.y) annotation (Line(points={{-8.88178e-16,60},{-8.88178e-16,0},{-9,0}},
                                                                                                                       color={0,0,127}));
        connect(nominal_massflow.y, multiProduct.u[1]) annotation (Line(points={{-79,-20},{-70,-20},{-70,-3.15},{-66,-3.15}}, color={0,0,127}));
        connect(specific_heat_capacity_air.y, multiProduct.u[2]) annotation (Line(points={{-79,50},{-74,50},{-74,-1.05},{-66,-1.05}}, color={0,0,127}));
        connect(dT.y, multiProduct.u[3]) annotation (Line(points={{-79,20},{-78,20},{-78,1.05},{-66,1.05}}, color={0,0,127}));
        connect(u, multiProduct.u[4]) annotation (Line(points={{-120,0},{-80,0},{-80,3.15},{-66,3.15}}, color={0,0,127}));
        connect(multiProduct.y, variableLimiter.u) annotation (Line(points={{-52.98,0},{-32,0}}, color={0,0,127}));
        connect(electric_power_demand.y, P_el) annotation (Line(points={{84,-50},{110,-50}}, color={0,0,127}));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
              Rectangle(
                extent={{-100,100},{100,-100}},
                lineColor={0,0,0},
                lineThickness=0.5),
              Line(
                points={{-30,-23},{-23,2},{-1,22},{29,20},{21,4},{-15,-18},{-30,-23}},
                color={0,0,0},
                thickness=0.5,
                smooth=Smooth.Bezier,
                origin={-23,30},
                rotation=90),
              Line(
                points={{-31,-24},{-23,2},{-1,22},{29,20},{21,4},{-15,-18},{-31,-24}},
                color={0,0,0},
                thickness=0.5,
                smooth=Smooth.Bezier,
                origin={31,24},
                rotation=360),
              Line(
                points={{-30,-25},{-23,2},{-1,22},{29,20},{21,4},{-15,-18},{-30,-25}},
                color={0,0,0},
                thickness=0.5,
                smooth=Smooth.Bezier,
                origin={25,-30},
                rotation=270),
              Line(
                points={{-29,-26},{-23,2},{-1,22},{29,20},{21,4},{-15,-18},{-29,-26}},
                color={0,0,0},
                thickness=0.5,
                smooth=Smooth.Bezier,
                origin={-29,-26},
                rotation=180),
              Ellipse(
                extent={{-12,12},{10,-10}},
                lineColor={0,0,0},
                lineThickness=0.5,
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid)}),                      Diagram(coordinateSystem(preserveAspectRatio=false)),
          Documentation(info="<html>
<p>Simple model of quenching unit. As convective cooling is assumed, cooling power of the quenching unit is primarily influenced by the max. massflow, predominate temperature within the retort/oven and the predominate temperature in the hall.</p>
</html>"));
      end QuenchingUnit;

      model QuenchingUnit_Controller
        Modelica.Blocks.Logical.Switch switch1 annotation (Placement(transformation(extent={{-8,-10},{12,10}})));
        Modelica.Blocks.Continuous.LimPID PID(
          controllerType=Modelica.Blocks.Types.SimpleController.P,
          k=0.1,
          yMax=1,
          yMin=0) annotation (Placement(transformation(extent={{40,-10},{60,10}})));
        Modelica.Blocks.Interfaces.RealInput Temperature annotation (Placement(transformation(extent={{-20,-20},{20,20}},
              rotation=90,
              origin={0,-120})));
        Modelica.Blocks.Interfaces.RealOutput y annotation (Placement(transformation(extent={{100,-10},{120,10}})));
        Modelica.Blocks.Sources.Constant const(k=0) annotation (Placement(transformation(extent={{12,-40},{-8,-20}})));
        Modelica.Blocks.Examples.BusUsage_Utilities.Interfaces.ControlBus controlBus annotation (Placement(transformation(
              extent={{-20,-20},{20,20}},
              rotation=270,
              origin={-100,0}), iconTransformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={-100,0})));
        Modelica.Blocks.Math.Add add(k2=-1) annotation (Placement(transformation(extent={{-50,32},{-30,52}})));
        Modelica.Blocks.Sources.Constant const1(k=0)
                                                    annotation (Placement(transformation(extent={{60,20},{40,40}})));
        Modelica.Blocks.Logical.GreaterThreshold greaterThreshold(threshold=0.0) annotation (Placement(transformation(extent={{-50,-10},{-30,10}})));
      equation
        connect(PID.y,y)  annotation (Line(points={{61,0},{110,0}}, color={0,0,127}));
        connect(const.y, switch1.u3) annotation (Line(points={{-9,-30},{-20,-30},{-20,-8},{-10,-8}},
                                                                                  color={0,0,127}));
        connect(switch1.y, PID.u_m) annotation (Line(points={{13,0},{20,0},{20,-14},{50,-14},{50,-12}}, color={0,0,127}));
        connect(add.u1, controlBus.TargetTemperature) annotation (Line(points={{-52,48},{-80,48},{-80,0},{-100,0}}, color={0,0,127}), Text(
            string="%second",
            index=1,
            extent={{-6,3},{-6,3}},
            horizontalAlignment=TextAlignment.Right));
        connect(add.u2, Temperature) annotation (Line(points={{-52,36},{-60,36},{-60,-94},{0,-94},{0,-120}}, color={0,0,127}));
        connect(add.y, switch1.u1) annotation (Line(points={{-29,42},{-16,42},{-16,8},{-10,8}}, color={0,0,127}));
        connect(const1.y, PID.u_s) annotation (Line(points={{39,30},{30,30},{30,0},{38,0}}, color={0,0,127}));
        connect(greaterThreshold.u, controlBus.Quenching) annotation (Line(points={{-52,0},{-100,0}}, color={0,0,127}), Text(
            string="%second",
            index=1,
            extent={{-6,3},{-6,3}},
            horizontalAlignment=TextAlignment.Right));
        connect(greaterThreshold.y, switch1.u2) annotation (Line(points={{-29,0},{-10,0}}, color={255,0,255}));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
              Rectangle(
                extent={{-100,100},{100,-100}},
                lineColor={0,0,0},
                lineThickness=0.5),
              Rectangle(
                extent={{10,20},{50,-20}},
                lineColor={0,0,0},
                lineThickness=0.5),
              Ellipse(
                extent={{-80,10},{-60,-10}},
                lineColor={0,0,0},
                lineThickness=0.5),
              Ellipse(
                extent={{-30,10},{-10,-10}},
                lineColor={0,0,0},
                lineThickness=0.5),
              Line(
                points={{-100,0},{-80,0}},
                color={0,0,0},
                thickness=0.5),
              Line(
                points={{-70,-10},{-70,-80},{0,-80},{0,-108}},
                color={0,0,0},
                thickness=0.5),
              Line(
                points={{-60,0},{-30,0}},
                color={0,0,0},
                thickness=0.5),
              Line(
                points={{-10,0},{10,0}},
                color={0,0,0},
                thickness=0.5),
              Line(
                points={{50,0},{100,0}},
                color={0,0,0},
                thickness=0.5),
              Line(
                points={{80,0},{80,-40},{-20,-40},{-20,-10}},
                color={0,0,0},
                thickness=0.5),
              Text(
                extent={{-90,100},{90,20}},
                lineColor={0,0,0},
                textString="Controller")}),                            Diagram(coordinateSystem(preserveAspectRatio=false)),
          Documentation(info="<html>
<p>Model to control the quenching unit to reach the target temperature</p>
</html>"));
      end QuenchingUnit_Controller;
    end QuenchingSystem;

    package VacuumSystem
      model InternalVolume
        parameter Modelica.Units.SI.Volume Volume "Volume within the oven";
        parameter Modelica.Units.SI.SpecificHeatCapacity R "Ideal gas constant of the volume within the oven";
        parameter Modelica.Units.SI.Pressure pressure_start "Start value for pressure within the oven";
        Modelica.Units.SI.Mass Mass(start=(pressure_start*Volume)/(R*T)) "Mass within the oven";
        Modelica.Units.SI.Pressure pressure(start=pressure_start) "Pressure within the oven";
        Modelica.Blocks.Interfaces.RealInput T "Temperature of the volume" annotation (quantity = "ThermodynamicTemperature", unit = "K", Placement(transformation(
              extent={{20,-20},{-20,20}},
              rotation=180,
              origin={-120,0})));
        Modelica.Blocks.Interfaces.RealInput m_gas_in "Gas mass flowing into the volume" annotation (Placement(transformation(
              extent={{-20,-20},{20,20}},
              rotation=90,
              origin={50,-120})));
        Modelica.Blocks.Interfaces.RealInput m_vacuumpump_out "Gas mass sucked out of the volume by the vacuum pump" annotation (Placement(transformation(
              extent={{-20,-20},{20,20}},
              rotation=90,
              origin={-50,-120})));
        Modelica.Blocks.Interfaces.RealOutput p "Pressure of the volume" annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=0,
              origin={110,0})));
      equation
        //mass balance
        der(Mass) = m_gas_in - m_vacuumpump_out;

        //ideal gas equation
        pressure * Volume = R * Mass * T;

        //output
        pressure = p;
        annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)),
          Documentation(info="<html>
<p>Internal volume of the oven, primarily used to control the operation of the vacuum pump. The internal volume of the oven is approximated with an constant ideal gas constant. Therefore, the pressure within the ideal volume of the oven is influenced by the mass, temperature and the geometry (p*V = R*M*T).</p>
</html>"));
      end InternalVolume;

      model VacuumPump
        Modelica.Blocks.Interfaces.RealInput p "Pressure on the suction side of the vacuum pump [Pa]"
                                               annotation (quantity = "ThermodynamicTemperature", unit = "K", Placement(transformation(
              extent={{20,-20},{-20,20}},
              rotation=270,
              origin={-50,-120})));
        Modelica.Blocks.Tables.CombiTable1Dv V_flow(table=[5,0; 6,0; 7,1/3600; 10,40/3600; 30,100/3600; 50,120/3600; 100,150/3600; 1000,200/3600; 10000,220/3600; 100000,280/3600]) "Possible volume-flow as a functino of absolute pressure at suction side of pumpe" annotation (Placement(transformation(extent={{-8,-30},{12,-10}})));
        Modelica.Blocks.Interfaces.RealInput T "Temperature on the suction side of the vacuum pump [K]" annotation (
          quantity="ThermodynamicTemperature",
          unit="K",
          Placement(transformation(
              extent={{20,-20},{-20,20}},
              rotation=270,
              origin={50,-120})));
        Modelica.Blocks.Math.Product product1 annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=180,
              origin={2,-80})));
        Modelica.Blocks.Math.Division rho annotation (Placement(transformation(extent={{-8,-60},{12,-40}})));
        Modelica.Blocks.Sources.Constant const(k=287) annotation (Placement(transformation(extent={{60,-84},{40,-64}})));
        Modelica.Blocks.Math.Product product2 annotation (Placement(transformation(
              extent={{10,-10},{-10,10}},
              rotation=180,
              origin={80,-50})));
        Modelica.Blocks.Interfaces.RealOutput P_el_vacuumpump "Electric power demand of vacuum pump [W]" annotation (Placement(transformation(extent={{100,40},{120,60}})));
        Modelica.Blocks.Interfaces.RealOutput m_vacuumpump_out "Mass flow of the vacuum pump [kg/s]" annotation (Placement(transformation(extent={{100,-60},{120,-40}})));
        Modelica.Blocks.Interfaces.BooleanInput u "On/Off signal of the vacuum pump [0;1]" annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
        Modelica.Blocks.Math.BooleanToReal booleanToReal annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
        Modelica.Blocks.Math.Product product3 annotation (Placement(transformation(
              extent={{10,-10},{-10,10}},
              rotation=180,
              origin={40,-20})));
        Modelica.Blocks.Math.Gain gain(k=10000) annotation (Placement(transformation(extent={{-10,40},{10,60}})));
      equation
        connect(V_flow.u[1], p) annotation (Line(points={{-10,-20},{-50,-20},{-50,-120}}, color={0,0,127}));
        connect(rho.u1, p) annotation (Line(points={{-10,-44},{-50,-44},{-50,-120}}, color={0,0,127}));
        connect(const.y, product1.u2) annotation (Line(points={{39,-74},{14,-74}}, color={0,0,127}));
        connect(product1.u1, T) annotation (Line(points={{14,-86},{50,-86},{50,-120}}, color={0,0,127}));
        connect(product1.y, rho.u2) annotation (Line(points={{-9,-80},{-30,-80},{-30,-56},{-10,-56}}, color={0,0,127}));
        connect(rho.y, product2.u1) annotation (Line(points={{13,-50},{24,-50},{24,-56},{68,-56}}, color={0,0,127}));
        connect(product2.y, m_vacuumpump_out) annotation (Line(points={{91,-50},{110,-50}}, color={0,0,127}));
        connect(booleanToReal.u, u) annotation (Line(points={{-82,0},{-120,0}}, color={255,0,255}));
        connect(V_flow.y[1], product3.u1) annotation (Line(points={{13,-20},{19.5,-20},{19.5,-26},{28,-26}}, color={0,0,127}));
        connect(booleanToReal.y, product3.u2) annotation (Line(points={{-59,0},{18,0},{18,-14},{28,-14}}, color={0,0,127}));
        connect(product3.y, product2.u2) annotation (Line(points={{51,-20},{60,-20},{60,-44},{68,-44}}, color={0,0,127}));
        connect(gain.y, P_el_vacuumpump) annotation (Line(points={{11,50},{58,50},{58,50},{110,50}}, color={0,0,127}));
        connect(gain.u, product3.u2) annotation (Line(points={{-12,50},{-30,50},{-30,0},{18,0},{18,-14},{28,-14}}, color={0,0,127}));
        annotation (
          Icon(coordinateSystem(preserveAspectRatio=false)),
          Diagram(coordinateSystem(preserveAspectRatio=false)),
          Documentation(info="<html>
<p>Model of a simple vacuum pump</p>
</html>"));
      end VacuumPump;

      model DummyVacuumSystem
        Modelica.Blocks.Interfaces.RealInput u "Regulating variable of quenching unit [0,1]"
                                               annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
        Modelica.Blocks.Interfaces.RealOutput P_el(quantity="Power", unit="W") "Electric power demand of vacuum system"
                                                                               annotation (Placement(transformation(extent={{100,-10},{120,10}})));
      equation
        connect(P_el, u) annotation (Line(points={{110,0},{-120,0}}, color={0,0,127}));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
              Rectangle(
                extent={{-100,100},{100,-100}},
                lineColor={0,0,0},
                lineThickness=0.5,
                fillColor={255,255,255},
                fillPattern=FillPattern.None),
              Ellipse(
                extent={{-60,60},{60,-60}},
                lineColor={0,0,0},
                lineThickness=0.5,
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid),
              Line(
                points={{-30,52},{56,20}},
                color={0,0,0},
                thickness=0.5),
              Line(
                points={{-30,-52},{56,-20}},
                color={0,0,0},
                thickness=0.5)}), Diagram(coordinateSystem(preserveAspectRatio=false)));
      end DummyVacuumSystem;

      model VacuumPump_Controller
        Modelica.Blocks.Interfaces.RealOutput y annotation (Placement(transformation(extent={{100,-10},{120,10}})));
        Modelica.Blocks.Examples.BusUsage_Utilities.Interfaces.ControlBus controlBus annotation (Placement(transformation(
              extent={{-20,-20},{20,20}},
              rotation=270,
              origin={-100,0}), iconTransformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={-100,0})));
      equation
        connect(y, controlBus.Vacuum) annotation (Line(points={{110,0},{-100,0}}, color={0,0,127}), Text(
            string="%second",
            index=1,
            extent={{-6,3},{-6,3}},
            horizontalAlignment=TextAlignment.Right));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
              Rectangle(
                extent={{-100,100},{100,-100}},
                lineColor={0,0,0},
                lineThickness=0.5),
              Line(
                points={{-98,0},{-30,0}},
                color={0,0,0},
                thickness=0.5),
              Line(
                points={{30,0},{100,0}},
                color={0,0,0},
                thickness=0.5),
              Text(
                extent={{-90,100},{90,20}},
                lineColor={0,0,0},
                textString="Controller"),
              Line(
                points={{4,18}},
                color={0,0,0},
                thickness=0.5),
              Line(
                points={{-16,-14}},
                color={0,0,0},
                thickness=0.5),
              Ellipse(
                extent={{-34,4},{-26,-4}},
                lineColor={0,0,0},
                lineThickness=0.5,
                fillColor={0,0,0},
                fillPattern=FillPattern.Solid),
              Ellipse(
                extent={{26,4},{34,-4}},
                lineColor={0,0,0},
                lineThickness=0.5,
                fillColor={0,0,0},
                fillPattern=FillPattern.Solid),
              Line(
                points={{-30,0},{20,34}},
                color={0,0,0},
                thickness=0.5)}),                                      Diagram(coordinateSystem(preserveAspectRatio=false)),
          Documentation(info="<html>
<p>Model to control the quenching unit to reach the target temperature</p>
</html>"));
      end VacuumPump_Controller;
    end VacuumSystem;

    package GascirculationSystem
      model DummyGascirculationSystem
        Modelica.Blocks.Interfaces.RealInput u "Regulating variable of quenching unit [0,1]"
                                               annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
        Modelica.Blocks.Interfaces.RealOutput P_el(quantity="Power", unit="W") "Electric power demand of gas circulation system"
                                                                               annotation (Placement(transformation(extent={{100,-10},{120,10}})));
      equation
        connect(u, P_el) annotation (Line(points={{-120,0},{110,0}}, color={0,0,127}));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
              Rectangle(
                extent={{-100,100},{100,-100}},
                lineColor={0,0,0},
                lineThickness=0.5,
                fillColor={255,255,255},
                fillPattern=FillPattern.None),
              Line(
                points={{-30,-23},{-23,2},{-1,22},{29,20},{21,4},{-15,-18},{-30,-23}},
                color={0,0,0},
                thickness=0.5,
                smooth=Smooth.Bezier,
                origin={-21,28},
                rotation=90),
              Line(
                points={{-31,-24},{-23,2},{-1,22},{29,20},{21,4},{-15,-18},{-31,-24}},
                color={0,0,0},
                thickness=0.5,
                smooth=Smooth.Bezier,
                origin={33,22},
                rotation=360),
              Line(
                points={{-30,-25},{-23,2},{-1,22},{29,20},{21,4},{-15,-18},{-30,-25}},
                color={0,0,0},
                thickness=0.5,
                smooth=Smooth.Bezier,
                origin={27,-32},
                rotation=270),
              Line(
                points={{-29,-26},{-23,2},{-1,22},{29,20},{21,4},{-15,-18},{-29,-26}},
                color={0,0,0},
                thickness=0.5,
                smooth=Smooth.Bezier,
                origin={-27,-28},
                rotation=180),
              Ellipse(
                extent={{-10,10},{12,-12}},
                lineColor={0,0,0},
                lineThickness=0.5,
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid)}), Diagram(coordinateSystem(preserveAspectRatio=false)));
      end DummyGascirculationSystem;

      model Gascirculation_Controller
        Modelica.Blocks.Interfaces.RealOutput y annotation (Placement(transformation(extent={{100,-10},{120,10}})));
        Modelica.Blocks.Examples.BusUsage_Utilities.Interfaces.ControlBus controlBus annotation (Placement(transformation(
              extent={{-20,-20},{20,20}},
              rotation=270,
              origin={-100,0}), iconTransformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={-100,0})));
      equation
        connect(y, controlBus.GasCirculation) annotation (Line(points={{110,0},{-100,0}}, color={0,0,127}), Text(
            string="%second",
            index=1,
            extent={{-6,3},{-6,3}},
            horizontalAlignment=TextAlignment.Right));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
              Rectangle(
                extent={{-100,100},{100,-100}},
                lineColor={0,0,0},
                lineThickness=0.5),
              Line(
                points={{-98,0},{-30,0}},
                color={0,0,0},
                thickness=0.5),
              Line(
                points={{30,0},{100,0}},
                color={0,0,0},
                thickness=0.5),
              Text(
                extent={{-90,100},{90,20}},
                lineColor={0,0,0},
                textString="Controller"),
              Line(
                points={{4,18}},
                color={0,0,0},
                thickness=0.5),
              Line(
                points={{-16,-14}},
                color={0,0,0},
                thickness=0.5),
              Ellipse(
                extent={{-34,4},{-26,-4}},
                lineColor={0,0,0},
                lineThickness=0.5,
                fillColor={0,0,0},
                fillPattern=FillPattern.Solid),
              Ellipse(
                extent={{26,4},{34,-4}},
                lineColor={0,0,0},
                lineThickness=0.5,
                fillColor={0,0,0},
                fillPattern=FillPattern.Solid),
              Line(
                points={{-30,0},{20,34}},
                color={0,0,0},
                thickness=0.5)}),                                      Diagram(coordinateSystem(preserveAspectRatio=false)),
          Documentation(info="<html>
<p>Model to control the quenching unit to reach the target temperature</p>
</html>"));
      end Gascirculation_Controller;
    end GascirculationSystem;

    package GasketcoolingSystem
      model Gasketcooling_Controller
        parameter Modelica.Units.SI.ThermodynamicTemperature T_target_gasket "Target temperature for gasketcooling";
        Modelica.Blocks.Logical.Switch switch1 annotation (Placement(transformation(extent={{-8,-10},{12,10}})));
        Modelica.Blocks.Continuous.LimPID PID(
          controllerType=Modelica.Blocks.Types.SimpleController.P,
          k=1,
          yMax=1,
          yMin=0) annotation (Placement(transformation(extent={{40,-10},{60,10}})));
        Modelica.Blocks.Interfaces.RealInput Temperature annotation (Placement(transformation(extent={{-20,-20},{20,20}},
              rotation=90,
              origin={0,-120})));
        Modelica.Blocks.Interfaces.RealOutput y annotation (Placement(transformation(extent={{100,-10},{120,10}})));
        Modelica.Blocks.Sources.Constant const(k=0) annotation (Placement(transformation(extent={{12,-40},{-8,-20}})));
        Modelica.Blocks.Examples.BusUsage_Utilities.Interfaces.ControlBus controlBus annotation (Placement(transformation(
              extent={{-20,-20},{20,20}},
              rotation=270,
              origin={-100,0}), iconTransformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={-100,0})));
        Modelica.Blocks.Math.Add add(k2=-1) annotation (Placement(transformation(extent={{-50,30},{-30,50}})));
        Modelica.Blocks.Sources.Constant const1(k=0)
                                                    annotation (Placement(transformation(extent={{60,20},{40,40}})));
        Modelica.Blocks.Sources.Constant const2(k=T_target_gasket)
                                                    annotation (Placement(transformation(extent={{-84,36},{-64,56}})));
        Modelica.Blocks.Logical.GreaterThreshold greaterThreshold(threshold=0.0) annotation (Placement(transformation(extent={{-50,-10},{-30,10}})));
      equation
        connect(PID.y,y)  annotation (Line(points={{61,0},{110,0}}, color={0,0,127}));
        connect(const.y, switch1.u3) annotation (Line(points={{-9,-30},{-20,-30},{-20,-8},{-10,-8}},
                                                                                  color={0,0,127}));
        connect(switch1.y, PID.u_m) annotation (Line(points={{13,0},{20,0},{20,-14},{50,-14},{50,-12}}, color={0,0,127}));
        connect(add.u2, Temperature) annotation (Line(points={{-52,34},{-60,34},{-60,-90},{0,-90},{0,-120}}, color={0,0,127}));
        connect(add.y, switch1.u1) annotation (Line(points={{-29,40},{-20,40},{-20,8},{-10,8}}, color={0,0,127}));
        connect(const1.y, PID.u_s) annotation (Line(points={{39,30},{30,30},{30,0},{38,0}}, color={0,0,127}));
        connect(const2.y, add.u1) annotation (Line(points={{-63,46},{-52,46}}, color={0,0,127}));
        connect(greaterThreshold.u, controlBus.GasketCooling) annotation (Line(points={{-52,0},{-100,0}}, color={0,0,127}), Text(
            string="%second",
            index=1,
            extent={{-6,3},{-6,3}},
            horizontalAlignment=TextAlignment.Right));
        connect(greaterThreshold.y, switch1.u2) annotation (Line(points={{-29,0},{-10,0}}, color={255,0,255}));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
              Rectangle(
                extent={{-100,100},{100,-100}},
                lineColor={0,0,0},
                lineThickness=0.5),
              Rectangle(
                extent={{10,20},{50,-20}},
                lineColor={0,0,0},
                lineThickness=0.5),
              Ellipse(
                extent={{-80,10},{-60,-10}},
                lineColor={0,0,0},
                lineThickness=0.5),
              Ellipse(
                extent={{-30,10},{-10,-10}},
                lineColor={0,0,0},
                lineThickness=0.5),
              Line(
                points={{-100,0},{-80,0}},
                color={0,0,0},
                thickness=0.5),
              Line(
                points={{-70,-10},{-70,-80},{0,-80},{0,-108}},
                color={0,0,0},
                thickness=0.5),
              Line(
                points={{-60,0},{-30,0}},
                color={0,0,0},
                thickness=0.5),
              Line(
                points={{-10,0},{10,0}},
                color={0,0,0},
                thickness=0.5),
              Line(
                points={{50,0},{100,0}},
                color={0,0,0},
                thickness=0.5),
              Line(
                points={{80,0},{80,-40},{-20,-40},{-20,-10}},
                color={0,0,0},
                thickness=0.5),
              Text(
                extent={{-90,100},{90,20}},
                lineColor={0,0,0},
                textString="Controller")}),                            Diagram(coordinateSystem(preserveAspectRatio=false)),
          Documentation(info="<html>
<p>Model to control the quenching unit to reach the target temperature</p>
</html>"));
      end Gasketcooling_Controller;

      model DummyGasketcooling
        parameter Modelica.Units.SI.Power P_th_nom "Nominal cooling power of gasketcooling system";
        Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow annotation (Placement(transformation(extent={{60,-10},{80,10}})));
        Modelica.Blocks.Math.Gain gain(k=P_th_nom)
                                       annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
        Modelica.Blocks.Math.Gain gain1(k=-1)
                                       annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
        Modelica.Blocks.Interfaces.RealInput u "Regulating variable of quenching unit [0,1]"
                                               annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a gasket_cooling "Thermal port of gasket cooling " annotation (Placement(transformation(extent={{90,-10},{110,10}})));
        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a central_cooling "Thermal port of central cooling" annotation (Placement(transformation(extent={{-10,90},{10,110}})));
        Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow1
                                                                                    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
              rotation=90,
              origin={0,50})));
      equation
        connect(prescribedHeatFlow.port, gasket_cooling) annotation (Line(points={{80,0},{100,0}}, color={191,0,0}));
        connect(gain.u,u)  annotation (Line(points={{-62,0},{-120,0}}, color={0,0,127}));
        connect(gain1.y,prescribedHeatFlow. Q_flow) annotation (Line(points={{11,0},{60,0}}, color={0,0,127}));
        connect(gain.y, gain1.u) annotation (Line(points={{-39,0},{-12,0}}, color={0,0,127}));
        connect(prescribedHeatFlow1.Q_flow, gain.y) annotation (Line(points={{0,40},{0,28},{-39,28},{-39,0}}, color={0,0,127}));
        connect(prescribedHeatFlow1.port, central_cooling) annotation (Line(points={{5.55112e-16,60},{0,100}}, color={191,0,0}));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
              Rectangle(
                extent={{-100,100},{100,-100}},
                lineColor={0,0,0},
                lineThickness=0.5),
              Line(
                points={{0,80},{0,-80},{0,-40},{20,-60},{0,-40},{-20,-60},{0,-40},{0,40},{20,60},{0,40},{-20,60},{0,40},{0,0},{-50,-50},{-30,-30},{-30,-50},{-30,-30},{-50,-30},{-30,-30},{50,50},{30,30},{50,30},{30,30},{30,50}},
                color={0,0,0},
                thickness=0.5),
              Line(
                points={{0,80},{0,-80},{0,-40},{20,-60},{0,-40},{-20,-60},{0,-40},{0,40},{20,60},{0,40},{-20,60},{0,40},{0,0},{-50,-50},{-30,-30},{-30,-50},{-30,-30},{-50,-30},{-30,-30},{50,50},{30,30},{50,30},{30,30},{30,50}},
                color={0,0,0},
                thickness=0.5,
                origin={0,0},
                rotation=90)}),                                        Diagram(coordinateSystem(preserveAspectRatio=false)),
          Documentation(info="<html>
<p>Simple model of quenching unit. As convective cooling is assumed, cooling power of the quenching unit is primarily influenced by the max. massflow, predominate temperature within the retort/oven and the predominate temperature in the hall.</p>
</html>"));
      end DummyGasketcooling;
    end GasketcoolingSystem;

    package WasteheatRecoverySystem
      model WasteHeatRecovery
        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a air annotation (Placement(transformation(extent={{-10,-110},{10,-90}})));
        Modelica.Blocks.Interfaces.RealInput T_air(quantity="ThermodynamicTemperature", unit="K") annotation (Placement(transformation(extent={{-140,30},{-100,70}})));
        Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(T=283.15) annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=270,
              origin={0,-50})));
        parameter Modelica.Units.SI.ThermodynamicTemperature T_target=373.15 "Target flow temperature of liquid medium after waste heat recovery. Target temperature should be below exhaust gas temperature, otherwise no mass flow is present";
        parameter Boolean use_WasteHeatRecovery "Boolean parameter to determine wheter waste heat recovery is used";
        Modelica.Units.SI.Power P_th_wasteHeatRecovered "Recovered thermal power";
        Modelica.Units.SI.Power P_th_wasteHeatDissipated "Dissipated thermal power";
        Modelica.Blocks.Interfaces.RealInput T_fluid_inlet(quantity="ThermodynamicTemperature", unit="K") annotation (Placement(transformation(extent={{-140,-70},{-100,-30}})));
        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a recovered "Thermal port for recovered thermal power" annotation (Placement(transformation(extent={{90,40},{110,60}})));
        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a dissipated "Thermal port for dissipated thermal power" annotation (Placement(transformation(extent={{90,-60},{110,-40}})));
        Modelica.Blocks.Sources.RealExpression realExpression(y=P_th_wasteHeatRecovered)
                                                              annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=0,
              origin={38,50})));
        Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=0,
              origin={70,50})));
        Modelica.Blocks.Sources.RealExpression realExpression1(y=P_th_wasteHeatDissipated)
                                                              annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=0,
              origin={38,-50})));
        Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow1
                                                                                    annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=0,
              origin={70,-50})));
        Modelica.Blocks.Interfaces.RealInput T_hall(quantity="ThermodynamicTemperature", unit="K")
                                                                                                  annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
      equation
        // calculate recovered wasteheat depending on predominant/required temperatur levels
        P_th_wasteHeatRecovered =if use_WasteHeatRecovery and T_air >= T_target then ((T_air - T_target)/max(1, (T_air - T_hall))) * air.Q_flow else 0;
        // calculate dissipated wasteheat depending on available and recovered wasteheat
        P_th_wasteHeatDissipated =air.Q_flow - P_th_wasteHeatRecovered;

        connect(fixedTemperature.port, air) annotation (Line(points={{0,-60},{0,-100}}, color={191,0,0}));
        connect(realExpression.y, prescribedHeatFlow.Q_flow) annotation (Line(points={{49,50},{60,50}}, color={0,0,127}));
        connect(prescribedHeatFlow.port, recovered) annotation (Line(points={{80,50},{100,50}}, color={191,0,0}));
        connect(realExpression1.y, prescribedHeatFlow1.Q_flow) annotation (Line(points={{49,-50},{60,-50}}, color={0,0,127}));
        connect(prescribedHeatFlow1.port, dissipated) annotation (Line(points={{80,-50},{100,-50}}, color={191,0,0}));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
              Rectangle(
                extent={{-100,100},{100,-100}},
                lineColor={0,0,0},
                lineThickness=0.5),
              Line(
                points={{14,46},{-16,16},{4,-24},{-26,-54},{14,-24},{-6,16},{14,46}},
                color={0,0,0},
                thickness=0.5,
                smooth=Smooth.Bezier),
              Line(
                points={{38,46},{8,16},{28,-24},{-2,-54},{38,-24},{18,16},{38,46}},
                color={0,0,0},
                thickness=0.5,
                smooth=Smooth.Bezier),
              Line(
                points={{-10,46},{-40,16},{-20,-24},{-50,-54},{-10,-24},{-30,16},{-10,46}},
                color={0,0,0},
                thickness=0.5,
                smooth=Smooth.Bezier),
              Ellipse(
                extent={{-70,70},{70,-70}},
                lineColor={0,0,0},
                lineThickness=0.5),
              Line(
                points={{0,70},{-10,80},{0,70},{-10,60}},
                color={0,0,0},
                thickness=0.5),
              Line(
                points={{5,0},{-5,10},{5,0},{-5,-10}},
                color={0,0,0},
                thickness=0.5,
                origin={5,-70},
                rotation=180)}),                                       Diagram(coordinateSystem(preserveAspectRatio=false)));
      end WasteHeatRecovery;
    end WasteheatRecoverySystem;

    package ProcessController
      model ProcessController
        parameter Real ProcessingProgramm1_chronological_log[:,2]=[0,1; 1801,2; 3601,3; 4001,4; 4601,5]
                                                                 "Table which defines the chronological log a the sub programms for a specific processing programm. Each timestamp (column 1) represents the starting time of the corresponding sub program (column 2).";
        parameter Real ProcessingProgramm1_TemperatureTimeseries[:,2]=[0,573.15; 1800,573.15; 1801,723.15; 3600,723.15; 3601,373.15; 4000,373.15; 4001,293.15; 4600,293.15]
                                                                                        "Table which defines the temperature profilfor a specific processing programm.";
        parameter Real ProcessingProgramm1[:,8] = [0, 1, 0, 0, 0, 0, 0, 0; 1, 1, 0, 0, 0, 0, 0, 0; 2, 1, 0, 0, 0, 0, 0, 0; 3, 0, 1, 0, 0, 0, 0, 0; 4, 0, 0, 1, 0, 0, 0, 0] "Table which defines whether components are active depending on the predominant sub programm.";

        parameter Real ProcessingProgramm2_chronological_log[:,2]=[0,1; 1801,2; 3601,3; 4001,4; 4601,5]
                                                                 "Table which defines the chronological log a the sub programms for a specific processing programm. Each timestamp (column 1) represents the starting time of the corresponding sub program (column 2).";
        parameter Real ProcessingProgramm2_TemperatureTimeseries[:,2]=[0,573.15; 1800,573.15; 1801,623.15; 3600,623.15; 3601,523.15; 4000,523.15; 4001,293.15; 4600,293.15]
                                                                                        "Table which defines the temperature profilfor a specific processing programm.";
        parameter Real ProcessingProgramm2[:,8] = [0, 1, 0, 0, 0, 0, 0, 0; 1, 1, 0, 0, 0, 0, 0, 0; 2, 1, 0, 0, 0, 0, 0, 0; 3, 0, 1, 0, 0, 0, 0, 0; 4, 0, 0, 1, 0, 0, 0, 0] "Table which defines whether components are active depending on the predominant sub programm.";
        parameter Real ProcessingProgramm3_chronological_log[:,2]=[0,1; 901,2; 1801,3; 2701,4; 3601,5]
                                                                 "Table which defines the chronological log a the sub programms for a specific processing programm. Each timestamp (column 1) represents the starting time of the corresponding sub program (column 2).";
        parameter Real ProcessingProgramm3_TemperatureTimeseries[:,2]=[0,573.15; 900,573.15; 901,623.15; 1800,623.15; 1801,523.15; 2700,523.15; 2701,293.15; 3600,293.15]
                                                                                        "Table which defines the temperature profilfor a specific processing programm.";
        parameter Real ProcessingProgramm3[:,8] = [0, 1, 0, 0, 0, 0, 0, 0; 1, 1, 0, 0, 0, 0, 0, 0; 2, 1, 0, 0, 0, 0, 0, 0; 3, 0, 1, 0, 0, 0, 0, 0; 4, 0, 0, 1, 0, 0, 0, 0] "Table which defines whether components are active depending on the predominant sub programm.";

        Modelica.Blocks.Interfaces.IntegerInput OperatingMode "Operating mode as defined by VDMA [working, standby, etc.]"
                                                              annotation (Placement(transformation(extent={{-240,80},{-200,120}})));
        Modelica.Blocks.Interfaces.IntegerInput ProcessingProgramm "A processing programm defines a workpiece-specific programm (e.g. temperature profile)" annotation (Placement(transformation(extent={{-240,-120},{-200,-80}})));
        Modelica.Blocks.Examples.BusUsage_Utilities.Interfaces.ControlBus controlBus annotation (Placement(transformation(
              extent={{-20,-20},{20,20}},
              rotation=270,
              origin={200,0}), iconTransformation(
              extent={{-10,-10},{10,10}},
              rotation=270,
              origin={200,0})));
        Modelica.Blocks.Sources.BooleanExpression booleanExpression(y=if noEvent(OperatingMode == 3 and ProcessingProgramm == 1) then true else false) annotation (Placement(transformation(extent={{-94,160},{-74,180}})));
        Modelica.Blocks.Sources.BooleanExpression booleanExpression1(y=if noEvent(OperatingMode == 3 and ProcessingProgramm == 2) then true else false) annotation (Placement(transformation(extent={{-94,130},{-74,150}})));
        Modelica.Blocks.Sources.BooleanExpression booleanExpression2(y=if noEvent(OperatingMode == 3 and ProcessingProgramm == 3) then true else false) annotation (Placement(transformation(extent={{-94,100},{-74,120}})));
        Working_to_SubProgramm_and_TargetTemperature working_to_SubProgramm_and_TargetTemperature(ProcessingProgramm_chronological_log=ProcessingProgramm1_chronological_log, ProcessingProgramm_TemperatureTimeseries=ProcessingProgramm1_TemperatureTimeseries)
                                                                                                  annotation (Placement(transformation(extent={{-50,160},{-30,180}})));
        Working_to_SubProgramm_and_TargetTemperature working_to_SubProgramm_and_TargetTemperature1(ProcessingProgramm_chronological_log=ProcessingProgramm2_chronological_log, ProcessingProgramm_TemperatureTimeseries=ProcessingProgramm2_TemperatureTimeseries)
                                                                                                   annotation (Placement(transformation(extent={{-50,130},{-30,150}})));
        Working_to_SubProgramm_and_TargetTemperature working_to_SubProgramm_and_TargetTemperature2(ProcessingProgramm_chronological_log=ProcessingProgramm3_chronological_log, ProcessingProgramm_TemperatureTimeseries=ProcessingProgramm3_TemperatureTimeseries)
                                                                                                   annotation (Placement(transformation(extent={{-50,100},{-30,120}})));
        Modelica.Blocks.Sources.RealExpression TargetTemperature(y=mux.y[ProcessingProgramm])     annotation (Placement(transformation(extent={{48,130},{68,150}})));
        Modelica.Blocks.Routing.Multiplex mux(n=3) annotation (Placement(transformation(extent={{18,160},{38,180}})));
        Modelica.Blocks.Routing.Multiplex mux1(n=3) annotation (Placement(transformation(extent={{18,100},{38,120}})));
        Modelica.Blocks.Sources.RealExpression SubProgramm(y=mux1.y[ProcessingProgramm])     annotation (Placement(transformation(extent={{-180,20},{-160,40}})));
        Modelica.Blocks.Routing.Extractor extractor(nin=3)
                                                    annotation (Placement(transformation(extent={{18,60},{38,80}})));
        Modelica.Blocks.Routing.Extractor extractor1(nin=3)
                                                     annotation (Placement(transformation(extent={{18,20},{38,40}})));
        Modelica.Blocks.Routing.Extractor extractor2(nin=3)
                                                     annotation (Placement(transformation(extent={{18,-20},{38,0}})));
        Modelica.Blocks.Tables.CombiTable1Ds ProcessingProgramm_1_is_active(table=ProcessingProgramm1)           annotation (Placement(transformation(extent={{-140,60},{-120,80}})));
        Modelica.Blocks.Tables.CombiTable1Ds ProcessingProgramm_2_is_active(table=ProcessingProgramm2)           annotation (Placement(transformation(extent={{-140,20},{-120,40}})));
        Modelica.Blocks.Tables.CombiTable1Ds ProcessingProgramm_3_is_active(table=ProcessingProgramm3)           annotation (Placement(transformation(extent={{-140,-20},{-120,0}})));
        Modelica.Blocks.Routing.Extractor extractor3(nin=3)
                                                     annotation (Placement(transformation(extent={{18,-60},{38,-40}})));
        Modelica.Blocks.Routing.Extractor extractor4(nin=3)
                                                     annotation (Placement(transformation(extent={{18,-100},{38,-80}})));
        Modelica.Blocks.Routing.Extractor extractor5(nin=3)
                                                     annotation (Placement(transformation(extent={{18,-140},{38,-120}})));
        Modelica.Blocks.Routing.Extractor extractor6(nin=3)
                                                     annotation (Placement(transformation(extent={{18,-180},{38,-160}})));
        Modelica.Blocks.Routing.Multiplex3 multiplex3_1 annotation (Placement(transformation(extent={{-50,60},{-30,80}})));
        Modelica.Blocks.Routing.Multiplex3 multiplex3_2 annotation (Placement(transformation(extent={{-50,20},{-30,40}})));
        Modelica.Blocks.Routing.Multiplex3 multiplex3_3 annotation (Placement(transformation(extent={{-50,-20},{-30,0}})));
        Modelica.Blocks.Routing.Multiplex3 multiplex3_4 annotation (Placement(transformation(extent={{-50,-140},{-30,-120}})));
        Modelica.Blocks.Routing.Multiplex3 multiplex3_5 annotation (Placement(transformation(extent={{-50,-100},{-30,-80}})));
        Modelica.Blocks.Routing.Multiplex3 multiplex3_6 annotation (Placement(transformation(extent={{-50,-60},{-30,-40}})));
        Modelica.Blocks.Routing.Multiplex3 multiplex3_7 annotation (Placement(transformation(extent={{-50,-180},{-30,-160}})));
      equation
        connect(booleanExpression.y, working_to_SubProgramm_and_TargetTemperature.Working) annotation (Line(points={{-73,170},{-52,170}},
                                                                                                                                        color={255,0,255}));
        connect(booleanExpression1.y, working_to_SubProgramm_and_TargetTemperature1.Working) annotation (Line(points={{-73,140},{-52,140}},
                                                                                                                                          color={255,0,255}));
        connect(booleanExpression2.y, working_to_SubProgramm_and_TargetTemperature2.Working) annotation (Line(points={{-73,110},{-52,110}},
                                                                                                                                          color={255,0,255}));
        connect(TargetTemperature.y, controlBus.TargetTemperature) annotation (Line(points={{69,140},{180,140},{180,0},{200,0}},
                                                                                                                             color={0,0,127}), Text(
            string="%second",
            index=1,
            extent={{-6,3},{-6,3}},
            horizontalAlignment=TextAlignment.Right));
        connect(working_to_SubProgramm_and_TargetTemperature.TargetTemperature, mux.u[1]) annotation (Line(points={{-29,165},{17.5,165},{17.5,174.667},{18,174.667}},
                                                                                                                                                                   color={0,0,127}));
        connect(working_to_SubProgramm_and_TargetTemperature1.TargetTemperature, mux.u[2]) annotation (Line(points={{-29,135},{12,135},{12,170},{18,170}},
                                                                                                                                                      color={0,0,127}));
        connect(working_to_SubProgramm_and_TargetTemperature2.TargetTemperature, mux.u[3]) annotation (Line(points={{-29,105},{8,105},{8,165.333},{18,165.333}},color={0,0,127}));
        connect(working_to_SubProgramm_and_TargetTemperature.SubProgramm, mux1.u[1]) annotation (Line(points={{-29,175},{4,175},{4,114.667},{18,114.667}},color={0,0,127}));
        connect(working_to_SubProgramm_and_TargetTemperature1.SubProgramm, mux1.u[2]) annotation (Line(points={{-29,145},{0,145},{0,110},{18,110}},
                                                                                                                                                 color={0,0,127}));
        connect(working_to_SubProgramm_and_TargetTemperature2.SubProgramm, mux1.u[3]) annotation (Line(points={{-29,115},{-4,115},{-4,105.333},{18,105.333}},
                                                                                                                                                           color={0,0,127}));
        connect(ProcessingProgramm, extractor.index) annotation (Line(points={{-220,-100},{-182,-100},{-182,50},{28,50},{28,58}},color={255,127,0}));
        connect(extractor1.index, ProcessingProgramm) annotation (Line(points={{28,18},{28,10},{-182,10},{-182,-100},{-220,-100}},color={255,127,0}));
        connect(extractor3.index, ProcessingProgramm) annotation (Line(points={{28,-62},{28,-70},{-182,-70},{-182,-100},{-220,-100}},
                                                                                                                                    color={255,127,0}));
        connect(extractor4.index, ProcessingProgramm) annotation (Line(points={{28,-102},{28,-110},{-182,-110},{-182,-100},{-220,-100}},
                                                                                                                                    color={255,127,0}));
        connect(extractor5.index, ProcessingProgramm) annotation (Line(points={{28,-142},{28,-150},{-182,-150},{-182,-100},{-220,-100}},
                                                                                                                                    color={255,127,0}));
        connect(extractor6.index, ProcessingProgramm) annotation (Line(points={{28,-182},{28,-190},{-182,-190},{-182,-100},{-220,-100}},
                                                                                                                                    color={255,127,0}));
        connect(extractor2.index, ProcessingProgramm) annotation (Line(points={{28,-22},{28,-32},{-182,-32},{-182,-100},{-220,-100}}, color={255,127,0}));
        connect(SubProgramm.y, ProcessingProgramm_2_is_active.u) annotation (Line(points={{-159,30},{-142,30}}, color={0,0,127}));
        connect(ProcessingProgramm_1_is_active.u, ProcessingProgramm_2_is_active.u) annotation (Line(points={{-142,70},{-150,70},{-150,30},{-142,30}}, color={0,0,127}));
        connect(ProcessingProgramm_3_is_active.u, ProcessingProgramm_2_is_active.u) annotation (Line(points={{-142,-10},{-150,-10},{-150,30},{-142,30}}, color={0,0,127}));
        connect(ProcessingProgramm_1_is_active.y[1], multiplex3_1.u1[1]) annotation (Line(points={{-119,70},{-110,70},{-110,77},{-52,77}}, color={0,0,127}));
        connect(multiplex3_2.y, extractor1.u) annotation (Line(points={{-29,30},{16,30}}, color={0,0,127}));
        connect(ProcessingProgramm_1_is_active.y[2], multiplex3_2.u1[1]) annotation (Line(points={{-119,70},{-110,70},{-110,37},{-52,37}}, color={0,0,127}));
        connect(ProcessingProgramm_1_is_active.y[3], multiplex3_3.u1[1]) annotation (Line(points={{-119,70},{-110,70},{-110,-2},{-52,-2},{-52,-3}}, color={0,0,127}));
        connect(ProcessingProgramm_1_is_active.y[4], multiplex3_6.u1[1]) annotation (Line(points={{-119,70},{-110,70},{-110,-43},{-52,-43}}, color={0,0,127}));
        connect(ProcessingProgramm_1_is_active.y[5], multiplex3_5.u1[1]) annotation (Line(points={{-119,70},{-110,70},{-110,-82},{-52,-82},{-52,-83}}, color={0,0,127}));
        connect(ProcessingProgramm_1_is_active.y[6], multiplex3_4.u1[1]) annotation (Line(points={{-119,70},{-110,70},{-110,-123},{-52,-123}}, color={0,0,127}));
        connect(ProcessingProgramm_1_is_active.y[7], multiplex3_7.u1[1]) annotation (Line(points={{-119,70},{-110,70},{-110,-163},{-52,-163}}, color={0,0,127}));
        connect(ProcessingProgramm_2_is_active.y[1], multiplex3_1.u2[1]) annotation (Line(points={{-119,30},{-100,30},{-100,70},{-52,70}}, color={0,0,127}));
        connect(ProcessingProgramm_2_is_active.y[2], multiplex3_2.u2[1]) annotation (Line(points={{-119,30},{-52,30}}, color={0,0,127}));
        connect(ProcessingProgramm_2_is_active.y[3], multiplex3_3.u2[1]) annotation (Line(points={{-119,30},{-100,30},{-100,-10},{-52,-10}}, color={0,0,127}));
        connect(ProcessingProgramm_2_is_active.y[4], multiplex3_6.u2[1]) annotation (Line(points={{-119,30},{-100,30},{-100,-50},{-52,-50}}, color={0,0,127}));
        connect(ProcessingProgramm_2_is_active.y[5], multiplex3_5.u2[1]) annotation (Line(points={{-119,30},{-100,30},{-100,-90},{-52,-90}}, color={0,0,127}));
        connect(ProcessingProgramm_2_is_active.y[6], multiplex3_4.u2[1]) annotation (Line(points={{-119,30},{-100,30},{-100,-130},{-52,-130}}, color={0,0,127}));
        connect(ProcessingProgramm_2_is_active.y[7], multiplex3_7.u2[1]) annotation (Line(points={{-119,30},{-100,30},{-100,-170},{-52,-170}}, color={0,0,127}));
        connect(ProcessingProgramm_3_is_active.y[1], multiplex3_1.u3[1]) annotation (Line(points={{-119,-10},{-90,-10},{-90,63},{-52,63}}, color={0,0,127}));
        connect(ProcessingProgramm_3_is_active.y[2], multiplex3_2.u3[1]) annotation (Line(points={{-119,-10},{-90,-10},{-90,23},{-52,23}}, color={0,0,127}));
        connect(ProcessingProgramm_3_is_active.y[3], multiplex3_3.u3[1]) annotation (Line(points={{-119,-10},{-90,-10},{-90,-17},{-52,-17}}, color={0,0,127}));
        connect(ProcessingProgramm_3_is_active.y[4], multiplex3_6.u3[1]) annotation (Line(points={{-119,-10},{-90,-10},{-90,-57},{-52,-57}}, color={0,0,127}));
        connect(ProcessingProgramm_3_is_active.y[5], multiplex3_5.u3[1]) annotation (Line(points={{-119,-10},{-90,-10},{-90,-97},{-52,-97}}, color={0,0,127}));
        connect(ProcessingProgramm_3_is_active.y[6], multiplex3_4.u3[1]) annotation (Line(points={{-119,-10},{-90,-10},{-90,-137},{-52,-137}}, color={0,0,127}));
        connect(ProcessingProgramm_3_is_active.y[7], multiplex3_7.u3[1]) annotation (Line(points={{-119,-10},{-90,-10},{-90,-177},{-52,-177}}, color={0,0,127}));
        connect(multiplex3_3.y, extractor2.u) annotation (Line(points={{-29,-10},{16,-10}}, color={0,0,127}));
        connect(multiplex3_6.y, extractor3.u) annotation (Line(points={{-29,-50},{16,-50}}, color={0,0,127}));
        connect(multiplex3_5.y, extractor4.u) annotation (Line(points={{-29,-90},{16,-90}}, color={0,0,127}));
        connect(multiplex3_4.y, extractor5.u) annotation (Line(points={{-29,-130},{16,-130}}, color={0,0,127}));
        connect(multiplex3_7.y, extractor6.u) annotation (Line(points={{-29,-170},{16,-170}}, color={0,0,127}));
        connect(multiplex3_1.y, extractor.u) annotation (Line(points={{-29,70},{16,70}}, color={0,0,127}));
        connect(extractor3.y, controlBus.Vacuum) annotation (Line(points={{39,-50},{80,-50},{80,0},{200,0}}, color={0,0,127}), Text(
            string="%second",
            index=1,
            extent={{6,3},{6,3}},
            horizontalAlignment=TextAlignment.Left));
        connect(extractor4.y, controlBus.GasCirculation) annotation (Line(points={{39,-90},{80,-90},{80,0},{200,0}}, color={0,0,127}), Text(
            string="%second",
            index=1,
            extent={{6,3},{6,3}},
            horizontalAlignment=TextAlignment.Left));
        connect(extractor5.y, controlBus.GasBurner) annotation (Line(points={{39,-130},{80,-130},{80,0},{200,0}}, color={0,0,127}), Text(
            string="%second",
            index=1,
            extent={{6,3},{6,3}},
            horizontalAlignment=TextAlignment.Left));
        connect(extractor.y, controlBus.Heating) annotation (Line(points={{39,70},{80,70},{80,0},{200,0}}, color={0,0,127}), Text(
            string="%second",
            index=1,
            extent={{6,3},{6,3}},
            horizontalAlignment=TextAlignment.Left));
        connect(extractor1.y, controlBus.Quenching) annotation (Line(points={{39,30},{80,30},{80,0},{200,0}}, color={0,0,127}), Text(
            string="%second",
            index=1,
            extent={{6,3},{6,3}},
            horizontalAlignment=TextAlignment.Left));
        connect(extractor2.y, controlBus.DoorIsOpen) annotation (Line(points={{39,-10},{80,-10},{80,0},{200,0}}, color={0,0,127}), Text(
            string="%second",
            index=1,
            extent={{6,3},{6,3}},
            horizontalAlignment=TextAlignment.Left));
        connect(extractor6.y, controlBus.GasketCooling) annotation (Line(points={{39,-170},{80,-170},{80,0},{200,0}}, color={0,0,127}), Text(
            string="%second",
            index=1,
            extent={{6,3},{6,3}},
            horizontalAlignment=TextAlignment.Left));
        connect(ProcessingProgramm, controlBus.ProcessingProgram) annotation (Line(points={{-220,-100},{158,-100},{158,0},{200,0}}, color={255,127,0}), Text(
            string="%second",
            index=1,
            extent={{6,3},{6,3}},
            horizontalAlignment=TextAlignment.Left));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-200,-200},{200,200}}), graphics={Text(
                extent={{-180,200},{180,-200}},
                lineColor={0,0,0},
                textString="PLC"), Rectangle(
                extent={{-200,200},{200,-200}},
                lineColor={0,0,0},
                lineThickness=0.5)}),                                  Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-200,-200},{200,200}})),
          Documentation(info="<html>
<p>Within the process controller model, the operating mode and processing programm are transferred to relevant values which are necessary to describe the process (e.g. temperature profil or bool signals for the specific components). For that, several submoduls are utilized.</p>
</html>"));
      end ProcessController;

      model Working_to_SubProgramm
        Modelica.Blocks.Interfaces.BooleanInput Working "Boolean input signal of operating mode \"Working\""                 annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
        Modelica.Blocks.Tables.CombiTable1Dv combiTable1D(table=ProcessingProgramm_chronological_log, smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments) annotation (Placement(transformation(extent={{-10,-80},{10,-60}})));
        Modelica.Blocks.Logical.Timer timer annotation (Placement(transformation(extent={{-50,-80},{-30,-60}})));
        Modelica.StateGraph.TransitionWithSignal transitionWithSignal annotation (Placement(transformation(extent={{-40,40},{-20,60}})));
        Modelica.StateGraph.InitialStep initialStep(nIn=1, nOut=1)
                                                    annotation (Placement(transformation(extent={{-80,40},{-60,60}})));
        Modelica.StateGraph.StepWithSignal stepWithSignal(nIn=1, nOut=1)
                                                          annotation (Placement(transformation(extent={{20,40},{40,60}})));
        Modelica.Blocks.Interfaces.IntegerOutput SubProgramm "Defines which sub programm is currently active. A sub programm is a subset of a processing programm"  annotation (Placement(transformation(extent={{100,-10},{120,10}})));
        Modelica.Blocks.Math.RealToInteger realToInteger annotation (Placement(transformation(extent={{60,-60},{80,-40}})));
        Modelica.StateGraph.Transition WaitTimeseriesDuration(enableTimer=true, waitTime=combiTable1D.table[size(combiTable1D.table, 1), 1]) annotation (Placement(transformation(extent={{60,60},{80,80}})));
        Modelica.StateGraph.Alternative alternative annotation (Placement(transformation(extent={{60,40},{80,60}})));
        Modelica.StateGraph.TransitionWithSignal Kill annotation (Placement(transformation(extent={{60,20},{80,40}})));
        Modelica.Blocks.MathBoolean.FallingEdge falling1 annotation (Placement(transformation(extent={{-4,-4},{4,4}},
              rotation=90,
              origin={70,10})));
        parameter Real ProcessingProgramm_chronological_log[:,2] "Table which defines the chronological log a the sub programms for a specific processing programm ";
        Modelica.Blocks.Logical.Switch switch1 annotation (Placement(transformation(extent={{30,-40},{50,-60}})));
        Modelica.Blocks.Sources.Constant const(k=0) annotation (Placement(transformation(extent={{-10,-40},{10,-20}})));
      equation
        connect(timer.y, combiTable1D.u[1]) annotation (Line(points={{-29,-70},{-12,-70}}, color={0,0,127}));
        connect(transitionWithSignal.condition, Working) annotation (Line(points={{-30,38},{-30,0},{-120,0}}, color={255,0,255}));
        connect(initialStep.outPort[1], transitionWithSignal.inPort) annotation (Line(points={{-59.5,50},{-34,50}}, color={0,0,0}));
        connect(transitionWithSignal.outPort, stepWithSignal.inPort[1]) annotation (Line(points={{-28.5,50},{19,50}}, color={0,0,0}));
        connect(WaitTimeseriesDuration.inPort,alternative. split[1]) annotation (Line(points={{66,70},{62.1,70},{62.1,50}}, color={0,0,0}));
        connect(WaitTimeseriesDuration.outPort,alternative. join[1]) annotation (Line(points={{71.5,70},{77.9,70},{77.9,50}}, color={0,0,0}));
        connect(Kill.inPort,alternative. split[2]) annotation (Line(points={{66,30},{62.1,30},{62.1,50}}, color={0,0,0}));
        connect(Kill.outPort,alternative. join[2]) annotation (Line(points={{71.5,30},{77.9,30},{77.9,50}}, color={0,0,0}));
        connect(stepWithSignal.outPort[1], alternative.inPort) annotation (Line(points={{40.5,50},{59.7,50}}, color={0,0,0}));
        connect(alternative.outPort, initialStep.inPort[1]) annotation (Line(points={{80.2,50},{90,50},{90,90},{-90,90},{-90,50},{-81,50}}, color={0,0,0}));
        connect(Kill.condition, falling1.y) annotation (Line(points={{70,18},{70,14.8}}, color={255,0,255}));
        connect(falling1.u, Working) annotation (Line(points={{70,4.4},{70,0},{-120,0}}, color={255,0,255}));
        connect(stepWithSignal.active, timer.u) annotation (Line(
            points={{30,39},{30,-10},{-70,-10},{-70,-70},{-52,-70}},
            color={255,0,255},
            pattern=LinePattern.Dash));
        connect(switch1.y, realToInteger.u) annotation (Line(points={{51,-50},{58,-50}}, color={0,0,127}));
        connect(combiTable1D.y[1], switch1.u1) annotation (Line(points={{11,-70},{20,-70},{20,-58},{28,-58}}, color={0,0,127}));
        connect(const.y, switch1.u3) annotation (Line(points={{11,-30},{20,-30},{20,-42},{28,-42}}, color={0,0,127}));
        connect(switch1.u2, Working) annotation (Line(points={{28,-50},{-30,-50},{-30,0},{-120,0}}, color={255,0,255}));
        connect(realToInteger.y, SubProgramm) annotation (Line(points={{81,-50},{90,-50},{90,0},{110,0}}, color={255,127,0}));
        annotation (
          Icon(coordinateSystem(preserveAspectRatio=false)),
          Diagram(coordinateSystem(preserveAspectRatio=false)),
          Documentation(info="<html>
<p>This model converts a boolean input signal &quot;<b>Working</b>&quot; (Operating Mode) into a integer output signal &quot;<b>SubProgramm</b>&quot;. The &quot;<b>SubProgramm</b>&quot; is a part of the so-called &quot;<b>ProcessingProgramm</b>&quot;. Based on the example of an annealing oven, a &quot;<b>SubProgramm</b>&quot; can be &quot;heat up&quot;, &quot;hold&quot; or &quot;cool down&quot;. The chronological log a the &quot;<b>SubProgramm</b>&quot; is defined via an array where the first column represents the timestamps where the specific &quot;<b>SubProgramm</b>&quot;, represented by integer entries, starts. While &quot;<b>Working</b>&quot; is true, the chronological log of the &quot;<b>SubProgramm</b>&quot; is looped. If &quot;<b>Working</b>&quot; changes to false, the &quot;<b>SubProgramm</b>&quot; will stop even if it is not finished.</p>
</html>"));
      end Working_to_SubProgramm;

      model TargetTemperature
        Modelica.Blocks.Interfaces.IntegerInput SubProgramm "Input signal of the corresponding subprogramm"
                                                            annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
        Modelica.Blocks.Interfaces.RealOutput TargetTemperature "Target temperatur which should be predominate in the oven [K]"
                                                                annotation (Placement(transformation(extent={{100,-10},{120,10}})));
        TemperatureTimeseries temperatureTimeseries(SubProgramm_TemperatureTimeseries=SubProgramm1_TemperatureTimeseries)
                                                    annotation (Placement(transformation(extent={{-10,80},{10,100}})));
        SubprogrammIsActive subprogrammIsActive(SubProgramm_=1) annotation (Placement(transformation(extent={{-60,80},{-40,100}})));
        parameter Real ProcessingProgramm_chronological_log[:,2] "Table which defines the chronological log a the sub programms for a specific processing programm ";
        parameter Real SubProgramm1_TemperatureTimeseries[:,2];
        parameter Real SubProgramm2_TemperatureTimeseries[:,2];
        parameter Real SubProgramm3_TemperatureTimeseries[:,2];
        parameter Real SubProgramm4_TemperatureTimeseries[:,2];
        parameter Real SubProgramm5_TemperatureTimeseries[:,2];
        parameter Real SubProgramm6_TemperatureTimeseries[:,2];
        parameter Real SubProgramm7_TemperatureTimeseries[:,2];
        parameter Real SubProgramm8_TemperatureTimeseries[:,2];
        parameter Real SubProgramm9_TemperatureTimeseries[:,2];
        parameter Real SubProgramm10_TemperatureTimeseries[:,2];
        TemperatureTimeseries temperatureTimeseries1(SubProgramm_TemperatureTimeseries=SubProgramm2_TemperatureTimeseries)
                                                    annotation (Placement(transformation(extent={{-10,60},{10,80}})));
        SubprogrammIsActive subprogrammIsActive1(SubProgramm_=2)
                                                                annotation (Placement(transformation(extent={{-60,60},{-40,80}})));
        TemperatureTimeseries temperatureTimeseries2(SubProgramm_TemperatureTimeseries=SubProgramm3_TemperatureTimeseries)
                                                    annotation (Placement(transformation(extent={{-10,40},{10,60}})));
        SubprogrammIsActive subprogrammIsActive2(SubProgramm_=3)
                                                                annotation (Placement(transformation(extent={{-60,40},{-40,60}})));
        TemperatureTimeseries temperatureTimeseries3(SubProgramm_TemperatureTimeseries=SubProgramm4_TemperatureTimeseries)
                                                    annotation (Placement(transformation(extent={{-10,20},{10,40}})));
        SubprogrammIsActive subprogrammIsActive3(SubProgramm_=4)
                                                                annotation (Placement(transformation(extent={{-60,20},{-40,40}})));
        Modelica.Blocks.Routing.Multiplex mux(n=11)
                                                   annotation (Placement(transformation(extent={{30,-10},{50,10}})));
        Modelica.Blocks.Sources.RealExpression realExpression(y=mux.y[SubProgramm + 1]) annotation (Placement(transformation(extent={{60,-10},{80,10}})));
        Modelica.Blocks.Sources.Constant const1(k=0) annotation (Placement(transformation(extent={{50,40},{30,60}})));
        TemperatureTimeseries temperatureTimeseries4(SubProgramm_TemperatureTimeseries=SubProgramm5_TemperatureTimeseries)
                                                    annotation (Placement(transformation(extent={{-10,0},{10,20}})));
        SubprogrammIsActive subprogrammIsActive4(SubProgramm_=5)
                                                                annotation (Placement(transformation(extent={{-60,0},{-40,20}})));
        TemperatureTimeseries temperatureTimeseries5(SubProgramm_TemperatureTimeseries=SubProgramm6_TemperatureTimeseries)
                                                    annotation (Placement(transformation(extent={{-10,-20},{10,0}})));
        SubprogrammIsActive subprogrammIsActive5(SubProgramm_=6)
                                                                annotation (Placement(transformation(extent={{-60,-20},{-40,0}})));
        TemperatureTimeseries temperatureTimeseries6(SubProgramm_TemperatureTimeseries=SubProgramm7_TemperatureTimeseries)
                                                    annotation (Placement(transformation(extent={{-10,-40},{10,-20}})));
        SubprogrammIsActive subprogrammIsActive6(SubProgramm_=7)
                                                                annotation (Placement(transformation(extent={{-60,-40},{-40,-20}})));
        TemperatureTimeseries temperatureTimeseries7(SubProgramm_TemperatureTimeseries=SubProgramm8_TemperatureTimeseries)
                                                    annotation (Placement(transformation(extent={{-10,-60},{10,-40}})));
        SubprogrammIsActive subprogrammIsActive7(SubProgramm_=8)
                                                                annotation (Placement(transformation(extent={{-60,-60},{-40,-40}})));
        TemperatureTimeseries temperatureTimeseries8(SubProgramm_TemperatureTimeseries=SubProgramm9_TemperatureTimeseries)
                                                    annotation (Placement(transformation(extent={{-10,-80},{10,-60}})));
        SubprogrammIsActive subprogrammIsActive8(SubProgramm_=9)
                                                                annotation (Placement(transformation(extent={{-60,-80},{-40,-60}})));
        TemperatureTimeseries temperatureTimeseries9(SubProgramm_TemperatureTimeseries=SubProgramm10_TemperatureTimeseries)
                                                    annotation (Placement(transformation(extent={{-10,-100},{10,-80}})));
        SubprogrammIsActive subprogrammIsActive9(SubProgramm_=10)
                                                                annotation (Placement(transformation(extent={{-60,-100},{-40,-80}})));
      equation
        connect(subprogrammIsActive.IsActive, temperatureTimeseries.IsActive) annotation (Line(points={{-39,90},{-12,90}},
                                                                                                                         color={255,0,255}));
        connect(subprogrammIsActive1.IsActive, temperatureTimeseries1.IsActive) annotation (Line(points={{-39,70},{-12,70}},
                                                                                                                           color={255,0,255}));
        connect(subprogrammIsActive2.IsActive,temperatureTimeseries2. IsActive) annotation (Line(points={{-39,50},{-12,50}},
                                                                                                                           color={255,0,255}));
        connect(subprogrammIsActive.SubProgramm, SubProgramm) annotation (Line(points={{-62,90},{-80,90},{-80,0},{-120,0}}, color={255,127,0}));
        connect(subprogrammIsActive1.SubProgramm, SubProgramm) annotation (Line(points={{-62,70},{-80,70},{-80,0},{-120,0}}, color={255,127,0}));
        connect(subprogrammIsActive2.SubProgramm, SubProgramm) annotation (Line(points={{-62,50},{-80,50},{-80,0},{-120,0}},   color={255,127,0}));
        connect(subprogrammIsActive3.IsActive,temperatureTimeseries3. IsActive) annotation (Line(points={{-39,30},{-12,30}},
                                                                                                                           color={255,0,255}));
        connect(subprogrammIsActive3.SubProgramm, SubProgramm) annotation (Line(points={{-62,30},{-80,30},{-80,0},{-120,0}},   color={255,127,0}));
        connect(realExpression.y, TargetTemperature) annotation (Line(points={{81,0},{110,0}}, color={0,0,127}));
        connect(subprogrammIsActive4.IsActive,temperatureTimeseries4. IsActive) annotation (Line(points={{-39,10},{-12,10}},
                                                                                                                           color={255,0,255}));
        connect(subprogrammIsActive5.IsActive,temperatureTimeseries5. IsActive) annotation (Line(points={{-39,-10},{-12,-10}},
                                                                                                                           color={255,0,255}));
        connect(subprogrammIsActive6.IsActive,temperatureTimeseries6. IsActive) annotation (Line(points={{-39,-30},{-12,-30}},
                                                                                                                           color={255,0,255}));
        connect(subprogrammIsActive7.IsActive,temperatureTimeseries7. IsActive) annotation (Line(points={{-39,-50},{-12,-50}},
                                                                                                                           color={255,0,255}));
        connect(subprogrammIsActive8.IsActive,temperatureTimeseries8. IsActive) annotation (Line(points={{-39,-70},{-12,-70}},
                                                                                                                           color={255,0,255}));
        connect(subprogrammIsActive9.IsActive,temperatureTimeseries9. IsActive) annotation (Line(points={{-39,-90},{-12,-90}},
                                                                                                                           color={255,0,255}));
        connect(subprogrammIsActive9.SubProgramm, SubProgramm) annotation (Line(points={{-62,-90},{-80,-90},{-80,0},{-120,0}}, color={255,127,0}));
        connect(subprogrammIsActive8.SubProgramm, SubProgramm) annotation (Line(points={{-62,-70},{-80,-70},{-80,0},{-120,0}}, color={255,127,0}));
        connect(subprogrammIsActive7.SubProgramm, SubProgramm) annotation (Line(points={{-62,-50},{-80,-50},{-80,0},{-120,0}}, color={255,127,0}));
        connect(subprogrammIsActive6.SubProgramm, SubProgramm) annotation (Line(points={{-62,-30},{-80,-30},{-80,0},{-120,0}}, color={255,127,0}));
        connect(subprogrammIsActive5.SubProgramm, SubProgramm) annotation (Line(points={{-62,-10},{-80,-10},{-80,0},{-120,0}}, color={255,127,0}));
        connect(subprogrammIsActive4.SubProgramm, SubProgramm) annotation (Line(points={{-62,10},{-80,10},{-80,0},{-120,0}}, color={255,127,0}));
        connect(const1.y, mux.u[1]) annotation (Line(points={{29,50},{20,50},{20,6.36364},{30,6.36364}}, color={0,0,127}));
        connect(temperatureTimeseries.TargetTemperature, mux.u[2]) annotation (Line(points={{11,90},{20,90},{20,5.09091},{30,5.09091}}, color={0,0,127}));
        connect(temperatureTimeseries1.TargetTemperature, mux.u[3]) annotation (Line(points={{11,70},{20,70},{20,3.81818},{30,3.81818}}, color={0,0,127}));
        connect(temperatureTimeseries2.TargetTemperature, mux.u[4]) annotation (Line(points={{11,50},{20,50},{20,2.54545},{30,2.54545}}, color={0,0,127}));
        connect(temperatureTimeseries3.TargetTemperature, mux.u[5]) annotation (Line(points={{11,30},{20,30},{20,1.27273},{30,1.27273}}, color={0,0,127}));
        connect(temperatureTimeseries4.TargetTemperature, mux.u[6]) annotation (Line(points={{11,10},{20,10},{20,3.33067e-16},{30,3.33067e-16}}, color={0,0,127}));
        connect(temperatureTimeseries5.TargetTemperature, mux.u[7]) annotation (Line(points={{11,-10},{20,-10},{20,-1.27273},{30,-1.27273}}, color={0,0,127}));
        connect(temperatureTimeseries6.TargetTemperature, mux.u[8]) annotation (Line(points={{11,-30},{20,-30},{20,-2.54545},{30,-2.54545}}, color={0,0,127}));
        connect(temperatureTimeseries7.TargetTemperature, mux.u[9]) annotation (Line(points={{11,-50},{20,-50},{20,-3.81818},{30,-3.81818}}, color={0,0,127}));
        connect(temperatureTimeseries8.TargetTemperature, mux.u[10]) annotation (Line(points={{11,-70},{20,-70},{20,-5.09091},{30,-5.09091}}, color={0,0,127}));
        connect(temperatureTimeseries9.TargetTemperature, mux.u[11]) annotation (Line(points={{11,-90},{20,-90},{20,-6.36364},{30,-6.36364}}, color={0,0,127}));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)),
          Documentation(info="<html>
<p>Within this model the input signal &quot;<b>SubProgramm</b>&quot; is transferred into a temperature profil. Per default, ten subprogramms are assumed.</p>
</html>"));
      end TargetTemperature;

      model TemperatureTimeseries
        Modelica.Blocks.Interfaces.RealOutput TargetTemperature "Target temperatur which should be predominate in the oven during each subprogramm [K]"
                                                                annotation (Placement(transformation(extent={{100,-10},{120,10}})));
        Modelica.Blocks.Interfaces.BooleanInput IsActive "Input signal determining wheter the subprogramm is active"
                                                         annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
        Modelica.Blocks.Logical.Timer timer annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
        Modelica.Blocks.Tables.CombiTable1Dv combiTable1D(
          table=SubProgramm_TemperatureTimeseries,
          smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments,
          extrapolation=Modelica.Blocks.Types.Extrapolation.HoldLastPoint) annotation (Placement(transformation(extent={{40,-10},{60,10}})));
        parameter Real SubProgramm_TemperatureTimeseries[:,2] "TBD";
      equation
        connect(timer.y, combiTable1D.u[1]) annotation (Line(points={{-39,0},{38,0}}, color={0,0,127}));
        connect(timer.u, IsActive) annotation (Line(points={{-62,0},{-120,0}}, color={255,0,255}));
        connect(combiTable1D.y[1], TargetTemperature) annotation (Line(points={{61,0},{110,0}}, color={0,0,127}));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)),
          Documentation(info="<html>
<p>This model creates a temperature profil if the input signal changes to &quot;true&quot;.</p>
</html>"));
      end TemperatureTimeseries;

      model SubprogrammIsActive
        Modelica.Blocks.Interfaces.IntegerInput SubProgramm "Input signal of the subprogramms"
                                                            annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
        Modelica.Blocks.Interfaces.BooleanOutput IsActive "Boolean signal to determine wheter subprogramm is active"
                                                          annotation (Placement(transformation(extent={{100,-10},{120,10}})));
        parameter Real SubProgramm_;
        Modelica.Blocks.Sources.BooleanExpression booleanExpression(y=noEvent(if SubProgramm == SubProgramm_ then true else false)) annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
      equation
        connect(booleanExpression.y, IsActive) annotation (Line(points={{11,0},{110,0}}, color={255,0,255}));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)));
      end SubprogrammIsActive;

      model Working_to_SubProgramm_and_TargetTemperature
        Modelica.Blocks.Interfaces.BooleanInput Working "Boolean input signal of operating mode \"Working\""                 annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
        Modelica.Blocks.Tables.CombiTable1Dv SubProgramms(table=ProcessingProgramm_chronological_log, smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments) annotation (Placement(transformation(extent={{-10,-80},{10,-60}})));
        Modelica.Blocks.Logical.Timer timer annotation (Placement(transformation(extent={{-50,-80},{-30,-60}})));
        Modelica.StateGraph.TransitionWithSignal transitionWithSignal annotation (Placement(transformation(extent={{-40,40},{-20,60}})));
        Modelica.StateGraph.InitialStep initialStep(nIn=1, nOut=1)
                                                    annotation (Placement(transformation(extent={{-80,40},{-60,60}})));
        Modelica.StateGraph.StepWithSignal stepWithSignal(nIn=1, nOut=1)
                                                          annotation (Placement(transformation(extent={{20,40},{40,60}})));
        Modelica.StateGraph.Transition WaitTimeseriesDuration(enableTimer=true, waitTime=SubProgramms.table[size(SubProgramms.table, 1), 1]) annotation (Placement(transformation(extent={{60,60},{80,80}})));
        Modelica.StateGraph.Alternative alternative annotation (Placement(transformation(extent={{60,40},{80,60}})));
        Modelica.StateGraph.TransitionWithSignal Kill annotation (Placement(transformation(extent={{60,20},{80,40}})));
        Modelica.Blocks.MathBoolean.FallingEdge falling1 annotation (Placement(transformation(extent={{-4,-4},{4,4}},
              rotation=90,
              origin={70,10})));
        parameter Real ProcessingProgramm_chronological_log[:,2] "Table which defines the chronological log of the sub programms for a specific processing programm ";
        parameter Real ProcessingProgramm_TemperatureTimeseries[:,2] "Table which defines the temperature profile for a specific processing programm ";
        Modelica.Blocks.Logical.Switch switch1 annotation (Placement(transformation(extent={{30,-40},{50,-60}})));
        Modelica.Blocks.Sources.Constant const(k=0) annotation (Placement(transformation(extent={{-10,-40},{10,-20}})));
        Modelica.Blocks.Interfaces.RealOutput TargetTemperature "Target temperatur which should be predominate in the oven [K]"
                                                                annotation (Placement(transformation(extent={{100,-60},{120,-40}})));
        Modelica.Blocks.Tables.CombiTable1Dv TemperatureProfiles(table=ProcessingProgramm_TemperatureTimeseries, smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments) annotation (Placement(transformation(extent={{-10,-100},{10,-80}})));
        Modelica.Blocks.Interfaces.RealOutput SubProgramm annotation (Placement(transformation(extent={{100,40},{120,60}})));
      equation
        connect(timer.y,SubProgramms. u[1]) annotation (Line(points={{-29,-70},{-12,-70}}, color={0,0,127}));
        connect(transitionWithSignal.condition, Working) annotation (Line(points={{-30,38},{-30,0},{-120,0}}, color={255,0,255}));
        connect(initialStep.outPort[1], transitionWithSignal.inPort) annotation (Line(points={{-59.5,50},{-34,50}}, color={0,0,0}));
        connect(transitionWithSignal.outPort, stepWithSignal.inPort[1]) annotation (Line(points={{-28.5,50},{19,50}}, color={0,0,0}));
        connect(WaitTimeseriesDuration.inPort,alternative. split[1]) annotation (Line(points={{66,70},{62.1,70},{62.1,50}}, color={0,0,0}));
        connect(WaitTimeseriesDuration.outPort,alternative. join[1]) annotation (Line(points={{71.5,70},{77.9,70},{77.9,50}}, color={0,0,0}));
        connect(Kill.inPort,alternative. split[2]) annotation (Line(points={{66,30},{62.1,30},{62.1,50}}, color={0,0,0}));
        connect(Kill.outPort,alternative. join[2]) annotation (Line(points={{71.5,30},{77.9,30},{77.9,50}}, color={0,0,0}));
        connect(stepWithSignal.outPort[1], alternative.inPort) annotation (Line(points={{40.5,50},{59.7,50}}, color={0,0,0}));
        connect(alternative.outPort, initialStep.inPort[1]) annotation (Line(points={{80.2,50},{90,50},{90,90},{-90,90},{-90,50},{-81,50}}, color={0,0,0}));
        connect(Kill.condition, falling1.y) annotation (Line(points={{70,18},{70,14.8}}, color={255,0,255}));
        connect(falling1.u, Working) annotation (Line(points={{70,4.4},{70,0},{-120,0}}, color={255,0,255}));
        connect(stepWithSignal.active, timer.u) annotation (Line(
            points={{30,39},{30,-10},{-70,-10},{-70,-70},{-52,-70}},
            color={255,0,255},
            pattern=LinePattern.Dash));
        connect(SubProgramms.y[1], switch1.u1) annotation (Line(points={{11,-70},{20,-70},{20,-58},{28,-58}}, color={0,0,127}));
        connect(const.y, switch1.u3) annotation (Line(points={{11,-30},{20,-30},{20,-42},{28,-42}}, color={0,0,127}));
        connect(switch1.u2, Working) annotation (Line(points={{28,-50},{-30,-50},{-30,0},{-120,0}}, color={255,0,255}));
        connect(timer.y, TemperatureProfiles.u[1]) annotation (Line(points={{-29,-70},{-29,-90},{-12,-90}}, color={0,0,127}));
        connect(TemperatureProfiles.y[1], TargetTemperature) annotation (Line(points={{11,-90},{90,-90},{90,-50},{110,-50}},
                                                                                                                     color={0,0,127}));
        connect(switch1.y, SubProgramm) annotation (Line(points={{51,-50},{90,-50},{90,50},{110,50}}, color={0,0,127}));
        annotation (
          Icon(coordinateSystem(preserveAspectRatio=false)),
          Diagram(coordinateSystem(preserveAspectRatio=false)),
          Documentation(info="<html>
<p>This model converts a boolean input signal &quot;<b>Working</b>&quot; (Operating Mode) into a real signals &quot;<b>SubProgramm</b>&quot; and &quot;<b>TargetTemperature</b>&quot;. The &quot;<b>SubProgramm</b>&quot; is a part of the so-called &quot;<b>ProcessingProgramm</b>&quot;. Based on the example of an annealing oven, a &quot;<b>SubProgramm</b>&quot; can be &quot;heat up&quot;, &quot;hold&quot; or &quot;cool down&quot;. The chronological log a the &quot;<b>SubProgramm</b>&quot; is defined via an array where the first column represents the timestamps where the specific &quot;<b>SubProgramm</b>&quot;, represented by integer entries, starts. While &quot;<b>Working</b>&quot; is true, the chronological log of the &quot;<b>SubProgramm</b>&quot; is looped. If &quot;<b>Working</b>&quot; changes to false, the &quot;<b>SubProgramm</b>&quot; will stop even if it is not finished.</p>
</html>"));
      end Working_to_SubProgramm_and_TargetTemperature;
    end ProcessController;

    package ProcessingProgramms
      package BaseClasses
        record ProcessingProgramm_base
          parameter Real ProcessingProgramm_chronological_log[:,2] "Table which defines the chronological log a the sub programms for a specific processing programm. Each timestamp (column 1) represents the starting time of the corresponding sub program (column 2).";
          parameter Real ProcessingProgramm_TemperatureTimeseries[:,2] "Table which defines the temperature profil for a specific processing programm. Temperature (column 2) over time (column 1).";
          parameter Real ProcessingProgramm[:,8] "Table which defines whether components are active (or their corresponding power) depending on the predominant sub programm. Currently seven components (heating, quenching, door, vacuum, gas-circulation, process-gas-burner and gasket-cooling) are assumed";

          annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)));
        end ProcessingProgramm_base;
      end BaseClasses;

      record ProcessingProgramm_Programm_26_Phi
        extends ThermalIntegrationLib.ProductionEquipment.Ovens.AnnealingOven.ProcessingProgramms.BaseClasses.ProcessingProgramm_base(
        ProcessingProgramm_chronological_log=[0,1; 60,2; 4680,3; 5460,4; 6360,5; 7140,6; 11160,7; 11220,8],
        ProcessingProgramm_TemperatureTimeseries=[0,293.15; 60,293.15; 61,673.15; 4680,673.15; 4681,793.15; 5460,793.15; 5461,823.15; 6360,823.15; 6361,673.15; 7140,673.15; 7141,543.15; 11160,543.15; 11161,328.15; 11220,328.15],
        ProcessingProgramm=[0,0,0,0,5500,0,0,1; 1,1,0,0,5500,5500,0,1; 2,1,0,0,0,5500,0,1; 3,1,0,0,0,5500,0,1; 4,1,0,0,0,5500,0,1; 5,0,1,0,0,5500,0,1; 6,0,1,0,0,5500,0,1; 7,1,0,0,0,5500,0,1; 8,1,0,1,0,0,0,1]);
        annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)));
      end ProcessingProgramm_Programm_26_Phi;

      record ProcessingProgramm_abc
        extends ThermalIntegrationLib.ProductionEquipment.Ovens.AnnealingOven.ProcessingProgramms.BaseClasses.ProcessingProgramm_base(
        ProcessingProgramm_chronological_log=[0,1; 60,2; 4680,3; 5460,4; 6360,5; 7140,6; 11160,7; 11220,8],
        ProcessingProgramm_TemperatureTimeseries=[0,293.15; 60,293.15; 61,673.15; 4680,673.15; 4681,793.15; 5460,793.15; 5461,823.15; 6360,823.15; 6361,673.15; 7140,673.15; 7141,543.15; 11160,543.15; 11161,328.15; 11220,328.15],
        ProcessingProgramm=[0,0,0,0,1,0,0,1; 1,1,0,0,1,1,0,1; 2,1,0,0,0,1,0,1; 3,1,0,0,0,1,0,1; 4,1,0,0,0,1,0,1; 5,0,1,0,0,1,0,1; 6,1,0,0,0,1,0,1; 7,1,0,0,0,1,0,1; 8,1,0,1,0,0,0,1]);
        annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)));
      end ProcessingProgramm_abc;

      record ProcessingProgramm_def
        extends ThermalIntegrationLib.ProductionEquipment.Ovens.AnnealingOven.ProcessingProgramms.BaseClasses.ProcessingProgramm_base(
        ProcessingProgramm_chronological_log=[0,1; 1801,2; 3601,3; 4001,4; 4601,5],
        ProcessingProgramm_TemperatureTimeseries=[0,573.15; 1800,573.15; 1801,723.15; 3600,723.15; 3601,373.15; 4000,373.15; 4001,293.15; 4600,293.15],
        ProcessingProgramm=[0,1,0,0,0,0,0,0; 1,1,0,0,0,0,0,0; 2,1,0,0,0,0,0,0; 3,0,1,0,0,0,0,0; 4,0,0,1,0,0,0,0]);

        annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)));
      end ProcessingProgramm_def;

      record ProcessingProgramm_ghi
        extends ThermalIntegrationLib.ProductionEquipment.Ovens.AnnealingOven.ProcessingProgramms.BaseClasses.ProcessingProgramm_base(
        ProcessingProgramm_chronological_log=[0,1; 1801,2; 3601,3; 4001,4; 4601,5],
        ProcessingProgramm_TemperatureTimeseries=[0,573.15; 1800,573.15; 1801,723.15; 3600,723.15; 3601,373.15; 4000,373.15; 4001,293.15; 4600,293.15],
        ProcessingProgramm=[0,1,0,0,0,0,0,0; 1,1,0,0,0,0,0,0; 2,1,0,0,0,0,0,0; 3,0,1,0,0,0,0,0; 4,0,0,1,0,0,0,0]);

        annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)));
      end ProcessingProgramm_ghi;

      record ProcessingProgramm_Programm_KI4ETA
        extends ThermalIntegrationLib.ProductionEquipment.Ovens.AnnealingOven.ProcessingProgramms.BaseClasses.ProcessingProgramm_base(
        ProcessingProgramm_chronological_log=[0,1; 780,2; 1380,3; 1500,3],
        ProcessingProgramm_TemperatureTimeseries=[0,343.15; 780,373.15; 1380,333.15; 1500,293.15],
        ProcessingProgramm=[1,1,0,0,0,0,0,0; 0,1,0,0,0,0,0,0; 0,0,1,0,0,0,0,0]);
        annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)));
      end ProcessingProgramm_Programm_KI4ETA;
    end ProcessingProgramms;

    package TechnicalConfiguration
      package BaseClasses
        record TechnicalConfiguration_base
          parameter Modelica.Units.SI.Density rho_wall "density of wall material" annotation (Dialog(tab="Thermal system properties", group="wall"));
          parameter Modelica.Units.SI.ThermalConductivity lambda_wall "thermal conductivity of wall material" annotation (Dialog(tab="Thermal system properties", group="wall"));
          parameter Modelica.Units.SI.SpecificHeatCapacity cp_wall "specific heat capacity of wall material" annotation (Dialog(tab="Thermal system properties", group="wall"));
          parameter Modelica.Units.SI.Length t_wall "thickness of wall material" annotation (Dialog(tab="Thermal system properties", group="wall"));
          parameter Modelica.Units.SI.Area A_wall "overall surface of wall material" annotation (Dialog(tab="Thermal system properties", group="wall"));

          parameter Modelica.Units.SI.Density rho_door "density of door material" annotation (Dialog(tab="Thermal system properties", group="door"));
          parameter Modelica.Units.SI.ThermalConductivity lambda_door "thermal conductivity of door material" annotation (Dialog(tab="Thermal system properties", group="door"));
          parameter Modelica.Units.SI.SpecificHeatCapacity cp_door "specific heat capacity of door material" annotation (Dialog(tab="Thermal system properties", group="door"));
          parameter Modelica.Units.SI.Length t_door "thickness of door material" annotation (Dialog(tab="Thermal system properties", group="door"));
          parameter Modelica.Units.SI.Area A_door "overall surface of door material" annotation (Dialog(tab="Thermal system properties", group="door"));

          parameter Modelica.Units.SI.Mass m_retort "mass of retort" annotation (Dialog(tab="Thermal system properties", group="retort"));
          parameter Modelica.Units.SI.SpecificHeatCapacity cp_retort "specific heat capacity of retort" annotation (Dialog(tab="Thermal system properties", group="retort"));
          parameter Modelica.Units.SI.Volume v_air "volume of air within burning chamber" annotation (Dialog(tab="Thermal system properties", group="retort"));

          parameter Modelica.Units.SI.Mass m_workpiece "mass of workpiece" annotation (Dialog(tab="Thermal system properties", group="workpiece"));
          parameter Modelica.Units.SI.SpecificHeatCapacity cp_workpiece "specific heat capacity of workpiece" annotation (Dialog(tab="Thermal system properties", group="workpiece"));
          parameter Modelica.Units.SI.Mass m_workpiece_carrier "mass of workpiece-carrier" annotation (Dialog(tab="Thermal system properties", group="workpiece"));
          parameter Modelica.Units.SI.SpecificHeatCapacity cp_workpiece_carrier "specific heat capacity of workpiece-carrier" annotation (Dialog(tab="Thermal system properties", group="workpiece"));

          parameter Modelica.Units.SI.CoefficientOfHeatTransfer alpha_forced "Coefficient of heat transfer for forced convection" annotation (Dialog(tab="Thermal system properties", group="assumptions"));

          parameter Modelica.Units.SI.Power P_th_nom_gasket_cooling "Nominal cooling power of gasket cooling" annotation (Dialog(tab="Technical components", group="Components"));
          parameter Modelica.Units.SI.MassFlowRate m_flow_nom_quenching "Nominal air mass flow of quenching system" annotation (Dialog(tab="Technical components", group="Components"));
          parameter Modelica.Units.SI.Power P_el_nom_quenching "Nominal electric power demand of quenching system" annotation (Dialog(tab="Technical components", group="Components"));
          parameter Modelica.Units.SI.Power P_th_nom_heating "Nominal heating power of heater unit" annotation (Dialog(tab="Technical components", group="Components"));
          parameter Real eta_f "Constant firing efficiency of heater unit" annotation(Dialog(tab = "Technical components", group = "Components"));
          parameter Boolean use_quenching_heat_recovery "True to recover heat from quenching air stream" annotation(Dialog(tab = "Technical components", group = "Components"));
          parameter Boolean use_heating_heat_recovery "True to recover heat from heating exhaust stream" annotation(Dialog(tab = "Technical components", group = "Components"));

          parameter Modelica.Units.SI.ThermodynamicTemperature T_target_gasketcooling "Target temperature of gasketcooling" annotation (Dialog(tab="Temperatures", group="Target-temperatures"));
          parameter Modelica.Units.SI.ThermodynamicTemperature T_target_quenching_heat_recovery "Fluid target temperature of heat recovery of quenching" annotation (Dialog(tab="Temperatures", group="Target-temperatures"));
          parameter Modelica.Units.SI.ThermodynamicTemperature T_target_heating_heat_recovery "Fluid target temperature of heat recovery of heating" annotation (Dialog(tab="Temperatures", group="Target-temperatures"));
          parameter Modelica.Units.SI.ThermodynamicTemperature T_init_air "Initial temperature of air volume within burning chamber" annotation (Dialog(tab="Temperatures", group="Initialization"));
          parameter Modelica.Units.SI.ThermodynamicTemperature T_init_retort "Initial temperature of retort" annotation (Dialog(tab="Temperatures", group="Initialization"));
          parameter Modelica.Units.SI.ThermodynamicTemperature T_init_workpiece "Initial temperature of workpiece" annotation (Dialog(tab="Temperatures", group="Initialization"));
          parameter Modelica.Units.SI.ThermodynamicTemperature T_init_wall "Initial temperature of wall" annotation (Dialog(tab="Temperatures", group="Initialization"));
          parameter Modelica.Units.SI.ThermodynamicTemperature T_init_door "Initial temperature of door" annotation (Dialog(tab="Temperatures", group="Initialization"));

          annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)));
        end TechnicalConfiguration_base;
      end BaseClasses;

      record TechnicalConfiguration_a
        extends ThermalIntegrationLib.ProductionEquipment.Ovens.AnnealingOven.TechnicalConfiguration.BaseClasses.TechnicalConfiguration_base(
        t_door=0.1,
        use_heating_heat_recovery=false,
        use_quenching_heat_recovery=false,
        T_init_door=323.15,
        T_init_wall=323.15,
        T_init_workpiece=293.15,
        T_init_retort=373.15,
        T_init_air=373.15,
        T_target_heating_heat_recovery=353.15,
        T_target_quenching_heat_recovery=353.15,
        T_target_gasketcooling=313.15,
        eta_f=0.99,
        P_th_nom_heating=500000,
        P_el_nom_quenching=5000,
        m_flow_nom_quenching=5,
        P_th_nom_gasket_cooling=50000,
        rho_wall=2000,
        lambda_wall=1,
        cp_wall=1000,
        t_wall=0.1,
        A_wall=20,
        rho_door=2000,
        lambda_door=1,
        cp_door=1000,
        A_door=2,
        m_retort=1000,
        cp_retort=500,
        v_air=1,
        m_workpiece=50,
        cp_workpiece=500,
        m_workpiece_carrier=50,
        cp_workpiece_carrier=500,
        alpha_forced=250);
        annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)));
      end TechnicalConfiguration_a;

    end TechnicalConfiguration;

    package WorkpieceHallDissipation
      model WorkpieceHallDissipation

        Modelica.Blocks.Examples.BusUsage_Utilities.Interfaces.ControlBus controlBus annotation (Placement(transformation(
              extent={{-20,-20},{20,20}},
              rotation=270,
              origin={-100,0}), iconTransformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={-100,0})));

        WorkpieceWorkpieceCarrier workpieceWorkpieceCarrier annotation (Placement(transformation(extent={{2,-10},{22,10}})));
        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_a annotation (Placement(transformation(extent={{90,-10},{110,10}})));
        Modelica.Blocks.Interfaces.RealInput T_workpiece annotation (Placement(transformation(extent={{-140,-98},{-100,-58}})));
        Modelica.Blocks.Logical.GreaterThreshold greaterThreshold(threshold=0.9) annotation (Placement(transformation(extent={{-56,6},{-48,14}})));
      equation

        connect(workpieceWorkpieceCarrier.port_a, port_a) annotation (Line(points={{22,0},{100,0}}, color={191,0,0}));
        connect(workpieceWorkpieceCarrier.T_workpiece, T_workpiece) annotation (Line(points={{0,8},{-14,8},{-14,-78},{-120,-78}},color={0,0,127}));
        connect(greaterThreshold.u, controlBus.DoorIsOpen) annotation (Line(points={{-56.8,10},{-78,10},{-78,0},{-100,0}},
                                                                                                         color={0,0,127}), Text(
            string="%second",
            index=1,
            extent={{-6,3},{-6,3}},
            horizontalAlignment=TextAlignment.Right));
        connect(greaterThreshold.y, workpieceWorkpieceCarrier.WorkpieceActivation) annotation (Line(points={{-47.6,10},{-24,10},{-24,0},{0,0}},
                                                                                                                              color={255,0,255}));
        connect(workpieceWorkpieceCarrier.ProcessingProgram, controlBus.ProcessingProgram) annotation (Line(points={{0.2,-8},{-78,-8},{-78,0},{-100,0}}, color={255,127,0}), Text(
            string="%second",
            index=1,
            extent={{-6,3},{-6,3}},
            horizontalAlignment=TextAlignment.Right));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
              Rectangle(
                extent={{-100,100},{100,-100}},
                lineColor={0,0,0},
                lineThickness=0.5),
              Line(
                points={{15,60},{-25,20},{15,-20},{-25,-60},{25,-20},{-15,20},{15,60}},
                color={0,0,0},
                thickness=0.5,
                smooth=Smooth.Bezier,
                origin={-1,0},
                rotation=90),
              Line(
                points={{-62,-34},{-62,-34},{70,-34},{70,26},{70,66},{30,26},{30,66},{-10,26},{-10,66},{-50,26},{-50,74},{-76,74},{-76,-34},{-62,-34},{-62,-34}},
                color={0,0,0},
                thickness=0.5)}),                                      Diagram(coordinateSystem(preserveAspectRatio=false)));
      end WorkpieceHallDissipation;

      model ThermalOnOffSwitch
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
                textString="%name")}),                                 Diagram(coordinateSystem(preserveAspectRatio=false)),
                    Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)));
      end ThermalOnOffSwitch;

      model WorkpieceWorkpieceCarrier

      Boolean StartWorkpieceDissipation;

        Modelica.Thermal.HeatTransfer.Components.HeatCapacitor workpiece_and_workpiece_carrier(C=2*1000*200, T(start=T_workpiece)) annotation (Placement(transformation(extent={{-30,0},{-10,20}})));
        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_a annotation (Placement(transformation(extent={{90,-10},{110,10}})));
        Modelica.Thermal.HeatTransfer.Components.ConvectiveResistor convectiveResistor annotation (Placement(transformation(extent={{10,-10},{30,10}})));
        Modelica.Blocks.Sources.Constant convection_air(k=10) annotation (Placement(transformation(extent={{-4,36},{10,50}})));
        ThermalOnOffSwitch thermalOnOffSwitch annotation (Placement(transformation(extent={{52,-10},{72,10}})));
        Modelica.Blocks.Interfaces.RealInput T_workpiece annotation (Placement(transformation(extent={{-140,60},{-100,100}})));
        Modelica.Blocks.Interfaces.BooleanInput WorkpieceActivation annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));

        Modelica.Blocks.Sources.BooleanExpression booleanExpression(y=StartWorkpieceDissipation) annotation (Placement(transformation(extent={{14,-42},{34,-22}})));
        Modelica.Blocks.Interfaces.IntegerInput ProcessingProgram annotation (Placement(transformation(extent={{-138,-100},{-98,-60}})));
      equation

        if ProcessingProgram == 1 and time >= 11220 then
          StartWorkpieceDissipation = true;
        elseif ProcessingProgram == 2 or ProcessingProgram == 3 and time > 4001 then
          StartWorkpieceDissipation = true;
        else
          StartWorkpieceDissipation = false;
        end if;

        when WorkpieceActivation and StartWorkpieceDissipation == true then
          reinit(workpiece_and_workpiece_carrier.T, T_workpiece);
        end when;

        connect(convection_air.y, convectiveResistor.Rc) annotation (Line(points={{10.7,43},{20,43},{20,10}}, color={0,0,127}));
        connect(port_a, thermalOnOffSwitch.port_out) annotation (Line(points={{100,0},{72,0}}, color={191,0,0}));
        connect(thermalOnOffSwitch.port_in, convectiveResistor.fluid) annotation (Line(points={{52,0},{30,0}}, color={191,0,0}));
        connect(booleanExpression.y, thermalOnOffSwitch.u) annotation (Line(points={{35,-32},{62,-32},{62,-12}}, color={255,0,255}));
        connect(workpiece_and_workpiece_carrier.port, convectiveResistor.solid) annotation (Line(points={{-20,0},{10,0}}, color={191,0,0}));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
              Rectangle(
                extent={{-100,100},{100,-100}},
                lineColor={0,0,0},
                lineThickness=0.5),
              Line(
                points={{15,60},{-25,20},{15,-20},{-25,-60},{25,-20},{-15,20},{15,60}},
                color={0,0,0},
                thickness=0.5,
                smooth=Smooth.Bezier,
                origin={-1,48},
                rotation=90),
              Line(
                points={{15,60},{-25,20},{15,-20},{-25,-60},{25,-20},{-15,20},{15,60}},
                color={0,0,0},
                thickness=0.5,
                smooth=Smooth.Bezier,
                origin={-1,0},
                rotation=90),
              Line(
                points={{15,60},{-25,20},{15,-20},{-25,-60},{25,-20},{-15,20},{15,60}},
                color={0,0,0},
                thickness=0.5,
                smooth=Smooth.Bezier,
                origin={-1,-50},
                rotation=90)}), Diagram(coordinateSystem(preserveAspectRatio=false)));
      end WorkpieceWorkpieceCarrier;
    end WorkpieceHallDissipation;

    model AnnealingOven
      extends ThermalIntegrationLib.BaseClasses.BaseProductionEquipment(
      electricDemands=1,
         ID=2,
         coolDemands=3,
         m=10000,
         cp=500,
      TInitial=298.15,
         heatDemands=0,
         tableOperationMode=[0, 3; 86400, 3],
         operationModes=3);
      parameter Real tableProcessingProgramm[:,2]=[0,1; 86400,1]
                                                    "Table matrix (time = first column; processingProgramm = second column)";
      replaceable parameter ThermalIntegrationLib.ProductionEquipment.Ovens.AnnealingOven.TechnicalConfiguration.TechnicalConfiguration_a TechnicalConfiguration                                                                     constrainedby ThermalIntegrationLib.ProductionEquipment.Ovens.AnnealingOven.TechnicalConfiguration.BaseClasses.TechnicalConfiguration_base "Record which defines technical/physical parameters" annotation (choicesAllMatching=true);
        replaceable parameter ProcessingProgramms.ProcessingProgramm_abc                                                                               ProcessingProgramm_1 constrainedby ThermalIntegrationLib.ProductionEquipment.Ovens.AnnealingOven.ProcessingProgramms.BaseClasses.ProcessingProgramm_base
                                                                                                                                                                                                        annotation (choicesAllMatching=true, Placement(transformation(extent={{-270,-260},{-250,-240}})));
        replaceable parameter ProcessingProgramms.ProcessingProgramm_def                                                                               ProcessingProgramm_2 constrainedby ThermalIntegrationLib.ProductionEquipment.Ovens.AnnealingOven.ProcessingProgramms.BaseClasses.ProcessingProgramm_base
                                                                                                                                                                                                        annotation (choicesAllMatching=true, Placement(transformation(extent={{-230,-260},{-210,-240}})));
        replaceable parameter ProcessingProgramms.ProcessingProgramm_ghi                                                                               ProcessingProgramm_3 constrainedby ThermalIntegrationLib.ProductionEquipment.Ovens.AnnealingOven.ProcessingProgramms.BaseClasses.ProcessingProgramm_base
                                                                                                                                                                                                        annotation (choicesAllMatching=true, Placement(transformation(extent={{-190,-260},{-170,-240}})));
      ThermalSystem.ThermalSystem thermalSystem(
        wall_element(
          n=5,
          rho_wall=TechnicalConfiguration.rho_wall,
          lambda_wall=TechnicalConfiguration.lambda_wall,
          cp_wall=TechnicalConfiguration.cp_wall,
          t_wall=TechnicalConfiguration.t_wall,
          A_wall=TechnicalConfiguration.A_wall,
          T_start_wall=TechnicalConfiguration.T_init_wall),
        door_element(
          n=5,
          rho_wall=TechnicalConfiguration.rho_door,
          lambda_wall=TechnicalConfiguration.lambda_door,
          cp_wall=TechnicalConfiguration.cp_door,
          t_wall=TechnicalConfiguration.t_door,
          A_wall=TechnicalConfiguration.A_door,
          T_start_wall=TechnicalConfiguration.T_init_door),
        retort(C=TechnicalConfiguration.m_retort*TechnicalConfiguration.cp_retort, T(start=TechnicalConfiguration.T_init_retort)),
        air(C=TechnicalConfiguration.v_air*1.3*1006, T(start=TechnicalConfiguration.T_init_air)),
        workpiece(C=TechnicalConfiguration.m_workpiece*TechnicalConfiguration.cp_workpiece, T(start=TechnicalConfiguration.T_init_workpiece)),
        workpiece_carrier(C=TechnicalConfiguration.m_workpiece_carrier*TechnicalConfiguration.cp_workpiece_carrier, T(start=TechnicalConfiguration.T_init_workpiece)),
        alpha(k=TechnicalConfiguration.alpha_forced*TechnicalConfiguration.A_wall),
        bodyRadiation(Gr=TechnicalConfiguration.A_door))
                                 annotation (Placement(transformation(extent={{20,-20},{60,20}})));
      HeatingSystem.HeaterUnit heaterUnit(P_th_nom=TechnicalConfiguration.P_th_nom_heating, eta_f=TechnicalConfiguration.eta_f)
                                                                   annotation (Placement(transformation(extent={{-110,-70},{-90,-90}})));
      Modelica.Thermal.HeatTransfer.Sources.FixedTemperature hall(T=298.15) annotation (Placement(transformation(extent={{240,-10},{220,10}})));
      Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor T_retort annotation (Placement(transformation(extent={{10,-40},{-10,-20}})));
      HeatingSystem.HeaterUnit_Controller heaterUnit_Controller annotation (Placement(transformation(extent={{-170,-90},{-150,-70}})));
      QuenchingSystem.QuenchingUnit quenchingUnit(m_nom=TechnicalConfiguration.m_flow_nom_quenching, P_el_nom=TechnicalConfiguration.P_el_nom_quenching)
                                                                         annotation (Placement(transformation(extent={{-110,0},{-90,20}})));
      Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor T_air annotation (Placement(transformation(extent={{10,20},{-10,40}})));
      Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor T_hall annotation (Placement(transformation(extent={{210,-30},{190,-10}})));
      QuenchingSystem.QuenchingUnit_Controller quenchingUnit_Controller annotation (Placement(transformation(extent={{-170,0},{-150,20}})));
      ProcessController.ProcessController processController(
        ProcessingProgramm1_chronological_log=ProcessingProgramm_1.ProcessingProgramm_chronological_log,
        ProcessingProgramm1_TemperatureTimeseries=ProcessingProgramm_1.ProcessingProgramm_TemperatureTimeseries,
        ProcessingProgramm1=ProcessingProgramm_1.ProcessingProgramm,
        ProcessingProgramm2=ProcessingProgramm_2.ProcessingProgramm,
        ProcessingProgramm3=ProcessingProgramm_3.ProcessingProgramm,
        ProcessingProgramm2_chronological_log=ProcessingProgramm_2.ProcessingProgramm_chronological_log,
        ProcessingProgramm2_TemperatureTimeseries=ProcessingProgramm_2.ProcessingProgramm_TemperatureTimeseries,
        ProcessingProgramm3_chronological_log=ProcessingProgramm_3.ProcessingProgramm_chronological_log,
        ProcessingProgramm3_TemperatureTimeseries=ProcessingProgramm_3.ProcessingProgramm_TemperatureTimeseries)
                                                            annotation (Placement(transformation(extent={{-240,-20},{-200,18}})));
      VacuumSystem.VacuumPump_Controller vacuumPump_Controller annotation (Placement(transformation(extent={{-170,80},{-150,100}})));
      VacuumSystem.DummyVacuumSystem dummyVacuumSystem annotation (Placement(transformation(extent={{-110,80},{-90,100}})));
      GascirculationSystem.Gascirculation_Controller gascirculation_Controller annotation (Placement(transformation(extent={{-170,120},{-150,140}})));
      GascirculationSystem.DummyGascirculationSystem dummyGascirculationSystem annotation (Placement(transformation(extent={{-110,120},{-90,140}})));
      GasketcoolingSystem.Gasketcooling_Controller gasketcooling_Controller(T_target_gasket=TechnicalConfiguration.T_target_gasketcooling)
                                                                            annotation (Placement(transformation(extent={{-170,160},{-150,180}})));
      GasketcoolingSystem.DummyGasketcooling dummyGasketcooling(P_th_nom=TechnicalConfiguration.P_th_nom_gasket_cooling)
                                                                             annotation (Placement(transformation(extent={{-110,160},{-90,180}})));
      Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor T_door annotation (Placement(transformation(extent={{70,20},{90,40}})));
      WasteheatRecoverySystem.WasteHeatRecovery wasteHeatRecovery(T_target=TechnicalConfiguration.T_target_heating_heat_recovery, use_WasteHeatRecovery=TechnicalConfiguration.use_heating_heat_recovery)
                                                                                              annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=180,
            origin={-100,-120})));
      WasteheatRecoverySystem.WasteHeatRecovery wasteHeatRecovery1(T_target=TechnicalConfiguration.T_target_quenching_heat_recovery, use_WasteHeatRecovery=TechnicalConfiguration.use_quenching_heat_recovery)
                                                                                               annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={-100,50})));
      Modelica.Blocks.Sources.RealExpression realExpression(y=T_heating.T) annotation (Placement(transformation(extent={{-140,30},{-120,50}})));
      Modelica.Thermal.HeatTransfer.Sources.FixedTemperature cooling_system(T=303.15) annotation (Placement(transformation(extent={{240,180},{220,200}})));
      Modelica.Thermal.HeatTransfer.Sources.FixedTemperature heating_system(T=333.15) annotation (Placement(transformation(extent={{240,140},{220,160}})));
      Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor T_cooling annotation (Placement(transformation(extent={{210,160},{190,180}})));
      Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor T_heating annotation (Placement(transformation(extent={{210,120},{190,140}})));
      Modelica.Blocks.Sources.RealExpression realExpression1(y=T_air.T) annotation (Placement(transformation(extent={{-140,50},{-120,70}})));
      Modelica.Blocks.Sources.RealExpression realExpression2(y=T_door.T) annotation (Placement(transformation(extent={{-120,140},{-140,160}})));
      Modelica.Blocks.Sources.RealExpression realExpression3(y=T_retort.T) annotation (Placement(transformation(extent={{-120,-20},{-140,0}})));
      Modelica.Blocks.Sources.RealExpression realExpression4(y=T_air.T) annotation (Placement(transformation(extent={{-140,-30},{-120,-10}})));
      Modelica.Blocks.Sources.RealExpression realExpression5(y=T_hall.T) annotation (Placement(transformation(extent={{-140,-42},{-120,-22}})));
      Modelica.Blocks.Sources.RealExpression realExpression6(y=T_retort.T) annotation (Placement(transformation(extent={{-120,-110},{-140,-90}})));
      Modelica.Blocks.Sources.RealExpression realExpression7(y=T_heating.T) annotation (Placement(transformation(extent={{-140,-120},{-120,-100}})));
      Modelica.Blocks.Sources.RealExpression realExpression8(y=T_air.T) annotation (Placement(transformation(extent={{-140,-140},{-120,-120}})));
      Modelica.Blocks.Math.MultiSum mainConnection(nu=4) annotation (Placement(transformation(extent={{-44,-6},{-32,6}})));
      Modelica.Blocks.Sources.IntegerExpression integerExpression(y=operationMode) annotation (Placement(transformation(extent={{-282,-2},{-262,18}})));
      Modelica.Blocks.Sources.IntegerTable integerTable(table=tableProcessingProgramm)
                                                        annotation (Placement(transformation(extent={{-280,-20},{-260,0}})));
      Modelica.Thermal.HeatTransfer.Components.ThermalCollector thermalCollector(m=1) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={170,190})));
      Modelica.Thermal.HeatTransfer.Components.ThermalCollector thermalCollector1(m=2) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={170,150})));
      Modelica.Thermal.HeatTransfer.Components.ThermalCollector thermalCollector2(m=5) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={170,0})));
      Modelica.Blocks.Sources.RealExpression realExpression9(y=T_hall.T)
                                                                        annotation (Placement(transformation(extent={{-140,-130},{-120,-110}})));
      Modelica.Blocks.Sources.RealExpression realExpression10(y=T_hall.T)
                                                                        annotation (Placement(transformation(extent={{-140,40},{-120,60}})));

      Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor T_workpiece annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=180,
            origin={80,-28})));
      Modelica.Blocks.Sources.RealExpression realExpression11(y=T_workpiece.T)
                                                                         annotation (Placement(transformation(extent={{-140,-76},{-120,-56}})));
      WorkpieceHallDissipation.WorkpieceHallDissipation workpieceHallDissipation annotation (Placement(transformation(extent={{-110,-58},{-90,-38}})));
    equation
      // First electric power demand represents main connection of annealing oven
      electricDemand[1].Power[1] = mainConnection.y;
      electricDemand[1].Power[2] = mainConnection.y;
      electricDemand[1].Power[3] = mainConnection.y;

      // Cool demand represents heat influx into central cooling system or heating system
      coolDemand[1].Q_flow[1] = - dummyGasketcooling.central_cooling.Q_flow;
      coolDemand[1].T_in[1] = T_cooling.T;
      coolDemand[1].T_out[1] = T_door.T;
      coolDemand[1].Q_flow[2] = - dummyGasketcooling.central_cooling.Q_flow;
      coolDemand[1].T_in[2] = T_cooling.T;
      coolDemand[1].T_out[2] = T_door.T;
      coolDemand[1].Q_flow[3] = - dummyGasketcooling.central_cooling.Q_flow;
      coolDemand[1].T_in[3] = T_cooling.T;
      coolDemand[1].T_out[3] = T_door.T;

      coolDemand[2].Q_flow[1] = - wasteHeatRecovery.recovered.Q_flow;
      coolDemand[2].T_in[1] = T_heating.T;
      coolDemand[2].T_out[1] = wasteHeatRecovery.T_target;
      coolDemand[2].Q_flow[2] = - wasteHeatRecovery.recovered.Q_flow;
      coolDemand[2].T_in[2] = T_heating.T;
      coolDemand[2].T_out[2] = wasteHeatRecovery.T_target;
      coolDemand[2].Q_flow[3] = - wasteHeatRecovery.recovered.Q_flow;
      coolDemand[2].T_in[3] = T_heating.T;
      coolDemand[2].T_out[3] = wasteHeatRecovery.T_target;

      coolDemand[3].Q_flow[1] = - wasteHeatRecovery1.recovered.Q_flow;
      coolDemand[3].T_in[1] = T_heating.T;
      coolDemand[3].T_out[1] = wasteHeatRecovery1.T_target;
      coolDemand[3].Q_flow[2] = - wasteHeatRecovery1.recovered.Q_flow;
      coolDemand[3].T_in[2] = T_heating.T;
      coolDemand[3].T_out[2] = wasteHeatRecovery1.T_target;
      coolDemand[3].Q_flow[3] = - wasteHeatRecovery1.recovered.Q_flow;
      coolDemand[3].T_in[3] = T_heating.T;
      coolDemand[3].T_out[3] = wasteHeatRecovery1.T_target;

      // Dissipation flow rate equals heat dissipated to hall
      dissipationFlowRate = hall.port.Q_flow;
      connect(T_retort.port, thermalSystem.retort_port) annotation (Line(points={{10,-30},{10,-10},{20,-10}}, color={191,0,0}));
      connect(heaterUnit_Controller.y, heaterUnit.u) annotation (Line(points={{-149,-80},{-112,-80}},
                                                                                                color={0,0,127}));
      connect(quenchingUnit.quenching, thermalSystem.air_port) annotation (Line(points={{-90,10},{20,10}}, color={191,0,0}));
      connect(T_air.port, thermalSystem.air_port) annotation (Line(points={{10,30},{10,10},{20,10}}, color={191,0,0}));
      connect(quenchingUnit_Controller.y, quenchingUnit.u) annotation (Line(points={{-149,10},{-112,10}},
                                                                                                        color={0,0,127}));
      connect(processController.controlBus, quenchingUnit_Controller.controlBus) annotation (Line(
          points={{-200,-1},{-190,-1},{-190,10},{-170,10}},
          color={255,204,51},
          thickness=0.5));
      connect(heaterUnit_Controller.controlBus, quenchingUnit_Controller.controlBus) annotation (Line(
          points={{-170,-80},{-190,-80},{-190,10},{-170,10}},
          color={255,204,51},
          thickness=0.5));
      connect(thermalSystem.controlBus, quenchingUnit_Controller.controlBus) annotation (Line(
          points={{40,-20},{40,-160},{-190,-160},{-190,10},{-170,10}},
          color={255,204,51},
          thickness=0.5));
      connect(dummyVacuumSystem.u, vacuumPump_Controller.y) annotation (Line(points={{-112,90},{-149,90}},
                                                                                                         color={0,0,127}));
      connect(vacuumPump_Controller.controlBus, processController.controlBus) annotation (Line(
          points={{-170,90},{-190,90},{-190,-1},{-200,-1}},
          color={255,204,51},
          thickness=0.5));
      connect(gascirculation_Controller.y, dummyGascirculationSystem.u) annotation (Line(points={{-149,130},{-112,130}},
                                                                                                                       color={0,0,127}));
      connect(gascirculation_Controller.controlBus, processController.controlBus) annotation (Line(
          points={{-170,130},{-190,130},{-190,-1},{-200,-1}},
          color={255,204,51},
          thickness=0.5));
      connect(T_hall.port, hall.port) annotation (Line(points={{210,-20},{210,0},{220,0}}, color={191,0,0}));
      connect(dummyGasketcooling.u, gasketcooling_Controller.y) annotation (Line(points={{-112,170},{-149,170}},                   color={0,0,127}));
      connect(gasketcooling_Controller.controlBus, processController.controlBus) annotation (Line(
          points={{-170,170},{-190,170},{-190,-1},{-200,-1}},
          color={255,204,51},
          thickness=0.5));
      connect(T_door.port, thermalSystem.door_loss) annotation (Line(points={{70,30},{70,10},{60,10}},    color={191,0,0}));
      connect(heaterUnit.heating, thermalSystem.air_port) annotation (Line(points={{-90,-80},{-60,-80},{-60,10},{20,10}},
                                                                                                                      color={191,0,0}));
      connect(wasteHeatRecovery.air, heaterUnit.exhaust) annotation (Line(points={{-100,-110},{-100,-90}},
                                                                                                         color={191,0,0}));
      connect(wasteHeatRecovery1.air, quenchingUnit.exhaust) annotation (Line(points={{-100,40},{-100,20}},
                                                                                                          color={191,0,0}));
      connect(T_cooling.port, cooling_system.port) annotation (Line(points={{210,170},{210,190},{220,190}}, color={191,0,0}));
      connect(T_heating.port, heating_system.port) annotation (Line(points={{210,130},{210,150},{220,150}}, color={191,0,0}));
      connect(wasteHeatRecovery1.T_fluid_inlet, realExpression.y) annotation (Line(points={{-112,45},{-112,40},{-119,40}}, color={0,0,127}));
      connect(realExpression1.y, wasteHeatRecovery1.T_air) annotation (Line(points={{-119,60},{-112,60},{-112,55}},
                                                                                                                 color={0,0,127}));
      connect(realExpression2.y, gasketcooling_Controller.Temperature) annotation (Line(points={{-141,150},{-160,150},{-160,158}},color={0,0,127}));
      connect(realExpression3.y, quenchingUnit_Controller.Temperature) annotation (Line(points={{-141,-10},{-160,-10},{-160,-2}},color={0,0,127}));
      connect(realExpression4.y, quenchingUnit.T_air) annotation (Line(points={{-119,-20},{-105,-20},{-105,-2}},
                                                                                                              color={0,0,127}));
      connect(realExpression5.y, quenchingUnit.T_hall) annotation (Line(points={{-119,-32},{-95,-32},{-95,-2}},color={0,0,127}));
      connect(realExpression6.y, heaterUnit_Controller.Temperature) annotation (Line(points={{-141,-100},{-160,-100},{-160,-92}},color={0,0,127}));
      connect(realExpression8.y, wasteHeatRecovery.T_air) annotation (Line(points={{-119,-130},{-112,-130},{-112,-125}},
                                                                                                                      color={0,0,127}));
      connect(dummyGasketcooling.gasket_cooling, thermalSystem.door_loss) annotation (Line(points={{-90,170},{60,170},{60,10}},   color={191,0,0}));
      connect(heaterUnit.P_final, mainConnection.u[1]) annotation (Line(points={{-89,-75},{-50,-75},{-50,-1.575},{-44,-1.575}},
                                                                                                                         color={0,0,127}));
      connect(dummyVacuumSystem.P_el, mainConnection.u[2]) annotation (Line(points={{-89,90},{-50,90},{-50,-0.525},{-44,-0.525}},
                                                                                                                           color={0,0,127}));
      connect(dummyGascirculationSystem.P_el, mainConnection.u[3]) annotation (Line(points={{-89,130},{-50,130},{-50,0.525},{-44,0.525}},
                                                                                                                                       color={0,0,127}));
      connect(quenchingUnit.P_el, mainConnection.u[4]) annotation (Line(points={{-89,5},{-50,5},{-50,1.575},{-44,1.575}},
                                                                                                                       color={0,0,127}));
      connect(integerExpression.y, processController.OperatingMode) annotation (Line(points={{-261,8},{-250,8},{-250,8.5},{-242,8.5}},
                                                                                                                                     color={255,127,0}));
      connect(integerTable.y, processController.ProcessingProgramm) annotation (Line(points={{-259,-10},{-242,-10.5}},
                                                                                                                     color={255,127,0}));
      connect(thermalCollector.port_b, cooling_system.port) annotation (Line(points={{180,190},{220,190}}, color={191,0,0}));
      connect(dummyGasketcooling.central_cooling, thermalCollector.port_a[1]) annotation (Line(points={{-100,180},{-100,190},{160,190}},
                                                                                                                                       color={191,0,0}));
      connect(thermalCollector1.port_b, heating_system.port) annotation (Line(points={{180,150},{220,150}}, color={191,0,0}));
      connect(wasteHeatRecovery1.recovered, thermalCollector1.port_a[1]) annotation (Line(points={{-90,55},{-20,55},{-20,150},{160.25,150}},
                                                                                                                                          color={191,0,0}));
      connect(wasteHeatRecovery.recovered, thermalCollector1.port_a[2]) annotation (Line(points={{-90,-125},{250,-125},{250,120},{159.75,120},{159.75,150}},
                                                                                                                                                           color={191,0,0}));
      connect(thermalCollector2.port_b, hall.port) annotation (Line(points={{180,-6.66134e-16},{200,-6.66134e-16},{200,0},{220,0}}, color={191,0,0}));
      connect(wasteHeatRecovery1.dissipated, thermalCollector2.port_a[1]) annotation (Line(points={{-90,45},{0,45},{0,70},{150,70},{150,0},{160.4,8.88178e-16}},              color={191,0,0}));
      connect(thermalSystem.wall_loss, thermalCollector2.port_a[2]) annotation (Line(points={{40,20},{40,60},{140,60},{140,0},{160.2,0}},    color={191,0,0}));
      connect(thermalSystem.radiation_loss, thermalCollector2.port_a[3]) annotation (Line(points={{60,0},{160,0}},     color={191,0,0}));
      connect(wasteHeatRecovery.dissipated, thermalCollector2.port_a[4]) annotation (Line(points={{-90,-115},{130,-115},{130,0},{159.8,0}},  color={191,0,0}));
      connect(realExpression9.y, wasteHeatRecovery.T_hall) annotation (Line(points={{-119,-120},{-112,-120}}, color={0,0,127}));
      connect(realExpression7.y, wasteHeatRecovery.T_fluid_inlet) annotation (Line(points={{-119,-110},{-112,-110},{-112,-115}}, color={0,0,127}));
      connect(realExpression10.y, wasteHeatRecovery1.T_hall) annotation (Line(points={{-119,50},{-112,50}}, color={0,0,127}));
      connect(workpieceHallDissipation.port_a, thermalCollector2.port_a[5]) annotation (Line(points={{-90,-48},{152,-48},{152,0},{159.6,0}}, color={191,0,0}));
      connect(workpieceHallDissipation.T_workpiece, realExpression11.y) annotation (Line(points={{-112,-55.8},{-116,-55.8},{-116,-66},{-119,-66}},
                                                                                                                                               color={0,0,127}));
      connect(T_workpiece.port, thermalSystem.workpiece_temp) annotation (Line(points={{70,-28},{66,-28},{66,-10},{60,-10}}, color={191,0,0}));
      connect(workpieceHallDissipation.controlBus, processController.controlBus) annotation (Line(
          points={{-110,-48},{-190,-48},{-190,-1},{-200,-1}},
          color={255,204,51},
          thickness=0.5));
                                                                                                                                                                                                           annotation (choicesAllMatching=true, Placement(transformation(extent={{-190,-260},{-170,-240}})),
                  Icon(coordinateSystem(preserveAspectRatio=false, extent={{-300,-300},{300,300}})), Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-300,-300},{300,300}})),
        experiment(StopTime=12000, __Dymola_Algorithm="Cvode"));
    end AnnealingOven;
  end AnnealingOven;
end Ovens;
