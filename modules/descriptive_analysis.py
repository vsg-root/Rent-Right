import streamlit as st
import pandas as pd

def descriptive_analysis(df):
    if st.checkbox("Mostrar Estatísticas Descritivas"):
        st.write(df.describe())

    