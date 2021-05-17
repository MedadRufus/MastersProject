import pandas as pd


def load_data():
    return pd.read_pickle('../data/df_ml_train.pkl')
