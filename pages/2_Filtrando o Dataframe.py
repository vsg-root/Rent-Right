import streamlit as st
import numpy as np
import pandas as pd
from utils import title

def initial_query(df):
    col_name = df.columns[0]
    value = df[col_name][0]
    if not isinstance(value,np.number):
        value = f'"{value}"'
    return f'{col_name} == {value}'

def print_df(container, df, query_str, sort_values):
    filtered_df = df
    if len(query_str) > 0:
        filtered_df = df.query(query_str).copy()
    if len(sort_values) > 0:
        filtered_df.sort_values(by=sort_values, inplace=True)
    container.dataframe(filtered_df, use_container_width=True)

def build_header():
    col1, col2 = st.columns([8,1])
    text ='<h1>Filtrando Dados de um Dataframe</h1>'+\
    '''<p>Aqui você pode realizar a filtragem e busca por valores específicos no dataframe, como apartamentos com valores em específicos, apenas bastando inserir a condição
    desejada na aba "Query" de forma similar a uma consulta em um database
    </p>'''
    with col1:
        st.write(text, unsafe_allow_html=True)
    with col2:
         st.image('assets\RentRightLogo.png')
def build_body():
    col1, col2 = st.columns([.3,.7])
    df = pd.read_csv("dataset\dataset.csv", encoding='utf-8', low_memory=False)
    sort_values = col1.multiselect('Ordenar', options=df.columns, default=df.columns[0])
    tooltip ='Insira neste campo a condição de filtragem.'
    query_str = st.text_area('Query', height=5, value=initial_query(df), help=tooltip)
    print_df(st, df, query_str, sort_values)

build_header()
build_body()
