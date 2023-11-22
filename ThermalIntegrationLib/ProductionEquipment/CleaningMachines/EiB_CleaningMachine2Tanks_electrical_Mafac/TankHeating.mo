within ThermalIntegrationLib.ProductionEquipment.CleaningMachines.EiB_CleaningMachine2Tanks_electrical_Mafac;
package TankHeating
  model Tank1_heating
  parameter Modelica.SIunits.Mass m_batch "Mass of batch";
    parameter Modelica.SIunits.HeatCapacity c_batch "Heat capacity of batch";

    parameter Modelica.SIunits.Mass m_rack "Mass of batching rack";
    parameter Modelica.SIunits.HeatCapacity c_rack "Heat capacity of batching rack";

    parameter Modelica.SIunits.Power P_heat "Electrical power of tank heating";
    parameter Real eta_heat "Efficiency factor of electrical heating (0-1)";
    parameter Modelica.SIunits.Temperature T_req "Working temperature of cleaning fluid";
    parameter Modelica.SIunits.Temperature T_lim "Minimum temperature of cleaning fluid";

    parameter Modelica.SIunits.Mass m_t1 "Mass of cleaning fluid tank 1";
    parameter Modelica.SIunits.Area A_t1 "Surface area of tank 1";
    parameter Modelica.SIunits.SpecificHeatCapacity c_fluid "Heat capacity of cleaning fluid";
    parameter Modelica.SIunits.Area A_tt "Surface area of wall between tanks";

    parameter Modelica.SIunits.Length d_ins "Thickness insulation";
    parameter Modelica.SIunits.ThermalConductivity lambda_ins "Thermal conductivity insulation";

    Real T_t1(start=298.15),
         Q_dot_t1(start=0),
         Q_dot_hall(start = 0);
    Modelica.Blocks.Interfaces.IntegerInput state
      annotation (Placement(transformation(extent={{-120,-10},{-100,10}}), iconTransformation(extent=
              {{-120,-10},{-100,10}})));
    Modelica.Blocks.Interfaces.RealInput Q_dot_batch
      annotation (Placement(transformation(extent={{-120,-50},{-100,-30}}), iconTransformation(extent=
             {{-120,-50},{-100,-30}})));
    Modelica.Blocks.Interfaces.RealOutput P_el
      annotation (Placement(transformation(extent={{100,-10},{120,10}})));
    Modelica.Blocks.Interfaces.BooleanOutput t1_state
      annotation (Placement(transformation(extent={{100,-70},{120,-50}})));
    Modelica.Blocks.Interfaces.RealInput T_amb
      annotation (Placement(transformation(extent={{-120,70},{-100,90}}), iconTransformation(extent={{-120,70},{-100,90}})));
    Modelica.Blocks.Interfaces.RealInput T2
      annotation (Placement(transformation(extent={{-120,30},{-100,50}}), iconTransformation(extent={{-120,30},{-100,50}})));
    Modelica.Blocks.Interfaces.RealInput T_batch
      annotation (Placement(transformation(extent={{-120,-90},{-100,-70}}), iconTransformation(extent={{-120,-90},{-100,-70}})));
    Modelica.Blocks.Interfaces.RealOutput T1 annotation (Placement(transformation(extent={{100,50},{120,70}})));
    Modelica.Blocks.Interfaces.BooleanOutput heating_t1 annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={0,110})));
  protected
    Real a_H2O = 350,
         a_air = 8,
         d_tt = 0.002,
         lambda_tt = 20,
         k = 1/(1/a_H2O+2*d_tt/lambda_tt+d_ins/lambda_ins+1/a_air),
         k_tt = 1/(2/a_H2O+d_tt/lambda_tt);
                      // heat transfer coefficient resting water [W/m^2K]
                    // heat transfer coefficient air [W/m^2K]
                       // thickness wall without insulation/between tanks [m]
                         // thermal conductivity stainless steel [W/mK]

  initial equation
    pre(heating_t1) = false;

  equation
    heating_t1 = T_t1 <= T_lim or pre(heating_t1) and T_t1 < T_req; // state tank1 heating on/off

    if state < 5 or state > 7 then // cleaning NOT in progress, fluid stays in tank
      Q_dot_hall = (T_t1-T_amb)*k*A_t1; // heat transfere to hall
      t1_state = false; // fluid is not in contact with batch
      if state >= 8 and state <= 10 then // cleaning with tank2 is running, no heat exchange between tanks
        if heating_t1 then // heating on, plus heat extraction by tankwall
          Q_dot_t1 = eta_heat*P_heat - Q_dot_hall;
          P_el = P_heat;
        else // heating off, only heat extraction by tankwall
          Q_dot_t1 = -Q_dot_hall;
          P_el = 0;
        end if;
      else // heat exchange between tanks
        if heating_t1 then // heating on, plus heat extraction by tankwall, plus heat exchange between tanks
          Q_dot_t1 = eta_heat*P_heat - Q_dot_hall + (T2-T_t1)*k_tt*A_tt;
          P_el = P_heat;
        else // heating off, heat extraction by tankwall, plus heat exchange between tanks
          Q_dot_t1 = -Q_dot_hall + (T2-T_t1)*k_tt*A_tt;
          P_el = 0;
        end if;
      end if;
    else // cleaning in progress, heat extraction by batch
      t1_state = true; // fluid is in contact with batch
      Q_dot_t1 = -Q_dot_batch;
      P_el = 0;
      Q_dot_hall = 0; // no immediate heat transfere to hall while cleaning (-> delayed heat transfere to hall over hot batch)
    end if;

    der(T_t1) = Q_dot_t1/(m_t1*c_fluid); // tank1 temperature slope

    T1 = T_t1;

    annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Rectangle(
            extent={{-100,100},{100,-100}},
            lineColor={0,0,0},
            lineThickness=0.5),
          Line(
            points={{-64,34}},
            color={0,0,0},
            thickness=0.5),
          Text(
            extent={{-60,-66},{60,-100}},
            lineColor={0,0,0},
            textString="T1"),
          Rectangle(
            extent={{-40,-40},{40,-46}},
            lineColor={0,0,0},
            lineThickness=0.5),
          Line(
            points={{-30,-40},{-30,80},{-20,86},{-10,80},{-8,0},{0,-8},{8,0},{10,80},{20,86},{30,80},
                {30,-40}},
            color={0,0,0},
            thickness=0.5,
            smooth=Smooth.Bezier),
          Line(
            points={{-26,-40},{-26,76},{-20,82},{-14,76},{-12,-4},{0,-12},{12,-4},{14,76},{20,82},{26,
                76},{26,-40}},
            color={0,0,0},
            thickness=0.5,
            smooth=Smooth.Bezier),
          Rectangle(
            extent={{-30,-52},{-20,-60}},
            lineColor={0,0,0},
            lineThickness=0.5),
          Rectangle(
            extent={{20,-52},{30,-60}},
            lineColor={0,0,0},
            lineThickness=0.5),
          Rectangle(
            extent={{-42,-46},{42,-52}},
            lineColor={0,0,0},
            lineThickness=0.5),
          Rectangle(
            extent={{-6,-52},{6,-60}},
            lineColor={0,0,0},
            lineThickness=0.5)}),          Diagram(coordinateSystem(preserveAspectRatio=false)));
  end Tank1_heating;

  model Tank2_heating
    parameter Modelica.SIunits.Power P_heat "Electrical power of tank heating";
    parameter Real eta_heat "Efficiency factor of electrical heating (0-1)";
    parameter Modelica.SIunits.Temperature T_req "Working temperature of cleaning fluid";
    parameter Modelica.SIunits.Temperature T_lim "Minimum temperature of cleaning fluid";
    parameter Modelica.SIunits.Mass m_t2 "Mass of cleaning fluid tank 2";
    parameter Modelica.SIunits.Area A_t2 "Surface area of tank 2";
    parameter Modelica.SIunits.SpecificHeatCapacity c_fluid "Heat capacity of cleaning fluid";
    parameter Modelica.SIunits.Area A_tt "Surface area of wall between tanks";
    parameter Modelica.SIunits.Length d_ins "Thickness insulation";
    parameter Modelica.SIunits.ThermalConductivity lambda_ins "Thermal conductivity insulation";
    Real T_t2(start=298.15),
         Q_dot_t2(start=0),
         Q_dot_hall(start=0);
    Modelica.Blocks.Interfaces.RealInput T_amb
      annotation (Placement(transformation(extent={{-120,70},{-100,90}}), iconTransformation(extent={
              {-120,70},{-100,90}})));
    Modelica.Blocks.Interfaces.RealInput T1
      annotation (Placement(transformation(extent={{-120,30},{-100,50}}), iconTransformation(extent={
              {-120,30},{-100,50}})));
    Modelica.Blocks.Interfaces.IntegerInput state
      annotation (Placement(transformation(extent={{-120,-10},{-100,10}}), iconTransformation(extent=
              {{-120,-10},{-100,10}})));
    Modelica.Blocks.Interfaces.RealInput Q_dot_batch
      annotation (Placement(transformation(extent={{-120,-50},{-100,-30}}), iconTransformation(extent=
             {{-120,-50},{-100,-30}})));
    Modelica.Blocks.Interfaces.RealInput T_batch
      annotation (Placement(transformation(extent={{-120,-90},{-100,-70}}), iconTransformation(extent=
             {{-120,-90},{-100,-70}})));
    Modelica.Blocks.Interfaces.RealOutput T2
      annotation (Placement(transformation(extent={{100,50},{120,70}})));
    Modelica.Blocks.Interfaces.RealOutput P_el
      annotation (Placement(transformation(extent={{100,-10},{120,10}})));
    Modelica.Blocks.Interfaces.BooleanOutput t2_state
      annotation (Placement(transformation(extent={{100,-70},{120,-50}})));
    Modelica.Blocks.Interfaces.BooleanOutput heating_t2 annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={0,110})));
  protected
    Real a_H2O = 500,
         a_air = 8,
         d_tt = 0.002,
         lambda_tt = 20,
         k = 1/(1/a_H2O+2*d_tt/lambda_tt+d_ins/lambda_ins+1/a_air),
         k_tt = 1/(2/a_H2O+d_tt/lambda_tt);
                      // heat transfer coefficient resting water [W/m^2K]
                    // heat transfer coefficient air [W/m^2K]
                       // thickness wall without insulation/between tanks [m]
                         // thermal conductivity stainless steel [W/mK]

  initial equation
    pre(heating_t2) = false;

  equation
    heating_t2 = T_t2 <= T_lim or pre(heating_t2) and T_t2 < T_req; // state tank2 heating on/off

    if state < 8 or state > 10 then // cleaning NOT in progress, fluid stays in tank
      Q_dot_hall = (T_t2-T_amb)*k*A_t2; // heat transfere to hall
      t2_state = false; // fluid is not in contact with batch
      if state >= 5 and state <= 7 then // cleaning with tank1 is running, no heat exchange between tanks
        if heating_t2 then // heating on, plus heat extraction by tankwall
          Q_dot_t2 = eta_heat*P_heat  - Q_dot_hall;
          P_el = P_heat;
        else // heating off, only heat extraction by tankwall
          Q_dot_t2 = -Q_dot_hall;
          P_el = 0;
        end if;
      else // heat exchange between tanks
        if heating_t2 then // heating on, plus heat extraction by tankwall, plus heat exchange between tanks
          Q_dot_t2 = eta_heat*P_heat - Q_dot_hall + (T1-T_t2)*k_tt*A_tt;
          P_el = P_heat;
        else // heating off, heat extraction by tankwall, plus heat exchange between tanks
          Q_dot_t2 = -Q_dot_hall + (T1-T_t2)*k_tt*A_tt;
          P_el = 0;
        end if;
      end if;
    else // cleaning in progress, heat extraction by batch
      t2_state = true; // fluid is in contact with batch
      Q_dot_t2 = -Q_dot_batch;
      P_el = 0;
      Q_dot_hall = 0; // no immediate heat transfere to hall while cleaning (-> delayed heat transfere to hall over hot batch)
    end if;

    der(T_t2) = Q_dot_t2/(m_t2*c_fluid); // tank1 temperature slope

    T2 = T_t2;

    annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Rectangle(
            extent={{-100,100},{100,-100}},
            lineColor={0,0,0},
            lineThickness=0.5),
          Text(
            extent={{-60,-66},{60,-100}},
            lineColor={0,0,0},
            textString="T2"),
          Line(
            points={{-78,80}},
            color={0,0,0},
            thickness=0.5),
          Line(
            points={{-30,80}},
            color={0,0,0},
            thickness=0.5,
            smooth=Smooth.Bezier),
          Line(
            points={{30,-20}},
            color={0,0,0},
            thickness=0.5,
            smooth=Smooth.Bezier),
          Line(
            points={{-26,56}},
            color={0,0,0},
            pattern=LinePattern.None,
            thickness=0.5),
          Rectangle(
            extent={{-40,-40},{40,-46}},
            lineColor={0,0,0},
            lineThickness=0.5),
          Line(
            points={{-30,-40},{-30,80},{-20,86},{-10,80},{-8,0},{0,-8},{8,0},{10,80},{20,86},{30,80},
                {30,-40}},
            color={0,0,0},
            thickness=0.5,
            smooth=Smooth.Bezier),
          Line(
            points={{-26,-40},{-26,76},{-20,82},{-14,76},{-12,-4},{0,-12},{12,-4},{14,76},{20,82},{26,
                76},{26,-40}},
            color={0,0,0},
            thickness=0.5,
            smooth=Smooth.Bezier),
          Rectangle(
            extent={{-30,-52},{-20,-60}},
            lineColor={0,0,0},
            lineThickness=0.5),
          Rectangle(
            extent={{20,-52},{30,-60}},
            lineColor={0,0,0},
            lineThickness=0.5),
          Rectangle(
            extent={{-42,-46},{42,-52}},
            lineColor={0,0,0},
            lineThickness=0.5),
          Rectangle(
            extent={{-6,-52},{6,-60}},
            lineColor={0,0,0},
            lineThickness=0.5)}),
                                Diagram(coordinateSystem(preserveAspectRatio=false)));
  end Tank2_heating;

end TankHeating;
