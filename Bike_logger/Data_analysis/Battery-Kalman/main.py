import math as m
import matplotlib.pyplot as plt
import numpy as np

from battery import Battery
from kalman import ExtendedKalmanFilter as EKF
from protocol import launch_experiment_protocol


class SocEstimator:
    def __init__(self):
        # total capacity
        self.Q_tot = 3.2  # Ah

        # Thevenin model values
        self.R0 = 0.062
        self.R1 = 0.01
        self.C1 = 3000

        # time period
        self.time_step = 10

        # Battery simulation model
        self.battery_simulation = Battery(self.Q_tot, self.R0, self.R1, self.C1)

        self.battery_simulation.actual_capacity = 0

        # measurement noise standard deviation
        self.std_dev = 0.015

        # get configured EKF
        self.Kf = self.get_EKF(self.R0, self.R1, self.C1, self.std_dev, self.time_step)

        self.time = [0]
        self.true_SoC = [self.battery_simulation.state_of_charge]
        self.estim_SoC = [self.Kf.x[0, 0]]
        self.true_voltage = [self.battery_simulation.voltage]
        self.mes_voltage = [self.battery_simulation.voltage + np.random.normal(0, 0.1, 1)[0]]
        self.current = [self.battery_simulation.current]

    def update_all(self, actual_current):
        self.battery_simulation.current = actual_current
        self.battery_simulation.update(self.time_step)

        self.time.append(self.time[-1] + self.time_step)
        self.current.append(actual_current)

        self.true_voltage.append(self.battery_simulation.voltage)
        self.mes_voltage.append(self.battery_simulation.voltage + np.random.normal(0, self.std_dev, 1)[0])

        self.Kf.predict(u=actual_current)
        self.Kf.update(self.mes_voltage[-1] + self.R0 * actual_current)

        self.true_SoC.append(self.battery_simulation.state_of_charge)
        self.estim_SoC.append(self.Kf.x[0, 0])

        return self.battery_simulation.voltage  # mes_voltage[-1]

    def run_all(self):
        # launch experiment
        launch_experiment_protocol(self.Q_tot, self.time_step, self.update_all)

        # plot stuff
        self.plot_everything(self.time, self.true_voltage, self.mes_voltage, self.true_SoC, self.estim_SoC,
                             self.current)

    def HJacobian(self, x):
        return np.matrix([[self.battery_simulation.OCV_model.deriv(x[0, 0]), -1]])

    def Hx(self, x):
        return self.battery_simulation.OCV_model(x[0, 0]) - x[1, 0]

    def get_EKF(self, R0, R1, C1, std_dev, time_step):
        # initial state (SoC is intentionally set to a wrong value)
        # x = [[SoC], [RC voltage]]
        x = np.matrix([[0.5],
                       [0.0]])

        exp_coeff = m.exp(-time_step / (C1 * R1))

        # state transition model
        F = np.matrix([[1, 0],
                       [0, exp_coeff]])

        # control-input model
        B = np.matrix([[-time_step / (self.Q_tot * 3600)],
                       [R1 * (1 - exp_coeff)]])

        # variance from std_dev
        var = std_dev ** 2

        # measurement noise
        R = var

        # state covariance
        P = np.matrix([[var, 0],
                       [0, var]])

        # process noise covariance matrix
        Q = np.matrix([[var / 50, 0],
                       [0, var / 50]])

        return EKF(x, F, B, P, Q, R, self.Hx, self.HJacobian)

    def plot_everything(self, time, true_voltage, mes_voltage, true_SoC, estim_SoC, current):
        fig = plt.figure()
        ax1 = fig.add_subplot(311)
        ax2 = fig.add_subplot(312)
        ax3 = fig.add_subplot(313)

        # title, labels
        ax1.set_title('')
        ax1.set_xlabel('Time / s')
        ax1.set_ylabel('voltage / V')
        ax2.set_xlabel('Time / s')
        ax2.set_ylabel('Soc')
        ax3.set_xlabel('Time / s')
        ax3.set_ylabel('Current / A')

        ax1.plot(time, true_voltage, label="True voltage")
        ax1.plot(time, mes_voltage, label="Mesured voltage")
        ax2.plot(time, true_SoC, label="True SoC")
        ax2.plot(time, estim_SoC, label="Estimated SoC")
        ax3.plot(time, current, label="Current")

        ax1.legend()
        ax2.legend()
        ax3.legend()

        plt.show()


if __name__ == '__main__':
    soc_estimator = SocEstimator()
    soc_estimator.run_all()
