import numpy as np


def calculate_dE(m, m_f, g, f, phi, rho, C_x, A, v_ev, v_w, dvdt, ds):
    """
    Calculate Energy consumed for a given distance ds.

    Vehicle dynamics model taken from:
    De Cauwer, C.; Verbeke, W.; Coosemans, T.; Faid, S.; Van Mierlo, J.
    A Data-Driven Method for Energy Consumption Prediction
    and Energy-Efficient Routing of Electric Vehicles in
    Real-World Conditions. Energies 2017, 10, 608.
    https://doi.org/10.3390/en10050608

    :param m: Total vehicle mass [kg]
    :param m_f: Fictive mass of rolling inertia [kg]
    :param g: Gravitational acceleration [m/s2]
    :param f: Vehicle coefficient of rolling resistance [-]
    :param phi: Road gradient angle [°]
    :param rho: Air density [kg/m3]
    :param C_x: Drag coefficient of the vehicle [-]
    :param A: Vehicle equivalent cross section [m2]
    :param v_ev: Vehicle speed between the point i and the point j [km/h]
    :param v_w: Wind speed projected to the opposing direction of the driving direction [km/h]
    :param dvdt: acceleration(unknown unit? may be [km/h2])
    :param ds: Distance driven from point i to point j [km]
    :return:
    """
    work_against_gravity = m * g * (f * np.cos(np.deg2rad(phi)) + np.sin(np.deg2rad(phi)))
    work_against_friction = 0.5 * rho * C_x * A * np.power(v_ev + v_w, 2)
    work_to_accelerate = (m + m_f) * dvdt  # Acceleration
    return (1 / 3600) * (work_against_gravity + work_against_friction + work_to_accelerate) * ds


def derive_human_energy_input(dE, dMotor_energy):
    return dE - dMotor_energy
