import plotly.express as px
import plotly.graph_objects as go
from plotly.subplots import make_subplots

def display_all_variables(df_ina, df_gps, df_baro, df_pas, df_ms, df_imu, df_brake):
    """
    Display all variables
    """
    fig = make_subplots(rows=9, cols=1,
                        shared_xaxes=True,
                        vertical_spacing=0.01,
                       )
    

    fig.update_layout(hovermode="x unified")


    fig.add_trace(go.Scatter(
        x=df_ina["Datetime"],
        y=df_ina["Power"],
        name="Power[mW]",
        hoverinfo='y'),
        row=1, col=1)

    fig.add_trace(go.Scatter(
        x=df_ina["Datetime"],
        y=df_ina["Power_averaged"],
        name="Power[mW] averaged",
        hoverinfo='y'),
        row=1, col=1)
    
    fig.update_yaxes(title_text="Power[mW]", row=1, col=1)


    fig.add_trace(go.Scatter(
        x=df_ina["Datetime"],
        y=df_ina["Battery_Voltage"],
        name="Battery Voltage[V]",
        hoverinfo='y'),
        row=2, col=1)
    
    fig.update_yaxes(title_text="Voltage[V]", row=2, col=1)


    fig.add_trace(go.Scatter(

        x=df_gps["Datetime"],
        y=df_gps["GPS Speed"],
        name="GPS Speed [km/h]",
        hoverinfo='y'),
        row=3, col=1)
    

    fig.add_trace(go.Scatter(
        x=df_ms["Datetime"],
        y=df_ms["motor_rpm"],
        name="Internal Speed sensor",
        hoverinfo='y'),
        row=3, col=1)
    

    fig.add_trace(go.Scatter(
        x=df_ms["Datetime"],
        y=df_ms["filtered_motor_rpm"],
        name="Filtered Motor RPM",
        hoverinfo='y'),
        row=3, col=1)
    
    fig.update_yaxes(title_text="Speed[km/h]", row=3, col=1)

    fig.add_trace(go.Scatter(

        x=df_ms["Datetime"],
        y=df_ms["motor_acceleration"],
        name="Motor Acceleration(km/h^2)",
        hoverinfo='y'),
        row=4, col=1)
    
    fig.update_yaxes(title_text="Acceleration[km/h^2]", row=4, col=1)

    fig.add_trace(go.Scatter(

        x=df_gps["Datetime"],
        y=df_gps["altitude"],
        name="GPS Altitude[m]",
        hoverinfo='y'),
        row=5, col=1)

    fig.add_trace(go.Scatter(

        x=df_baro["Datetime"],
        y=df_baro["Baro_Altitude"],
        name="Baro_Altitude[m]",
        hoverinfo='y'),
        row=5, col=1)


    fig.add_trace(go.Scatter(

        x=df_baro["Datetime"],
        y=df_baro["filtered_Baro_Altitude"],
        name="Baro_Altitude[m] filtered",
        hoverinfo='y'),
        row=5, col=1)

    fig.update_yaxes(title_text="Altitude ASL[m]", row=5, col=1)

    fig.add_trace(go.Scatter(

        x=df_baro["Datetime"],
        y=df_baro["slope"],
        name="Slope",
        hoverinfo='y'),
        row=6, col=1)

    fig.update_yaxes(title_text="Slope[degrees]", row=6, col=1)

    
    fig.add_trace(go.Scatter(
        x=df_pas["Datetime"],
        y=df_pas["pas_rpm"],
        name="Pedal Assist Sensor RPM",
        hoverinfo='y'),
        row=7, col=1)
    
    fig.update_yaxes(title_text="Pedal RPM", row=7, col=1)

    
    for var in ["acceleration_x", "acceleration_y", "acceleration_z", "gyro_x", "gyro_y", "gyro_z"]:
        fig.add_trace(go.Scatter(
            x=df_imu["Datetime"],
            y=df_imu[var],
            name=var,
            hoverinfo='y'),
            row=8, col=1)
    
    fig.update_yaxes(title_text="Acceleration[m/s^2]", row=8, col=1)

    fig.add_trace(go.Scatter(
        x=df_brake["Datetime"],
        y=df_brake["brake_state"],
        name="Brake State",
        hoverinfo='y'),
        row=9, col=1)


    fig.update_yaxes(title_text="Brake State", row=9, col=1)
    

    fig.update_layout(title_text="All parameters")

    fig.write_html("output/All_variables.html")

    fig.show()

def display_interesting_variables(df_ml, xgbr):
    """
    Display the interesting variables
    """
    fig = make_subplots(rows=5, cols=1,
                        shared_xaxes=True,
                        vertical_spacing=0.01)

    fig.update_layout(hovermode="x unified")


    fig.add_trace(go.Scatter(
        x=df_ml["Datetime"],
        y=df_ml["Power"],
        name="Power[mW]",
        hoverinfo='y'),
        row=1, col=1)
    
    fig.update_yaxes(title_text="Power[mW]", row=1, col=1)


    fig.add_trace(go.Scatter(
        x=df_ml["Datetime"],
        y=df_ml["Power_averaged"],
        name="Power[mW] Averaged",
        hoverinfo='y'),
        row=1, col=1)


    fig.add_trace(go.Scatter(
        x=df_ml["Datetime"],
        y=xgbr.predict(df_ml[params_x_for_ml]),
        name="Power[mW] Prediction",
        hoverinfo='y'),
        row=1, col=1)

    fig.add_trace(go.Scatter(
        x=df_ml["Datetime"],
        y=df_ml["Battery_Voltage"],
        name="Battery Voltage[V]",
        hoverinfo='y'),
        row=2, col=1)
    
    fig.update_yaxes(title_text="Voltage[V]", row=2, col=1)

    fig.add_trace(go.Scatter(

        x=df_ml["Datetime"],
        y=df_ml["Baro_Altitude"],
        name="Baro_Altitude[m]",
        hoverinfo='y'),
        row=3, col=1)

    fig.add_trace(go.Scatter(

        x=df_ml["Datetime"],
        y=df_ml["filtered_Baro_Altitude"],
        name="Baro_Altitude[m] low pass filtered",
        hoverinfo='y'),
        row=3, col=1)
    
    fig.update_yaxes(title_text="Barometric Altitude[m]", row=3, col=1)

    fig.add_trace(go.Scatter(
        x=df_ml["Datetime"],
        y=df_ml["motor_rpm_x"],
        name="Motor RPS",
        hoverinfo='y'),
        row=4, col=1)
    
    fig.update_yaxes(title_text="Motor RPS", row=4, col=1)

    fig.add_trace(go.Scatter(
        x=df_ml["Datetime"],
        y=df_ml["pas_rpm"],
        name="Pedal Assist Sensor RPM",
        hoverinfo='y'),
        row=5, col=1)
    
    fig.update_yaxes(title_text="Pedal Assist Sensor RPS", row=5, col=1)



    fig.update_layout(title_text="Battery Power, Voltage, Barometric Altitude, Motor RPM, Pedal Assist Sensor RPM")

    fig.write_html("output/interesting_variables.html")

    fig.show()