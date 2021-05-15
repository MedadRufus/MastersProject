from unittest import TestCase

from battery_real import Battery_real


class TestBattery_real(TestCase):
    def setUp(self) -> None:
        self.my_batt = Battery_real(total_capacity=720)

    def test_update(self):
        self.fail()

    def test_current(self):
        self.fail()

    def test_current(self):
        self.fail()

    def test_voltage(self):
        self.fail()

    def test_state_of_charge(self):
        self.fail()

    def test_OCV_model(self):
        self.fail()

    def test_OCV(self):
        self.fail()

    def test_load_data(self):
        self.my_batt.load_data()
        print(self.my_batt.df.head())
