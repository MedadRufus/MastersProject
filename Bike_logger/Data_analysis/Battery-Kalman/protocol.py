high_cut_off_voltage = 29.36


class Protocol:
    def __init__(self):
        pass

    def get_discharge_time(self, df):
        start_time = df.head(1).index
        end_time = df.tail(1).index
        return end_time - start_time

    def launch_experiment_protocol_real_data(self, df, Q_tot, time_step, experiment_callback):

        # discharge currents taken from real data stored on the dataframe
        discharge_time = len(df.index)
        time = 0

        while time < discharge_time:
            current = df["Current"].iloc[time] / 1000  # Current in dataframe in mA. Convert to A
            experiment_callback(current)
            time += time_step

    def launch_experiment_protocol(self, Q_tot, time_step, experiment_callback):
        charge_current_rate = 0.5  # C
        discharge_current_rate = 1  # C
        discharge_constants_stages_time = 20 * 60  # s
        pulse_time = 60  # s
        total_pulse_time = 40 * 60  # s

        low_cut_off_voltage = 2.5 * 6

        # charge CC
        current = -charge_current_rate * Q_tot
        voltage = 0
        while voltage < high_cut_off_voltage:
            voltage = experiment_callback(current)

        # charge CV
        while current < -0.1:
            # pseudo current control to simulate CV charge
            if voltage > high_cut_off_voltage * 1.001:
                current += 0.01 * Q_tot
            # if battery_simulation.voltage < high_cut_off_voltage*0.999:
            #     current += 0.02 * Q_tot
            voltage = experiment_callback(current)

        # discharge first stage
        time = 0
        current = discharge_current_rate * Q_tot
        while time < discharge_constants_stages_time:
            experiment_callback(current)
            time += time_step

        # discharge pulses stage
        time = 0
        while time < total_pulse_time:
            time_low = 0
            current = 0
            while time_low < pulse_time:
                experiment_callback(current)
                time_low += time_step
            time_high = 0
            current = discharge_current_rate * Q_tot
            while time_high < pulse_time:
                experiment_callback(current)
                time_high += time_step
            time += time_low + time_high

        # discharge last stage
        time = 0
        current = discharge_current_rate * Q_tot
        while time < discharge_constants_stages_time:
            experiment_callback(current)
            time += time_step
