import streamlit as st
from modules.data_loader import load_data
import streamlit as st
import seaborn as sns
import matplotlib.pyplot as plt

df = load_data("dataset\housing.parquet")  # Caminho atualizado

if st.checkbox("Mostrar Mapa de Calor de Correlação"):
    st.write("Mapa de Calor de Correlação")
    correlation_matrix = df.corr()
    plt.figure(figsize=(10, 5))
    sns.heatmap(correlation_matrix, annot=True, cmap='coolwarm')
    st.pyplot(plt)
