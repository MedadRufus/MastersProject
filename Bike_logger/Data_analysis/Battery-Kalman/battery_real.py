import pandas as pd

from utils import Polynomial


class Battery_real:
    # capacity in Ah
    def __init__(self, total_capacity):
        self.load_data()
        
        # capacity in As
        self.total_capacity = total_capacity * 3600
        self.actual_capacity = self.total_capacity

        self._current = 0
        self._RC_voltage = 0

        # polynomial representation of OCV vs SoC
        self._OCV_model = Polynomial([3.1400, 3.9905, -14.2391, 24.4140, -13.5688, -4.0621, 4.5056])

    def update(self, time_delta):
        self.actual_capacity -= self.current * time_delta

    @property
    def current(self):
        return self._current

    @current.setter
    def current(self, current):
        self._current = current

    @property
    def voltage(self):
        return self.OCV - self.R0 * self.current - self._RC_voltage

    @property
    def state_of_charge(self):
        return self.actual_capacity / self.total_capacity

    @property
    def OCV_model(self):
        return self._OCV_model

    @property
    def OCV(self):
        return self.OCV_model(self.state_of_charge)

    def load_data(self):
        self.df = pd.read_pickle('../data/df_ml_train.pkl')
