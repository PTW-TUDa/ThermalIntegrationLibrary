within ThermalIntegrationLib.ProductionEquipment.MachineTools.MachineTool.CoolingSystem.CompressionChillers;
package Data

  package BaseClasses

    record CompressionChillerProperties
      "Basic parameter record for compression chiller models"

      //## PARAMETERS ##

      // Nominal Performance
      parameter SI.Power P_el_nom "Maximum electric power defined as nominal electric power"                  annotation (Dialog(group="Nominal Performance"));
      parameter SI.Power P_th_cool_nom "Maximum thermal cooling power defined as nominal thermal cooling power"               annotation (Dialog(group="Nominal Performance"));
      parameter SI.MassFlowRate m_flow_nom "Maximum mass flow defined as nominal mass flow through condenser and evaporator" annotation (Dialog(group="Nominal Performance"));
      parameter SI.Pressure dp_nom_evap "Nominal pressure on evaporator side" annotation (Dialog(group="Nominal Performance"));
      parameter SI.Pressure dp_nom_cond "Nominal pressure on condenser side" annotation (Dialog(group="Nominal Performance"));

      // Efficiency Characteristics
      parameter Real f_PthMax[:,:]
        "Efficiency table matrix for availble thermal cooling power normalized to P_th_cool_nom (grid T_in_cool = first column, grid T_in_heat = first row)"
        annotation (Dialog(group="Efficiency Characteristics"));
      parameter Real f_PelMax[:,:]
        "Efficiency table matrix for reqired electric power normalized to P_el_nom (grid T_in_cool = first column, grid T_in_heat = first row)"
        annotation (Dialog(group="Efficiency Characteristics"));
      parameter Real f_Pel_partLoad[:,:]
        "Part load behavior of required electric power normalized to P_el_nom (grid u = first column)"
        annotation (Dialog(group="Efficiency Characteristics"));
      parameter Real alpha "factor for electric power to heat flow, P_th_heat = P_th_cool + alpha*P_el"
        annotation (Dialog(group="Efficiency Characteristics"));
      // Operating Conditions
      parameter Real u_min "Minimum operation point" annotation (Dialog(group="Operating Conditions"));
      parameter SI.Temperature T_in_cool_min "Minimal cool instream temperature"
        annotation (Dialog(group="Operating Conditions"));
      parameter SI.Temperature T_in_cool_max "Maximal cool instream temperature"
        annotation (Dialog(group="Operating Conditions"));
      parameter SI.Temperature T_in_heat_min "Minimal heated instream temperature"
        annotation (Dialog(group="Operating Conditions"));
      parameter SI.Temperature T_in_heat_max "Maximal heated instream temperature"
        annotation (Dialog(group="Operating Conditions"));

      // Dynamics
      parameter SI.Volume V_int_cool "Internal Cool Mixing Volume" annotation (Dialog(group="Dynamics"));
      parameter SI.Volume V_int_heat "Internal Heat Mixing Volume" annotation (Dialog(group="Dynamics"));
        parameter SI.Time tau "Delay parameter (corresponds to internal fluid volume depending on nominal mass flow)" annotation (Dialog(group="Dynamics"));

      annotation(defaultComponentPrefixes = "parameter");
    end CompressionChillerProperties;
  end BaseClasses;

  record Viessmann_Vitocal350G_BWC351A07
    extends CompressionChillers.Data.BaseClasses.CompressionChillerProperties(
      P_el_nom=3600,
      P_th_cool_nom=12000,
      m_flow_nom = 1,
      f_PthMax = [0,35,45,55,65,72; -5,0.40,0.36,0.31,0.26,0.22; 0,0.48,0.44,0.38,0.33,0.29; 5,0.6,0.55,
        0.49,0.42,0.37; 10,0.71,0.65,0.59,0.52,0.46; 15,0.81,0.76,0.69,0.61,0.54; 20,0.91,0.87,0.79,0.69,0.61; 25,1.0,0.98,0.88,0.77,0.68],
      f_PelMax = [0,35,45,55,65,72; -5,0.43,0.51,0.61,0.72,0.81; 0,0.44,0.53,0.63,0.75,0.84; 5,0.45,0.54,0.65,0.77,0.87; 10,0.46,0.55,0.66,0.79,0.90; 15,0.47,0.56,0.68,0.82,0.93; 20,0.48,0.58,0.7,0.84,0.96; 25,0.48,0.59,0.72,0.87,0.99],
      f_Pel_partLoad = [0.0,0.0;0.5,0.61;0.75,0.79;1,1],
      alpha = 0.9,
      u_min = 0.5,
      T_in_cool_min=273.15 - 5,
      T_in_cool_max=273.15 + 50,
      T_in_heat_min=273.15 + 20,
      T_in_heat_max=273.15 + 72,
      V_int_cool = 0.01,
      V_int_heat = 0.01,
      tau = 150,
      dp_nom_evap=10000,
      dp_nom_cond=10000);             //eigentlich 25 grad

    annotation(defaultComponentPrefixes = "parameter", Icon(graphics));
  end Viessmann_Vitocal350G_BWC351A07;
end Data;
