import pandas as pd
import os
from sklearn.impute import SimpleImputer
from sklearn.preprocessing import OneHotEncoder
from sklearn.compose import ColumnTransformer
from sklearn.pipeline import Pipeline
import pyarrow.parquet as pq
import shutil

def df_names():
    check_data()
    result = []
    dir_iter = os.scandir('dataset')
    for f in dir_iter:
        if f.name.endswith('.csv'):
            result.append(f.name[0:-4])
    return sorted(result)

def read_df(df_path, extension='csv', encoding='utf-8', low_memory=False):
    if extension == 'csv':
        return pd.read_csv("dataset\dataset.csv", encoding=encoding, low_memory=low_memory)
    elif extension == 'parquet':
        return pd.read_parquet("dataset\dataset.csv")
    else:
        raise Exception(f"Formato inválido: {extension}")

def __read_csv(path = "dataset\dataset.csv", encoding = "utf-8", low_memory=False):
    check_data()
    try:
        df = pd.read_csv(path, sep=',', encoding=encoding, low_memory=low_memory)
    except:
        df = pd.read_csv(path, sep=';', encoding=encoding, low_memory=low_memory)
    return df

def get_data():
    dfs = []

    # Iterar sobre os arquivos salvos
    for arquivo in os.listdir('dataset'):
        if arquivo.endswith('.parquet'):  # ou '.csv' para arquivos CSV
            df = pd.read_parquet(os.path.join('dataset', arquivo))  # ou pd.read_csv para CSV
            dfs.append(df)

    # Concatenar todos os dataframes
    df = pd.concat(dfs, ignore_index=True)
    
    categorical_cols = ['type', 'laundry_options', 'parking_options', 'state']  # ajuste conforme necessário

    
    numeric_imputer = SimpleImputer(strategy='mean')

    
    categorical_transformer = Pipeline(steps=[
        ('imputer', SimpleImputer(strategy='most_frequent')),
        ('onehot', OneHotEncoder(handle_unknown='ignore', sparse=False))
    ])

    
    preprocessor = ColumnTransformer(
        transformers=[
            ('num', numeric_imputer, ['lat', 'long', 'price', 'sqfeet', 'beds', 'baths', 'cats_allowed', 'dogs_allowed', 'smoking_allowed', 'wheelchair_access', 'electric_vehicle_charge', 'comes_furnished']),
            ('cat', categorical_transformer, categorical_cols)
        ])

    
    df_transformed = preprocessor.fit_transform(df)

    
    columns = (['lat', 'long', 'price', 'sqfeet', 'beds', 'baths', 'cats_allowed', 'dogs_allowed', 'smoking_allowed', 'wheelchair_access', 'electric_vehicle_charge', 'comes_furnished'] + 
               preprocessor.named_transformers_['cat']['onehot'].get_feature_names_out(categorical_cols).tolist())

    
    df_transformed = pd.DataFrame(df_transformed, columns=columns)

    return df_transformed

def load_data():
    path = "dataset"
    file = "dataset.csv"
    caminho_completo = os.path.join(path, file)
    
    if os.path.exists(caminho_completo):
        return get_data()
    else:
        make_csv()
        return get_data()

def make_csv():
    df_transformed = get_data()
    csv_filepath = 'dataset/dataset.csv'
    df_transformed.to_csv(csv_filepath, index=False)

def check_data():
    path = "dataset"
    file = "dataset.csv"
    caminho_completo = os.path.join(path, file)
    
    if os.path.exists(caminho_completo):
        return
    else:
        make_csv()
        return
    
def clean_start():
    
    csv_path = os.path.join('dataset', 'Dataset.csv')
    profile_path = os.path.join('reports', 'dataset.html')

    if os.path.exists(csv_path):
        os.remove(csv_path)

    if os.path.exists(profile_path):
        os.remove(profile_path)
    
    return

import streamlit as st

def title(text):
    col1, col2 = st.columns([8, 1])
    with col1:
        st.markdown(f'''<h1>{text}</h1>''', unsafe_allow_html=True)
    with col2:
        st.image('assets\RentRightLogo.png')